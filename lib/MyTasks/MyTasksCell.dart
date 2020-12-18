import 'package:JMrealty/utils/sizeConfig.dart';
import 'package:flutter/material.dart';

class MyTasksCell extends StatefulWidget {
  final Map data;
  const MyTasksCell({this.data});
  @override
  _MyTasksCellState createState() => _MyTasksCellState();
}

class _MyTasksCellState extends State<MyTasksCell> {
  double cellHeight = 340;
  double widthScale;
  double outMargin;
  double insideMargin;
  double labelSpace = 3;
  @override
  Widget build(BuildContext context) {
    widthScale = SizeConfig.blockSizeHorizontal;
    outMargin = widthScale * 4;
    insideMargin = widthScale * 6;
    return Container();
  }
}
