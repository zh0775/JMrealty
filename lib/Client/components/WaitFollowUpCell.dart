import 'package:JMrealty/const/Default.dart';
import 'package:JMrealty/utils/sizeConfig.dart';
import 'package:flutter/material.dart';

enum waitFollowLevel { A, B, C }

class WaitFollowUpCell extends StatefulWidget {
  // final waitFollowLevel level;
  // final String name;
  // final String sex;
  // final String houseType;
  // final String roomCount;
  // final String houseSize;
  // final String housePrice;
  // final String newFollowTime;
  // final String clientIntention;
  // final String clientPhoneNum;
  @override
  _WaitFollowUpCellState createState() => _WaitFollowUpCellState();
}

class _WaitFollowUpCellState extends State<WaitFollowUpCell> {
  @override
  Widget build(BuildContext context) {
    SizeConfig().init(context);
    double cellHeight = 200;
    double cellWidth = SizeConfig.screenWidth;
    return Container(
      width: cellWidth,
      height: cellHeight,
      decoration: BoxDecoration(
          border: Border(
        bottom: BorderSide(color: jm_line_color, width: 0.5),
      )),
      child: Column(
        children: [
          Container(
            height: 50,
            width: cellWidth,
            color: Colors.red,
          )
        ],
      ),
    );
  }
}
