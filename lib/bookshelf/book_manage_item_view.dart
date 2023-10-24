import 'package:flutter/material.dart';

import '../model/novel.dart';
import '../public.dart';
import '../utility/screen.dart';
import '../widget/novel_cover_image.dart';


class BookManageItemView extends StatefulWidget {
  final Novel novel;

  BookManageItemView(this.novel);

  @override
  BookManageItemViewState createState() => BookManageItemViewState();
}

class BookManageItemViewState extends State<BookManageItemView> {
  var isSelected = false;

  @override
  void initState() {
    super.initState();
    eventBus.on(EventBookManageAll, (arg) {
      setState(() {
        isSelected = arg as bool ;
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    var width = (Screen.width - 15 * 2 - 24 * 2) / 3;
    return GestureDetector(
      onTap: () {
        setState(() {
          isSelected = !isSelected;
          widget.novel.isSelected=isSelected;
        });
        //选中通知
        eventBus.emit(EventBookCountChange, true);
      },
      child: Container(
        width: width,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            DecoratedBox(
              decoration: BoxDecoration(boxShadow: [
                BoxShadow(color: Color(0x22000000), blurRadius: 5)
              ]),
              child: Stack(
                children: [
                  NovelCoverImage(
                    widget.novel.imgUrl,
                    width: width,
                    height: width / 0.75,
                  ),
                  buildSelectedView(),
                ],
              ),
            ),
            SizedBox(height: 10),
            Text(widget.novel.name,
                style: TextStyle(fontSize: 14),
                maxLines: 1,
                overflow: TextOverflow.ellipsis),
            SizedBox(height: 15),
          ],
        ),
      ),
    );
  }

  buildSelectedView() {
    if (isSelected) {
      return Positioned(
          bottom: 10,
          right: 10,
          child: Image.asset(
            'assets/img/ic_selected_all.webp',
            width: 24,
            height: 24,
          ));
    }
    return Container();
  }
}
