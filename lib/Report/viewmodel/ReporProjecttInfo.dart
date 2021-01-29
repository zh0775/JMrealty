import 'package:JMrealty/components/NoneV.dart';
import 'package:JMrealty/const/Default.dart';
import 'package:JMrealty/utils/sizeConfig.dart';
import 'package:flutter/material.dart';

class ReporProjecttInfo extends StatefulWidget {
  final Map data;
  final bool isCopy;
  final double width;
  final double margin;
  final double labelSpace;
  const ReporProjecttInfo({
    this.data,
    this.isCopy = false,
    this.width,
    this.margin,
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
  @override
  Widget build(BuildContext context) {
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
          getProjectInfoCell('报备项目', widget.data['projectName'] ?? ''),
          SizedBox(
            height: widget.labelSpace,
          ),
          getProjectInfoCell('发起报备时间', widget.data['createTime'] ?? ''),
          SizedBox(
            height: widget.labelSpace,
          ),
          getProjectInfoCell('最早到场时间', widget.data['projectBeforeTime'] ?? ''),
          SizedBox(
            height: widget.labelSpace,
          ),
          updateCell(),
          getProjectInfoCell('报备保护期', widget.data['projectProtect'] ?? '-'),
          SizedBox(
            height: widget.labelSpace,
          ),
          getProjectInfoCell('报备状态', statusText,
              textColor: jm_getReportStatusColor(widget.data['status'] ?? -1)),
          SizedBox(
            height: widget.labelSpace,
          ),
          getProjectInfoCell('报备公司', widget.data['company'] ?? ''),
          SizedBox(
            height: widget.labelSpace,
          ),
          getProjectInfoCell('报备服务点', widget.data['deptName'] ?? ''),
          SizedBox(
            height: widget.labelSpace,
          ),
          getProjectInfoCell('员工名称', widget.data['employeeName'] ?? ''),
          SizedBox(
            height: widget.labelSpace,
          ),
          getProjectInfoCell('员工号码', widget.data['employeePhone'] ?? '')
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
      child: getProjectInfoCell(title, widget.data['updateTime'] ?? '-'),
    );
  }

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
              widget.data['customerPhone'] ?? '',
              style: jm_text_black_bold_style16,
            )
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
      {Color textColor = jm_text_black}) {
    return Row(
      children: [
        SizedBox(
          width: outMargin,
        ),
        getLabel(title),
        Text(
          content,
          style: TextStyle(fontSize: 15, color: textColor),
        )
      ],
    );
  }

  Widget getLabel(String title) {
    return Container(
      width: widthScale * 25,
      child: Text(
        title,
        style: jm_text_gray_style15,
      ),
    );
  }
}