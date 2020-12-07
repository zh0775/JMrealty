import 'package:JMrealty/Report/ReportUpload.dart';
import 'package:JMrealty/components/CustomAlert.dart';
import 'package:JMrealty/const/Default.dart';
import 'package:JMrealty/utils/sizeConfig.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class ReportListCell extends StatefulWidget {
  final Map data;
  final int index;
  ReportListCell({@required this.data, this.index});
  @override
  _ReportListCellState createState() => _ReportListCellState();
}

class _ReportListCellState extends State<ReportListCell> {
  double cellHeight;
  double widthScale;
  double outMargin;
  double insideMargin;
  double labelSpace;
  @override
  void initState() {
    cellHeight = 330;
    labelSpace = 3;
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    SizeConfig().init(context);
    widthScale = SizeConfig.blockSizeHorizontal;
    outMargin = widthScale * 4;
    insideMargin = widthScale * 6;

    return Container(
      width: SizeConfig.screenWidth,
      height: widget.index != null && widget.index == 0
          ? cellHeight + outMargin
          : cellHeight,
      decoration: BoxDecoration(
        // border: Border(bottom: BorderSide(width: 1.5, color: Colors.black)),
        color: Color(0xfff0f2f5),
      ),
      child: Align(
        alignment: Alignment.topLeft,
        child: Container(
          width: SizeConfig.screenWidth - outMargin * 2,
          height: cellHeight - outMargin,
          margin: widget.index != null && widget.index == 0
              ? EdgeInsets.only(top: outMargin, left: outMargin)
              : EdgeInsets.only(left: outMargin),
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(16),
            color: Colors.white,
          ),
          child: Column(
            children: [
              SizedBox(
                height: 15,
              ),
              // 第一行
              getTitle(),
              SizedBox(
                height: 12,
              ),
              getProject(),
              SizedBox(
                height: labelSpace,
              ),
              getProtect(),
              SizedBox(
                height: labelSpace,
              ),
              getStatus(),
              SizedBox(
                height: labelSpace,
              ),
              getCompany(),
              SizedBox(
                height: labelSpace,
              ),
              getName(),
              SizedBox(
                height: labelSpace,
              ),
              getNum(),
              SizedBox(
                height: 15,
              ),
              JMline(width: SizeConfig.screenWidth, height: 0.5),
              SizedBox(
                height: 6,
              ),
              getButtons(),
            ],
          ),
        ),
      ),
    );
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
              widget.data['employeeName'] ?? '无',
              style: jm_text_black_bold_style16,
            ),
            SizedBox(
              width: widthScale * 2,
            ),
            Text(
              widget.data['employeePhone'],
              style: jm_text_black_bold_style16,
            )
          ],
        ),
        Row(
          children: [
            Text(
              '已复制',
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
          widget.data['status'].toString(),
          style: jm_text_black_style15,
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

  // 底部按钮
  Widget getButtons() {
    return Container(
      width: SizeConfig.screenWidth - outMargin * 2,
      child: Column(
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              getTextButton('上传带看单', () {
                Navigator.of(context).push(CupertinoPageRoute(
                  builder: (context) {
                    return ReportUpload(data: widget.data);
                  },
                ));
              }),
              getTextButton('退单', () {
                CustomAlert(content: '确认要退单吗？').show();
              },
                  borderColor: Colors.red,
                  textStyle: TextStyle(color: Colors.red, fontSize: 13)),
              getTextButton('成交', () {}),
            ],
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              getTextButton('签约', () {
                CustomAlert(content: '确认要签约吗？').show();
              }),
            ],
          )
        ],
      ),
    );
  }

  // label
  Widget getLabel(String title) {
    return Container(
      width: widthScale * 22,
      child: Text(
        title,
        style: jm_text_gray_style15,
      ),
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
