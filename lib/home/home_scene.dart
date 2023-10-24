import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'home_list_view.dart';

class BookCityPage extends StatefulWidget {
  @override
  State<StatefulWidget> createState() => BookCityPageState();
}

class BookCityPageState extends State<BookCityPage> {

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 4,
      child: Scaffold(
        appBar: AppBar(
          systemOverlayStyle: SystemUiOverlayStyle.dark,
          title: Container(
            padding: const EdgeInsets.symmetric(horizontal: 15),
            child: const TabBar(
              labelColor: Color(0xFF333333),
              labelStyle: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
              unselectedLabelColor: Color(0xFF888888),
              indicatorColor: Color(0xFF51DEC6),
              indicatorSize: TabBarIndicatorSize.label,
              indicatorWeight: 3,
              indicatorPadding: EdgeInsets.fromLTRB(8, 0, 8, 5),
              tabs: [
                Tab(text: '精选'),
                Tab(text: '女生'),
                Tab(text: '男生'),
                Tab(text: '漫画'),
              ],
            ),
          ),
          backgroundColor: Colors.white,
        ),
        body: TabBarView(children: [
          HomeListView(HomeListType.excellent),
          HomeListView(HomeListType.female),
          HomeListView(HomeListType.male),
          HomeListView(HomeListType.cartoon),
        ]),
      ),
    );
  }
}
