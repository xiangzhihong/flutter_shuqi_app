import 'package:flutter/material.dart';
import 'package:flutter_shuji_app/classify/classify_appbar.dart';
import 'package:flutter_shuji_app/classify/classify_detail_page.dart';
import '../app/app_navigator.dart';
import '../widget/radio_button_view.dart';

class ClassifyPage extends StatefulWidget {
  @override
  State<StatefulWidget> createState() => ClassifyPageState();
}

class ClassifyPageState extends State<ClassifyPage> {
  List<String> datas = ['热门', '题材', '情节', '角色', '风格','动漫'];
  var hots = ['大国科技', '都市异能', '历史', '脑洞', '武侠', '穿越', '仙侠', '游戏', '玄幻'];
  var subjects = ['历史', '都市', '同人', '游戏', '武侠', '穿越', '仙侠', '科幻', '玄幻','悬疑'];

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: ClassifyAppBar(onCancel: () {
        Navigator.pop(context);
      }),
      body: SingleChildScrollView(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            buildClassify(),
            buildHotTitle(),
            SizedBox(height: 15),
            buildHotList(),
            buildSubjectTitle(),
            SizedBox(height: 15),
            buildSubjectList(),
          ],
        ),
      ),
    );
  }

  buildClassify() {
    return Container(
      padding: const EdgeInsets.only(left: 15, right: 15, top: 15, bottom: 15),
      child: SingleChildScrollView(
        scrollDirection: Axis.horizontal,
        child: RadioButtonView(
            list: datas,
            chooseItem: (value) {
                print(value);
            }),
      ),
    );
  }

  buildHotTitle() {
    return Container(
        padding: EdgeInsets.only(left: 15),
        child: Text('热门', style: TextStyle(fontSize: 16)));
  }

  buildHotList() {
    return Container(
      padding: EdgeInsets.only(left: 15,),
      child: GridView(
        shrinkWrap: true ,
        gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
          crossAxisCount: 2,
          childAspectRatio: 3.5,
        ),
        children: hots.map((name) => buildItem(name)).toList(),
      ),
    );
  }

  Widget buildItem(String name) {
    return GestureDetector(
      child: Container(
        margin: EdgeInsets.only(right: 15, bottom: 10),
        alignment: Alignment.center,
        decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.all(Radius.circular(8))),
        child: Text(
          name,
          style: TextStyle(color: Colors.black, fontSize: 18),
        ),
      ),
      onTap: (){
        AppNavigator.push(context, ClassifyDetailPage(name));
      },
    );
  }

  buildSubjectTitle() {
    return Container(
        padding: EdgeInsets.only(left: 15),
        child: Text('题材', style: TextStyle(fontSize: 16)));
  }

  buildSubjectList() {
    return Container(
      padding: EdgeInsets.only(left: 15,),
      child: GridView(
        shrinkWrap: true ,
        gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
          crossAxisCount: 3,
          childAspectRatio: 2,
        ),
        children: subjects.map((name) => buildItem(name)).toList(),
      ),
    );
  }

}
