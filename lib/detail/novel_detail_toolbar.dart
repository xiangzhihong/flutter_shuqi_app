import 'package:flutter/material.dart';
import '../public.dart';
import '../utility/screen.dart';

class NovelDetailToolbar extends StatelessWidget {
  final Novel novel;

  NovelDetailToolbar(this.novel);

  read() {}

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.only(bottom: Screen.bottomSafeHeight),
      decoration:
          BoxDecoration(color: Colors.white, boxShadow: Styles.borderShadow),
      height: 50 + Screen.bottomSafeHeight,
      child: Row(children: <Widget>[
        Expanded(
          child: Center(
            child: Text(
              '加书架',
              style: TextStyle(fontSize: 16, color: Color(0xFF23B38E)),
            ),
          ),
        ),
        Expanded(
          child: GestureDetector(
            onTap: () {
              AppNavigator.pushReader(context, novel.firstArticleId);
            },
            child: Container(
              height: 40,
              decoration: BoxDecoration(
                  color: Color(0xFF23B38E),
                  borderRadius: BorderRadius.circular(5)),
              child: const Center(
                child: Text(
                  '开始阅读',
                  style: TextStyle(fontSize: 16, color: Colors.white),
                ),
              ),
            ),
          ),
        ),
        const Expanded(
          child: Center(
            child: Text(
              '下载',
              style: TextStyle(fontSize: 16, color: Color(0xFF23B38E)),
            ),
          ),
        ),
      ]),
    );
  }
}
