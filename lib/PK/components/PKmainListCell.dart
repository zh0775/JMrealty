import 'package:JMrealty/const/Default.dart';
import 'package:JMrealty/utils/sizeConfig.dart';
import 'package:flutter/material.dart';

class PKmainListCell extends StatefulWidget {
  final Map cellData;
  final int index;
  final Function(Map cellData, int index) cellClick;
  const PKmainListCell(
      {@required this.cellData, @required this.index, this.cellClick});
  @override
  _PKmainListCellState createState() => _PKmainListCellState();
}

class _PKmainListCellState extends State<PKmainListCell> {
  double cellLineHeight = 40;
  double widthScale;
  double margin;
  double selfWidth;
  @override
  Widget build(BuildContext context) {
    SizeConfig().init(context);
    widthScale = SizeConfig.blockSizeHorizontal;
    margin = widthScale * 4.5;
    selfWidth = SizeConfig.screenWidth - margin * 2;
    return GestureDetector(
      onTap: () {
        if (widget.cellClick != null) {
          widget.cellClick(widget.cellData, widget.index);
        }
      },
      child: Align(
        child: Container(
          width: selfWidth,
          padding: EdgeInsets.only(bottom: 20),
          child: Container(
            decoration: BoxDecoration(
              color: Colors.white,
              border: Border.all(width: 0.5, color: jm_line_color),
              borderRadius: BorderRadius.circular(widthScale * 1.0),
            ),
            width: selfWidth,
            child: Column(
              children: [
                Container(
                  width: selfWidth,
                  height: 0,
                  child: Stack(
                    overflow: Overflow.visible,
                    children: [
                      Positioned(
                          right: margin,
                          top: -15,
                          child: Container(
                            width: widthScale * 16,
                            height: 30,
                            decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(15),
                                color: jm_appTheme,
                                border: Border.all(
                                    width: 0.5, color: jm_line_color)),
                            child: Center(
                              child: Text(
                                jm_getPKStatus(widget.cellData['status'] ?? 0),
                                style: jm_text_black_bold_style15,
                              ),
                            ),
                          )),
                    ],
                  ),
                ),
                SizedBox(
                  height: 15,
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Row(
                      children: [
                        SizedBox(
                          width: widthScale * 3,
                        ),
                        Container(
                          width: widthScale * 39,
                          child: Text(
                            widget.cellData['name'] ?? '',
                            maxLines: 100,
                            style: jm_text_black_bold_style15,
                          ),
                        ),
                      ],
                    ),
                    Row(
                      children: [
                        Text(
                          '时间：' +
                              (widget.cellData['startTime'] ?? '') +
                              ' 至 ' +
                              (widget.cellData['endTime'] ?? ''),
                          style: TextStyle(fontSize: 10, color: jm_text_gray),
                        ),
                        SizedBox(
                          width: widthScale * 3,
                        ),
                      ],
                    )
                  ],
                ),
                SizedBox(
                  height: 10,
                ),
                JMline(width: selfWidth, height: 0.5),
                ...getCell(),
                // SizedBox(height: 10,)
              ],
            ),
          ),
        ),
      ),
    );
  }

  List<Widget> getCell() {
    List<Widget> cells = [];
    if ((widget.cellData['raceRankList']) != null &&
        (widget.cellData['raceRankList']) is List &&
        (widget.cellData['raceRankList']).length > 0) {
      for (var i = 0; i < 1; i++) {
        Map<String, dynamic> data = (widget.cellData['raceRankList'])[i];
        cells.add(Row(
          children: [
            SizedBox(
              height: cellLineHeight,
              width: margin,
            ),
            Icon(
              Icons.emoji_events,
              size: 15,
              color: jm_appTheme,
            ),
            SizedBox(width: widthScale * 4),
            Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                SizedBox(
                  height: 5,
                ),
                Text(
                  (data['bussinesName'] != null
                      ? (data['bussinesName']).toString()
                      : ''),
                  style: jm_text_black_style14,
                ),
                Text(
                  data['commission'] != null
                      ? (data['commission']).toString()
                      : '',
                  style: jm_text_gray_style12,
                ),
                SizedBox(
                  height: 5,
                ),
              ],
            ),
            SizedBox(
              width: widthScale * 3,
            ),
            // Text(
            //   data['bussinesName'] ?? '',
            //   style: jm_text_black_style14,
            // ),
            // JMline(margin: widthScale * 3 ,width: selfWidth - widthScale * 6, height: 0.5)
          ],
        ));
        cells.add(JMline(
          width: selfWidth - margin * 2,
          height: 0.5,
        ));
      }
    }
    cells.add(Container(
      height: cellLineHeight,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Text('查看详情'),
          Icon(
            Icons.chevron_right,
            size: 23,
            color: jm_line_color,
          )
        ],
      ),
    ));
    return cells;
  }
}
