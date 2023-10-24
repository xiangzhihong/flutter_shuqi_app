import 'package:flutter/material.dart';
import '../detail/novel_detail_page.dart';
import '../model/man_cool.dart';
import '../public.dart';
import '../utility/screen.dart';

class ClassifyfListItem extends StatelessWidget {
  final Items item;

  ClassifyfListItem(this.item);

  @override
  Widget build(BuildContext context) {
    var width = (Screen.width - 15 * 2 - 24 * 2) / 3;
    return GestureDetector(
      onTap: (){
        AppNavigator.push(context, NovelDetailPage(item.bid));
      },
      child: Row(
        children: [
          Image.network(
            item.bookCover,
            width: width,
            height: width / 0.75,
          ),
          SizedBox(
            width: 10,
          ),
          Expanded(
              child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(item.bookName,
                  style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16)),
              SizedBox(height: 10),
              Text(
                item.desc,
                style: TextStyle(color: Color(0xFFBBBBBB), fontSize: 14),
                maxLines: 2,
                overflow: TextOverflow.ellipsis,
              ),
              SizedBox(height: 30),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(item.author,
                      style: TextStyle(color: Color(0xFFBBBBBB), fontSize: 14)),
                  buildTag(item.tags.first, Colors.grey)
                ],
              )
            ],
          ))
        ],
      ),
    );
  }

  buildTag(String title, Color color) {
    return Container(
      padding: EdgeInsets.fromLTRB(8, 3, 8, 3),
      decoration: BoxDecoration(
        border: Border.all(
            color: Color.fromARGB(99, color.red, color.green, color.blue),
            width: 0.5),
        borderRadius: BorderRadius.circular(3),
      ),
      child: Text(
        title,
        style: TextStyle(fontSize: 11, color: color),
      ),
    );
  }
}
