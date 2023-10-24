import 'package:flutter/material.dart';

GlobalKey<SearchAppBarState> bookManageKey = GlobalKey();

class SearchAppBar extends StatefulWidget implements PreferredSizeWidget {
  SearchAppBar({
    this.borderRadius = 20,
    this.height = 44,
    this.hintText = '请输入需要搜索的内容',
    required this.onCancel,
    required this.onChanged,
    required this.onSearch,
  }) : super();
  final double borderRadius;
  final double height;
  final String hintText;
  final VoidCallback onCancel;
  final ValueChanged onChanged;
  final ValueChanged onSearch;

  @override
  SearchAppBarState createState() => SearchAppBarState();

  @override
  Size get preferredSize => Size.fromHeight(kToolbarHeight);
}

class SearchAppBarState extends State<SearchAppBar> {
  TextEditingController controller = TextEditingController();

  @override
  void initState() {
    super.initState();
    controller.addListener(() {
      widget.onChanged.call(controller.text);
    });
  }

  void onClearInput() {
    controller.clear();
    setState(() {});
  }

  Widget buildSuffix() {
    return GestureDetector(
      onTap: onClearInput,
      child: SizedBox(
        width: widget.height,
        height: widget.height,
        child: const Icon(Icons.cancel, size: 22, color: Color(0xFF999999)),
      ),
    );
  }

  buildCancel() {
     return GestureDetector(
       onTap: () {
         widget.onCancel();
       },
       child: const Text(
         '取消',
         style: TextStyle(fontSize: 18, color: Colors.green),
       ),
     );
  }

  buildTextField() {
     return Expanded(
       child: TextField(
         controller: controller,
         decoration: InputDecoration(
           isDense: true,
           border: InputBorder.none,
           hintText: widget.hintText,
         ),
         textInputAction: TextInputAction.search,
         onSubmitted: widget.onSearch,
       ),
     );
  }

  buildSearchIcon() {
    return SizedBox(
      width: widget.height,
      height: widget.height,
      child: Icon(Icons.search, size: 22, color: Color(0xFF999999)),
    );
  }


  @override
  Widget build(BuildContext context) {
    return SafeArea(
        child: Container(
          color: Colors.white,
          padding: EdgeInsets.all(10),
          child: Row(
            children: [
              Expanded(child: Container(
                margin: EdgeInsets.only(right: 15, left: 10),
                height: widget.height,
                decoration: BoxDecoration(
                  color: Color(0xFFF6F6F6),
                  borderRadius: BorderRadius.circular(widget.borderRadius),
                ),
                child: Row(
                  children: [
                    buildSearchIcon(),
                    buildTextField(),
                    buildSuffix(),
                  ],
                ),
              ),),
              buildCancel()
            ],
          ),
        )
    );
  }

  @override
  void dispose() {
    controller.dispose();
    super.dispose();
  }

}
