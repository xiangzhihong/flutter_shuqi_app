import 'package:flutter/material.dart';
import '../app/app_navigator.dart';
import '../model/novel.dart';
import 'novel_cover_image.dart';


class NovelCoverView extends StatelessWidget {
  final Novel novel;

  NovelCoverView(this.novel);

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        AppNavigator.pushNovelDetail(context, novel);
      },
      child: Container(
        width: 90,
        margin: const EdgeInsets.symmetric(horizontal: 7),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            NovelCoverImage(
              novel.imgUrl,
              width: 90,
              height: 120,
            ),
            const SizedBox(height: 10),
            Text(novel.name, style: TextStyle(fontSize: 12, fontWeight: FontWeight.bold), maxLines: 2),
          ],
        ),
      ),
    );
  }
}
