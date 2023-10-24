import 'package:flutter/material.dart';

/**
 * 自定义下拉三角
 */
class TriangleUpPainter extends CustomPainter {

  late Color color; //填充颜色
  late Paint _paint; //画笔
  late Path _path; //绘制路径
  late double angle; //角度

  TriangleUpPainter() {
    _paint = Paint()
      ..strokeWidth = 1.0
      ..color = Colors.white
      ..isAntiAlias = true;
    _path = Path();
  }

  @override
  void paint(Canvas canvas, Size size) {
    final baseX = size.width;
    final baseY = size.height;
    //起点
    _path.moveTo(baseX*0.5, 0);
    _path.lineTo(baseX, baseY);
    _path.lineTo(0, baseY);
    canvas.drawPath(_path, _paint);
  }

  @override
  bool shouldRepaint(CustomPainter oldDelegate) {
    return false;
  }
}

class TriangleUpArrow extends StatefulWidget {
  double height;
  double width;

  TriangleUpArrow({this.height = 14, this.width = 18}) ;

  @override
  CoreTriangleState createState() => CoreTriangleState();
}

class CoreTriangleState extends State<TriangleUpArrow> {
  @override
  Widget build(BuildContext context) {
    return Container(
        height: widget.height,
        width: widget.width,
        child: CustomPaint(
          painter: TriangleUpPainter(),
        ));
  }
}