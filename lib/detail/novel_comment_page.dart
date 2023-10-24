import 'package:flutter/material.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';

class CommentPage extends StatefulWidget {
  @override
  State<StatefulWidget> createState() => CommentPageState();
}

class CommentPageState extends State<CommentPage> {

  TextEditingController controller = TextEditingController();

  @override
  void initState() {
    super.initState();
    controller.addListener(() {
      var content=controller.text;
      print(content);
    });
  }


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          '点评此书',
          style: TextStyle(color: Colors.black),
        ),
        centerTitle: true,
        elevation: 0,
        backgroundColor: Colors.white,
        leading: GestureDetector(
          child: Image.asset('assets/img/back_gray.png'),
          onTap: () {
            Navigator.pop(context);
          },
        ),
        actions: [
          Container(
            padding: EdgeInsets.only(right: 15),
            child: const Center(
              child: Text(
                '发布',
                style: TextStyle(color: Colors.green, fontSize: 16),
              ),
            ),
          )
        ],
      ),
      body: buildBody(),
    );
  }

  buildBody() {
    return Column(
      children: [
        buildRating(),
        buildRatingContent(),
        SizedBox(height: 10),
        buildComment()
      ],
    );
  }

  buildRating() {
    return Container(
      color: Colors.white,
      padding: EdgeInsets.only(top: 15),
      child: Center(
        child: RatingBar.builder(
          initialRating: 0,
          minRating: 1,
          direction: Axis.horizontal,
          allowHalfRating: true,
          itemCount: 5,
          itemPadding: const EdgeInsets.symmetric(horizontal: 3.0),
          itemBuilder: (context, _) => const Icon(
            Icons.star,
            color: Colors.orange,
          ),
          onRatingUpdate: (rating) {
            print(rating);
          },
        ),
      ),
    );
  }

  buildRatingContent() {
    return  Container(
      padding: EdgeInsets.only(bottom: 20),
      color: Colors.white,
      child: const Center(
        child: Text(
          '点击星星评分',
          style: TextStyle(fontSize: 16, color: Colors.orange),
        ),
      ),
    );
  }

  buildComment() {
    return Container(
      color: Colors.white,
      height: 200,
      padding: EdgeInsets.all(15),
      child: TextField(
        controller: controller,
        decoration: const InputDecoration(
          isDense: true,
          border: InputBorder.none,
          hintText: '打分并说明你的看法...(800字以内)',
        ),
      ),
    );
  }
}
