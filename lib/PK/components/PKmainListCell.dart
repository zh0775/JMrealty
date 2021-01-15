import 'package:JMrealty/const/Default.dart';
import 'package:JMrealty/utils/sizeConfig.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

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
  DateFormat dateFormat = DateFormat('yyyy-MM-dd HH:mm:ss');
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
                          top: -(25 / 2),
                          width: widthScale * 17,
                          height: 25,
                          child: Image.asset(
                            'assets/images/icon/icon_pk_status_bg.png',
                            fit: BoxFit.fill,
                          )),
                      Positioned(
                          right: margin,
                          top: -(25 / 2) - 1,
                          width: widthScale * 17,
                          height: 25,
                          child: Center(
                            child: Text(
                              jm_getPKStatus(widget.cellData['status'] ?? 0),
                              style: jm_text_black_style11,
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
                  crossAxisAlignment: CrossAxisAlignment.end,
                  children: [
                    Row(
                      children: [
                        SizedBox(
                          width: widthScale * 3,
                        ),
                        Container(
                          width: selfWidth * 0.5 - widthScale * 4,
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
                        Container(
                          alignment: Alignment.centerRight,
                          width: selfWidth * 0.5 - widthScale * 4,
                          child: Text(
                            '时间：' +
                                (widget.cellData['startTime'] ?? '') +
                                ' 至 ' +
                                (widget.cellData['endTime'] ?? ''),
                            style: TextStyle(fontSize: 10, color: jm_text_gray),
                            maxLines: 100,
                          ),
                        ),
                        SizedBox(width: widthScale * 3)
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
      for (var i = 0;
          i <
              ((widget.cellData['raceRankList'] as List).length > 3
                  ? 3
                  : (widget.cellData['raceRankList'] as List).length);
          i++) {
        Map<String, dynamic> data = (widget.cellData['raceRankList'])[i];
        cells.add(Row(
          children: [
            SizedBox(
              height: cellLineHeight,
              width: margin,
            ),
            Image.asset(
                'assets/images/icon/icon_pk_rank${(i + 1).toString()}.png'),
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
                  '${data["number"] != null && data["number"] != 0 ? (data["number"]).toString() + "套  " : ""}${(data["commission"] != null ? data["commission"].toString() + "元  " : "")}${data["saleRate"] != null ? "成交率" + (data["saleRate"] * 100).toString() + "%" : ""}',
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
