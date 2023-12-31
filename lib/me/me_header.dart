import 'package:flutter/material.dart';
import 'package:cached_network_image/cached_network_image.dart';

import '../app/app_navigator.dart';
import '../app/user_manager.dart';


class MeHeader extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    var user = UserManager.currentUser;

    return GestureDetector(
      onTap: () {
        if (UserManager.instance.isLogin) {
          AppNavigator.pushWeb(context, 'https://t.shuqi.com/', '书旗小说');
        } else {
          AppNavigator.pushLogin(context);
        }
      },
      child: Container(
        color: Colors.white,
        padding: EdgeInsets.fromLTRB(20, 30, 15, 15),
        child: Row(
          children: <Widget>[
            CircleAvatar(
              radius: 40,
              backgroundImage: (user?.avatarUrl != null ? CachedNetworkImageProvider(user!.avatarUrl) : AssetImage('assets/img/placeholder_avatar.png')) as ImageProvider<Object>?,
            ),
            SizedBox(width: 25),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  Text(
                    user != null ? user.nickname : '登录',
                    style: TextStyle(fontSize: 18),
                  ),
                  SizedBox(height: 10),
                  buildItems(),
                ],
              ),
            )
          ],
        ),
      ),
    );
  }

  Widget buildItems() {
    var user = UserManager.currentUser;

    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: <Widget>[
        buildItem(user != null ? user.wealth.toStringAsFixed(1) : '0.0', '书豆余额'),
        buildItem(user != null ? user.coupon.toString() : '0', '书券（张）'),
        buildItem(user != null ? user.monthlyTicket.toString() : '0', '月票'),
        Container(),
      ],
    );
  }

  Widget buildItem(String title, String subtitle) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        Text(
          title,
          style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
        ),
        SizedBox(height: 5),
        Text(
          subtitle,
          style: TextStyle(fontSize: 12, color: Color(0xFF888888)),
        ),
      ],
    );
  }
}
