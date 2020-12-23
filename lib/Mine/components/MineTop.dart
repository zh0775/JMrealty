import 'package:JMrealty/Report/viewmodel/ReportUploadViewModel.dart';
import 'package:JMrealty/base/image_loader.dart';
import 'package:JMrealty/components/SelectImageView.dart';
import 'package:JMrealty/const/Default.dart';
import 'package:JMrealty/utils/sizeConfig.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class MineTop extends StatefulWidget {
  final double height;
  final Map data;
  final Map targetData;
  final Function(Map params) changeInfo;
  final Function() toLevelSetting;
  const MineTop(
      {this.height,
      this.data,
      this.toLevelSetting,
      this.targetData,
      this.changeInfo});

  @override
  _MineTopState createState() => _MineTopState();
}

class _MineTopState extends State<MineTop> {
  FocusNode signFocusNode = FocusNode();
  SelectImageView headImgSelectV;
  SelectImageView backImgSelectV;
  double targetHeight = 60;
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
            widget.changeInfo != null) {
          widget
              .changeInfo({'sign': userSign, 'userId': widget.data['userId']});
        }
      }
      // print("焦点1是否被选中：" + signFocusNode.hasFocus.toString());
    });
    super.initState();
  }

  @override
  void dispose() {
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
            UnconstrainedBox(
              child: Container(
                width: SizeConfig.screenWidth,
                height: topHeight,
                child: Stack(
                  overflow: Overflow.clip,
                  children: [
                    // 照片
                    Positioned(
                        top: 0,
                        left: 0,
                        right: 0,
                        height: topImageHeight,
                        child: GestureDetector(
                          onTap: () {
                            backImgSelectV.showImage(context);
                          },
                          child: backgroundPath != null &&
                                  backgroundPath.length > 0
                              ? ImageLoader(widget.data['background'], 0)
                              : Container(
                                  width: 0.0,
                                  height: 0.0,
                                ),
                        )),
                    // 遮挡照片一部分的
                    // Positioned(
                    //     top: topImageHeight - coverHeight,
                    //     left: 0,
                    //     right: 0,
                    //     height: coverHeight,
                    //     child: Container(
                    //       color: Colors.white,
                    //     )),
                    Positioned(
                        top: topHeight - 35,
                        left: widthScale * 18 + margin * 2,
                        // width: 200,
                        height: 50,
                        child: Text(
                          widget.data['userName'] ?? '',
                          style: TextStyle(
                              fontSize: 18,
                              color: Colors.white,
                              fontWeight: FontWeight.bold),
                        )),
                  ],
                ),
              ),
            ),
            // 头像
            Container(
              width: SizeConfig.screenWidth,
              height: 0,
              child: Stack(
                overflow: Overflow.visible,
                children: [
                  Positioned(
                      left: margin,
                      top: -(widthScale * 10),
                      width: widthScale * 20,
                      height: widthScale * 20,
                      child: GestureDetector(
                        onTap: () {
                          print('headImgSelectV == tap');
                          headImgSelectV.showImage(context);
                        },
                        child: Container(
                          width: widthScale * 20,
                          height: widthScale * 20,
                          decoration: BoxDecoration(
                            color: Colors.white,
                            borderRadius: BorderRadius.circular(widthScale * 3),
                          ),
                        ),
                      )),
                ],
              ),
            ),
            SizedBox(
              height: 10,
            ),
            // 个人签名
            Row(children: [
              SizedBox(
                width: widthScale * 18 + margin * 2,
              ),
              signIsEdit
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
                          style: jm_text_black_style13,
                        ),
                      ),
                    )
            ]),
            SizedBox(
              height: 10,
            ),
            // 部门信息
            Row(
              children: [
                SizedBox(
                  width: margin,
                ),
                Text(
                  (widget.data['psotName'] != null
                          ? (widget.data['psotName'] + ' | ')
                          : '') +
                      (widget.data['dept'] != null
                          ? (widget.data['dept'])['deptName'] ?? ''
                          : ''),
                  style: jm_text_gray_style13,
                )
              ],
            ),
            // 入职时间
            Row(
              children: [
                SizedBox(
                  width: margin,
                ),
                Text(
                  widget.data['joinDate'] != null
                      ? ('入职时间: ' + widget.data['joinDate'])
                      : '',
                  style: jm_text_gray_style13,
                )
              ],
            ),
            // 奖章
            SizedBox(
              height: 3,
            ),
            Container(
              width: SizeConfig.screenWidth - margin * 2,
              // height: 40,
              // color: Colors.red,
              child: Wrap(
                children: [],
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
                      countFormat(widget.targetData['amount']),
                      widthScale,
                      (SizeConfig.screenWidth - margin * 2) / 3,
                      targetHeight,
                      () {}),
                  JMline(width: 1, height: targetHeight),
                  getCommissionButton(
                      '已结佣',
                      countFormat(widget.targetData['getSalary']),
                      widthScale,
                      (SizeConfig.screenWidth - margin * 2) / 3,
                      targetHeight,
                      () {}),
                  JMline(width: 1, height: targetHeight),
                  getCommissionButton(
                      '待结佣',
                      countCalculateFormat(
                          widget.data['amount'], widget.data['getSalary']),
                      widthScale,
                      (SizeConfig.screenWidth - margin * 2) / 3,
                      targetHeight,
                      () {},
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
                  style: jm_text_black_style13,
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

  Widget getCommissionButton(String title, String subTitle, double widthScale,
      double width, double height, Function() onPressed,
      {bool isGold = false}) {
    return Container(
      width: width - 3,
      height: height,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        // crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            title,
            style: jm_text_black_style11,
          ),
          SizedBox(
            height: height * 0.14,
          ),
          Text(
            subTitle,
            style: isGold
                ? TextStyle(
                    color: jm_appTheme,
                    fontSize: 18,
                    fontWeight: FontWeight.bold)
                : jm_text_black_bold_style18,
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

  String countFormat(double count) {
    if (count == null) {
      return '0.0元';
    } else if (count >= 10000) {
      return (count / 10000).toString() + '万元';
    } else {
      return count.toString() + '元';
    }
  }

  String countCalculateFormat(double count, double count2) {
    if (count == null && count2 == null) {
      return '0.0元';
    } else if (count != null && count2 == null) {
      if (count >= 10000) {
        return (count / 10000).toString() + '万元';
      } else {
        return count.toString() + '元';
      }
    } else if (count == null && count2 != null) {
      return '0.0元';
    } else if ((count - count2) >= 10000) {
      return ((count - count2) / 10000).toString() + '万元';
    } else {
      return (count - count2).toString() + '元';
    }
  }
}
