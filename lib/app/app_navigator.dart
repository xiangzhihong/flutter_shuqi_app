import 'package:flutter/material.dart';
import 'package:flutter_shuji_app/app/root_scene.dart';
import 'package:flutter_shuji_app/bookshelf/book_manage_page.dart';
import 'package:flutter_shuji_app/classify/classify_page.dart';
import 'package:flutter_shuji_app/detail/novel_all_comment_page.dart';
import 'package:flutter_shuji_app/detail/novel_chapter_page.dart';
import 'package:flutter_shuji_app/detail/novel_comment_page.dart';

import '../me/login_page.dart';
import '../widget/web_page.dart';
import '../model/novel.dart';
import '../detail/novel_detail_page.dart';
import '../reader/reader_page.dart';


class AppNavigator {
  static push(BuildContext context, Widget scene) {
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (BuildContext context) => scene,
      ),
    );
  }

  static pushMain(BuildContext context) {
    AppNavigator.push(context, RootPage());
  }

  static pushClassify(BuildContext context) {
    AppNavigator.push(context, ClassifyPage());
  }

  static pushNovelDetail(BuildContext context, Novel novel) {
    AppNavigator.push(context, NovelDetailPage(novel.id));
  }

  static pushAllComments(BuildContext context, String novelId) {
    AppNavigator.push(context, AllCommentPage(novelId));
  }

  static pushLogin(BuildContext context) {
    Navigator.push(context, MaterialPageRoute(builder: (context) {
      return LoginPage();
    }));
  }

  static pushChapter(BuildContext context,Novel novel) {
    Navigator.push(context, MaterialPageRoute(builder: (context) {
      return ChapterPage(novel: novel);
    }));
  }

  static pushComment(BuildContext context) {
    AppNavigator.push(context, CommentPage());
  }

  static pushWeb(BuildContext context, String url, String title) {
    Navigator.push(context, MaterialPageRoute(builder: (context) {
      return WebPage(url: url, title: title);
    }));
  }

  static pushReader(BuildContext context, int articleId) {
    Navigator.push(context, MaterialPageRoute(builder: (context) {
      return ReaderPage(articleId: articleId);
    }));
  }

  static pushBookManage(BuildContext context) {
    Navigator.push(context, MaterialPageRoute(builder: (context) {
      return BookManagePage();
    }));
  }
}
