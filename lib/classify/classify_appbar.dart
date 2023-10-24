import 'package:flutter/material.dart';

class ClassifyAppBar extends StatefulWidget implements PreferredSizeWidget {
  ClassifyAppBar({
    required this.onCancel,
  });

  final VoidCallback onCancel;

  @override
  ClassifyAppBarState createState() => ClassifyAppBarState();

  @override
  Size get preferredSize => Size.fromHeight(kToolbarHeight);
}

class ClassifyAppBarState extends State<ClassifyAppBar> {
  @override
  void initState() {
    super.initState();
  }

  buildTabBar() {
    return const SizedBox(
        width: 240,
        child: TabBar(
          labelColor: Colors.black,
          labelStyle: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
          unselectedLabelColor: Color(0xFF888888),
          unselectedLabelStyle:
              TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
          indicator: BoxDecoration(),
          tabs: [
            Tab(text: '推荐'),
            Tab(text: '女生'),
            Tab(text: '男生'),
          ],
        ));
  }

  buildCancel() {
    return GestureDetector(
      onTap: () {
        widget.onCancel();
      },
      child: const Text(
        '取消',
        style: TextStyle(fontSize: 16, color: Colors.green),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
        child: Container(
      padding: EdgeInsets.only(left: 15, right: 15, top: 10, bottom: 10),
      child: DefaultTabController(
        length: 3,
        child: Row(
          children: [
            buildTabBar(),
            Expanded(child: Container()),
            buildCancel()],
        ),
      ),
    ));
  }
}
