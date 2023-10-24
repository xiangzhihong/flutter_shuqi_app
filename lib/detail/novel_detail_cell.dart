import 'package:flutter/material.dart';

import '../app/sq_color.dart';


class NovelDetailCell extends StatelessWidget {
  final String iconName;
  final String title;
  final String subtitle;
  final Widget? attachedWidget;

  NovelDetailCell({required this.iconName, required this.title, required this.subtitle, this.attachedWidget});

  @override
  Widget build(BuildContext context) {
    return Container(
      color: Colors.white,
      padding: EdgeInsets.symmetric(horizontal: 15),
      child: Column(
        children: <Widget>[
          Container(
            height: 50,
            child: Row(
              children: <Widget>[
                Image.asset(iconName),
                SizedBox(width: 5),
                Text(title, style: TextStyle(fontSize: 16)),
                SizedBox(width: 10),
                Expanded(
                  child: Text(
                    subtitle,
                    style: TextStyle(fontSize: 14, color: Color(0xFF888888)),
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                  ),
                ),
                attachedWidget != null ? attachedWidget! : Container(),
                SizedBox(width: 10),
                Image.asset('assets/img/arrow_right.png'),
              ],
            ),
          ),
          Divider(height: 1),
        ],
      ),
    );
  }
}
