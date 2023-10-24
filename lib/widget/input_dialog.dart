import 'package:flutter/material.dart';

import '../utility/screen.dart';

class InputDialog extends StatefulWidget {
  String title;
  String hint;
  VoidCallback onCancel;
  ValueChanged onConfirm;

  InputDialog({
    required this.hint,
    required this.title,
    required this.onCancel,
    required this.onConfirm,
  });

  @override
  InputDialogState createState() => InputDialogState();
}

class InputDialogState extends State<InputDialog> {
  TextEditingController controller = TextEditingController();

  @override
  void initState() {
    super.initState();
    controller.addListener(() {
      widget.onConfirm.call(controller.text);
    });
  }

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
                buildTextField(),
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
            widget.onConfirm(controller.text);
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

  buildTextField() {
    return Container(
      margin: EdgeInsets.only(right: 20, left: 20),
      height: 45,
      padding: EdgeInsets.only(left: 10),
      decoration: BoxDecoration(
        color: Color(0xFFF6F6F6),
        borderRadius: BorderRadius.circular(3),
      ),
      child: TextField(
        controller: controller,
        decoration: InputDecoration(
          border: InputBorder.none,
          hintText: widget.hint,
        ),
        textInputAction: TextInputAction.search,
      ),
    );
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
