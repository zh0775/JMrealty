import 'dart:ui';

import 'package:JMrealty/components/CustomButton.dart';
import 'package:JMrealty/components/NoneV.dart';
import 'package:JMrealty/const/Default.dart';
import 'package:JMrealty/utils/sizeConfig.dart';
import 'package:JMrealty/utils/tTools.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';

class ReporProjecttInfo extends StatefulWidget {
  final Map data;
  final bool isCopy;
  final double width;
  final double margin;
  final double labelSpace;
  final bool isDetail;
  final int selfUserId;
  final Function(bool showPhone) showPhone;
  const ReporProjecttInfo({
    this.isDetail = true,
    this.data,
    this.isCopy = false,
    this.width,
    this.selfUserId,
    this.margin,
    this.showPhone,
    this.labelSpace = 3,
  });
  @override
  _ReporProjecttInfoState createState() => _ReporProjecttInfoState();
}

class _ReporProjecttInfoState extends State<ReporProjecttInfo> {
  double cellHeight;
  double widthScale;
  double outMargin;
  // double labelSpace;
  double selfWidth;
  bool needShowTmButton = false;
  bool showPhone = false;
  @override
  void initState() {
    super.initState();
  }

  @override
  void didUpdateWidget(covariant ReporProjecttInfo oldWidget) {
    // if (oldWidget.selfUserId != widget.selfUserId ||
    //     oldWidget.data['employeeId'] != widget.data['employeeId']) {
    //   print('needShowTmButton ==== $needShowTmButton');

    // }
    super.didUpdateWidget(oldWidget);
  }

  @override
  Widget build(BuildContext context) {
    if (widget.data['isSensitive'] != null &&
        widget.data['isSensitive'] == 1 &&
        widget.data['employeeId'] != null &&
        widget.selfUserId != null &&
        widget.data['employeeId'] == widget.selfUserId) {
      needShowTmButton = true;
    } else {
      needShowTmButton = false;
    }
    SizeConfig().init(context);
    widthScale = SizeConfig.blockSizeHorizontal;
    outMargin = widget.margin ?? widthScale * 6;
    selfWidth = SizeConfig.screenWidth - outMargin * 2;

    String statusText = jm_getReportStatusStr(widget.data['status'] ?? -1);
    if (widget.data['status'] == 24) {
      statusText = '待成交';
    } else if (widget.data['status'] == 22) {
      statusText = '待预约';
    }

    return Container(
      width: widget.width ?? selfWidth,
      child: Column(
        children: [
          getTitle(),
          SizedBox(
            height: 12,
          ),
          getProjectInfoCell('报备项目', widget.data['projectName'] ?? '-',
              use: widget.data['purpose'] ?? ''),
          SizedBox(
            height: widget.labelSpace,
          ),
          getProjectInfoCell('发起报备时间', widget.data['createTime'] ?? '-'),
          SizedBox(
            height: widget.labelSpace,
          ),
          widget.data['status'] == 0 && !widget.isDetail
              ? NoneV()
              : getProjectInfoCell(
                  '最早到场时间', widget.data['projectBeforeTime'] ?? ''),
          SizedBox(
            height: widget.data['status'] == 0 && !widget.isDetail
                ? 0
                : widget.labelSpace,
          ),
          widget.data['status'] != 0 ? updateCell() : NoneV(),
          widget.data['status'] == 0 && !widget.isDetail
              ? NoneV()
              : getProjectInfoCell(
                  '报备保护期', widget.data['projectProtect'] ?? '-'),
          SizedBox(
            height: widget.data['status'] == 0 && !widget.isDetail
                ? 0
                : widget.labelSpace,
          ),
          getProjectInfoCell('报备状态', statusText,
              textColor: jm_getReportStatusColor(widget.data['status'] ?? -1)),
          SizedBox(
            height: widget.labelSpace,
          ),
          getProjectInfoCell('报备公司', widget.data['employeeCompany'] ?? '-'),
          SizedBox(
            height: widget.labelSpace,
          ),
          getProjectInfoCell('报备服务点', widget.data['deptName'] ?? '-'),
          SizedBox(
            height: widget.labelSpace,
          ),
          getProjectInfoCell('员工名称', widget.data['employeeName'] ?? '-'),
          SizedBox(
            height: widget.labelSpace,
          ),
          getProjectInfoCell('员工号码', widget.data['employeePhone'] ?? '-',
              heightAdjust: true),
          SizedBox(
            height: widget.labelSpace,
          ),
          getProjectInfoCell('对接公司', widget.data['company'] ?? '-')
        ],
      ),
    );
  }

  Widget updateCell() {
    if (widget.data['status'] != 20 &&
        widget.data['status'] != 63 &&
        widget.data['status'] != 21 &&
        widget.data['status'] != 22 &&
        widget.data['status'] != 24 &&
        widget.data['status'] != 30 &&
        widget.data['status'] != 40 &&
        widget.data['status'] != 0 &&
        widget.data['status'] != 5 &&
        widget.data['status'] != 10 &&
        widget.data['status'] != 50 &&
        widget.data['status'] != 60 &&
        widget.data['status'] != 70 &&
        widget.data['status'] != 80) {
      return NoneV();
    }
    String title = '-';
    switch (widget.data['status']) {
      case 0:
        title = '报备时间';
        break;
      case 5:
        title = '报备接收时间';
        break;
      case 10:
        title = '带看时间';
        break;
      case 20:
        title = '报备上传时间';
        break;
      case 63:
        title = '变更争议时间';
        break;
      case 21:
        title = '确认预约时间';
        break;
      case 22:
        title = '提交预约时间';
        break;
      case 24:
        title = '提交成交时间';
        break;
      case 30:
        title = '确认成交时间';
        break;
      case 40:
        title = '签约时间';
        break;
      case 50:
        title = '回款时间';
        break;
      case 60:
        title = '结佣时间';
        break;
      case 70:
        title = '失效时间';
        break;
      case 80:
        title = '退单时间';
        break;

      default:
    }

    return Padding(
      padding: EdgeInsets.only(bottom: widget.labelSpace),
      child: getProjectInfoCell(title, widget.data['reportStatusTime'] ?? '-'),
    );
  }

  Widget getTitle() {
    String customerPhone = '';
    if (needShowTmButton) {
      if (showPhone) {
        customerPhone = widget.data['customerPhone'] ?? '';
      } else {
        customerPhone = hiddenPhone(widget.data['customerPhone']);
      }
    } else {
      customerPhone = (widget.data['isSensitive'] ?? 0) == 1
          ? hiddenPhone(widget.data['customerPhone'])
          : widget.data['customerPhone'] ?? '';
    }

    double showTMbuttonWidth = needShowTmButton ? widthScale * 10 : 0;
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Row(
          children: [
            SizedBox(
              width: outMargin,
            ),
            ConstrainedBox(
              constraints: BoxConstraints(
                minWidth: 0,
                maxWidth: widget.isDetail
                    ? widthScale * 40 - showTMbuttonWidth
                    : (widget.isCopy != null && widget.isCopy
                        ? widthScale * 26 - showTMbuttonWidth
                        : widthScale * 38 - showTMbuttonWidth),
              ),
              child: widget.isDetail
                  ? SelectableText(
                      widget.data['customerName'] ?? '无',
                      scrollPhysics: NeverScrollableScrollPhysics(),
                      style: TextStyle(
                        color: jm_text_black,
                        fontSize: 17,
                      ),
                    )
                  : Text(
                      widget.data['customerName'] ?? '无',
                      style: jm_text_black_bold_style16,
                    ),
            ),
            SizedBox(
              width: widthScale * 2,
            ),
            widget.data['customerSex'] != null
                ? Container(
                    decoration: BoxDecoration(
                      color: getSexBgColor(widget.data['customerSex']),
                      borderRadius: BorderRadius.circular(4),
                    ),
                    child: Padding(
                      padding: EdgeInsets.symmetric(horizontal: 6, vertical: 2),
                      child: Text(
                        widget.data['customerSex'] == 0 ||
                                widget.data['customerSex'] == '0'
                            ? '先生'
                            : '女士',
                        style: TextStyle(
                            fontSize: 12,
                            color: getSexTextColor(widget.data['customerSex'])),
                      ),
                    ),
                  )
                : NoneV(),
            SizedBox(
              width: widget.data['customerSex'] != null ? widthScale * 2 : 0,
            ),
            widget.isDetail
                ? SelectableText(
                    customerPhone,
                    style: jm_text_black_style17,
                  )
                : Text(
                    customerPhone,
                    style: jm_text_black_bold_style16,
                  ),
            needShowTmButton
                ? CustomButton(
                    onPressed: () {
                      setState(() {
                        showPhone = !showPhone;
                        if (widget.showPhone != null) {
                          widget.showPhone(showPhone);
                        }
                      });
                    },
                    // width: showTMbuttonWidth - widthScale * 2,
                    child: Image.asset(
                      showPhone
                          ? 'assets/images/icon/icon_showpass.png'
                          : 'assets/images/icon/icon_hidepass.png',
                      width: showTMbuttonWidth - widthScale * 2,
                    ),
                  )
                : NoneV()
            // SelectableText(
            //   (widget.data['isSensitive'] ?? 0) == 1
            //       ? hiddenPhone(widget.data['customerPhone'])
            //       : widget.data['customerPhone'] ?? '',
            //   style: jm_text_black_bold_style16,
            // ),
            // widget.isDetail
            //     ? SelectableText(
            //         (widget.data['isSensitive'] ?? 0) == 1
            //             ? hiddenPhone(widget.data['customerPhone'])
            //             : widget.data['customerPhone'] ?? '',
            //         style: jm_text_black_bold_style16,
            //       )
            //     : Text(
            //         (widget.data['isSensitive'] ?? 0) == 1
            //             ? hiddenPhone(widget.data['customerPhone'])
            //             : widget.data['customerPhone'] ?? '',
            //         style: jm_text_black_bold_style16,
            //       )
          ],
        ),
        Row(
          children: [
            Text(
              widget.isCopy != null ? (widget.isCopy ? '已复制' : '') : '',
              style: jm_text_gray_style15,
            ),
            SizedBox(
              width: outMargin,
            )
          ],
        )
      ],
    );
  }

  Widget getProjectInfoCell(String title, String content,
      {Color textColor = jm_text_black,
      bool heightAdjust = false,
      String use = ''}) {
    String contentText = content.length == 0 ? '-' : content;
    return Row(
      children: [
        SizedBox(
          width: outMargin,
        ),
        getLabel(title),
        widget.isDetail
            ? SelectableText(
                contentText,
                style: heightAdjust && widget.isDetail
                    ? TextStyle(fontSize: 16, color: textColor)
                    : TextStyle(fontSize: 16, color: textColor),
              )
            : Text(
                contentText,
                style: TextStyle(fontSize: 16, color: textColor),
              ),
        use != null && use.length > 0
            ? SizedBox(
                width: widthScale * 2,
              )
            : NoneV(),
        use != null && use.length > 0
            ? Container(
                decoration: BoxDecoration(
                  color: getPurposeColor(use),
                  borderRadius: BorderRadius.circular(widthScale * 1.5),
                ),
                child: Padding(
                  padding: EdgeInsets.symmetric(horizontal: 6, vertical: 2),
                  child: Text(
                    use,
                    style: TextStyle(fontSize: 14, color: Color(0xff62677D)),
                  ),
                ),
              )
            : NoneV()
      ],
    );
  }

  Widget getLabel(String title) {
    return Container(
      width: widthScale * 28,
      child: Text(
        title,
        style: jm_text_gray_style16,
      ),
    );
  }
}
