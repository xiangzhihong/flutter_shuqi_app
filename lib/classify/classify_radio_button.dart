import 'package:flutter/material.dart';

class ClassifyRadioButton extends StatefulWidget {
  final List<String> list;
  final ValueChanged chooseItem;

  ClassifyRadioButton({required this.list, required this.chooseItem});

  @override
  State<StatefulWidget> createState() => RadioButtonState();
}

class RadioButtonState extends State<ClassifyRadioButton> {
  String value = '';

  @override
  void initState() {
    super.initState();
    value = widget.list[0];
  }

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      scrollDirection: Axis.horizontal,
      child: Row(
        children: widget.list
            .map((item) => Container(
                  margin: EdgeInsets.only(right: 15),
                  child: GestureDetector(
                    child: value == item?Container(
                      height: 28,
                      width: 60,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(15),
                        color: Color(0xffecf6e8),
                      ),
                      child: Center(
                        child: Text(
                          item,
                          style: TextStyle(
                              color: Colors.green),
                        ),
                      ),
                    ):Container(
                      height: 28,
                      width: 60,
                      child: Center(
                        child: Text(
                          item,
                          style: TextStyle(
                              color: Colors.black87),
                        ),
                      ),
                    ),
                    onTap: () {
                      setState(() {
                        value = item;
                      });
                      widget.chooseItem(item);
                    },
                  ),
                ))
            .toList(),
      ),
    );
  }
}
