import 'package:flutter/material.dart';
import 'package:flutter_shuji_app/app/app_navigator.dart';


import 'home_model.dart';

class HomeMenu extends StatelessWidget {
  final List<MenuInfo> infos;

  HomeMenu(this.infos);

  @override
  Widget build(BuildContext context) {
    return Container(
      color: Colors.white,
      padding: EdgeInsets.symmetric(vertical: 10),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        children: infos.map((info) => menuItem(info,context)).toList(),
      ),
    );
  }

  Widget menuItem(MenuInfo info, BuildContext context) {
    return GestureDetector(
      child: Column(
        children: <Widget>[
          Image.asset(info.icon),
          SizedBox(height: 5),
          Text(info.title, style: TextStyle(fontSize: 12, color: Color(0xFF888888))),
        ],
      ),
      onTap: (){
         AppNavigator.pushClassify(context);
      },
    );
  }
}
