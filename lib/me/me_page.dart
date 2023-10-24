import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import 'me_header.dart';
import 'setting_page.dart';
import 'me_cell.dart';

class MePage extends StatelessWidget {

  Widget buildCells(BuildContext context) {
    return Container(
      child: Column(
        children: <Widget>[
          MeCell(
            title: '我的钱包',
            iconName: 'assets/img/me_wallet.png',
            onPressed: () {},
          ),
          MeCell(
            title: '消费充值记录',
            iconName: 'assets/img/me_record.png',
            onPressed: () {},
          ),
          MeCell(
            title: '购买的书',
            iconName: 'assets/img/me_buy.png',
            onPressed: () {},
          ),
          MeCell(
            title: '我的会员',
            iconName: 'assets/img/me_vip.png',
            onPressed: () {},
          ),
          MeCell(
            title: '绑兑换码',
            iconName: 'assets/img/me_coupon.png',
            onPressed: () {},
          ),
          MeCell(
            title: '我的收藏',
            iconName: 'assets/img/me_favorite.png',
            onPressed: () {},
          ),
          MeCell(
            title: '设置',
            iconName: 'assets/img/me_setting.png',
            onPressed: () {
              Navigator.push(context, MaterialPageRoute(builder: (context) {
                return SettingPage();
              }));
            },
          ),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: AnnotatedRegion(
        value: SystemUiOverlayStyle.dark,
        child: Container(
          color: Colors.white,
          child: ListView(
            children: <Widget>[
              MeHeader(),
              SizedBox(height: 10),
              buildCells(context),
            ],
          ),
        ),
      ),
    );
  }
}
