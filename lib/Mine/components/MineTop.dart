import 'package:JMrealty/Report/viewmodel/ReportUploadViewModel.dart';
import 'package:JMrealty/base/image_loader.dart';
import 'package:JMrealty/components/SelectImageView.dart';
import 'package:JMrealty/const/Default.dart';
import 'package:JMrealty/utils/sizeConfig.dart';
import 'package:JMrealty/utils/tTools.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class MineTop extends StatefulWidget {
  final double height;
  final Map data;
  final Map targetData;
  final List medelList;
  final Function(Map params) changeInfo;
  final Function(Map params) changeSign;
  final Function() toLevelSetting;
  const MineTop(
      {this.height,
      this.data,
      this.medelList,
      this.toLevelSetting,
      this.targetData,
      this.changeSign,
      this.changeInfo});

  @override
  _MineTopState createState() => _MineTopState();
}

class _MineTopState extends State<MineTop> {
  FocusNode signFocusNode = FocusNode();

  SelectImageView headImgSelectV;
  SelectImageView backImgSelectV;
  double targetHeight = 65;
  double topHeight;
  double coverHeight = 50;
  double topImageHeight;
  double widthScale;
  double margin;
  bool signIsEdit = false;
  String userSign = '';
  String backgroundPath = '';
  String avatarPath = '';
  @override
  void initState() {
    // mineVM.getMedelList(userId, (success, medelList) => null);
    headImgSelectV = SelectImageView(
      count: 1,
      imageSelected: (images) {
        if (images != null) {
          ReportUploadViewModel().upLoadReportImages(images,
              callBack: (List strImages) {
            if (strImages != null && strImages.length > 0) {
              setState(() {
                avatarPath = strImages[0];
              });
              if (widget.changeInfo != null) {
                widget.changeInfo(Map<String, dynamic>.from(
                    {'avatar': avatarPath, 'userId': widget.data['userId']}));
              }
            }
          });
        }
      },
    );
    backImgSelectV = SelectImageView(
      count: 1,
      imageSelected: (images) {
        if (images != null) {
          ReportUploadViewModel().upLoadReportImages(images,
              callBack: (List strImages) {
            if (strImages != null && strImages.length > 0) {
              setState(() {
                backgroundPath = strImages[0];
              });
              if (widget.changeInfo != null) {
                widget.changeInfo(Map<String, dynamic>.from({
                  'background': backgroundPath,
                  'userId': widget.data['userId']
                }));
              }
            }
          });
        }
      },
    );
    topHeight = widget.height;
    topImageHeight = topHeight + coverHeight;
    signFocusNode.addListener(() {
      if (!signFocusNode.hasFocus) {
        setState(() {
          signIsEdit = false;
        });
        if (userSign != null &&
            userSign.length > 0 &&
            widget.changeSign != null) {
          widget
              .changeSign({'sign': userSign, 'userId': widget.data['userId']});
        }
      }
      // print("焦点1是否被选中：" + signFocusNode.hasFocus.toString());
    });
    super.initState();
  }

  @override
  void dispose() {
    signFocusNode.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    backgroundPath = widget.data['background'];
    avatarPath = widget.data['avatar'];
    SizeConfig().init(context);
    widthScale = SizeConfig.blockSizeHorizontal;
    margin = widthScale * 6;
    return GestureDetector(
      onTap: () {
        FocusScope.of(context).requestFocus(FocusNode());
      },
      child: SingleChildScrollView(
        child: Column(
          children: [
            GestureDetector(
              onTap: () => backImgSelectV.showImage(context),
              child: Container(
                  width: SizeConfig.screenWidth,
                  height: 160,
                  child: Stack(
                    overflow: Overflow.visible,
                    children: [
                      Positioned.fill(
                        child:
                            backgroundPath != null && backgroundPath.length > 0
                                ? ImageLoader(widget.data['background'])
                                : Image.asset(
                                    'assets/images/icon/bg_appbar_03.png',
                                    fit: BoxFit.fill,
                                  ),
                      ),
                      Positioned(
                          bottom: 5,
                          left: 95,
                          child: Text(
                            widget.data['userName'] ?? '',
                            style: TextStyle(
                                fontSize: 18,
                                color: Colors.white,
                                fontWeight: FontWeight.bold),
                          )),
                      Positioned(
                          left: 5,
                          bottom: 0,
                          child: Image.asset(
                            'assets/images/icon/icon_mine_headicon_bg.png',
                            width: 88,
                            height: 40,
                          )),
                      Positioned(
                          left: 25,
                          bottom: -18,
                          width: 48,
                          height: 48,
                          child: GestureDetector(
                            behavior: HitTestBehavior.opaque,
                            onTap: () {
                              headImgSelectV.showImage(context);
                            },
                            child: ClipRRect(
                                borderRadius:
                                    BorderRadius.circular(widthScale * 1),
                                child:
                                    avatarPath != null && avatarPath.length > 0
                                        ? ImageLoader(
                                            avatarPath,
                                            fit: BoxFit.fill,
                                          )
                                        : Image.asset(
                                            'assets/images/icon/icon_default_head.png',
                                            fit: BoxFit.fill,
                                          )),
                          )),
                    ],
                  )),
            ),

            // SizedBox(
            //   height: 100,
            // ),
            // UnconstrainedBox(
            //   child: Container(
            //     width: SizeConfig.screenWidth,
            //     height: topHeight,
            //     child: Stack(
            //       overflow: Overflow.clip,
            //       children: [
            //         // 照片
            //         Positioned(
            //             top: 0,
            //             left: 0,
            //             right: 0,
            //             height: topImageHeight,
            //             child: GestureDetector(
            //               onTap: () {
            //                 backImgSelectV.showImage(context);
            //               },
            //               child: backgroundPath != null &&
            //                       backgroundPath.length > 0
            //                   ? ImageLoader(widget.data['background'])
            //                   : Image.asset(
            //                       'assets/images/icon/bg_appbar_03.png',
            //                       fit: BoxFit.fill,
            //                     ),
            //             )),
            //         // 遮挡照片一部分的
            //         // Positioned(
            //         //     top: topImageHeight - coverHeight,
            //         //     left: 0,
            //         //     right: 0,
            //         //     height: coverHeight,
            //         //     child: Container(
            //         //       color: Colors.white,
            //         //     )),
            //         Container(
            //           margin:
            //               EdgeInsets.only(left: widthScale * 18 + margin * 2),
            //           height: 30,
            //           child: Stack(
            //             overflow: Overflow.visible,
            //             children: [
            //               Positioned(
            //                   top: -30,
            //                   child: Text(
            //                     widget.data['userName'] ?? '',
            //                     style: TextStyle(
            //                         fontSize: 18,
            //                         color: Colors.white,
            //                         fontWeight: FontWeight.bold),
            //                   ))
            //             ],
            //           ),
            //         ),
            //         Positioned(
            //             top: topHeight - 35,
            //             left: widthScale * 18 + margin * 2,
            //             // width: 200,
            //             height: 50,
            //             child: Text(
            //               widget.data['userName'] ?? '',
            //               style: TextStyle(
            //                   fontSize: 18,
            //                   color: Colors.white,
            //                   fontWeight: FontWeight.bold),
            //             )),
            //       ],
            //     ),
            //   ),
            // ),
            // // 头像
            // Container(
            //   width: SizeConfig.screenWidth,
            //   height: 30,
            //   child: Stack(
            //     overflow: Overflow.visible,
            //     children: [
            //       Positioned(
            //           left: margin,
            //           top: -(widthScale * 10),
            //           width: widthScale * 20,
            //           height: widthScale * 20,
            //           child: GestureDetector(
            //             onTap: () {
            //               print('headImgSelectV == tap');
            //               headImgSelectV.showImage(context);
            //             },
            //             child: Container(
            //                 width: widthScale * 20,
            //                 height: widthScale * 20,
            //                 decoration: BoxDecoration(
            //                   color: Colors.white,
            //                   borderRadius:
            //                       BorderRadius.circular(widthScale * 3),
            //                 ),
            //                 child: Padding(
            //                   padding: const EdgeInsets.all(5.0),
            //                   child: ClipRRect(
            //                       borderRadius:
            //                           BorderRadius.circular(widthScale * 2),
            //                       child: avatarPath != null &&
            //                               avatarPath.length > 0
            //                           ? ImageLoader(avatarPath)
            //                           : Image.asset(
            //                               'assets/images/icon/icon_default_head.png')),
            //                 )),
            //           )),
            //     ],
            //   ),
            // ),
            // SizedBox(
            //   height: 10,
            // ),
            // 个人签名
            Row(crossAxisAlignment: CrossAxisAlignment.start, children: [
              SizedBox(
                width: 25,
              ),
              GestureDetector(
                behavior: HitTestBehavior.opaque,
                onTap: () => headImgSelectV.showImage(context),
                child: Container(
                  width: 48,
                  height: 20,
                ),
              ),
              SizedBox(
                width: 22,
              ),
              Padding(
                padding: EdgeInsets.only(top: 10),
                child: signIsEdit
                    ? getSignInput(
                        SizeConfig.screenWidth - (widthScale * 18 + margin * 3),
                        30)
                    : GestureDetector(
                        onTap: () {
                          setState(() {
                            signIsEdit = true;
                          });
                          Future.delayed(Duration(milliseconds: 300), () {
                            FocusScope.of(context).requestFocus(signFocusNode);
                          });
                        },
                        child: Container(
                          width: SizeConfig.screenWidth -
                              (widthScale * 18 + margin * 3),
                          child: Text(
                            widget.data['sign'] ?? '点击设置个人签名',
                            maxLines: 10,
                            style: widget.data['sign'] == null ||
                                    widget.data['sign'] == ''
                                ? jm_text_gray_style13
                                : jm_text_black_style13,
                          ),
                        ),
                      ),
              ),
            ]),
            SizedBox(
              height: 6,
            ),
            // 部门信息
            Row(
              children: [
                SizedBox(
                  width: margin,
                ),
                Text(
                  (widget.data['posts'] != null &&
                              widget.data['posts'].length > 0
                          ? (((widget.data['posts'])[0])['postName'] ?? '')
                          : '') +
                      '  ' +
                      (widget.data['dept'] != null
                          ? (widget.data['dept'])['deptName'] ?? ''
                          : ''),
                  style: jm_text_gray_style13,
                )
              ],
            ),
            SizedBox(height: 3),
            // 入职时间
            Row(
              children: [
                SizedBox(
                  width: margin,
                ),
                Text(
                  widget.data['joinDate'] != null
                      ? ('入职日期: ' + widget.data['joinDate'])
                      : '',
                  style: jm_text_gray_style13,
                )
              ],
            ),
            // 奖章
            SizedBox(
              height: 10,
            ),

            Container(
              width: SizeConfig.screenWidth - margin - widthScale * 3.5,
              // height: 40,
              // color: Colors.red,
              child: Wrap(
                children: [
                  ...getMedals((medalData) {
                    showMedal(medalData);
                  })
                ],
              ),
            ),
            SizedBox(
              height: 10,
            ),
            Container(
              width: SizeConfig.screenWidth - margin * 2,
              decoration: BoxDecoration(
                border: Border.all(width: 1, color: jm_line_color),
                borderRadius: BorderRadius.circular(widthScale * 3),
              ),
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  getCommissionButton(
                      '总佣金',
                      numberFormat(widget.data['amount']) + '元',
                      // countFormat(widget.data['amount']),
                      widthScale,
                      (SizeConfig.screenWidth - margin * 2) / 3,
                      targetHeight,
                      () {},
                      textStyle: jm_text_black_style16),
                  JMline(width: 1, height: targetHeight),
                  getCommissionButton(
                      '已结佣',
                      numberFormat(widget.data['getSalary']) + '元',
                      // (widget.data['getSalary'].toString() ?? '') + '元',
                      // countFormat(widget.data['getSalary']),
                      widthScale,
                      (SizeConfig.screenWidth - margin * 2) / 3,
                      targetHeight,
                      () {},
                      textStyle: jm_text_black_style16),
                  JMline(width: 1, height: targetHeight),
                  getCommissionButton(
                      '待结佣',
                      numberFormat((widget.data['amount'] ?? 0) -
                              (widget.data['getSalary'] ?? 0)) +
                          '元',
                      // widget.data['amount'] != null &&
                      //         widget.data['getSalary'] != null
                      //     ? (widget.data['amount'] - widget.data['getSalary'])
                      //             .toString() +
                      //         '元'
                      //     : '',
                      // countCalculateFormat(
                      //     widget.data['amount'], widget.data['getSalary']),
                      widthScale,
                      (SizeConfig.screenWidth - margin * 2) / 3,
                      targetHeight,
                      () {},
                      goldTextStyle: jm_text_apptheme_style16,
                      isGold: true),
                ],
              ),
            ),
            SizedBox(
              height: 10,
            ),
            Container(
              decoration: BoxDecoration(
                  color: jm_line_color,
                  borderRadius: BorderRadius.circular(widthScale * 1.5)),
              child: Padding(
                padding: EdgeInsets.fromLTRB(widthScale * 3.5, widthScale * 1,
                    widthScale * 3.5, widthScale * 1),
                child: Text(
                  getMonthText(),
                  style: jm_text_black_bold_style13,
                ),
              ),
            ),
            SizedBox(
              height: 10,
            ),
            Container(
              width: SizeConfig.screenWidth - margin * 2,
              decoration: BoxDecoration(
                border: Border.all(width: 1, color: jm_line_color),
                borderRadius: BorderRadius.circular(widthScale * 3),
              ),
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  getCommissionButton(
                      '目标业绩',
                      countFormat(widget.targetData['number']),
                      widthScale,
                      (SizeConfig.screenWidth - margin * 2) / 2,
                      targetHeight,
                      () {}),
                  JMline(width: 1, height: targetHeight),
                  // getCommissionButton('已结佣', '20000', widthScale, (SizeConfig.screenWidth - margin * 2)/2, targetHeight, () {}),
                  // JMline(width: 1, height: targetHeight),
                  getCommissionButton(
                      '完成业绩',
                      countFormat(widget.targetData['actualCommission']),
                      widthScale,
                      (SizeConfig.screenWidth - margin * 2) / 2,
                      targetHeight,
                      () {},
                      isGold: true),
                ],
              ),
            ),
            SizedBox(
              height: 10,
            ),
          ],
        ),
      ),
    );
  }

  List<Widget> getMedals(Function(Map medalData) medalClick) {
    List<Widget> list = [];
    if (widget.medelList == null || widget.medelList.length == 0) {
      return list;
    }
    widget.medelList.forEach((element) {
      list.add(GestureDetector(
        onTap: () => medalClick(element),
        child: Container(
            margin: EdgeInsets.only(bottom: 8),
            width: widthScale * 10,
            height: widthScale * 7,
            alignment: Alignment.centerLeft,
            child: Image.network(
              element['icon'] ?? '',
              width: widthScale * 7,
              height: widthScale * 7,
            )),
      ));
    });
    return list;
  }

  Widget getCommissionButton(String title, String subTitle, double widthScale,
      double width, double height, Function() onPressed,
      {bool isGold = false,
      TextStyle textStyle = jm_text_black_style18,
      TextStyle goldTextStyle = jm_text_apptheme_style18}) {
    return Container(
      width: width - 3,
      constraints: BoxConstraints(minHeight: height),
      // height: height,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        // crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          SizedBox(
            height: 13,
          ),
          Text(
            title,
            style: jm_text_black_bold_style12,
          ),
          SizedBox(
            height: 3,
          ),
          Text(
            subTitle,
            style: isGold ? goldTextStyle : textStyle,
          ),
          SizedBox(
            height: 10,
          ),
        ],
      ),
    );
  }

  Widget getSignInput(double width, double height) {
    String str = widget.data['sign'] ?? '';
    return Container(
        constraints: BoxConstraints(
            minWidth: width,
            maxWidth: width,
            maxHeight: height,
            minHeight: height),
        child: CupertinoTextField(
          textAlignVertical: TextAlignVertical.center,
          focusNode: signFocusNode,
          maxLength: 60,
          controller: TextEditingController.fromValue(TextEditingValue(
              text: str ?? '',
              selection: TextSelection.fromPosition(TextPosition(
                  affinity: TextAffinity.downstream,
                  offset: str.length ?? 0)))),
          onChanged: (value) {
            userSign = value;
          },
        ));
  }

  void showMedal(Map medal) {
    showGeneralDialog(
      context: context,
      barrierColor: Colors.black.withOpacity(0.5),
      transitionDuration: const Duration(milliseconds: 500),
      barrierLabel: "",
      barrierDismissible: true,
      transitionBuilder: (_, anim, __, child) {
        return ScaleTransition(
          scale: anim,
          child: child,
        );
      },
      pageBuilder: (context, animation, secondaryAnimation) {
        return GestureDetector(
          onTap: () => Navigator.pop(context),
          child: UnconstrainedBox(
            child: Container(
              height: 610,
              // color: Colors.red,
              width: SizeConfig.screenWidth,
              child: Stack(
                children: [
                  Positioned(
                    left: 0,
                    right: 0,
                    top: 0,
                    bottom: 70,
                    child: Image.asset(
                      'assets/images/icon/bg_medal.png',
                      fit: BoxFit.fill,
                    ),
                  ),
                  Align(
                    alignment: Alignment.bottomCenter,
                    child: RawMaterialButton(
                      onPressed: () => Navigator.pop(context),
                      fillColor: Colors.transparent,
                      splashColor: Colors.transparent,
                      elevation: 0,
                      highlightElevation: 0,
                      constraints: BoxConstraints(minWidth: 112, minHeight: 48),
                      shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(24),
                          side: BorderSide(width: 2, color: Colors.white)),
                      child: Text(
                        '知道了',
                        style: TextStyle(color: Colors.white, fontSize: 17),
                      ),
                    ),
                  ),
                  Positioned(
                      top: 207,
                      left: 48,
                      right: 48,
                      child: Column(
                        children: [
                          Container(
                            width: SizeConfig.screenWidth - 96,
                            alignment: Alignment.topCenter,
                            child: Text(
                              medal['name'] ?? '',
                              textAlign: TextAlign.center,
                              style: jm_text_black_bold_style17,
                            ),
                          ),
                          SizedBox(
                            height: 16,
                          ),
                          Container(
                            width: SizeConfig.screenWidth - 96,
                            alignment: Alignment.topCenter,
                            child: Text(
                              medal['mean'] ?? '',
                              textAlign: TextAlign.center,
                              style: jm_text_black_style15,
                            ),
                          )
                        ],
                      ))
                ],
              ),
            ),
          ),
        );
      },
    );
  }

  String getMonthText() {
    DateTime dateTime = DateTime.now();
    return dateTime.year.toString() +
        '-' +
        andZero(dateTime.month) +
        '-01' +
        ' 至 ' +
        dateTime.year.toString() +
        '-' +
        andZero(dateTime.month) +
        '-' +
        andZero(dateTime.day);
  }

  String andZero(int time) {
    if (time < 10) {
      return '0' + time.toString();
    } else {
      return time.toString();
    }
  }

  String countFormat(dynamic count) {
    if (count == null) {
      return '0.0元';
    } else if (count >= 10000) {
      return formatNum((count / 10000) * 1.0, 2) + '万元';
    } else {
      return formatNum(count * 1.0, 2) + '元';
    }
  }

  String countCalculateFormat(double count, double count2) {
    if (count == null && count2 == null) {
      return '0.0元';
    } else if (count != null && count2 == null) {
      if (count >= 10000) {
        return formatNum((count / 10000.0), 2) + '万元';
      } else {
        return formatNum((count * 1.0), 2) + '元';
      }
    } else if (count == null && count2 != null) {
      return '0.0元';
    } else if ((count - count2) >= 10000) {
      return formatNum(((count - count2) * 1.0 / 10000), 2) + '万元';
    } else {
      return formatNum((count - count2) * 1.0, 2) + '元';
    }
  }
}
