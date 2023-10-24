import 'package:flutter/material.dart';

import '../app/app_navigator.dart';
import '../model/novel.dart';
import '../public.dart';
import '../utility/screen.dart';
import '../widget/novel_cover_image.dart';


class BookshelfItemView extends StatelessWidget {
  final Novel novel;
  BookshelfItemView(this.novel);

  @override
  Widget build(BuildContext context) {
    var width = (Screen.width - 15 * 2 - 24 * 2) / 3;
    return GestureDetector(
      onTap: () {
        AppNavigator.pushNovelDetail(context, novel);
      },
      onLongPress: (){
        AppNavigator.pushBookManage(context);
      },
      child: Container(
        width: width,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            DecoratedBox(
              decoration: BoxDecoration(boxShadow: [BoxShadow(color: Color(0x22000000), blurRadius: 5)]),
              child: NovelCoverImage(
                novel.imgUrl,
                width: width,
                height: width / 0.75,
              ),
            ),
            SizedBox(height: 10),
            Text(novel.name, style: TextStyle(fontSize: 14), maxLines: 1, overflow: TextOverflow.ellipsis),
            SizedBox(height: 15),
          ],
        ),
      ),
    );
  }
}
