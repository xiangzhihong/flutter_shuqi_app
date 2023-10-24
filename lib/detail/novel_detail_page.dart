import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_shuji_app/detail/novel_all_comment_page.dart';
import '../public.dart';
import '../utility/screen.dart';
import 'novel_detail_header.dart';
import 'novel_summary_view.dart';
import 'novel_detail_toolbar.dart';
import 'novel_detail_recommend_view.dart';
import 'novel_detail_cell.dart';
import 'novel_comment_cell.dart';

class NovelDetailPage extends StatefulWidget {
  final String novelId;

  NovelDetailPage(this.novelId);

  @override
  NovelDetailPageState createState() => NovelDetailPageState();
}

class NovelDetailPageState extends State<NovelDetailPage> with RouteAware {
  Novel? novel;
  List<Novel> recommendNovels = [];
  List<NovelComment> comments = [];
  ScrollController scrollController = ScrollController();
  double navAlpha = 0;
  bool isSummaryUnfold = false;
  int commentCount = 0;
  int commentMemberCount = 0;

  @override
  void initState() {
    super.initState();
    fetchData();
    addScrollListener();
  }

  addScrollListener() {
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

  @override
  void dispose() {
    scrollController.dispose();
    super.dispose();
  }

  changeSummaryMaxLines() {
    setState(() {
      isSummaryUnfold = !isSummaryUnfold;
    });
  }

  back() {
    Navigator.pop(context);
  }

  fetchData() async {
    var novelId = widget.novelId;
    var novelResponse =
        await Request.post(action: 'novel_detail', params: {'id': novelId});
    var commentsResponse =
        await Request.post(action: 'novel_comment', params: {'id': novelId});
    List<NovelComment> comments = [];
    commentsResponse.forEach((data) {
      comments.add(NovelComment.fromJson(data));
    });

    var recommendResponse =
        await Request.post(action: 'novel_recommend', params: {'id': novelId});
    List<Novel> recommendNovels = [];
    recommendResponse.forEach((data) {
      recommendNovels.add(Novel.fromJson(data));
    });

    setState(() {
      novel = Novel.fromJson(novelResponse);
      this.comments = comments;
      this.recommendNovels = recommendNovels;
    });
  }

  Widget buildNavigationBar() {
    return Stack(
      children: <Widget>[
        Container(
          width: 44,
          height: Screen.navigationBarHeight,
          padding: EdgeInsets.fromLTRB(5, Screen.topSafeHeight, 0, 0),
          child: GestureDetector(
              onTap: back, child: Image.asset('assets/img/back_white.png')),
        ),
        Opacity(
          opacity: navAlpha,
          child: Container(
            decoration: BoxDecoration(
                color: Colors.white, boxShadow: Styles.borderShadow),
            padding: EdgeInsets.fromLTRB(5, Screen.topSafeHeight, 0, 0),
            height: Screen.navigationBarHeight,
            child: Row(
              children: <Widget>[
                Container(
                  width: 44,
                  child: GestureDetector(
                      onTap: back,
                      child: Image.asset('assets/img/back_gray.png')),
                ),
                Expanded(
                  child: Text(
                    novel!.name,
                    style: TextStyle(fontSize: 17, fontWeight: FontWeight.bold),
                    textAlign: TextAlign.center,
                  ),
                ),
                Container(width: 44),
              ],
            ),
          ),
        )
      ],
    );
  }

  Widget buildComment() {
    return Container(
      color: Colors.white,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          Container(
            padding: EdgeInsets.symmetric(vertical: 15),
            child: Row(
              children: <Widget>[
                Image.asset('assets/img/home_tip.png'),
                SizedBox(width: 13),
                Text('书友评价', style: TextStyle(fontSize: 16)),
                Expanded(child: Container()),
                Image.asset('assets/img/detail_write_comment.png'),
                SizedBox(width: 8,),
                GestureDetector(
                  child: Text('写书评',
                      style: TextStyle(fontSize: 14, color: Color(0xFF23B38E))),
                  onTap: (){
                    AppNavigator.pushComment(context);
                  },
                ),
                SizedBox(width: 15),
              ],
            ),
          ),
          Divider(height: 1),
          Column(
            children:
                comments.map((comment) => NovelCommentCell(comment)).toList(),
          ),
          GestureDetector(
            child: Container(
              padding: EdgeInsets.symmetric(vertical: 15),
              child: Center(
                child: Text(
                  '查看全部评论（${novel!.commentCount}条）',
                  style: TextStyle(fontSize: 14, color: Color(0xFF888888)),
                ),
              ),
            ),
            onTap: (){
              AppNavigator.pushAllComments(context, widget.novelId);
            },
          )
        ],
      ),
    );
  }

  Widget buildTags() {
    var colors = [Color(0xFFF9A19F), Color(0xFF59DDB9), Color(0xFF7EB3E7)];
    var i = 0;
    var tagWidgets = novel!.tags.map((tag) {
      var color = colors[i % 3];
      var tagWidget = Container(
        decoration: BoxDecoration(
          border: Border.all(
              color: Color.fromARGB(99, color.red, color.green, color.blue),
              width: 0.5),
          borderRadius: BorderRadius.circular(3),
        ),
        padding: EdgeInsets.fromLTRB(6, 3, 6, 3),
        child: Text(tag, style: TextStyle(fontSize: 14, color: colors[i % 3])),
      );
      i++;
      return tagWidget;
    }).toList();
    return Container(
      padding: EdgeInsets.fromLTRB(15, 15, 15, 15),
      color: Colors.white,
      child: Wrap(runSpacing: 10, spacing: 10, children: tagWidgets),
    );
  }

  @override
  Widget build(BuildContext context) {
    if (this.novel == null) {
      return Scaffold(appBar: AppBar(elevation: 0));
    }
    var novel = this.novel!;
    return Scaffold(
      body: AnnotatedRegion(
        value: navAlpha > 0.5
            ? SystemUiOverlayStyle.dark
            : SystemUiOverlayStyle.light,
        child: Stack(
          children: <Widget>[
            Column(
              children: <Widget>[
                Expanded(
                  child: ListView(
                    controller: scrollController,
                    padding: EdgeInsets.only(top: 0),
                    children: <Widget>[
                      NovelDetailHeader(novel),
                      buildContentTitle(),
                      NovelSummaryView(novel.introduction, isSummaryUnfold,
                          changeSummaryMaxLines),
                      Divider(height: 1, indent: 15),
                      buildLastView(novel),
                      buildChapter(context,novel),
                      buildTags(),
                      SizedBox(height: 10),
                      buildComment(),
                      SizedBox(height: 10),
                      NovelDetailRecommendView(recommendNovels),
                    ],
                  ),
                ),
                NovelDetailToolbar(novel),
              ],
            ),
            buildNavigationBar(),
          ],
        ),
      ),
    );
  }

  buildContentTitle() {
    return Container(
      color: Colors.white,
      padding: EdgeInsets.only(left: 15, top: 10),
      child: const Text(
        '内容简介',
        style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
      ),
    );
  }

  buildLastView(novel) {
    return NovelDetailCell(
      iconName: 'assets/img/detail_latest.png',
      title: '最新',
      subtitle: novel.lastChapter.title,
      attachedWidget: Text(novel.status,
          style: TextStyle(fontSize: 14, color: novel.statusColor())),
    );
  }

  buildChapter(context,novel) {
    return GestureDetector(
      child: NovelDetailCell(
        iconName: 'assets/img/detail_chapter.png',
        title: '目录',
        subtitle: '共${novel.chapterCount}章',
      ),
      onTap: () {
        AppNavigator.pushChapter(context,novel);
      },
    );
  }
}
