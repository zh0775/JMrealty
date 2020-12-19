import 'package:JMrealty/base/image_loader.dart';
import 'package:JMrealty/const/Default.dart';
import 'package:JMrealty/utils/sizeConfig.dart';
import 'package:flutter/material.dart';

class MyTasksCell extends StatefulWidget {
  final Map data;
  final int status;
  const MyTasksCell({this.data, this.status = 1});
  @override
  _MyTasksCellState createState() => _MyTasksCellState();
}

class _MyTasksCellState extends State<MyTasksCell> {
  double cellHeight = 340;
  double widthScale;
  double outMargin;
  double insideMargin;
  double labelSpace = 3;
  double axisSpace = 14;
  @override
  Widget build(BuildContext context) {
    widthScale = SizeConfig.blockSizeHorizontal;
    outMargin = widthScale * 4;
    insideMargin = widthScale * 6;
    return Container(
        width: SizeConfig.screenWidth,
        decoration: BoxDecoration(
            border:
                Border(bottom: BorderSide(width: 0.5, color: jm_line_color))),
        child: Row(
          children: [
            SizedBox(
              width: insideMargin,
            ),
            Column(
              // mainAxisAlignment: MainAxisAlignment.center,
              // crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                ClipRRect(
                  borderRadius: BorderRadius.circular(30),
                  child: Container(
                      width: 60,
                      height: 60,
                      child: widget.data['avatar'] != null &&
                              widget.data['avatar'] != ''
                          ? ImageLoader(widget.data['avatar'], 0)
                          : Container(
                              width: 0.0,
                              height: 0.0,
                            )),
                ),
                SizedBox(
                  height: labelSpace,
                ),
                Text(
                  widget.data['userName'] ?? '',
                  style: jm_text_black_style14,
                )
              ],
            ),
            SizedBox(
              width: outMargin,
            ),
            Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                SizedBox(
                  height: axisSpace,
                ),
                Text(
                  widget.data['name'] ?? '',
                  style: jm_text_black_style15,
                ),
                SizedBox(
                  height: labelSpace,
                ),
                Text(
                  widget.data['taskExplain'] ?? '',
                  style: jm_text_gray_style14,
                ),
                SizedBox(
                  height: labelSpace,
                ),
                Text(
                  widget.data['startTime'] != null
                      ? (widget.data['startTime'] + ' - ')
                      : '',
                  style: jm_text_black_style14,
                ),
                SizedBox(
                  height: labelSpace,
                ),
                Text(widget.data['expireTime'] ?? '',
                    style: jm_text_black_style14),
                SizedBox(
                  height: axisSpace,
                ),
              ],
            ),
          ],
        ));
  }
}
