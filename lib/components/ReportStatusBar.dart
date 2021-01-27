import 'package:JMrealty/const/Default.dart';
import 'package:JMrealty/utils/sizeConfig.dart';
import 'package:JMrealty/utils/tTools.dart';
import 'package:flutter/material.dart';

class ReportStatusBar extends StatelessWidget {
  final int statusNo;
  final List statusData;
  ReportStatusBar({@required this.statusNo, this.statusData = const []});

  double widthScale;
  double margin;
  double rowWidth;
  @override
  Widget build(BuildContext context) {
    SizeConfig().init(context);
    widthScale = SizeConfig.blockSizeHorizontal;
    margin = widthScale * 4;
    rowWidth = (SizeConfig.screenWidth) / 5;
    return SingleChildScrollView(
        scrollDirection: Axis.horizontal,
        child: Container(
          constraints: BoxConstraints(minWidth: SizeConfig.screenWidth),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              ...getRow(),
            ],
          ),
        ));
  }

  List<Widget> getRow() {
    double leftRightLineWidth = widthScale * 3;
    double titleHeight = 40;
    List<Widget> rows = [];

    if (statusData != null && statusData.length > 0) {
      for (int i = 0; i < statusData.length; i++) {
        Map rowData = statusData[i];
        rows.add(Column(
          children: [
            SizedBox(
              height: 5,
            ),
            Container(
                width: rowWidth,
                height: titleHeight,
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    i != 0
                        ? Container(
                            width: leftRightLineWidth,
                            height: 2,
                            color: jm_appTheme,
                          )
                        : SizedBox(
                            width: leftRightLineWidth,
                          ),
                    Container(
                      width: rowWidth - widthScale * 8,
                      height: 30,
                      decoration: BoxDecoration(
                          color: Color.fromRGBO(252, 247, 238, 1),
                          borderRadius: BorderRadius.circular(titleHeight / 2),
                          border: Border.all(color: jm_appTheme, width: 2)),
                      child: Center(
                        child: Text(
                          getTitle(rowData['status']),
                          style: jm_text_apptheme_style14,
                        ),
                      ),
                    ),
                    i != statusData.length - 1
                        ? Container(
                            width: leftRightLineWidth,
                            height: 2.0,
                            color: jm_appTheme,
                          )
                        : SizedBox(
                            width: leftRightLineWidth,
                          ),
                  ],
                )),
            SizedBox(
              height: 1,
            ),
            Container(
              alignment: Alignment.center,
              height: 12,
              // color: Colors.red,
              child: Text(
                rowData['createTime'] != null
                    ? timeToYMD(rowData['createTime'])
                    : '',
                style: jm_text_gray_style11,
              ),
            ),
            Container(
              alignment: Alignment.center,
              height: 19,
              child: Text(
                rowData['employeeName'] ?? '',
                style: jm_text_black_style11,
              ),
            ),
            SizedBox(
              height: 4,
            )
          ],
        ));
      }
    }
    return rows;
  }

  String getTitle(int status) {
    String statusStr = '';
    switch (status) {
      case 0:
        statusStr = '报备';
        break;
      case 5:
        statusStr = '接收';
        break;
      case 10:
        statusStr = '带看';
        break;
      case 20:
        statusStr = '上传';
        break;
      case 22:
        statusStr = '待确认';
        break;
      case 24:
        statusStr = '待确认';
        break;
      case 21:
        statusStr = '预约';
        break;
      case 30:
        statusStr = '成交';
        break;
      case 40:
        statusStr = '签约';
        break;
      case 50:
        statusStr = '结款';
        break;
      case 60:
        statusStr = '结佣';
        break;
      case 63:
        statusStr = '争议单';
        break;
      case 70:
        statusStr = '失效';
        break;
      case 80:
        statusStr = '退单';
        break;
      default:
        return '其他';
    }
    return statusStr;
  }
}
