import 'package:JMrealty/const/Default.dart';
import 'package:JMrealty/utils/sizeConfig.dart';
import 'package:flutter/material.dart';

class ProjectCell extends StatefulWidget {
  final int status;
  final Map data;
  const ProjectCell({this.data, this.status});
  @override
  _ProjectCellState createState() => _ProjectCellState();
}

class _ProjectCellState extends State<ProjectCell> {
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
      width: SizeConfig.screenWidth - insideMargin,
      decoration: BoxDecoration(
          border: Border(bottom: BorderSide(color: jm_line_color, width: 0.5))),
      child: Padding(
        padding: EdgeInsets.only(left: insideMargin),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            SizedBox(
              height: axisSpace,
            ),
            Text(
              widget.data['name'] ?? '',
              style: jm_text_black_style18,
            ),
            SizedBox(
              height: labelSpace,
            ),
            Text(
              widget.data['address'] ?? '',
              style: jm_text_gray_style14,
            ),
            SizedBox(
              height: labelSpace,
            ),
            RichText(
                text: TextSpan(
                    text: '均',
                    style: TextStyle(fontSize: 14, color: Colors.red),
                    children: [
                  TextSpan(
                      text: widget.data['averagePrice'] != null
                          ? (widget.data['averagePrice']).toString()
                          : '',
                      style: TextStyle(fontSize: 20, color: Colors.red)),
                  TextSpan(
                      text: '元/平',
                      style: TextStyle(fontSize: 14, color: Colors.red)),
                ])),
            SizedBox(
              height: labelSpace,
            ),
            Row(
              children: [
                Text(
                  widget.data['architecture'] != null
                      ? (widget.data['architecture'] + ' | ')
                      : '',
                  style: jm_text_gray_style14,
                ),
                Text(
                  widget.data['property'] != null
                      ? (widget.data['property'] + ' - ')
                      : '',
                  style: jm_text_gray_style14,
                ),
                Text(
                  widget.data['city'] != null
                      ? (widget.data['city'] + ' - ')
                      : '',
                  style: jm_text_gray_style14,
                ),
                Text(
                  widget.data['region'] != null
                      ? (widget.data['region'] + ' | ')
                      : '',
                  style: jm_text_gray_style14,
                ),
                Text(
                  widget.data['areaMin'] != null
                      ? (widget.data['areaMin'] + '-')
                      : '',
                  style: jm_text_gray_style14,
                ),
                Text(
                  widget.data['areaMax'] != null
                      ? (widget.data['areaMax'] + '平')
                      : '',
                  style: jm_text_gray_style14,
                ),
              ],
            ),
            SizedBox(
              height: labelSpace,
            ),
            Row(
              children: [...getTagList()],
            ),
            SizedBox(
              height: axisSpace,
            ),
          ],
        ),
      ),
    );
  }

  List<Widget> getTagList() {
    List<Widget> tagList = [];
    if (widget.data['status'] != null) {
      tagList.add(getTag(getStatusTitle(widget.data['status'])));
    }
    if (widget.data['property'] != null) {
      tagList.add(getTag(widget.data['property'] + '年'));
    }
    if (widget.data['isDecorate'] != null && widget.data['isDecorate'] == 1) {
      tagList.add(getTag('精装房'));
    }
    return tagList;
  }

  Widget getTag(String title) {
    return Container(
      // height: 20,
      margin: EdgeInsets.only(right: widthScale * 3),
      color: jm_line_color,
      child: Padding(
        padding: EdgeInsets.fromLTRB(7, 1, 7, 1),
        child: Text(
          title,
          style: jm_text_gray_style14,
        ),
      ),
    );
  }

  String getStatusTitle(int status) {
    switch (status) {
      case 1:
        return '未开盘';
        break;
      case 2:
        return '在售';
        break;
      case 3:
        return '售罄';
        break;
      default:
        return '';
    }
  }
}
