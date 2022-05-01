import 'package:flutter/material.dart';

class MathOps {
  static double reduceZeroToOne(double maxVal, double num) {
    if (num < maxVal)
      return num / maxVal;
    else
      return 1;
  }

  static List getPosition(GlobalKey gk) {
    List xy = [];
    final RenderBox renderBoxRed = gk.currentContext.findRenderObject();
    final position = renderBoxRed.localToGlobal(Offset.zero);
    xy.add(position.dx);
    xy.add(position.dy);
    return xy;
  }
}
