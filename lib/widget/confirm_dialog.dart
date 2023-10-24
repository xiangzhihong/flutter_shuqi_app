import 'package:flutter/material.dart';

import '../utility/screen.dart';


class ConfirmDialog extends StatefulWidget {
  String title;
  String content;
  VoidCallback onCancel;
  VoidCallback onConfirm;

  ConfirmDialog({
    required this.title,
    required this.content,
    required this.onCancel,
    required this.onConfirm,
  });

  @override
  ConfirmDialogState createState() => ConfirmDialogState();
}

class ConfirmDialogState extends State<ConfirmDialog> {
  @override
  Widget build(BuildContext context) {
    return Material(
      color: Colors.transparent,
      child: Center(
        child: ClipRRect(
          borderRadius: BorderRadius.circular(10.0),
          child: Container(
            color: Colors.white,
            width: Screen.width*0.75,
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: <Widget>[
                SizedBox(height: 20),
                buildTitle(),
                SizedBox(height: 10),
                buildContent(),
                SizedBox(height: 20),
                buildHorLine(),
                buildActionView(),
              ],
            ),
          ),
        ),
      ),
    );
  }

  buildTitle() {
    return widget.title.isEmpty
        ? Container()
        : Container(
      child: Text(
        widget.title,
        style: const TextStyle(
            color: Colors.black,
            fontWeight: FontWeight.bold,
            fontSize: (17)),
      ),
    );
  }

  buildContent() {
    return Container(
      margin: EdgeInsets.only(left: 15, right: 15),
      child: Text(
        widget.content,
        style: const TextStyle(
          color: Colors.black,
          fontSize: (14),
        ),
      ),
    );
  }

  buildActionView() {
    return SizedBox(
        height: 48,
        child: Row(
          children: [
            Expanded(
                flex: 1,
                child: GestureDetector(
                  onTap: () {
                    widget.onCancel();
                    Navigator.pop(context);
                  },
                  child: const Center(
                    child: Text('取消',
                        style: TextStyle(color: Colors.black, fontSize: (16))),
                  ),
                )),
            buildVerLine(),
            Expanded(
                flex: 1,
                child: GestureDetector(
                  onTap: () {
                    widget.onConfirm();
                    Navigator.pop(context);
                  },
                  child: const Center(
                    child: Text('确认',
                        style: TextStyle(color: Colors.green, fontSize: (16))),
                  ),
                )),
          ],
        ));
  }

  buildHorLine() {
    return Container(
      width: double.infinity,
      height: 1,
      color: Color(0xFFE7E8ED),
    );
  }

  buildVerLine() {
    return Container(
      height: 48,
      width: 1,
      color: Color(0xFFE7E8ED) ,
    );
  }

}
