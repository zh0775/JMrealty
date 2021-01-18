import 'package:JMrealty/components/CustomWebV.dart';
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
  List<DateButton> dateButtonList = [];
  int dateButtonIndex = -1;
  List scheData = [[], [], [], [], [], [], []];
  @override
  Widget build(BuildContext context) {
    dateButtonList = [];
    DateTime date = DateTime.now();
    if (dateButtonIndex == -1) {
      dateButtonIndex = (date.weekday - 7).abs();
    }
    DateTime startTime = DateTime.now();
    if (startTime.weekday != 7) {
      startTime = startTime.subtract(Duration(days: startTime.weekday));
    }
    for (var i = 0; i < 7; i++) {
      DateTime iTime = date.add(Duration(days: i));
      // DateTime iTime = date.subtract(Duration(days: date.weekday - i));
      bool havePoint = false;
      if (widget.data != null && widget.data.length > 0) {
        for (var j = 0; j < widget.data.length; j++) {
          var sche = widget.data[j];
          // print((iTime.toString().split(' '))[0]);
          if (DateFormat('yyyy-MM-dd').format(iTime) == sche['date']) {
            scheData[i] = sche['scheduleList'];
            havePoint = true;
            break;
          }
        }
      }
      dateButtonList.add(DateButton(
        index: i,
        seleted: dateButtonIndex == i ? true : false,
        date: iTime,
        enable: !iTime.isBefore(date),
        havePoint: havePoint,
        dateButtonClick: (index) {
          setState(() {
            dateButtonIndex = index;
          });
        },
      ));
    }
    double top = -5;
    return Container(
        width: double.infinity,
        height: 110,
        margin: EdgeInsets.only(top: 15),
        decoration: BoxDecoration(
            // color: Colors.red,
            border: Border(
          top: BorderSide(width: 1, color: Color.fromRGBO(0, 0, 0, 0.1)),
          bottom: BorderSide(width: 1, color: Color.fromRGBO(0, 0, 0, 0.1)),
        )),
        child: Stack(
          children: [
            Positioned(
                left: 20,
                top: top + 10,
                height: 20,
                child: Text(
                  '日程待办',
                  style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
                )),
            Positioned(
                top: top,
                right: 10,
                // width: 80,
                child: Container(
                  child: TextButton(
                      onPressed: () {
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
                      )),
                )),
            Positioned(
                left: 20,
                right: 20,
                height: 80,
                top: top + 40,
                child: Container(
                  child: Row(
                    children: dateButtonList,
                  ),
                )),
            Positioned(
                left: 20,
                right: 0,
                top: top + 115,
                height: 60,
                child: Container(
                    // color: Colors.red,
                    child: ListView.builder(
                        scrollDirection: Axis.horizontal,
                        itemCount: scheData[dateButtonIndex].length,
                        itemBuilder: (BuildContext context, int index) {
                          return scheduRow(index, scheData[dateButtonIndex]);
                        })))
          ],
        ));
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
  final bool havePoint;
  final bool seleted;
  final bool enable;
  final DateTime date;
  final DateButtonClick dateButtonClick;
  // final var date = date;

  const DateButton({
    Key key,
    @required this.index,
    this.dateButtonClick,
    this.havePoint = true,
    this.seleted = true,
    this.enable = true,
    @required this.date,
  }) : super(key: key);
  @override
  _DateButtonState createState() => _DateButtonState();
}

class _DateButtonState extends State<DateButton> {
  @override
  Widget build(BuildContext context) {
    SizeConfig().init(context);
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
    if (widget.havePoint) {
      pointColor = Color(0xffd9b76c);
    } else {
      pointColor = Colors.transparent;
    }
    switch (widget.date.weekday) {
      case 1:
        weekStr = '周一';
        break;
      case 2:
        weekStr = '周二';
        break;
      case 3:
        weekStr = '周三';
        break;
      case 4:
        weekStr = '周四';
        break;
      case 5:
        weekStr = '周五';
        break;
      case 6:
        weekStr = '周六';
        break;
      case 7:
        weekStr = '周日';
        break;
      default:
    }
    return Container(
      height: 80,
      width: (SizeConfig.screenWidth - 40) / 7,
      child: TextButton(
        onPressed: () {
          widget.dateButtonClick(widget.index);
        },
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
              width: (SizeConfig.screenWidth - 40) / 7 - 10,
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
            SizedBox(
              height: 8,
            ),
            Container(
              width: 8,
              height: 8,
              decoration: BoxDecoration(
                  color: pointColor,
                  borderRadius: BorderRadius.all(Radius.circular(4))),
            )
          ],
        ),
      ),
    );
  }
}
