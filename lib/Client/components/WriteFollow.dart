import 'package:JMrealty/components/NoneV.dart';
import 'package:JMrealty/const/Default.dart';

import 'package:JMrealty/services/Urls.dart';
import 'package:JMrealty/services/http.dart';
import 'package:JMrealty/utils/notify_default.dart';
import 'package:JMrealty/utils/sizeConfig.dart';
import 'package:JMrealty/utils/toast.dart';
import 'package:JMrealty/utils/user_default.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'dart:convert' as convert;

class WriteFollow {
  Map<String, dynamic> clientData;
  void Function() addFollowConfirm;
  bool isForce;
  WriteFollow(
      {@required this.clientData, this.addFollowConfirm, this.isForce = false});
  int expectTime;
  String expectTimeFormat;
  Map userInfo;
  void loadNextFollow() {
    UserDefault.get(USERINFO).then((value) {
      userInfo = convert.jsonDecode(value);
      Http().get(
        Urls.findExpectTime,
        {'id': clientData['id']},
        success: (json) {
          print('loadNextFollow === $json');
          if (json['code'] == 200) {
            expectTime = (json['data'])['expectTime'];
            DateTime date = DateTime.fromMillisecondsSinceEpoch(expectTime);
            var formatter = DateFormat('yyyy-MM-dd');
            expectTimeFormat = formatter.format(date);
            showContent(Global.navigatorKey.currentState.context);
          } else {
            ShowToast.normal(json['msg']);
          }
        },
        fail: (reason, code) {
          ShowToast.normal(reason);
        },
        after: () {},
      );
    });
  }

  void showContent(BuildContext context) {
    showGeneralDialog(
        context: context,
        barrierDismissible: !isForce,
        barrierLabel: '',
        transitionDuration: Duration(milliseconds: 200),
        pageBuilder: (BuildContext context, Animation<double> animation,
            Animation<double> secondaryAnimation) {
          return WriteWidget(
            clientData: clientData,
            addFollowConfirm: addFollowConfirm,
            expectTimeFormat: expectTimeFormat,
            isForce: isForce,
          );
        });
  }
}

class WriteWidget extends StatefulWidget {
  final Map<String, dynamic> clientData;
  final Function() addFollowConfirm;
  final String expectTimeFormat;
  final bool isForce;
  const WriteWidget(
      {this.clientData,
      this.addFollowConfirm,
      this.expectTimeFormat,
      this.isForce = false});
  @override
  _WriteWidgetState createState() => _WriteWidgetState();
}

class _WriteWidgetState extends State<WriteWidget> {
  DateFormat dateFormat = DateFormat('yyyy-MM-dd HH:mm:ss');
  DateTime nowTime = DateTime.now();
  String _followDetail;
  int expectTime;
  String expectTimeFormat;
  Map userInfo;

  double margin = 25;
  double width;
  @override
  void initState() {
    expectTimeFormat = widget.expectTimeFormat;
    // loadNextFollow();
    super.initState();
  }

  @override
  void dispose() {
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    SizeConfig().init(context);
    width = SizeConfig.screenWidth - margin * 2;
    return GestureDetector(
      onTap: () => FocusScope.of(context).requestFocus(FocusNode()),
      child: Center(
        child: Container(
          height: 300,
          width: width,
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(20),
          ),
          child: Material(
            color: Colors.transparent,
            child: Column(
              children: [
                SizedBox(
                  height: 10,
                ),
                SizedBox(
                  height: 40,
                  width: width,
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Row(
                        children: [
                          SizedBox(
                            width: margin,
                          ),
                          Text(
                            widget.clientData['name'],
                            style: TextStyle(
                                fontSize: 17,
                                color: jm_text_black,
                                fontWeight: FontWeight.bold),
                          ),
                        ],
                      ),
                      widget.isForce
                          ? NoneV()
                          : Padding(
                              padding: const EdgeInsets.only(right: 8.0),
                              child: IconButton(
                                  icon: Icon(Icons.highlight_off),
                                  onPressed: () {
                                    Navigator.pop(context);
                                  }),
                            )
                    ],
                  ),
                ),
                GestureDetector(
                  onTap: () => callPhone(widget.clientData['phone']),
                  child: Row(
                    children: [
                      SizedBox(
                        width: margin,
                      ),
                      Text(
                        widget.clientData['phone'],
                        style: TextStyle(
                            fontSize: 17,
                            color: jm_text_black,
                            fontWeight: FontWeight.bold),
                      ),
                      SizedBox(
                        width: SizeConfig.blockSizeHorizontal * 2,
                      ),
                      Image.asset(
                        'assets/images/icon_client_phone.png',
                        height: SizeConfig.blockSizeHorizontal * 5,
                        width: SizeConfig.blockSizeHorizontal * 5,
                      )
                    ],
                  ),
                ),
                SizedBox(
                  height: 8,
                ),
                Row(
                  children: [
                    SizedBox(
                      width: margin,
                    ),
                    Text(
                      '本次跟进时间',
                      style: TextStyle(fontSize: 13, color: jm_text_gray),
                    ),
                    SizedBox(
                      width: 8,
                    ),
                    Text(
                      dateFormat.format(nowTime),
                      style: TextStyle(fontSize: 13, color: jm_text_black),
                    ),
                  ],
                ),
                SizedBox(
                  height: 10,
                ),
                Container(
                  constraints: BoxConstraints(maxHeight: 80, minHeight: 80),
                  width: width - margin * 2,
                  // margin: EdgeInsets.only(left: margin),
                  child: TextField(
                    maxLines: 2,
                    maxLength: 200,
                    decoration: InputDecoration(
                        contentPadding: EdgeInsets.fromLTRB(10, 10, 10, 10),
                        // border: OutlineInputBorder(
                        //     borderRadius: BorderRadius.circular(10),
                        //     borderSide:
                        //         BorderSide(width: 0.1, color: Colors.red)),
                        // fillColor: Color(0xfff7f8fb),
                        // contentPadding: EdgeInsets.all(20.0),
                        hintText: '请输入',
                        filled: true,
                        enabledBorder: OutlineInputBorder(
                          //未选中时候的颜色
                          borderRadius: BorderRadius.circular(10.0),
                          borderSide: BorderSide(
                            color: jm_line_color,
                          ),
                        ),
                        focusedBorder: OutlineInputBorder(
                          //选中时外边框颜色
                          borderRadius: BorderRadius.circular(10.0),
                          borderSide: BorderSide(
                            color: jm_line_color,
                          ),
                        )),
                    onChanged: (value) {
                      _followDetail = value;
                      // print('特殊要求 value === $value');
                      // addClientParams['remarks'] = value;
                    },
                  ),
                ),
                GestureDetector(
                  behavior: HitTestBehavior.opaque,
                  onTap: () {
                    showSelectNextDate(context);
                  },
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Row(
                        children: [
                          SizedBox(
                            width: margin,
                            height: 40,
                          ),
                          Text(
                            '下次跟进时间',
                            style: TextStyle(fontSize: 14, color: jm_text_gray),
                          ),
                          SizedBox(
                            width: SizeConfig.blockSizeHorizontal * 2,
                          ),
                          Text(
                            expectTimeFormat,
                            style:
                                TextStyle(fontSize: 14, color: jm_text_black),
                          )
                        ],
                      ),
                      Row(
                        children: [
                          Icon(
                            Icons.keyboard_arrow_right,
                            size: SizeConfig.blockSizeHorizontal * 6,
                            color: jm_text_gray,
                          ),
                          SizedBox(
                            width: margin,
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
                SizedBox(
                  height: 10,
                ),
                SizedBox(
                  width: width - margin * 2,
                  child: Row(
                    mainAxisAlignment: widget.isForce
                        ? MainAxisAlignment.center
                        : MainAxisAlignment.spaceBetween,
                    children: [
                      widget.isForce
                          ? NoneV()
                          : Container(
                              width: (width - margin * 2) / 2 - 10,
                              height: 40,
                              decoration: BoxDecoration(
                                  color: Color(0xfff0f2f5),
                                  borderRadius: BorderRadius.circular(6)),
                              child: TextButton(
                                  onPressed: () {
                                    Navigator.pop(context);
                                  },
                                  child: Text(
                                    '取消',
                                    style: TextStyle(
                                        fontSize: 15, color: jm_text_black),
                                  )),
                            ),
                      Container(
                        width: (width - margin * 2) / 2 - 10,
                        height: 40,
                        decoration: BoxDecoration(
                            color: jm_appTheme,
                            borderRadius: BorderRadius.circular(6)),
                        child: TextButton(
                            onPressed: () {
                              setClientFollow(context);
                            },
                            child: Text(
                              '确定',
                              style:
                                  TextStyle(fontSize: 15, color: Colors.white),
                            )),
                      )
                    ],
                  ),
                ),
                SizedBox(
                  height: 10,
                )
              ],
            ),
          ),
        ),
      ),
    );
  }

  setClientFollow(BuildContext context) {
    if (_followDetail == null || _followDetail.length == 0) {
      ShowToast.normal('请输入跟进内容');
      return;
    }
    DateFormat dateFormat = DateFormat('yyyy-MM-dd HH:mm:ss');
    Http().post(Urls.addFollow, {
      'customerId': widget.clientData['id'],
      'expect': expectTimeFormat,
      'postId': 0,
      'postName': widget.clientData['psotName'],
      'result': _followDetail,
      'visitDate': dateFormat.format(nowTime),
    }, success: (json) {
      if (json['code'] == 200) {
        if (widget.addFollowConfirm != null) {
          widget.addFollowConfirm();
          Navigator.pop(context);
        }
      }
      ShowToast.normal(json['msg']);
    }, fail: (reason, code) {
      ShowToast.normal(reason);
    });
  }

  Future<void> showSelectNextDate(BuildContext context) async {
    DateFormat nexTimeDateFormat = DateFormat('yyyy-MM-dd');

    // DateTime dateData = dateFormat.parse(expectTimeFormat);
    final DateTime date = await showDatePicker(
        context: context,
        initialDate: DateTime.now(),
        firstDate: DateTime.now(),
        lastDate: DateTime.now().add(Duration(days: 5)),
        locale: Locale('zh'));
    if (date == null) return;
    setState(() {
      expectTimeFormat = nexTimeDateFormat.format(date);
    });
  }
}
