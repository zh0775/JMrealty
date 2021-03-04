import 'dart:ui';

import 'package:JMrealty/Report/ReportSuccess.dart';
import 'package:JMrealty/Report/ReportUpload.dart';
import 'package:JMrealty/Report/viewmodel/ReporProjecttInfo.dart';
import 'package:JMrealty/Report/viewmodel/ReportChangeStatusViewModel.dart';
import 'package:JMrealty/components/CustomAlert.dart';
import 'package:JMrealty/components/CustomCheckBox.dart';
import 'package:JMrealty/const/Default.dart';
import 'package:JMrealty/utils/notify_default.dart';
import 'package:JMrealty/utils/sizeConfig.dart';
import 'package:JMrealty/utils/user_default.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'dart:convert' as convert;
import 'ReportDetail.dart';
import 'package:intl/intl.dart';

enum ReportCellButtonStatus {
  takeLook, // 带看
  invalid, // 失效
  upload, // 上传
  appointment, // 预约
  buy, // 认购
  sign, // 签约
  chargeback, // 退单
  disputed, // 争议单
  check, // 审核,
  receive, // 接收,
}

class ReportListCell extends StatefulWidget {
  final Function() needRefrash;
  final Map data;
  final int index;
  final bool copyStatus;
  final Map buttonAuth;
  final int selfUserId;
  final Function(Map data, bool add, bool copyNeedShowPhone) copyItem;
  final Function(Map data, bool copyNeedShowPhone) copyOneItem;
  ReportListCell(
      {@required this.data,
      this.index,
      this.selfUserId,
      this.needRefrash,
      this.copyItem,
      this.buttonAuth = const {},
      this.copyStatus = false,
      this.copyOneItem});
  @override
  _ReportListCellState createState() => _ReportListCellState();
}

class _ReportListCellState extends State<ReportListCell> {
  bool checkCopyValue = false;
  ReportChangeStatusViewModel reportChangeStatusVM =
      ReportChangeStatusViewModel();
  double widthScale;
  double outMargin;
  double insideMargin;
  double labelSpace;
  int status;
  bool copyNeedShowPhone = false;
  @override
  void initState() {
    labelSpace = 4;
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    status = widget.data['status'];
    if (!widget.copyStatus) {
      checkCopyValue = false;
    }

    SizeConfig().init(context);
    widthScale = SizeConfig.blockSizeHorizontal;
    outMargin = widthScale * 4;
    insideMargin = widthScale * 6;

    return GestureDetector(
      onLongPress: () {
        if (!widget.copyStatus && widget.copyOneItem != null) {
          widget.copyOneItem(
              Map.from({'showPhone': copyNeedShowPhone, ...widget.data}),
              copyNeedShowPhone);
        }
      },
      onTap: () {
        FocusScope.of(context).requestFocus(FocusNode());
        push(
            ReportDetail(
              data: widget.data,
              selfUserId: widget.selfUserId,
            ),
            context);
      },
      child: Container(
        width: SizeConfig.screenWidth,
        margin: EdgeInsets.only(bottom: outMargin),
        decoration: BoxDecoration(
          // border: Border(bottom: BorderSide(width: 1.5, color: Colors.black)),
          color: Color(0xfff0f2f5),
        ),
        child: Align(
          alignment: Alignment.topLeft,
          child: Container(
            width: SizeConfig.screenWidth - outMargin * 2,
            margin: widget.index != null && widget.index == 0
                ? EdgeInsets.only(top: outMargin, left: outMargin)
                : EdgeInsets.only(left: outMargin),
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(16),
              color: Colors.white,
            ),
            child: Column(
              children: [
                copyView(),
                ReporProjecttInfo(
                    showPhone: (showPhone) {
                      copyNeedShowPhone = showPhone;
                    },
                    data: widget.data,
                    isDetail: false,
                    selfUserId: widget.selfUserId,
                    isCopy: widget.data['isCopy'] != null &&
                            widget.data['isCopy'] == 1
                        ? true
                        : false,
                    width: SizeConfig.screenWidth - outMargin * 2,
                    margin: insideMargin),
                // SizedBox(
                //   height: 15,
                // ),
                // JMline(width: SizeConfig.screenWidth, height: 0.5),
                SizedBox(
                  height: 6,
                ),
                getButtons(),
              ],
            ),
          ),
        ),
      ),
    );
  }

  // 复制
  Widget copyView() {
    if (widget.copyStatus) {
      return Container(
        width: double.infinity,
        margin: EdgeInsets.only(right: widthScale * 2),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.end,
          children: [
            SizedBox(
              height: 5,
            ),
            CustomCheckBox(
              value: checkCopyValue,
              onChange: (selected) {
                setState(() {
                  checkCopyValue = selected;
                });
                if (widget.copyItem != null) {
                  widget.copyItem(
                      Map.from(
                          {'showPhone': copyNeedShowPhone, ...widget.data}),
                      checkCopyValue,
                      copyNeedShowPhone);
                }
              },
            ),
          ],
        ),
      );
    } else {
      return SizedBox(
        height: 15,
      );
    }
  }

  // 姓名电话
  Widget getTitle() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Row(
          children: [
            SizedBox(
              width: outMargin,
            ),
            Text(
              widget.data['customerName'] ?? '无',
              style: jm_text_black_bold_style16,
            ),
            SizedBox(
              width: widthScale * 2,
            ),
            Text(
              widget.data['customerPhone'],
              style: jm_text_black_bold_style16,
            )
          ],
        ),
        Row(
          children: [
            Text(
              widget.data['isCopy'] != null
                  ? (widget.data['isCopy'] == 1 ? '已复制' : '')
                  : '',
              style: jm_text_gray_style15,
            ),
            SizedBox(
              width: insideMargin,
            )
          ],
        )
      ],
    );
  }

  // 项目名称
  Widget getProject() {
    return Row(
      children: [
        SizedBox(
          width: outMargin,
        ),
        getLabel('报备项目'),
        Text(
          widget.data['projectName'],
          style: jm_text_black_style15,
        )
      ],
    );
  }

  Widget getProjectInfoCell(String title, String content) {
    return Row(
      children: [
        SizedBox(
          width: outMargin,
        ),
        getLabel(title),
        Text(
          content,
          style: jm_text_black_style15,
        )
      ],
    );
  }

  // 项目保护期
  Widget getProtect() {
    return Row(
      children: [
        SizedBox(
          width: outMargin,
        ),
        getLabel('报备保护期'),
        Text(
          widget.data['projectProtect'] ?? '-',
          style: jm_text_black_style15,
        )
      ],
    );
  }

  // 报备状态
  Widget getStatus() {
    return Row(
      children: [
        SizedBox(
          width: outMargin,
        ),
        getLabel('报备状态'),
        Text(
          jm_getReportStatusStr(widget.data['status'] ?? -1),
          style: TextStyle(
              fontSize: 15,
              color: jm_getReportStatusColor(widget.data['status'] ?? -1)),
        )
      ],
    );
  }

  // 报备公司
  Widget getCompany() {
    return Row(
      children: [
        SizedBox(
          width: outMargin,
        ),
        getLabel('报备公司'),
        Text(
          widget.data['projectName'],
          style: jm_text_black_style15,
        )
      ],
    );
  }

  // 员工名称
  Widget getName() {
    return Row(
      children: [
        SizedBox(
          width: outMargin,
        ),
        getLabel('员工名称'),
        Text(
          widget.data['employeeName'],
          style: jm_text_black_style15,
        )
      ],
    );
  }

  // 员工号码
  Widget getNum() {
    return Row(
      children: [
        SizedBox(
          width: outMargin,
        ),
        getLabel('员工号码'),
        Text(
          widget.data['employeePhone'],
          style: jm_text_black_style15,
        )
      ],
    );
  }

  // enum ReportCellButtonStatus {
  //   takeLook, // 带看
  //   invalid, // 失效
  //   upload, // 上传
  //   appointment, // 预约
  //   buy, // 认购
  //   sign, // 签约
  //   chargeback, // 退单
  // }

  // 底部按钮
  Widget getButtons() {
    List buttonsType = [];
    switch (status) {
      case 0:
        if (widget.buttonAuth['app:report:list:receive'] != null) {
          buttonsType.add(ReportCellButtonStatus.receive);
        }
        // buttonsType = [
        //   ReportCellButtonStatus.receive,
        //   // ReportCellButtonStatus.takeLook,
        //   // ReportCellButtonStatus.upload,
        //   // ReportCellButtonStatus.invalid
        // ];
        break;
      case 5:
        if (widget.buttonAuth['app:report:list:see'] != null) {
          buttonsType.add(ReportCellButtonStatus.takeLook);
        }
        if (widget.buttonAuth['app:report:list:upload'] != null) {
          buttonsType.add(ReportCellButtonStatus.upload);
        }
        if (widget.buttonAuth['app:report:list:invalid'] != null) {
          buttonsType.add(ReportCellButtonStatus.invalid);
        }
        // buttonsType = [
        //   ReportCellButtonStatus.takeLook,
        //   ReportCellButtonStatus.upload,
        //   ReportCellButtonStatus.invalid
        // ];
        break;
      case 10:
        if (widget.buttonAuth['app:report:list:upload'] != null) {
          buttonsType.add(ReportCellButtonStatus.upload);
        }
        // buttonsType = [
        //   ReportCellButtonStatus.upload,
        // ];
        break;
      case 20:
        if (widget.buttonAuth['app:report:list:order'] != null) {
          buttonsType.add(ReportCellButtonStatus.appointment);
        }
        if (widget.buttonAuth['app:report:list:deal'] != null) {
          buttonsType.add(ReportCellButtonStatus.buy);
        }
        if (widget.buttonAuth['app:report:list:dispute'] != null) {
          buttonsType.add(ReportCellButtonStatus.disputed);
        }
        // buttonsType = [
        //   ReportCellButtonStatus.appointment,
        //   ReportCellButtonStatus.buy,
        //   ReportCellButtonStatus.disputed,
        // ];
        break;
      case 22:
        if (widget.buttonAuth['app:report:list:review appointment'] != null) {
          buttonsType.add(ReportCellButtonStatus.check);
        }
        // buttonsType = [
        //   ReportCellButtonStatus.check,
        // ];
        break;
      case 24:
        if (widget.buttonAuth['app:report:list:check the transaction'] !=
            null) {
          buttonsType.add(ReportCellButtonStatus.check);
        }
        // buttonsType = [
        //   ReportCellButtonStatus.check,
        // ];
        break;
      case 21:
        if (widget.buttonAuth['app:report:list:deal'] != null) {
          buttonsType.add(ReportCellButtonStatus.buy);
        }
        // buttonsType = [
        //   ReportCellButtonStatus.buy,
        // ];
        break;
      case 30:
        if (widget.buttonAuth['app:report:list:sign up'] != null) {
          buttonsType.add(ReportCellButtonStatus.sign);
        }
        if (widget.buttonAuth['app:report::list:Chargeback'] != null) {
          buttonsType.add(ReportCellButtonStatus.chargeback);
        }
        // buttonsType = [
        //   ReportCellButtonStatus.sign,
        //   ReportCellButtonStatus.chargeback,
        // ];
        break;
      case 63:
        if (widget.buttonAuth['app:report:list:upload'] != null) {
          buttonsType.add(ReportCellButtonStatus.upload);
        }
        if (widget.buttonAuth['app:report:list:deal'] != null) {
          buttonsType.add(ReportCellButtonStatus.buy);
        }
        if (widget.buttonAuth['app:report:list:order'] != null) {
          buttonsType.add(ReportCellButtonStatus.appointment);
        }
        // buttonsType = [
        //   ReportCellButtonStatus.upload,
        //   ReportCellButtonStatus.buy,
        //   ReportCellButtonStatus.appointment,
        // ];
        break;
    }
    List<Widget> buttons = [];
    // takeLook, // 带看
    // invalid, // 失效
    // upload, // 上传
    // appointment, // 预约
    // buy, // 认购
    // sign, // 签约
    // chargeback, // 退单
    // disputed, // 争议单
    // check, // 审核,
    // receive, // 接收,
    buttonsType.forEach((e) {
      buttons.add(getStatusButton(e));
    });
    double space =
        ((SizeConfig.screenWidth - outMargin * 2) - widthScale * 75) / 4;
    return Container(
        width: SizeConfig.screenWidth,
        margin: EdgeInsets.only(top: 8),
        decoration: BoxDecoration(
            border: Border(
                top: buttons.length > 0
                    ? BorderSide(width: 0.5, color: jm_line_color)
                    : BorderSide.none)),
        // margin: EdgeInsets.only(left: space, bottom: 10, top: 4),
        child: Padding(
          padding: EdgeInsets.fromLTRB(space, buttons.length > 0 ? 10 : 0,
              space, buttons.length > 0 ? 10 : 0),
          child: Wrap(
            // alignment: WrapAlignment.spaceAround,
            spacing: space,

            children: [...buttons],
          ),
        ));
  }

  // label
  Widget getLabel(String title) {
    return Container(
      width: widthScale * 25,
      child: Text(
        title,
        style: jm_text_gray_style15,
      ),
    );
  }

  Widget getStatusButton(ReportCellButtonStatus buttonStatus) {
    void Function() buttonClick = () {};
    // Color buttonColor = Colors.white;
    Color borderColor = jm_line_color;
    String titlt = '带看';
    TextStyle textStyle = jm_text_black_style13;
    switch (buttonStatus) {
      case ReportCellButtonStatus.receive:
        buttonClick = () {
          CustomAlert(title: '接收', content: '是否确认接收').show(
            confirmClick: () {
              Map<String, dynamic> params = {
                'beforeStatus': widget.data['status'],
                'reportId': widget.data['id'],
                'visaTime':
                    DateFormat('yyyy-MM-dd HH:mm:ss').format(DateTime.now())
              };
              reportChangeStatusVM.reportReceive(params, (success) {
                if (success && widget.needRefrash != null) {
                  widget.needRefrash();
                }
              });
            },
          );
        };
        titlt = '接收';
        break;
      case ReportCellButtonStatus.takeLook:
        buttonClick = () {
          CustomAlert(content: '是否添加到已带看').show(
            confirmClick: () {
              Map<String, dynamic> params = {
                'beforeStatus': widget.data['status'],
                'reportId': widget.data['id'],
                'remark': '',
                'images': '',
                'visaTime':
                    DateFormat('yyyy-MM-dd HH:mm:ss').format(DateTime.now())
              };
              reportChangeStatusVM.takelookRequest(params, (success) {
                if (success && widget.needRefrash != null) {
                  widget.needRefrash();
                }
              });
            },
          );
        };
        titlt = '带看';
        break;
      case ReportCellButtonStatus.upload:
        buttonClick = () {
          Navigator.of(context).push(CupertinoPageRoute(
            builder: (context) {
              return ReportUpload(
                data: widget.data,
                uploadStatus: ReportUploadStatus.upload,
              );
            },
          ));
        };
        titlt = '上传带看单';
        break;
      case ReportCellButtonStatus.invalid:
        buttonClick = () {
          Navigator.of(context).push(CupertinoPageRoute(
            builder: (context) {
              return ReportUpload(
                data: widget.data,
                uploadStatus: ReportUploadStatus.invalid,
              );
            },
          ));
        };
        titlt = '失效';
        break;
      case ReportCellButtonStatus.appointment:
        buttonClick = () {
          Navigator.of(context).push(CupertinoPageRoute(
            builder: (context) {
              return ReportUpload(
                data: widget.data,
                uploadStatus: ReportUploadStatus.appointment,
              );
            },
          ));
        };
        titlt = '预约';
        break;
      case ReportCellButtonStatus.buy:
        buttonClick = () {
          UserDefault.get(USERINFO).then((value) {
            Map userInfo = Map<String, dynamic>.from(convert.jsonDecode(value));

            Navigator.of(context).push(CupertinoPageRoute(
              builder: (context) {
                return ReportSuccess(
                  data: widget.data,
                  userInfo: userInfo,
                );
              },
            ));
          });
        };
        titlt = '成交';
        break;
      case ReportCellButtonStatus.sign:
        buttonClick = () {
          Navigator.of(context).push(CupertinoPageRoute(
            builder: (context) {
              return ReportUpload(
                data: widget.data,
                uploadStatus: ReportUploadStatus.sign,
              );
            },
          ));
        };
        titlt = '签约';
        break;
      case ReportCellButtonStatus.chargeback:
        buttonClick = () {
          push(
              ReportUpload(
                data: widget.data,
                uploadStatus: ReportUploadStatus.chargeback,
              ),
              context);
        };
        titlt = '退单';
        break;
      case ReportCellButtonStatus.disputed:
        buttonClick = () {
          push(
              ReportUpload(
                data: widget.data,
                uploadStatus: ReportUploadStatus.disputed,
              ),
              context);
        };
        titlt = '争议单';
        break;
      case ReportCellButtonStatus.check:
        ReportUploadStatus uploadStatus = ReportUploadStatus.checkAppointment;
        titlt = '审核预约';

        if (status == 24) {
          uploadStatus = ReportUploadStatus.checkDeal;
          titlt = '审核成交';
        }
        buttonClick = () {
          push(
              ReportUpload(
                data: widget.data,
                uploadStatus: uploadStatus,
              ),
              context);
        };
    }

    return RawMaterialButton(
      materialTapTargetSize: MaterialTapTargetSize.shrinkWrap,
      shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(widthScale * 2),
          side: BorderSide(width: 1, color: borderColor)),
      constraints: BoxConstraints(
        minHeight: 30,
        minWidth: widthScale * 25,
      ),
      textStyle: textStyle,
      child: Text(titlt),
      onPressed: () {
        FocusScope.of(context).requestFocus(FocusNode());
        buttonClick();
      },
    );
  }

  Widget getTextButton(String title, Function() buttonClick,
      {Color borderColor = jm_line_color,
      TextStyle textStyle = jm_text_black_style13}) {
    return TextButton(
        onPressed: buttonClick,
        style: ButtonStyle(
          minimumSize: MaterialStateProperty.all(Size(widthScale * 25, 30)),
          padding: MaterialStateProperty.all(EdgeInsets.all(10)),
        ),
        child: Container(
          width: widthScale * 25,
          height: 30,
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(6),
            border: Border.all(width: 0.5, color: borderColor),
          ),
          child: Center(
            child: Text(
              title,
              style: textStyle,
            ),
          ),
        ));
  }
}
