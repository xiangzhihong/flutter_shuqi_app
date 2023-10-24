import 'package:flutter/material.dart';

import '../global.dart';
import '../public.dart';
import '../utility/screen.dart';
import 'bookshelf_cloud_widget.dart';

class BookshelfHeader extends StatefulWidget {
  final Novel novel;

  BookshelfHeader(this.novel);

  @override
  _BookshelfHeaderState createState() => _BookshelfHeaderState();
}

class _BookshelfHeaderState extends State<BookshelfHeader> with SingleTickerProviderStateMixin {
  late AnimationController controller;
  late Animation<double> animation;

  @override
  initState() {
    super.initState();
    controller = AnimationController(duration: const Duration(milliseconds: 2000), vsync: this);
    animation = Tween(begin: 0.0, end: 1.0).animate(controller);

    animation.addStatusListener((status) {
      if (status == AnimationStatus.completed) {
        controller.reverse();
      } else if (status == AnimationStatus.dismissed) {
        controller.forward();
      }
    });
    controller.forward();
  }

  dispose() {
    controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    var width = Screen.width;
    var bgHeight = width / 0.9;
    var height = Screen.topSafeHeight + 250;
    return Container(
      width: width,
      height: height,
      child: Stack(
        children: <Widget>[
          Positioned(
            top: height - bgHeight,
            child: Image.asset(
              'assets/img/bookshelf_bg.png',
              fit: BoxFit.cover,
              width: width,
              height: bgHeight,
            ),
          ),
          Positioned(
            bottom: 0,
            child: BookshelfCloudWidget(
              animation: animation,
              width: width,
            ),
          ),
          buildContent(context),
        ],
      ),
    );
  }

  Widget buildContent(BuildContext context) {
    Novel novel = widget.novel;
    var width = Screen.width;
    var percent= preferences.getString(SPConstant().ReaderPercent);
    percent ??= '0.0';
    print(novel);
    return Container(
      width: width,
      padding: EdgeInsets.fromLTRB(15, 54 + Screen.topSafeHeight, 10, 0),
      color: Colors.transparent,
      child: GestureDetector(
        onTap: () {
          AppNavigator.pushNovelDetail(context, novel);
        },
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            DecoratedBox(
              child: NovelCoverImage(novel.imgUrl, width: 120, height: 160),
              decoration: BoxDecoration(boxShadow: Styles.borderShadow),
            ),
            SizedBox(width: 20),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  SizedBox(height: 40),
                  Text(novel.name, style: TextStyle(fontSize: 20, color: Colors.white, fontWeight: FontWeight.bold)),
                  SizedBox(height: 20),
                  GestureDetector(child: Row(
                    children: <Widget>[
                      Text('已阅读'+percent+'%     继续阅读', style: TextStyle(fontSize: 14, color: Color(0xFFF5F5F5))),
                      Image.asset('assets/img/bookshelf_continue_read.png'),
                    ],
                  ),
                    onTap: (){
                      AppNavigator.pushReader(context, 1000);
                    },
                  )
                ],
              ),
            )
          ],
        ),
      ),
    );
  }
}
