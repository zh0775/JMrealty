import 'package:JMrealty/components/CustomWebV.dart';
import 'package:JMrealty/components/NoneV.dart';
import 'package:JMrealty/const/Default.dart';
import 'package:JMrealty/utils/sizeConfig.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class HomeScheduleToDo extends StatefulWidget {
  final List data;
  const HomeScheduleToDo({this.data});
  @override
  _HomeScheduleToDoState createState() => _HomeScheduleToDoState();
}

class _HomeScheduleToDoState extends State<HomeScheduleToDo> {
  double widthScale;
  double heightScale;
  double margin;
  double selfWidth;
  List<DateButton> dateButtonList = [];
  int dateButtonIndex = -1;
  List scheData = [{}, {}, {}, {}, {}, {}, {}];
  @override
  Widget build(BuildContext context) {
    SizeConfig().init(context);
    widthScale = SizeConfig.blockSizeHorizontal;
    heightScale = SizeConfig.blockSizeVertical;
    margin = widthScale * 2;
    selfWidth = SizeConfig.screenWidth - margin * 2;
    dateButtonList = [];
    DateTime date = DateTime.now();
    if (dateButtonIndex == -1) {
      if (date.weekday == 7) {
        dateButtonIndex = 0;
      } else {
        dateButtonIndex = date.weekday;
      }
    }
    DateTime startTime = DateTime.now();
    if (startTime.weekday != 7) {
      startTime = startTime.subtract(Duration(days: startTime.weekday));
    }

    for (var i = 0; i < 7; i++) {
      DateTime iTime = startTime.add(Duration(days: i));

      // DateTime iTime = date.subtract(Duration(days: date.weekday - i));
      if (widget.data != null && widget.data.length > 0) {
        for (var j = 0; j < widget.data.length; j++) {
          var sche = widget.data[j];
          // print((iTime.toString().split(' '))[0]);
          if (DateFormat('yyyy-MM-dd').format(iTime) == sche['today']) {
            scheData[i] = sche;
            break;
          }
        }
      }
      dateButtonList.add(DateButton(
        index: i,
        seleted: dateButtonIndex == i ? true : false,
        date: iTime,
        width: selfWidth / 7,
        enable: !iTime.isBefore(date),
        markData: scheData[i],
        dateButtonClick: (index) {
          push(CustomWebV(path: WebPath.backlog), context);
          // setState(() {
          //   dateButtonIndex = index;
          // });
        },
      ));
    }
    return Align(
      child: Container(
          width: selfWidth,
          // height: 120,

          margin: EdgeInsets.only(top: 15),
          decoration: BoxDecoration(
              border: Border(
            top: BorderSide(width: 1, color: Color.fromRGBO(0, 0, 0, 0.1)),
            bottom: BorderSide(width: 1, color: Color.fromRGBO(0, 0, 0, 0.1)),
          )),
          child: Column(
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Padding(
                    padding: EdgeInsets.only(left: widthScale * 3, top: 10),
                    child: Text(
                      '日程待办',
                      style:
                          TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
                    ),
                  ),
                  Padding(
                      padding: EdgeInsets.only(right: widthScale * 2, top: 10),
                      child: GestureDetector(
                        onTap: () {
                          push(CustomWebV(path: WebPath.backlog), context);
                        },
                        child: Row(
                          children: [
                            RichText(
                                text: TextSpan(
                              text: '全部',
                              style: TextStyle(
                                color: Color(0XFF9fa1a8),
                                fontSize: 15,
                              ),
                            )),
                            Icon(
                              Icons.navigate_next,
                              color: Color(0XFF9fa1a8),
                              size: 20,
                            )
                          ],
                        ),
                      )),
                ],
              ),
              Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: dateButtonList,
              ),
              // Positioned(
              //     left: 20,
              //     right: 0,
              //     top: top + 115,
              //     height: 60,
              //     child: Container(
              //         // child: ListView.builder(
              //         //     scrollDirection: Axis.horizontal,
              //         //     itemCount: scheData[dateButtonIndex].length,
              //         //     itemBuilder: (BuildContext context, int index) {
              //         //       return scheduRow(index, scheData[dateButtonIndex]);
              //         //     })
              //         ))
            ],
          )),
    );
  }

  Widget scheduRow(index, data) {
    // print('data === ${(data[index])['title']}');
    return Container(
      margin: EdgeInsets.only(right: 10),
      padding: EdgeInsets.only(top: 5, left: 10, right: 10),
      decoration: BoxDecoration(
          color: jm_line_color,
          borderRadius: BorderRadius.all(Radius.circular(10))),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text((data[index])['title']),
          SizedBox(
            height: 5,
          ),
          Text((data[index])['time']),
        ],
      ),
    );
  }
}

typedef void DateButtonClick(int index);

class DateButton extends StatefulWidget {
  final int index;
  final double width;
  final bool seleted;
  final bool enable;
  final DateTime date;
  final DateButtonClick dateButtonClick;
  final Map markData;
  // final var date = date;

  const DateButton({
    Key key,
    this.width,
    this.markData,
    @required this.index,
    this.dateButtonClick,
    this.seleted = true,
    this.enable = true,
    @required this.date,
  }) : super(key: key);
  @override
  _DateButtonState createState() => _DateButtonState();
}

class _DateButtonState extends State<DateButton> {
  double widthScale;
  @override
  Widget build(BuildContext context) {
    SizeConfig().init(context);
    widthScale = SizeConfig.blockSizeHorizontal;
    String weekStr = '';
    String monthDay = widget.date.day.toString();
    TextStyle textStyle1;
    TextStyle textStyle2;
    Color pointColor;
    Color selectedColor;
    if (widget.enable) {
      textStyle1 = TextStyle(fontSize: 14, color: Colors.black);
      textStyle2 = TextStyle(fontSize: 14, color: Colors.black);
      pointColor = Color(0xffd9b76c);
    } else {
      textStyle1 = TextStyle(fontSize: 14, color: Color(0xffc6c7cb));
      textStyle2 = TextStyle(fontSize: 14, color: Color(0xffc6c7cb));
      pointColor = Color(0xfff4ead2);
    }
    if (widget.seleted) {
      textStyle2 = TextStyle(fontSize: 14, color: Colors.white);
      selectedColor = Color(0xffe5b763);
    } else {
      selectedColor = Colors.transparent;
    }
    // if (widget.havePoint) {
    //   pointColor = Color(0xffd9b76c);
    // } else {
    //   pointColor = Colors.transparent;
    // }
    switch (widget.date.weekday) {
      case 1:
        weekStr = '一';
        break;
      case 2:
        weekStr = '二';
        break;
      case 3:
        weekStr = '三';
        break;
      case 4:
        weekStr = '四';
        break;
      case 5:
        weekStr = '五';
        break;
      case 6:
        weekStr = '六';
        break;
      case 7:
        weekStr = '日';
        break;
      default:
    }
    return Container(
      // height: 80,
      width: widget.width,
      child: TextButton(
        onPressed: () {
          widget.dateButtonClick(widget.index);
        },
        child: Column(
          children: [
            Container(
              height: 48,
              child: Column(
                children: [
                  Text(
                    weekStr,
                    style: textStyle1,
                  ),
                  SizedBox(
                    height: 3,
                  ),
                  Container(
                    width: widget.width,
                    height: 20,
                    decoration: BoxDecoration(
                        color: selectedColor,
                        borderRadius: BorderRadius.all(Radius.circular(5))),
                    child: Center(
                      child: Text(
                        monthDay,
                        style: textStyle2,
                      ),
                    ),
                  ),
                ],
              ),
            ),
            getPoint(),
            // getExpect(),
          ],
        ),
      ),
    );
  }

  Widget getExpect() {
    if (widget.markData['delayTodo'] != null &&
        widget.markData['delayTodo'] > 0) {
      double expectWidth = widthScale * 5.5;
      return Container(
        width: expectWidth,
        height: expectWidth,
        alignment: Alignment.center,
        decoration: BoxDecoration(
            color: Colors.red,
            borderRadius: BorderRadius.circular(expectWidth / 2)),
        child: Text(
          widget.markData['delayTodo'].toString(),
          style: TextStyle(fontSize: 12, color: Colors.white),
        ),
      );
    }
    return NoneV();
  }

  Widget getPoint() {
    double expectWidth = widthScale * 5.5;
    if (widget.markData['delayTodo'] != null &&
        widget.markData['delayTodo'] > 0) {
      return Container(
        width: expectWidth,
        height: expectWidth,
        alignment: Alignment.center,
        decoration: BoxDecoration(
            color: Colors.red,
            borderRadius: BorderRadius.circular(expectWidth / 2)),
        child: Text(
          widget.markData['delayTodo'].toString(),
          style: TextStyle(fontSize: 12, color: Colors.white),
        ),
      );
    } else {
      int allTodo = widget.markData['allTodo'] ?? 0;
      int finishTodo = widget.markData['finishTodo'] ?? 0;
      if (allTodo == 0) {
        return NoneV();
      }
      double pointWidth = widthScale * 3;
      Color pointColor = Color(0x99E6B85C);
      if (allTodo > finishTodo) {
        pointColor = jm_appTheme;
      }
      return Container(
        margin: EdgeInsets.only(top: (expectWidth - pointWidth) / 2),
        width: pointWidth,
        height: pointWidth,
        decoration: BoxDecoration(
            color: pointColor,
            borderRadius: BorderRadius.circular(pointWidth / 2)),
      );
    }
  }
}
