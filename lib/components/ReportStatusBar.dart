import 'package:JMrealty/const/Default.dart';
import 'package:JMrealty/utils/sizeConfig.dart';
import 'package:JMrealty/utils/tTools.dart';
import 'package:flutter/material.dart';

class ReportStatusBar extends StatelessWidget {
  final int statusNo;
  final List statusData;
  ReportStatusBar({@required this.statusNo,@required this.statusData});

  double widthScale;
  double margin;
  double rowWidth;
  @override
  Widget build(BuildContext context) {
    SizeConfig().init(context);
    widthScale = SizeConfig.blockSizeHorizontal;
    margin = widthScale * 4;
    rowWidth = (SizeConfig.screenWidth - margin * 2) / 5;
    return Container(
      // height: 200,
      width: double.infinity,
      child: Row(
        children: [
          ...getRow(),
        ],
      ),
    );
  }

  List<Widget> getRow(){
    double titleHeight = 40;
    List<Widget> rows = [];
    for (int i = 0; i < 5; i++) {
      Column column;
      if (statusData!= null &&  i < statusData.length) {
        Map rowData = statusData[i];
        column = Column(
          children: [
            Container(width: rowWidth - widthScale * 4,height: titleHeight,
              decoration: BoxDecoration(
                color: Color.fromRGBO(252,247,238, 1),
                borderRadius: BorderRadius.circular(titleHeight / 2),
                border: Border.all(color: jm_appTheme,width: 2)
              ),
              child: Center(child: Text(getTitle(i),style: jm_text_apptheme_style15,),),
            ),
            Text(rowData['createTime'] != null ? timeToYMD(rowData['createTime']) : '' ,style: jm_text_gray_style11,),
            Text(rowData['employeeName']??'',style: jm_text_black_style11,),
          ],
        );
      } else {
        column = Column(
          children: [
            Container(width: rowWidth - widthScale * 4,height: 40,
              decoration: BoxDecoration(
                  color: jm_line_color,
                  borderRadius: BorderRadius.circular(titleHeight / 2),
              ),
              child: Center(child: Text(getTitle(i),style: jm_text_gray_style15,),),
            )
          ],
        );
      }
      rows.add(column);
    }
    return rows;
    Column(
      children: [
        Container(width: rowWidth - widthScale * 4,height: 40,)
      ],
    );
  }
  String getTitle (int index) {
    switch(index) {
      case 0:
        return '报备';
        break;
      case 1:
        return '报备';
        break;
      case 2:
        return '认购';
        break;
      case 3:
        return '签约';
        break;
      case 4:
        return '结佣';
        break;
      default:
        return '其他';
    }
  }
}
