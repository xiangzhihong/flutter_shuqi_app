import 'package:flutter/material.dart';

class RadioButtonView extends StatefulWidget {
  final List<String> list;
  final ValueChanged chooseItem;

  RadioButtonView({required this.list, required this.chooseItem});

  @override
  State<StatefulWidget> createState() => RadioButtonState();
}

class RadioButtonState extends State<RadioButtonView> {
  String value = '';

  @override
  void initState() {
    super.initState();
    value = widget.list[0];
  }

  @override
  Widget build(BuildContext context) {
    return Row(
      children: widget.list
          .map((item) => Container(
                margin: EdgeInsets.only(right: 15),
                child: GestureDetector(
                  child: Container(
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(5),
                      color: value == item ? Colors.green : Color(0xFFE6E6E6),
                    ),
                    height: 28,
                    width: 55,
                    child: Center(
                      child: Text(
                        item,
                        style: TextStyle(
                            color:
                                value == item ? Colors.white : Colors.black45),
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
    );
  }
}
