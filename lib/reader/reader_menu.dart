import 'package:flutter/material.dart';
import 'package:flutter_shuji_app/reader/reader_manager.dart';
import 'package:flutter_tts/flutter_tts.dart';
import 'dart:async';
import 'package:provider/provider.dart';
import '../public.dart';
import '../theme/theme_manager.dart';
import '../utility/screen.dart';
import '../widget/toast.dart';

class ReaderMenu extends StatefulWidget {
  final List<Chapter> chapters;
  final int articleIndex;
  final VoidCallback onTap;
  final VoidCallback onPreviousArticle;  //上一章
  final VoidCallback onNextArticle;     //下一章
  final void Function(Chapter chapter) onToggleChapter;

  ReaderMenu(
      {required this.chapters,
      required this.articleIndex,
      required this.onTap,
      required this.onPreviousArticle,
      required this.onNextArticle,
      required this.onToggleChapter});

  @override
  _ReaderMenuState createState() => _ReaderMenuState();
}

class _ReaderMenuState extends State<ReaderMenu>
    with SingleTickerProviderStateMixin {
  late AnimationController animationController;
  late Animation<double> animation;
  late double progressValue;
  late FlutterTts tts;
  bool menuVisible = false; //目录
  bool lightVisible = false; //黑白
  bool fontVisible = false; //字体
  bool settingVisible = false; //设置

  @override
  initState() {
    super.initState();
    iniAnim();
    initTts();
  }

  void iniAnim() {
    progressValue = widget.articleIndex / (widget.chapters.length - 1);
    animationController = AnimationController(
        duration: const Duration(milliseconds: 200), vsync: this);
    animation = Tween(begin: 0.0, end: 1.0).animate(animationController);
    animation.addListener(() {
      setState(() {});
    });
    animationController.forward();
  }

  initTts() async {
    tts = FlutterTts();
    await tts.setLanguage("zh-CN");
    await tts.setSpeechRate(0.5);
    await tts.setVolume(1.0);
    await tts.setPitch(0.5);
    await tts.setSilence(1);
  }

  @override
  void didUpdateWidget(ReaderMenu oldWidget) {
    super.didUpdateWidget(oldWidget);
    progressValue = widget.articleIndex / (widget.chapters.length - 1);
  }

  @override
  void dispose() {
    animationController.dispose();
    tts.stop();
    super.dispose();
  }

  hide() {
    animationController.reverse();
    Timer(const Duration(milliseconds: 200), () {
      widget.onTap();
    });
    setState(() {
      menuVisible = false;
    });
  }

  buildBackView() {
    return Container(
      width: 44,
      child: GestureDetector(
        onTap: () {
          Navigator.pop(context);
        },
        child: Image.asset('assets/img/back_gray.png'),
      ),
    );
  }

  buildReadView() {
    return GestureDetector(
      child: SizedBox(
        width: 44,
        child: Image.asset('assets/img/read_icon_voice.png'),
      ),
      onTap: () {
        listeningTts();
      },
    );
  }

  buildMoreView() {
    return PopupMenuButton(
        offset: Offset(0, 48),
        child: Listener(
          child: SizedBox(
            width: 44,
            child: Image.asset('assets/img/read_icon_more.png'),
          ),
        ),
        onSelected: (value) {
          print('buildMoreView: ' + value);
        },
        itemBuilder: (context) => [
              PopupMenuItem(
                value: 'Share',
                child: Row(
                  children: [
                    Image.asset('assets/img/read_icon_book_share.webp',width: 28,),
                    SizedBox(width: 5),
                    Text('分享'),
                  ],
                ),
              ),
              PopupMenuItem(
                value: 'BookSelf',
                child: Row(
                  children: [
                    Image.asset('assets/img/read_icon_shelf.webp',width: 28),
                    SizedBox(width: 5),
                    Text('去书架'),
                  ],
                ),
              ),
              PopupMenuItem(
                value: 'BookDetail',
                child: Row(
                  children: [
                    Image.asset('assets/img/read_icon_book_detail.webp',width: 28),
                    SizedBox(width: 5),
                    Text('图书详情'),
                  ],
                ),
              ),
              PopupMenuItem(
                value: 'Report',
                child: Row(
                  children: [
                    Image.asset('assets/img/read_icon_book_report.webp',width: 28),
                    SizedBox(width: 5),
                    Text('举报'),
                  ],
                ),
              ),
            ]);
  }

  buildTopView(BuildContext context) {
    return Positioned(
      top: -Screen.navigationBarHeight * (1 - animation.value),
      left: 0,
      right: 0,
      child: Container(
        decoration: BoxDecoration(
            color: Colors.white, boxShadow: Styles.borderShadow),
        height: Screen.navigationBarHeight,
        padding: EdgeInsets.fromLTRB(5, Screen.topSafeHeight, 5, 0),
        child: Row(
          children: <Widget>[
            buildBackView(),
            Expanded(child: Container()),
            buildReadView(),
            buildMoreView(),
          ],
        ),
      ),
    );
  }

  int currentArticleIndex() {
    return ((widget.chapters.length - 1) * progressValue).toInt();
  }

  buildProgressTipView() {
    if (!menuVisible) {
      return Container();
    }
    Chapter chapter = widget.chapters[currentArticleIndex()];
    double percentage = chapter.index / (widget.chapters.length - 1) * 100;
    return Container(
      decoration: BoxDecoration(
          color: Color(0xff00C88D), borderRadius: BorderRadius.circular(5)),
      margin: EdgeInsets.fromLTRB(15, 0, 15, 10),
      padding: EdgeInsets.all(15),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: <Widget>[
          Text(chapter.title,
              style: const TextStyle(color: Colors.white, fontSize: 16)),
          Text('${percentage.toStringAsFixed(1)}%',
              style: TextStyle(color: Color(0xFFBBBBBB), fontSize: 12)),
        ],
      ),
    );
  }

  previousArticle() {
    if (widget.articleIndex == 0) {
      Toast.show('已经是第一章了');
      return;
    }
    widget.onPreviousArticle();
    setState(() {
      menuVisible = true;
    });
  }

  nextArticle() {
    if (widget.articleIndex == widget.chapters.length - 1) {
      Toast.show('已经是最后一章了');
      return;
    }
    widget.onNextArticle();
    setState(() {
      menuVisible = true;
    });
  }

  buildProgressView() {
    return menuVisible?Container(
      padding: EdgeInsets.fromLTRB(5, 0, 5, 0),
      child: Row(
        children: <Widget>[
          GestureDetector(
            onTap: previousArticle,
            child: Container(
              padding: EdgeInsets.all(20),
              child: Image.asset('assets/img/read_icon_chapter_previous.png'),
            ),
          ),
          Expanded(
            child: Slider(
              value: progressValue,
              onChanged: (double value) {
                setState(() {
                  menuVisible = true;
                  progressValue = value;
                });
              },
              onChangeEnd: (double value) {
                Chapter chapter = widget.chapters[currentArticleIndex()];
                widget.onToggleChapter(chapter);
              },
              activeColor: Color(0xFF23B38E),
              inactiveColor: Color(0xFF888888),
            ),
          ),
          GestureDetector(
            onTap: nextArticle,
            child: Container(
              padding: EdgeInsets.all(20),
              child: Image.asset('assets/img/read_icon_chapter_next.png'),
            ),
          )
        ],
      ),
    ):Container();
  }


  buildFontView() {
     return fontVisible?Container(
       padding: EdgeInsets.all(15),
       child: Row(
         children: [
            Text('字号',style: TextStyle(color: Color(0xFFBBBBBB))),
            SizedBox(width: 20),
            Container(
              padding: EdgeInsets.only(left: 12,right: 12,top: 5,bottom: 5),
              decoration: BoxDecoration(
                color: Color(0xFFBBBBBB),
                borderRadius: BorderRadius.circular(10),
              ),
              child: Text('A+'),
            ),
           SizedBox(width: 20),
           Text('25'),
           SizedBox(width: 20),
           Container(
             padding: EdgeInsets.only(left: 12,right: 12,top: 5,bottom: 5),
             decoration: BoxDecoration(
               color: Color(0xFFBBBBBB),
               borderRadius: BorderRadius.circular(10),
             ),
             child: Text('A-'),
           ),
           SizedBox(width: 30),
           Container(
             padding: EdgeInsets.only(left: 12,right: 12,top: 5,bottom: 5),
             decoration: BoxDecoration(
               color: Color(0xFFBBBBBB),
               borderRadius: BorderRadius.circular(10),
             ),
             child: Text('系统字体'),
           )
         ],
       ),
     ):Container();
  }

  buildSettingView() {
     return settingVisible?Container(
       padding: EdgeInsets.all(15),
       child: Column(
         children: [
           buildColorView(),
           SizedBox(height: 15),
           buildPageView(),
         ],
       ),
     ):Container();
  }

  buildColorView() {
    return Row(
      children: [
        Text('背景',style: TextStyle(color: Color(0xFFBBBBBB))),
        SizedBox(width: 20),
        Container(
          height: 25,
          width: 50,
          decoration: BoxDecoration(
            color: Color(0xFFdaebd3),
            borderRadius: BorderRadius.circular(15),
          ),
        ),
        SizedBox(width: 20),
        Container(
          height: 25,
          width: 50,
          decoration: BoxDecoration(
            color: Color(0xFFcfdbec),
            borderRadius: BorderRadius.circular(15),
          ),
        ),
        SizedBox(width: 20),
        Container(
          height: 25,
          width: 50,
          decoration: BoxDecoration(
            color: Color(0xFFeddde2),
            borderRadius: BorderRadius.circular(15),
          ),
        ),
        SizedBox(width: 20),
        Container(
          height: 25,
          width: 50,
          decoration: BoxDecoration(
            color: Color(0xFFfef8ec),
            borderRadius: BorderRadius.circular(15),
          ),
        )
      ],
    );
  }

  buildPageView() {
    return Row(
      children: [
        Text('翻页',style: TextStyle(color: Color(0xFFBBBBBB))),
        SizedBox(width: 20),
        Container(
          height: 25,
          width: 65,
          decoration: BoxDecoration(
            color: Color(0xFFF5F5F5),
            border: Border.all(width: 1, color: Colors.black54),
            borderRadius: BorderRadius.circular(15),
          ),
          child: Center(child: Text('默认')),
        ),
        SizedBox(width: 20),
        Container(
          height: 25,
          width: 65,
          decoration: BoxDecoration(
            color: Color(0xFFF5F5F5),
            borderRadius: BorderRadius.circular(15),
          ),
          child: Center(child: Text('仿真')),
        ),
        SizedBox(width: 20),
        Container(
          height: 25,
          width: 65,
          decoration: BoxDecoration(
            color: Color(0xFFF5F5F5),
            borderRadius: BorderRadius.circular(15),
          ),
          child: Center(child: Text('大小')),
        ),
      ],
    );
  }


  buildBottomView() {
    return Positioned(
      bottom: -(Screen.bottomSafeHeight + 110) * (1 - animation.value),
      left: 0,
      right: 0,
      child: Column(
        children: <Widget>[
          buildProgressTipView(),
          Container(
            decoration: BoxDecoration(
                color: Colors.white, boxShadow: Styles.borderShadow),
            padding: EdgeInsets.only(bottom: Screen.bottomSafeHeight),
            child: Column(
              children: <Widget>[
                buildProgressView(),
                buildFontView(),
                buildSettingView(),
                buildBottomMenus(),
              ],
            ),
          )
        ],
      ),
    );
  }


  buildBottomMenus() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceAround,
      children: <Widget>[
        buildBottomItem('目录', 'assets/img/read_icon_catalog.png'),
        buildBottomItem('黑白', 'assets/img/read_icon_brightness.png'),
        buildBottomItem('字体', 'assets/img/read_icon_font.png'),
        buildBottomItem('设置', 'assets/img/read_icon_setting.png'),
      ],
    );
  }

  buildBottomItem(String title, String icon) {
    return GestureDetector(
      child: Container(
        padding: EdgeInsets.symmetric(vertical: 7),
        child: Column(
          children: <Widget>[
            Image.asset(icon),
            SizedBox(height: 5),
            Text(title,
                style: const TextStyle(
                    fontSize: 12,
                    color: Color(0xFF333333))),
          ],
        ),
      ),
      onTap: (){
        onBottomViewClick(title);
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    // themeManager= Provider.of<ThemeManager>(context);
    return Stack(
      children: <Widget>[
        GestureDetector(
          onTapDown: (_) {
            hide();
          },
          child: Container(color: Colors.transparent),
        ),
        buildTopView(context),
        buildBottomView(),
      ],
    );
  }

  listeningTts() async {
    var result = ReaderManager.instance.getContent();
    var statues = await tts.speak(result);
    print(statues);
  }

  void onBottomViewClick(String title) {
     switch(title){
       case '目录':
         setState(() {
           menuVisible=!menuVisible;
           fontVisible=false;
           settingVisible=false;
         });
         break;
       case '黑白':
         lightVisible=!lightVisible;
         // eventBus.emit(EventThemeChange, lightVisible);
         Provider.of<ThemeManager>(context, listen: false).changeTheme(lightVisible);
         break;
       case '字体':
         setState(() {
           fontVisible=!fontVisible;
           menuVisible=false;
           settingVisible=false;
         });
         break;
       case '设置':
         setState(() {
           settingVisible=!settingVisible;
           menuVisible=false;
           fontVisible=false;
         });
         break;
     }
  }

}
