import 'package:flutter/material.dart';
import 'package:flutter_shuji_app/widget/confirm_dialog.dart';
import '../public.dart';
import '../utility/pop_util.dart';
import '../widget/input_dialog.dart';
import 'book_manage_appbar.dart';
import 'book_manage_item_view.dart';

class BookManagePage extends StatefulWidget {
  @override
  State<StatefulWidget> createState() => BookManagePageState();
}

class BookManagePageState extends State<BookManagePage> {
  List<Novel> favoriteNovels = [];
  Iterable<Novel> novels = [];

  Future<void> fetchData() async {
    try {
      List<Novel> favoriteNovels = [];
      List<dynamic> favoriteResponse =
          await Request.get(action: 'bookshelf_recommend');
      for (var data in favoriteResponse) {
        favoriteNovels.add(Novel.fromJson(data));
      }
      setState(() {
        this.favoriteNovels = favoriteNovels;
      });
    } catch (e) {
      print(e.toString());
    }
  }

  @override
  void initState() {
    super.initState();
    fetchData();
    bookChangeListener();
  }

  void bookChangeListener() {
    int select = 0;
    eventBus.on(EventBookCountChange, (arg) {
      //重新计算选中的个数
      for (var novel in novels) {
        if (novel.isSelected) {
          select = select + 1;
        }
      }
      eventBus.emit(EventBookCount, select);
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: BookManageAppBar(
        onAllSelected: (allSelected) {
          if (allSelected) {
            // bookManageKey.currentState?.setSelectedCount(novels.length);
            eventBus.emit(EventBookCount, novels.length);
            eventBus.emit(EventBookManageAll, true);
          } else {
            // bookManageKey.currentState?.setSelectedCount(0);
            eventBus.emit(EventBookCount, 0);
            eventBus.emit(EventBookManageAll, false);
          }
        },
        onFinish: () {
          Navigator.pop(context);
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
          Expanded(child: buildFavoriteView()),
          buildBottomView()
        ],
      ),
    );
  }

  buildFavoriteView() {
    if (favoriteNovels.length <= 1) {
      return Container();
    }
    List<Widget> children = [];
    //取前5条数据
    novels = favoriteNovels.sublist(1).take(5);
    for (var novel in novels) {
      children.add(BookManageItemView(novel));
    }
    return Container(
      padding: EdgeInsets.fromLTRB(15, 10, 15, 10),
      child: Wrap(
        spacing: 23,
        children: children,
      ),
    );
  }

  buildBottomView() {
    return Container(
      margin: EdgeInsets.only(bottom: 30),
      child: Row(
        children: [
          Flexible(
              child: GestureDetector(
            onTap: moveBook,
            child: Center(
              child: Column(
                children: [
                  Image.asset('assets/img/bookshelf_move_group.webp',
                      width: 28, height: 28),
                  const Text(
                    '移动至分组',
                    style: TextStyle(fontSize: 14),
                  )
                ],
              ),
            ),
          )),
          Flexible(
              child: GestureDetector(
            onTap: () {
              delBook();
            },
            child: Center(
              child: Column(
                children: [
                  Image.asset('assets/img/bookshelf_delete_selected.webp',
                      width: 28, height: 28),
                  const Text(
                    '删除',
                    style: TextStyle(fontSize: 14),
                  )
                ],
              ),
            ),
          )),
        ],
      ),
    );
  }

  moveBook() {
    PopUtil.showPopDialog(
        context,
        InputDialog(
          title: '新建分组',
          hint: '请输入分组名称（最多12个字）',
          onCancel: () {
            print('onCancel');
          },
          onConfirm: (value){
            print('onConfirm: '+value);
          },
        )
    );
  }

  void delBook() {
    PopUtil.showPopDialog(
        context,
        ConfirmDialog(
          title: '提示',
          content: '确定将所选书籍从书架中移除吗？',
          onCancel: () {},
          onConfirm: () {},
        ));
  }
}
