import 'package:JMrealty/base/image_loader.dart';
import 'package:JMrealty/components/CustomWebV.dart';
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

  double imageWidth;
  double otherWidth;
  @override
  Widget build(BuildContext context) {
    widthScale = SizeConfig.blockSizeHorizontal;
    outMargin = widthScale * 4;
    insideMargin = widthScale * 3;
    imageWidth = widthScale * 36;
    otherWidth = SizeConfig.screenWidth - imageWidth - insideMargin * 3;
    return GestureDetector(
      onTap: () {
        push(
            CustomWebV(
              path: WebPath.projectInfo,
              otherParams: {'projectId': widget.data['id']},
            ),
            context);
      },
      child: Container(
        width: SizeConfig.screenWidth,
        decoration: BoxDecoration(
            border: Border(bottom: BorderSide(color: jm_line_color, width: 1))),
        child: Row(
          children: [
            SizedBox(
              width: insideMargin,
            ),
            Container(
              height: imageWidth - widthScale * 10,
              // color: Colors.red,
              width: imageWidth,
              child: widget.data['headIcon'] != null
                  ? ImageLoader(
                      widget.data['headIcon'],

                      // widget.data['headIcon'],
                      fit: BoxFit.fill,
                    )
                  : Image.asset(
                      'assets/images/icon/icon_default_head.png',
                      fit: BoxFit.fill,
                    ),
            ),
            SizedBox(
              width: insideMargin,
            ),
            Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                SizedBox(
                  height: axisSpace,
                ),
                SizedBox(
                  width: otherWidth,
                  child: Text(
                    widget.data['name'] ?? '',
                    style: jm_text_black_style16,
                    maxLines: 100,
                  ),
                ),
                SizedBox(
                  height: labelSpace,
                ),
                // SizedBox(
                //   width: otherWidth,
                //   child: Text(
                //     widget.data['address'] ?? '',
                //     style: jm_text_gray_style13,
                //   ),
                // ),
                SizedBox(
                  height: labelSpace,
                ),
                SizedBox(
                  width: otherWidth,
                  child: RichText(
                      maxLines: 100,
                      text: TextSpan(
                          text: '',
                          style: TextStyle(fontSize: 13, color: Colors.red),
                          children: [
                            TextSpan(
                                text: widget.data['averagePrice'] != null
                                    ? (widget.data['averagePrice']).toString()
                                    : '',
                                style:
                                    TextStyle(fontSize: 19, color: Colors.red)),
                            TextSpan(
                                text: '元/平',
                                style:
                                    TextStyle(fontSize: 13, color: Colors.red)),
                          ])),
                ),
                SizedBox(
                  height: labelSpace,
                ),
                SizedBox(
                  width: otherWidth,
                  child: Text(
                    // (widget.data['architecture'] != null
                    //         ? (widget.data['architecture'] + ' | ')
                    //         : '') +
                    // (widget.data['property'] != null
                    //         ? (widget.data['property'] + ' - ')
                    //         : '') +
                    (widget.data['city'] != null
                            ? (widget.data['city'] + ' ')
                            : '') +
                        (widget.data['region'] != null
                            ? widget.data['region']
                            : '') +
                        (widget.data['areaMin'] != null
                            ? ('/建面 ' + widget.data['areaMin'] + '-')
                            : '') +
                        (widget.data['areaMax'] != null
                            ? (widget.data['areaMax'] + '㎡')
                            : ''),
                    style: jm_text_black_style13,
                  ),
                ),
                SizedBox(
                  height: labelSpace,
                ),
                SizedBox(
                  width: otherWidth,
                  child: Wrap(
                    children: [
                      ...getTagList(),
                    ],
                  ),
                ),
                SizedBox(
                  height: axisSpace - 8,
                ),
              ],
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
      margin: EdgeInsets.only(right: widthScale * 3, bottom: 8),
      constraints: BoxConstraints(minWidth: widthScale * 10, minHeight: 22),
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
      case 0:
        return '未开盘';
        break;
      case 1:
        return '在售';
        break;
      case 2:
        return '售罄';
        break;
      default:
        return '';
    }
  }
}
