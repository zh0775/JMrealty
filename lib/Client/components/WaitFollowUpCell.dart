import 'package:JMrealty/const/Default.dart';
import 'package:JMrealty/utils/sizeConfig.dart';
import 'package:flutter/material.dart';

enum waitFollowLevel { A, B, C }

class WaitFollowUpCell extends StatefulWidget {
  @override
  _WaitFollowUpCellState createState() => _WaitFollowUpCellState();
}

class _WaitFollowUpCellState extends State<WaitFollowUpCell> {
  @override
  Widget build(BuildContext context) {
    SizeConfig().init(context);
    return Container(
      width: 100,
      height: 200,
      decoration: BoxDecoration(
          border: Border(
        bottom: BorderSide(color: jm_line_color, width: 0.5),
      )),
    );
  }
}
