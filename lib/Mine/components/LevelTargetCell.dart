import 'package:JMrealty/components/CustomTextF.dart';
import 'package:JMrealty/components/NoneV.dart';
import 'package:JMrealty/const/Default.dart';
import 'package:JMrealty/utils/sizeConfig.dart';
import 'package:JMrealty/utils/toast.dart';
import 'package:flutter/material.dart';

class LevelTargetCell extends StatefulWidget {
  final Map data;
  final int index;
  final bool isEmpty;
  final Function(Map item) deleteItemClick;
  final Function(Map item) addItemClick;
  const LevelTargetCell(
      {this.data,
      this.index,
      this.isEmpty = false,
      this.deleteItemClick,
      this.addItemClick});
  @override
  _LevelTargetCellState createState() => _LevelTargetCellState();
}

class _LevelTargetCellState extends State<LevelTargetCell> {
  Map data = {};
  double selfWidth;
  double widthScale;
  double margin;
  @override
  void initState() {
    // data = widget.data ?? {};
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    SizeConfig().init(context);
    widthScale = SizeConfig.blockSizeHorizontal;
    margin = widthScale * 5;
    selfWidth = SizeConfig.screenWidth - margin * 2;

    return UnconstrainedBox(
      child: Container(
        // margin: EdgeInsets.only(top: 15),
        padding: EdgeInsets.symmetric(vertical: 10),
        width: selfWidth,
        child: Column(
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                CustomTextF(
                  width: widthScale * 50,
                  height: 25,
                  leftTextPadding: 0,
                  style: jm_text_black_style16,
                  text: widget.isEmpty
                      ? (data['gradeName'] ?? '')
                      : (widget.data['gradeName'] ?? ''),
                  enable: widget.isEmpty,
                  placeholder: '请输入规则名称',
                  valueChange: (value) {
                    data['gradeName'] = value;
                  },
                ),
                widget.isEmpty
                    ? NoneV()
                    : IconButton(
                        padding: EdgeInsets.zero,
                        constraints: BoxConstraints(minHeight: 0, minWidth: 0),
                        icon: Icon(
                          Icons.cancel,
                          size: widthScale * 5,
                          color: jm_placeholder_color,
                        ),
                        onPressed: () {
                          if (widget.deleteItemClick != null) {
                            widget.deleteItemClick(widget.data);
                          }
                        })
              ],
            ),
            SizedBox(
              height: 5,
            ),
            Row(
              children: [
                Container(
                  padding: EdgeInsets.all(widthScale * 3),
                  decoration: BoxDecoration(
                      border: Border.all(width: 2, color: jm_line_color),
                      borderRadius: BorderRadius.only(
                          bottomLeft: Radius.circular(widthScale * 2),
                          topLeft: Radius.circular(widthScale * 2))),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        '入职时长(*月内)',
                        style: jm_text_gray_style10,
                      ),
                      SizedBox(
                        height: 5,
                      ),
                      CustomTextF(
                        keyboardType: TextInputType.number,
                        placeholder: widget.isEmpty ? '请输入' : '',
                        width: widthScale * 18,
                        text: widget.isEmpty
                            ? (data['entryDays']?.toString() ?? '')
                            : (widget.data['entryDays'] != null
                                ? (widget.data['entryDays'] / 30)
                                    .round()
                                    .toString()
                                : ''),
                        enable: widget.isEmpty,
                        height: 40,
                        backgroundColor: jm_line_color,
                        valueChange: (value) {
                          data['entryDays'] = value;
                        },
                      )
                    ],
                  ),
                ),
                Container(
                  padding: EdgeInsets.all(widthScale * 3),
                  decoration: BoxDecoration(
                      border: Border.symmetric(
                          horizontal:
                              BorderSide(width: 2, color: jm_line_color))),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        '目标套数',
                        style: jm_text_gray_style10,
                      ),
                      SizedBox(
                        height: 5,
                      ),
                      CustomTextF(
                        keyboardType: TextInputType.number,
                        placeholder: widget.isEmpty ? '请输入' : '',
                        width: widthScale * 17,
                        height: 40,
                        text: widget.isEmpty
                            ? (data['num']?.toString() ?? '')
                            : (widget.data['num'] != null
                                ? widget.data['num'].toString()
                                : ''),
                        enable: widget.isEmpty,
                        backgroundColor: jm_line_color,
                        valueChange: (value) {
                          data['num'] = value;
                        },
                      )
                    ],
                  ),
                ),
                Container(
                  padding: EdgeInsets.all(widthScale * 3),
                  decoration: BoxDecoration(
                      border: Border.all(width: 2, color: jm_line_color),
                      borderRadius: BorderRadius.only(
                          bottomRight: Radius.circular(widthScale * 2),
                          topRight: Radius.circular(widthScale * 2))),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        '目标业绩(元)',
                        style: jm_text_gray_style10,
                      ),
                      SizedBox(
                        height: 5,
                      ),
                      CustomTextF(
                        keyboardType: TextInputType.number,
                        placeholder: widget.isEmpty ? '请输入' : '',
                        width: selfWidth - widthScale * (3 * 6 + 17 + 18) - 15,
                        height: 40,
                        text: widget.isEmpty
                            ? (data['amount']?.toString() ?? '')
                            : (widget.data['amount'] != null
                                ? widget.data['amount'].toString()
                                : ''),
                        enable: widget.isEmpty,
                        backgroundColor: jm_line_color,
                        valueChange: (value) {
                          data['amount'] = value;
                        },
                      ),
                    ],
                  ),
                ),
              ],
            ),
            widget.isEmpty
                ? SizedBox(
                    width: selfWidth,
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.end,
                      children: [
                        RawMaterialButton(
                          onPressed: () {
                            FocusScope.of(context).requestFocus(FocusNode());
                            if (data['gradeName'] == null ||
                                (data['gradeName'] as String).length == 0 ||
                                data['entryDays'] == null ||
                                data['entryDays'].toString().length == 0 ||
                                data['num'] == null ||
                                data['num'].toString().length == 0 ||
                                data['amount'] == null ||
                                data['amount'].toString().length == 0) {
                              ShowToast.normal('请输入完整信息后添加');
                              return;
                            }
                            if (data['entryDays'] is int) {
                              data['entryDays'] = data['entryDays'] * 30;
                            } else if (data['entryDays'] is String) {
                              data['entryDays'] =
                                  int.parse(data['entryDays']) * 30;
                            }

                            data['num'] = data['num'] is int
                                ? data['num']
                                : int.parse(data['num']);
                            data['amount'] = data['amount'] is int
                                ? data['amount']
                                : int.parse(data['amount']);
                            // data['amount'] = int.parse(data['amount']);
                            if (widget.addItemClick != null) {
                              widget.addItemClick(data);
                            }
                          },
                          shape: RoundedRectangleBorder(
                              borderRadius:
                                  BorderRadius.circular(widthScale * 1.5)),
                          constraints: BoxConstraints(
                              minHeight: 35, minWidth: widthScale * 18),
                          fillColor: jm_appTheme,
                          elevation: 0.0,
                          highlightElevation: 0.5,
                          child: Text('增加',
                              style: TextStyle(
                                color: Colors.white,
                                fontSize: 15,
                              )),
                        ),
                      ],
                    ),
                  )
                : NoneV()
          ],
        ),
      ),
    );
  }
}
