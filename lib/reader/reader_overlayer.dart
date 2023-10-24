import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

import '../global.dart';
import '../public.dart';
import '../utility/screen.dart';
import 'battery_view.dart';

class ReaderOverLayer extends StatelessWidget {
  final Article article;
  final int page;
  final double topSafeHeight;

  ReaderOverLayer({required this.article, required this.page, required this.topSafeHeight});

  @override
  Widget build(BuildContext context) {
    var format = DateFormat('HH:mm');
    var time = format.format(DateTime.now());
    var percent=(page/article.pageCount).toStringAsFixed(2);
    //保存阅读记录
    preferences.setString(SPConstant().ReaderPercent, percent);
    return Container(
      padding: EdgeInsets.fromLTRB(15, 10 + topSafeHeight, 15, 10 + Screen.bottomSafeHeight),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          Text(article.title, style: TextStyle( color: Color(0xff8B7961))),
          Expanded(child: Container()),
          Row(
            children: <Widget>[
              BatteryView(),
              SizedBox(width: 10),
              Text(time, style: TextStyle(fontSize: 11, color: Color(0xff8B7961))),
              Expanded(child: Container()),
              Text('第${page + 1}页', style: TextStyle(fontSize: 11, color: Color(0xff8B7961))),
              SizedBox(width: 10),
              Text(percent+'%', style: TextStyle(fontSize: 11, color: Color(0xff8B7961))),
            ],
          ),
        ],
      ),
    );
  }
}