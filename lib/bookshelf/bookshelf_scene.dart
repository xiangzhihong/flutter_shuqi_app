import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_shuji_app/search/search_page.dart';
import '../model/man_cool.dart';
import '../public.dart';
import '../utility/screen.dart';
import 'bookshelf_item_view.dart';
import 'bookshelf_header.dart';
import 'bookshelf_list_item_view.dart';

/**
 * 书架
 */
class BookshelfPage extends StatefulWidget {
  @override
  State<StatefulWidget> createState() => BookshelfState();
}

class BookshelfState extends State<BookshelfPage> with RouteAware {
  ScrollController scrollController = ScrollController();
  double navAlpha = 0;
  List<Novel> favoriteNovels = [];
  List<Items> manCoolItems = [];
  List<Items> womenItems = [];

  @override
  void initState() {
    super.initState();
    fetchData();
    scrollListener();
  }

  void scrollListener() {
    scrollController.addListener(() {
      var offset = scrollController.offset;
      if (offset < 0) {
        if (navAlpha != 0) {
          setState(() {
            navAlpha = 0;
          });
        }
      } else if (offset < 50) {
        setState(() {
          navAlpha = 1 - (50 - offset) / 50;
        });
      } else if (navAlpha != 1) {
        setState(() {
          navAlpha = 1;
        });
      }
    });
  }

  Future<void> fetchData() async {
    fetchRecommendData();
    fetchManData();
    fetchWomenData();
  }

  Future<void> fetchRecommendData() async {
    List<Novel> favoriteNovels = [];
    List<dynamic> favoriteResponse =
        await Request.get(action: 'bookshelf_recommend');
    for (var data in favoriteResponse) {
      favoriteNovels.add(Novel.fromJson(data));
    }
    setState(() {
      this.favoriteNovels = favoriteNovels;
    });
  }

  Future<void> fetchManData() async {
    List<Items> items = [];
    var response = await Request.get(action: 'man_cool');
    ManCool data = ManCool.fromJson(response);
    for (var item in data.items) {
      items.add(item);
    }
    setState(() {
      manCoolItems = items;
    });
  }

  Future<void> fetchWomenData() async {
    List<Items> items = [];
    var response = await Request.get(action: 'women_selling');
    ManCool data = ManCool.fromJson(response);
    for (var item in data.items) {
      items.add(item);
    }
    setState(() {
      womenItems = items;
    });
  }

  Widget buildActions(Color iconColor) {
    return Row(children: <Widget>[
      Container(
        height: kToolbarHeight,
        width: 44,
        child:
            Image.asset('assets/img/actionbar_checkin.png', color: iconColor),
      ),
      GestureDetector(
        child: Container(
          height: kToolbarHeight,
          width: 44,
          child:
              Image.asset('assets/img/actionbar_search.png', color: iconColor),
        ),
        onTap: () {
          Navigator.push(context, MaterialPageRoute(builder: (context) {
            return SearchPage();
          }));
        },
      ),
      const SizedBox(width: 15)
    ]);
  }

  Widget buildNavigationBar() {
    return Stack(
      children: <Widget>[
        Positioned(
          right: 0,
          child: Container(
            margin: EdgeInsets.fromLTRB(5, Screen.topSafeHeight, 0, 0),
            child: buildActions(Colors.white),
          ),
        ),
        Opacity(
          opacity: navAlpha,
          child: Container(
            padding: EdgeInsets.fromLTRB(5, Screen.topSafeHeight, 0, 0),
            height: Screen.navigationBarHeight,
            color: Colors.white,
            child: Row(
              children: <Widget>[
                SizedBox(width: 103),
                const Expanded(
                  child: Text(
                    '书架',
                    style: TextStyle(fontSize: 17, fontWeight: FontWeight.bold),
                    textAlign: TextAlign.center,
                  ),
                ),
                buildActions(Color(0xFF333333)),
              ],
            ),
          ),
        )
      ],
    );
  }

  buildFavoriteTitle() {
    return Container(
      padding: EdgeInsets.only(left: 15, top: 10, right: 15, bottom: 5),
      child: const Text('我的书架',
          style: TextStyle(fontWeight: FontWeight.bold, fontSize: 18)),
    );
  }

  buildFavoriteView() {
    if (favoriteNovels.length <= 1) {
      return Container();
    }
    List<Widget> children = [];
    //取前8条数据
    var novels = favoriteNovels.sublist(1).take(5);
    for (var novel in novels) {
      children.add(BookshelfItemView(novel));
    }
    var width = (Screen.width - 15 * 2 - 24 * 2) / 3;
    children.add(GestureDetector(
      onTap: () {
        eventBus.emit(EventToggleTabBarIndex, 1);
      },
      child: Container(
        color: Color(0xFFF5F5F5),
        width: width,
        height: width / 0.75,
        child: Image.asset('assets/img/bookshelf_add.png'),
      ),
    ));
    return Container(
      padding: EdgeInsets.fromLTRB(15, 10, 15, 10),
      child: Wrap(
        spacing: 23,
        children: children,
      ),
    );
  }

  buildManTitle() {
    return Container(
      padding: EdgeInsets.only(left: 15, right: 15, bottom: 10),
      child: const Row(
        children: [
          Expanded(
              child: Text('男生爽文',
                  style: TextStyle(fontWeight: FontWeight.bold, fontSize: 18))),
          Text('换一换',
              style: TextStyle(
                  fontWeight: FontWeight.bold,
                  fontSize: 14,
                  color: Color(0xFF51DEC6)))
        ],
      ),
    );
  }

  buildManView() {
    return Container(
        padding: EdgeInsets.only(left: 15, right: 15, top: 5, bottom: 30),
        child: ListView.separated(
          physics: const NeverScrollableScrollPhysics(),
          shrinkWrap: true,
          itemCount: manCoolItems.length,
          itemBuilder: (context, index) {
            return BookshelfListItemView(manCoolItems[index]);
          },
          separatorBuilder: (context, index) {
            if (index == manCoolItems.length - 1) {
              return Container();
            }
            return Divider(color: Color(0xFFBBBBBB), indent: 20);
          },
        ));
  }

  buildWomenTitle() {
    return Container(
      padding: EdgeInsets.only(left: 15, right: 15, bottom: 10),
      child: const Row(
        children: [
          Expanded(
              child: Text('女生畅销',
                  style: TextStyle(fontWeight: FontWeight.bold, fontSize: 18))),
          Text('换一换',
              style: TextStyle(
                  fontWeight: FontWeight.bold,
                  fontSize: 14,
                  color: Color(0xFF51DEC6)))
        ],
      ),
    );
  }

  buildWomenView() {
    return Container(
        padding: EdgeInsets.only(left: 15, right: 15, top: 5, bottom: 30),
        child: ListView.separated(
          physics: const NeverScrollableScrollPhysics(),
          shrinkWrap: true,
          itemCount: womenItems.length,
          itemBuilder: (context, index) {
            return BookshelfListItemView(womenItems[index]);
          },
          separatorBuilder: (context, index) {
            if (index == womenItems.length - 1) {
              return Container();
            }
            return Divider(color: Color(0xFFBBBBBB), indent: 20);
          },
        ));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: AnnotatedRegion(
        value: navAlpha > 0.5
            ? SystemUiOverlayStyle.dark
            : SystemUiOverlayStyle.light,
        child: Stack(children: [
          RefreshIndicator(
            onRefresh: fetchData,
            child: ListView(
              controller: scrollController,
              children: <Widget>[
                favoriteNovels.isNotEmpty
                    ? BookshelfHeader(favoriteNovels[0])
                    : Container(),
                buildFavoriteTitle(),
                buildFavoriteView(),
                buildManTitle(),
                buildManView(),
                buildWomenTitle(),
                buildWomenView(),
              ],
            ),
          ),
          buildNavigationBar(),
        ]),
      ),
    );
  }
}
