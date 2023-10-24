import 'package:flutter/material.dart';
import 'package:flutter_shuji_app/widget/triangle_up_arrow.dart';

import '../utility/screen_utils.dart';

/**
 * 带下拉三角的PopWindow
 */
typedef ClickCallBack = void Function(int selectIndex, String selectText);

class PopMenus {
  static void showPop(
      {required BuildContext context,
      required List<String> listData,
      required ClickCallBack clickCallback}) {

    double cellHeight = 40;
    double cellWidth = 140;

    buildMenuLineCell(dataArr) {
      return ListView.separated(
        itemCount: dataArr.length,
        physics: const NeverScrollableScrollPhysics(),
        itemBuilder: (BuildContext context, int index) {
          return GestureDetector(
              onTap: () {
                Navigator.pop(context);
                clickCallback(index, listData[index]);
              },
              child: Container(
                height: cellHeight,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: <Widget>[
                    Text(dataArr[index], style: TextStyle(fontSize: 18))
                  ],
                ),
              ));
        },
        separatorBuilder: (context, index) {
          return const Divider(
            height: 1,
            color: Color(0xFFE6E6E6),
          );
        },
      );
    }

    buildMenusView(dataArr) {
      var cellH = dataArr.length * cellHeight;
      var navH = ScreenUtils.navigationBarHeight;
      navH = navH - ScreenUtils.topSafeHeight;
      var leftP = (ScreenUtils.screenWidth - cellWidth) / 2;
      return Positioned(
        right: 15,
        top: navH - 10,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.end,
          children: <Widget>[
            Container(
              padding: EdgeInsets.only(right: 10),
              child: TriangleUpArrow(height: 10, width: 14),
            ),
            ClipRRect(
                borderRadius: BorderRadius.circular(2),
                child: Container(
                    color: Colors.white,
                    width: cellWidth,
                    height: cellH,
                    child: buildMenuLineCell(dataArr)))
          ],
        ),
      );
    }

    showDialog(
        context: context,
        barrierDismissible: false,
        builder: (context) {
          return PopMenuArrow(child: buildMenusView(listData));
        });
  }
}

class PopMenuArrow extends Dialog {
  PopMenuArrow({
    required this.child,
  });

  final Widget child;

  @override
  Widget build(BuildContext context) {
    return Material(
      type: MaterialType.transparency,
      child: Stack(
        fit: StackFit.expand,
        children: <Widget>[
          GestureDetector(onTap: () => Navigator.pop(context)),
          child
        ],
      ),
    );
  }
}
