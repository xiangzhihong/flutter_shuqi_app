import 'package:flutter/material.dart';
import 'package:flutter_shuji_app/app/app_navigator.dart';
import '../app/request.dart';
import '../model/chapter_list.dart';
import '../model/novel.dart';

/**
 * 图书章节
 */
class ChapterPage extends StatefulWidget {
  final Novel? novel;

  ChapterPage({required this.novel});

  @override
  State<StatefulWidget> createState() => ChapterPageState();
}

class ChapterPageState extends State<ChapterPage> {
  List<ChapterList> chapterList = [];

  @override
  void initState() {
    super.initState();
    fetchData();
  }

  fetchData() async {
    var response = await Request.get(action: 'chapter_book_list');
    List<ChapterList> list = [];
    response.forEach((data) {
      list.add(ChapterList.fromJson(data));
    });
    setState(() {
      chapterList = list;
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
        '小说章节',
        style: TextStyle(color: Colors.black),
      ),
      centerTitle: true,
      backgroundColor: Colors.white,
      elevation: 0,
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
      padding: EdgeInsets.all(15),
      child: Column(
        children: [
          buildBookInfo(),
          SizedBox(height: 15,),
          Divider(height: 1, color: Color(0xFFE6E6E6)),
          buildChapterList()],
      ),
    );
  }

  buildBookInfo() {
    var width = 120.0;
    return Row(
      children: [
        Container(
          color: Color(0xFFF5F5F5),
          width: width,
          height: width / 0.75,
          child: Image.network(widget.novel!.imgUrl),
        ),
        SizedBox(width: 15),
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(widget.novel!.name,
                  style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold)),
              Text('作者：${widget.novel!.author}',
                  style: TextStyle(fontSize: 14, color: Colors.grey)),
              Text('简介：${widget.novel!.introduction}',
                  maxLines: 2,
                  style: TextStyle(fontSize: 14, color: Colors.grey)),
              SizedBox(
                height: 15,
              ),
              Text('共${widget.novel!.chapterCount}章  已读3%',
                  style: TextStyle(fontSize: 14, color: Colors.grey)),
              buildTags(),
            ],
          ),
        )
      ],
    );
  }

  Widget buildTags() {
    var colors = [Color(0xFFF9A19F), Color(0xFF59DDB9), Color(0xFF7EB3E7)];
    var i = 0;
    var tagWidgets = widget.novel!.tags.map((tag) {
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
      padding: EdgeInsets.only(top: 10),
      color: Colors.white,
      child: Wrap(runSpacing: 10, spacing: 10, children: tagWidgets),
    );
  }

  buildChapterList() {
    return Expanded(
        child: ListView.separated(
      itemCount: chapterList.length,
      itemBuilder: (BuildContext context, int index) {
        return GestureDetector(
          child: Container(
            padding: EdgeInsets.all(15),
            child: Text(chapterList[index].chapterName,style: TextStyle(fontSize: 16),),
          ),
          onTap: (){
            AppNavigator.pushWeb(context, 'https://t.shuqi.com/reader/6900908'+chapterList[index].contUrlSuffix, chapterList[index].chapterName);
          },
        );
      },
      separatorBuilder: (BuildContext context, int index) {
        return const Divider(
          height: 1,
          color: Color(0xFFE6E6E6),
        );
      },
    ));
  }
}
