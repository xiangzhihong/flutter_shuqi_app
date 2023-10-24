import 'package:flutter/material.dart';
import 'dart:async';

import '../app/request.dart';
import '../app/sq_color.dart';
import '../app/user_manager.dart';
import '../public.dart';
import 'search_appbar.dart';

class SearchPage extends StatefulWidget {
  @override
  State<StatefulWidget> createState() => SearchPageState();
}

class SearchPageState extends State<SearchPage> {
  TextEditingController? searchController = TextEditingController();
  List<Widget> wrapChild = [];
  List<String> textList = [
    '最强万岁爷',
    '都市逍遥医仙',
    '绝世强龙',
    '九天仙女',
    '寒门败家子',
    '医妃当道：邪王欺上门',
    '不负当年晴时雨',
    '天师寻龙诀',
    '盖世神医',
  ];

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return  Scaffold(
      appBar: SearchAppBar(
        onCancel: () {
          Navigator.pop(context);
        },
        onChanged: (value) {},
        onSearch: (value) {
          print('onSearch====》'+value);
        },
      ),
      body: buildBody(),
    );
  }

  Widget buildBody() {
    return Container(
      color: Colors.white,
      width: double.infinity,
      child: Column(
        children: <Widget>[
          buildHotTitle(),
          buildRecommend()
        ],
      ),
    );
  }

  buildHotTitle() {
    return Container(
      alignment: Alignment.centerLeft,
      margin: EdgeInsets.only(top: 10, bottom: 10, left: 20),
      child: const Text(
        '热门搜索',
        style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
      ),
    );
  }

  buildRecommend() {
    for (int i = 0; i < textList.length; i++) {
      wrapChild.add(Container(
          decoration: const BoxDecoration(
              color: Color(0xFFF6F6F6),
              borderRadius: BorderRadius.all(Radius.circular(5))),
          padding: EdgeInsets.only(left: 10, right: 10, top: 5, bottom: 5),
          child: Text(
            textList[i],
            style: TextStyle(fontSize: 14),
          )));
    }
    return Wrap(spacing: 10, runSpacing: 8, children: wrapChild);
  }
}
