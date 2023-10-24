import 'package:flutter/material.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';

import '../app/request.dart';
import '../model/novel_comment.dart';
import 'novel_comment_cell.dart';

class AllCommentPage extends StatefulWidget {
  final String novelId;

  AllCommentPage(this.novelId);

  @override
  State<StatefulWidget> createState() => AllCommentPageState();
}

class AllCommentPageState extends State<AllCommentPage> {
  List<NovelComment> comments = [];

  @override
  void initState() {
    super.initState();
    fetchData();
  }

  Future<void> fetchData() async {
    var commentsResponse = await Request.post(
        action: 'novel_all_comment', params: {'id': widget.novelId});
    List<NovelComment> comments = [];
    commentsResponse.forEach((data) {
      comments.add(NovelComment.fromJson(data));
    });
    setState(() {
      this.comments = comments;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: buildAppBar(),
      body: buildBody(),
    );
  }

  buildAppBar() {
    return AppBar(
      title: const Text(
        '全部评论',
        style: TextStyle(color: Colors.black),
      ),
      centerTitle: true,
      backgroundColor: Colors.white,
      elevation: 0.3,
      leading: GestureDetector(
        child: Image.asset('assets/img/back_gray.png'),
        onTap: () {
          Navigator.pop(context);
        },
      ),
    );
  }

  buildBody() {
    return Container(
      color: Colors.white,
      padding: EdgeInsets.only(top: 15),
      child: Column(
        children:
        comments.map((comment) => NovelCommentCell(comment)).toList(),
      ),
    );
  }
}
