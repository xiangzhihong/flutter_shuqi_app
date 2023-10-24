import 'package:flutter/material.dart';

class PopupWindowMenu extends StatefulWidget {
  final List<MenuItem> items;
  final dynamic value;
  final String? title;
  final ValueChanged<dynamic>? valueChanged;

  const PopupWindowMenu(
      {Key? key,
      this.items = const [],
      this.value,
      this.valueChanged,
      this.title})
      : super(key: key);

  @override
  State<PopupWindowMenu> createState() => _PopupWindowMenuState();
}

class _PopupWindowMenuState extends State<PopupWindowMenu> {
  String label = '请选择';
  dynamic currentValue;

  @override
  void initState() {
    super.initState();
    currentValue = widget.value;
  }


  @override
  Widget build(BuildContext context) {
    return Wrap(
      children: [
        PopupMenuButton<String>(
          offset:  Offset(25, 30),
          child: Listener(
            child: Text(
              label,
              style: TextStyle(fontSize: 18),
            ),
          ),
          onSelected: (value) {
            widget.valueChanged?.call(value);
            setState(() {
              currentValue = value;
            });
          },
          itemBuilder: (context) {
            return widget.items
                .map(
                  (item) => PopupMenuItem<String>(
                    value: item.value,
                    child: Text(item.label),
                  ),
                )
                .toList();
          },
        )
      ],
    );
  }
}

class MenuItem {
  String label;
  String img;
  dynamic value; //选中的值
  bool checked; //是否选中

  MenuItem({this.label = '', this.value, this.img = '', this.checked = false});
}
