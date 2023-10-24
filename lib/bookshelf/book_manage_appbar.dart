import 'package:flutter/material.dart';

import '../app/constant.dart';
import '../utility/event_bus.dart';

// GlobalKey<BookManageAppBarState> bookManageKey = GlobalKey();

class BookManageAppBar extends StatefulWidget implements PreferredSizeWidget {
  BookManageAppBar({
    required this.onAllSelected,
    required this.onFinish,
  });

  final ValueChanged onAllSelected;
  final VoidCallback onFinish;

  @override
  BookManageAppBarState createState() => BookManageAppBarState();

  @override
  Size get preferredSize => Size.fromHeight(kToolbarHeight);
}

class BookManageAppBarState extends State<BookManageAppBar> {
  int selectedCount = 0;
  bool isAllSelected = false;

  @override
  void initState() {
    super.initState();
    eventBus.on(EventBookCount, (arg) {
      setState(() {
        selectedCount = arg as int;
      });
    });
  }

  buildCancel() {
    return GestureDetector(
      onTap: () {
        widget.onFinish();
      },
      child: const Text(
        '完成',
        style: TextStyle(fontSize: 16, color: Colors.grey),
      ),
    );
  }

  buildAllSelected() {
    return GestureDetector(
      onTap: () {
        isAllSelected = !isAllSelected;
        widget.onAllSelected(isAllSelected);
        setState(() {});
      },
      child: Text(
        isAllSelected ? '取消' : '全选',
        style: TextStyle(fontSize: 16, color: Colors.grey),
      ),
    );
  }

  buildContent() {
    return Expanded(
        child: Center(
      child: Text('共选择${selectedCount}个',
          style: const TextStyle(
              fontSize: 20, color: Colors.black, fontWeight: FontWeight.bold)),
    ));
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
        child: Container(
      color: Colors.white,
      padding: EdgeInsets.only(left: 15, right: 15, top: 10, bottom: 10),
      child: Row(
        children: [buildAllSelected(), buildContent(), buildCancel()],
      ),
    ));
  }

  // setSelectedCount(int count) {
  //   setState(() {
  //     selectedCount = count;
  //   });
  // }
}
