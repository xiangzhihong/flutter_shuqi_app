import 'package:flutter/material.dart';

import '../app/user_manager.dart';


class SettingPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    List<Widget> children = [];
    if (UserManager.instance.isLogin) {
      children.add(GestureDetector(
        onTap: () {
          Navigator.pop(context);
          UserManager.instance.logout();
        },
        child: Container(
          height: 50,
          color: Colors.white,
          child: Center(
            child: Text('退出登录', style: TextStyle(fontSize: 16, color: Color(0xFFFF2B45))),
          ),
        ),
      ));
    }
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          '设置',
          style: TextStyle(color: Colors.black),
        ),
        centerTitle: true,
        elevation: 0.5,
        backgroundColor: Colors.white,
        leading: GestureDetector(
          child: Image.asset('assets/img/back_gray.png'),
          onTap: (){
            Navigator.pop(context);
          },
        ),
      ),
      body: Container(
        child: ListView(
          children: children,
        ),
      ),
    );
  }
}
