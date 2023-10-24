import 'package:flutter/material.dart';
import '../app/request.dart';
import '../model/man_cool.dart';

import 'classify_list_item.dart';
import 'classify_radio_button.dart';

class ClassifyDetailPage extends StatefulWidget {

  final String classifyName;
  const ClassifyDetailPage(this.classifyName);


  @override
  State<StatefulWidget> createState() => ClassifyDetailPageState();
}

class ClassifyDetailPageState extends State<ClassifyDetailPage> {
  List<String> types = ['全部', '热血', '江湖', '侠客', '爽文', '穿越', '修炼'];
  List<String> endDatas = ['全部', '连载', '完结'];
  List<String> fees = ['全部', '免费', '会员'];
  List<String> ranks = ['全部', '按热度', '按评分','按新书'];
  List<String> datas = [];
  List<Items>  listItems = [];

  @override
  void initState() {
    super.initState();
    fetchData();
  }

  Future<void> fetchData() async {
    List<Items> items = [];
    var response = await Request.get(action: 'women_selling');
    ManCool data = ManCool.fromJson(response);
    for (var item in data.items) {
      items.add(item);
    }
    setState(() {
      listItems = items;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: buildAppBar(),
      body:SingleChildScrollView(
        child: Column(
          children: [
            buildWithCondition(PickType.TYPE),
            buildWithCondition(PickType.END),
            buildWithCondition(PickType.FEE),
            buildWithCondition(PickType.RANK),
            buildLine(),
            buildListView(),
          ],
        ),
      ),
    );
  }

  buildAppBar() {
    return AppBar(
      title: Text(
        widget.classifyName,
        style: TextStyle(color: Colors.black),
      ),
      centerTitle: true,
      elevation: 0.5,
      backgroundColor: Colors.white,
      leading: GestureDetector(
        child: Image.asset('assets/img/back_gray.png'),
        onTap: (){
          Navigator.pop(context);
        },
      ),
    );
  }

  buildRadioButtons(List<String> datas) {
    return Container(
      width: double.infinity,
      color: Colors.white,
      padding: EdgeInsets.only(left: 20,top: 15,right: 20,bottom: 15),
      child: ClassifyRadioButton(
          list: datas,
          chooseItem: (value) {
            print(value);
          }),
    );
  }


  buildWithCondition(type) {
     switch(type){
       case PickType.TYPE:
         setState(() {
           datas = types;
         });
         break;
       case PickType.END:
         setState(() {
           datas = endDatas;
         });
         break;
       case PickType.FEE:
         setState(() {
           datas = fees;
         });
         break;
       case PickType.RANK:
         setState(() {
           datas = ranks;
         });
         break;
     }
     return buildRadioButtons(datas);
  }

  buildListView() {
    return Container(
        color: Colors.white,
        padding: EdgeInsets.only(left: 15, right: 15, top: 5, bottom: 30),
        child: ListView.separated(
          physics: const NeverScrollableScrollPhysics(),
          shrinkWrap: true,
          itemCount: listItems.length,
          itemBuilder: (context, index) {
            return ClassifyfListItem(listItems[index]);
          },
          separatorBuilder: (context, index) {
            if (index == listItems.length - 1) {
              return Container();
            }
            return Divider(color: Color(0xFFBBBBBB), indent: 20);
          },
        ));
  }

  buildLine() {
    return Container(
       color: Colors.white,
       child: Divider(color: Color(0xFFBBBBBB), indent: 20),
    );
  }

}


enum PickType {
  TYPE,
  END,
  FEE,
  RANK,
}