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
  DateFormat dateFormat = DateFormat('yyyy-MM-dd HH:mm:ss');
  DateTime nowTime = DateTime.now();
  Map<String, dynamic> clientData;
  void Function() addFollowConfirm;
  WriteFollow({@required this.clientData, this.addFollowConfirm});
  String _followDetail;
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
            var formatter = new DateFormat('yyyy-MM-dd');
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

  setClientFollow(BuildContext context) {
    if (_followDetail == null || _followDetail.length == 0) {
      ShowToast.normal('请输入跟进内容');
      return;
    }
    DateFormat dateFormat = DateFormat('yyyy-MM-dd HH:mm:ss');
    Http().post(Urls.addFollow, {
      'customerId': clientData['id'],
      'expect':
          dateFormat.format(DateTime.fromMillisecondsSinceEpoch(expectTime)),
      'postId': 0,
      'postName': clientData['psotName'],
      'result': _followDetail,
      'visitDate': dateFormat.format(nowTime),
    }, success: (json) {
      if (json['code'] == 200) {
        if (addFollowConfirm != null) {
          addFollowConfirm();
          Navigator.pop(context);
        }
      }
      ShowToast.normal(json['msg']);
    }, fail: (reason, code) {
      ShowToast.normal(reason);
    });
  }

  void showContent(BuildContext context) {
    SizeConfig().init(context);
    double margin = 25;
    double width = SizeConfig.screenWidth - margin * 2;
    showGeneralDialog(
        context: context,
        barrierDismissible: true,
        barrierLabel: '',
        transitionDuration: Duration(milliseconds: 200),
        pageBuilder: (BuildContext context, Animation<double> animation,
            Animation<double> secondaryAnimation) {
          return GestureDetector(
            onTap: () => FocusScope.of(context).requestFocus(FocusNode()),
            child: Center(
              child: Container(
                height: 270,
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
                                  clientData['name'],
                                  style: TextStyle(
                                      fontSize: 17,
                                      color: jm_text_black,
                                      fontWeight: FontWeight.bold),
                                ),
                                SizedBox(
                                  width: 8,
                                ),
                                Text(
                                  clientData['phone'],
                                  style: TextStyle(
                                      fontSize: 17,
                                      color: jm_text_black,
                                      fontWeight: FontWeight.bold),
                                ),
                              ],
                            ),
                            Padding(
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
                      SizedBox(
                        height: 30,
                        width: width,
                        child: Row(
                          children: [
                            SizedBox(
                              width: margin,
                            ),
                            Text(
                              '跟进时间',
                              style:
                                  TextStyle(fontSize: 13, color: jm_text_gray),
                            ),
                            SizedBox(
                              width: 8,
                            ),
                            Text(
                              dateFormat.format(nowTime),
                              style:
                                  TextStyle(fontSize: 13, color: jm_text_black),
                            ),
                          ],
                        ),
                      ),
                      SizedBox(
                        height: 5,
                      ),
                      Container(
                        constraints:
                            BoxConstraints(maxHeight: 80, minHeight: 80),
                        width: width - margin * 2,
                        // margin: EdgeInsets.only(left: margin),
                        child: TextField(
                          maxLines: 2,
                          maxLength: 200,
                          decoration: InputDecoration(
                              contentPadding:
                                  EdgeInsets.fromLTRB(10, 10, 10, 10),
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
                      SizedBox(
                        width: width,
                        height: 40,
                        child: Stack(
                          children: [
                            Padding(
                              padding: EdgeInsets.only(left: margin),
                              child: Align(
                                alignment: Alignment.centerLeft,
                                child: Text(
                                  '下次跟进',
                                  style: TextStyle(
                                      fontSize: 14, color: jm_text_gray),
                                ),
                              ),
                            ),
                            Padding(
                              padding: EdgeInsets.only(left: 100),
                              child: Align(
                                alignment: Alignment.centerLeft,
                                child: Text(
                                  expectTimeFormat,
                                  style: TextStyle(
                                      fontSize: 14, color: jm_text_black),
                                ),
                              ),
                            ),
                            Padding(
                              padding: EdgeInsets.only(right: margin),
                              child: Align(
                                alignment: Alignment.centerRight,
                                child: Icon(
                                  Icons.keyboard_arrow_right,
                                  color: jm_text_gray,
                                  size: 20,
                                ),
                              ),
                            )
                          ],
                        ),
                      ),
                      SizedBox(
                        height: 10,
                      ),
                      SizedBox(
                        width: width - margin * 2,
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Container(
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
                                    style: TextStyle(
                                        fontSize: 15, color: Colors.white),
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
        });
  }
}
