import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_shuji_app/app/user_manager.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../bookshelf/bookshelf_scene.dart';
import '../global.dart';
import '../home/home_scene.dart';
import '../me/me_page.dart';
import '../utility/event_bus.dart';
import 'constant.dart';


class RootPage extends StatefulWidget {
  @override
  State<StatefulWidget> createState() => RootPageState();
}

class RootPageState extends State<RootPage> {
  int _tabIndex = 1;
  final List<Image> _tabImages = [
    Image.asset('assets/img/tab_bookshelf_n.png'),
    Image.asset('assets/img/tab_bookstore_n.png'),
    Image.asset('assets/img/tab_me_n.png'),
  ];
  final List<Image> _tabSelectedImages = [
    Image.asset('assets/img/tab_bookshelf_p.png'),
    Image.asset('assets/img/tab_bookstore_p.png'),
    Image.asset('assets/img/tab_me_p.png'),
  ];

  @override
  void initState() {
    super.initState();
    setupApp();
    eventBus.on(EventUserLogin, (arg) {
      setState(() {});
    });
    eventBus.on(EventUserLogout, (arg) {
      setState(() {});
    });
    eventBus.on(EventToggleTabBarIndex, (arg) {
      setState(() {
        _tabIndex = arg;
      });
    });
  }

  @override
  void dispose() {
    eventBus.off(EventUserLogin);
    eventBus.off(EventUserLogout);
    eventBus.off(EventToggleTabBarIndex);
    super.dispose();
  }

  setupApp() async {
    preferences = await SharedPreferences.getInstance();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: IndexedStack(
        index: _tabIndex,
        children: <Widget>[
          BookshelfPage(),
          BookCityPage(),
          MePage(),
        ],
      ),
      bottomNavigationBar: CupertinoTabBar(
        backgroundColor: Colors.white,
        activeColor: const Color(0xFF23B38E),
        items: <BottomNavigationBarItem>[
          BottomNavigationBarItem(icon: getTabIcon(0), label: '书架'),
          BottomNavigationBarItem(icon: getTabIcon(1), label: '书城'),
          BottomNavigationBarItem(icon: getTabIcon(2), label: '我的'),
        ],
        currentIndex: _tabIndex,
        onTap: (index) {
          setState(() {
            _tabIndex = index;
          });
        },
      ),
    );
  }

  Image getTabIcon(int index) {
    if (index == _tabIndex) {
      return _tabSelectedImages[index];
    } else {
      return _tabImages[index];
    }
  }
}
