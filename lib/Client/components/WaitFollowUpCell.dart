import 'package:JMrealty/Client/components/LevelIcon.dart';
import 'package:JMrealty/Client/viewModel/ClientListViewModel.dart';
import 'package:JMrealty/components/NoneV.dart';
import 'package:JMrealty/const/Default.dart';
import 'package:JMrealty/utils/sizeConfig.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

typedef void SelectedForRowAtIndex(
    ClientStatus status, int index, Map model, BuildContext context);
typedef void WriteFollowClick(
    ClientStatus status, int index, Map model, BuildContext context);
typedef void CellReportClick(
    ClientStatus status, int index, Map model, BuildContext context);
typedef void CellClientOpenClick(
    ClientStatus status, int index, Map model, BuildContext context);

typedef void TakeOrderClick(Map model);

class WaitFollowUpCell extends StatefulWidget {
  final Map model;
  final int index;
  final ClientStatus status;
  final SelectedForRowAtIndex selectedForRowAtIndex;
  final WriteFollowClick writeFollowClick;
  final CellReportClick cellReportClick;
  final TakeOrderClick takeOrderClick;
  final CellClientOpenClick cellClientOpenClick;
  final bool pool;
  WaitFollowUpCell(
      {this.model,
      this.selectedForRowAtIndex,
      this.index,
      this.status,
      this.writeFollowClick,
      this.cellReportClick,
      this.takeOrderClick,
      this.cellClientOpenClick,
      this.pool = false});
  @override
  _WaitFollowUpCellState createState() => _WaitFollowUpCellState();
}

class _WaitFollowUpCellState extends State<WaitFollowUpCell> {
  double lineHeight = 33;
  double lineSpace = 4;
  double cellHeight;
  double cellWidth;
  double widthScale;
  String name = '';
  String sex = '';
  String houseType = '';
  String roomCount = '';
  String houseSize = '';
  String housePrice = '';
  String newFollowTime = '';
  String clientIntention = '';
  String clientPhoneNum = '';
  Map model;
  @override
  void initState() {
    // cellHeight = 200;
    if (widget.pool) {
      // cellHeight = 140;
    }
    super.initState();
  }

  @override
  void didUpdateWidget(covariant WaitFollowUpCell oldWidget) {
    super.didUpdateWidget(oldWidget);
  }

  @override
  Widget build(BuildContext context) {
    SizeConfig().init(context);
    model = widget.model;
    cellWidth = SizeConfig.screenWidth;
    widthScale = SizeConfig.blockSizeHorizontal;

    if (model['name'] != null) {
      name = model['name'];
    }
    if (model['sex'] != null) {
      sex = model['sex'] == 0 ? '男士' : '女士';
    }
    if (model['type'] != null) {
      houseType = model['type'];
    }
    // if (model.roomCount != null) {
    //   roomCount = model.roomCount;
    // }
    if (model['area'] != null) {
      houseSize = model['area'];
    }
    if (model['paymentsBudget'] != null) {
      housePrice = model['paymentsBudget'];
    }
    if (model['visitDate'] != null) {
      newFollowTime = '最新跟进  ' + model['visitDate'];
    }
    if (model['result'] != null) {
      clientIntention = model['result'];
    }
    // if (model.clientPhoneNum != null) {
    //   clientPhoneNum = model.clientPhoneNum;
    // }

    return GestureDetector(
      onTap: () {
        if (widget.selectedForRowAtIndex != null) {
          widget.selectedForRowAtIndex(
              widget.status, widget.index, widget.model, context);
        }
      },
      child: Container(
        width: cellWidth,
        // height: cellHeight,
        decoration: BoxDecoration(
            border: Border(
          bottom: BorderSide(color: jm_line_color, width: 0.5),
        )),
        child: Column(
          children: [
            Container(
              // height: lineHeight,
              width: cellWidth,
              margin: EdgeInsets.only(
                  left: SizeConfig.blockSizeHorizontal * 4, top: 10),
              child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Row(
                      children: [
                        // 客户级别
                        LevelIcon(desireId: model['desireId'] ?? 0),
                        SizedBox(width: SizeConfig.blockSizeHorizontal * 4),
                        // 客户姓名
                        ConstrainedBox(
                          constraints: BoxConstraints(
                            minWidth: 0,
                            maxWidth: widthScale * 36,
                          ),
                          child: Text(
                            name,
                            maxLines: 1,
                            overflow: TextOverflow.ellipsis,
                            softWrap: true,
                            style: jm_text_black_bold_style17,
                          ),
                        ),
                        // frameText(name,
                        //     width: 20,
                        //     maxWidth: SizeConfig.blockSizeHorizontal * 20,
                        //     height: lineHeight - 10,
                        //     fontSize: 16,
                        //     textColor: Colors.black),
                        SizedBox(width: SizeConfig.blockSizeHorizontal * 2),
                        // 客户性别
                        Container(
                          // width: SizeConfig.blockSizeHorizontal * 12,
                          // height: lineHeight - 10,
                          decoration: BoxDecoration(
                              color: Color.fromRGBO(243, 249, 255, 1),
                              borderRadius:
                                  BorderRadius.circular((lineHeight - 10) / 2)),
                          child: Center(
                            child: Padding(
                              padding: EdgeInsets.symmetric(
                                  horizontal: widthScale * 2, vertical: 3),
                              child: Text(
                                sex ?? '',
                                style: jm_text_black_style12,
                              ),
                            ),
                          ),
                        ),
                        SizedBox(
                            width: SizeConfig.blockSizeHorizontal * 2), // 房子类型
                        Container(
                          // width: SizeConfig.blockSizeHorizontal * 12,
                          // height: lineHeight - 10,
                          decoration: BoxDecoration(
                              color: Color.fromRGBO(243, 249, 255, 1),
                              borderRadius:
                                  BorderRadius.circular((lineHeight - 10) / 2)),
                          child: Padding(
                            padding: EdgeInsets.symmetric(
                                horizontal: widthScale * 2, vertical: 3),
                            child: Center(
                              child: Text(
                                houseType ?? '',
                                style: jm_text_black_style12,
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
                    Row(
                      children: [
                        ...callPhoneView(),
                      ],
                    )
                  ]),
            ),
            SizedBox(
              height: lineSpace,
            ),
            Container(
              // height: lineHeight - 5,
              width: cellWidth,
              child: Row(
                children: [
                  SizedBox(
                    width: SizeConfig.blockSizeHorizontal * 16,
                  ),
                  // 房间数量
                  Container(
                    width: SizeConfig.blockSizeHorizontal * (100 - 16.5 - 4),
                    // height: 40,
                    // color: Colors.red,
                    child: Text(
                      '${model['area'] ?? '-'} | ${model['paymentsBudget'] ?? '-'} | ${model['source'] ?? '-'}',
                      style: jm_text_black_style13,
                    ),
                  ),
                ],
              ),
            ),
            SizedBox(
              height: lineSpace,
            ),
            ...followInfoWidget(),
            Container(
              margin: EdgeInsets.only(top: 3),
              // height: lineHeight - 5,
              width: cellWidth,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.end,
                children: [...buttons()],
              ),
            ),
            SizedBox(
              height: 3,
            )
          ],
        ),
      ),
    );
  }

  List<Widget> callPhoneView() {
    if (!widget.pool) {
      return [
        // SizedBox(
        //   width: SizeConfig.blockSizeHorizontal * 10,
        // ),
        // 联系电话
        GestureDetector(
          onTap: () {
            callPhone(widget.model['phone']);
          },
          child: Row(
            children: [
              frameText('联系客户',
                  width: SizeConfig.blockSizeHorizontal * 16.5,
                  height: lineHeight - 10,
                  fontSize: 15,
                  textColor: Colors.black),
              SizedBox(
                width: SizeConfig.blockSizeHorizontal * 1,
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
          width: SizeConfig.blockSizeHorizontal * 2,
        )
      ];
    } else {
      return [NoneV()];
    }
  }

  List<Widget> buttons() {
    if (widget.pool) {
      return [
        Container(
            width: SizeConfig.blockSizeHorizontal * 25,
            // height: lineHeight - 5,
            margin: EdgeInsets.only(bottom: 3),
            child: RawMaterialButton(
              highlightElevation: 0,
              elevation: 0,
              fillColor: Colors.white,
              shape: RoundedRectangleBorder(
                side: BorderSide(
                    width: 0.5, color: Color.fromRGBO(87, 93, 116, 1)),
                borderRadius: BorderRadius.circular(6),
              ),
              onPressed: () {
                if (widget.takeOrderClick != null) {
                  widget.takeOrderClick(widget.model);
                }
              },
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Icon(
                    Icons.create,
                    size: 15,
                    color: Color.fromRGBO(87, 93, 116, 1),
                  ),
                  SizedBox(
                    width: 6,
                  ),
                  Text(
                    '我来跟进',
                    style: TextStyle(
                        fontSize: 14, color: Color.fromRGBO(87, 93, 116, 1)),
                  )
                ],
              ),
            )),
        SizedBox(
          width: SizeConfig.blockSizeHorizontal * 4,
        ),
      ];
    } else if (widget.status != ClientStatus.deal &&
        widget.status != ClientStatus.water) {
      Color whiteButtonTextColor = Color.fromRGBO(87, 93, 116, 1);
      return [
        RawMaterialButton(
          onPressed: () {
            if (widget.cellClientOpenClick != null) {
              widget.cellClientOpenClick(
                  widget.status, widget.index, widget.model, context);
            }
          },
          constraints: BoxConstraints(
            minHeight: lineHeight - 8,
            minWidth: SizeConfig.blockSizeHorizontal * 16,
          ),
          shape: RoundedRectangleBorder(
            side: BorderSide(width: 0.5, color: whiteButtonTextColor),
            borderRadius: BorderRadius.circular(6),
          ),
          child: Row(
            children: [
              Icon(
                Icons.lock_open,
                size: widthScale * 4.5,
                color: whiteButtonTextColor,
              ),
              SizedBox(
                width: widthScale,
              ),
              Text(
                '公开',
                style: TextStyle(fontSize: 14, color: whiteButtonTextColor),
              )
            ],
          ),
        ),
        SizedBox(
          width: SizeConfig.blockSizeHorizontal * 3,
        ),
        Container(
            width: SizeConfig.blockSizeHorizontal * 18,
            height: lineHeight - 8,
            child: RawMaterialButton(
              highlightElevation: 0,
              elevation: 0,
              fillColor: Colors.white,
              shape: RoundedRectangleBorder(
                side: BorderSide(width: 0.5, color: whiteButtonTextColor),
                borderRadius: BorderRadius.circular(6),
              ),
              onPressed: () {
                if (widget.writeFollowClick != null) {
                  widget.writeFollowClick(
                      widget.status, widget.index, widget.model, context);
                }
              },
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Icon(
                    Icons.create,
                    size: 15,
                    color: whiteButtonTextColor,
                  ),
                  SizedBox(
                    width: 3,
                  ),
                  Text(
                    '写跟进',
                    style: TextStyle(fontSize: 14, color: whiteButtonTextColor),
                  )
                ],
              ),
            )),
        SizedBox(
          width: SizeConfig.blockSizeHorizontal * 3,
        ),
        Container(
            width: SizeConfig.blockSizeHorizontal * 15,
            height: lineHeight - 8,
            child: RawMaterialButton(
              highlightElevation: 0,
              elevation: 0,
              fillColor: Color.fromRGBO(230, 184, 92, 1),
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(6),
              ),
              onPressed: () {
                if (widget.cellReportClick != null) {
                  widget.cellReportClick(
                      widget.status, widget.index, widget.model, context);
                }
              },
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Icon(
                    Icons.assignment,
                    size: 15,
                    color: Colors.white,
                  ),
                  SizedBox(
                    width: 5,
                  ),
                  Text(
                    '报备',
                    style: TextStyle(fontSize: 14, color: Colors.white),
                  )
                ],
              ),
            )),
        SizedBox(
          width: SizeConfig.blockSizeHorizontal * 4,
        )
      ];
    } else {
      return [NoneV()];
    }
  }

  List<Widget> followInfoWidget() {
    if (widget.pool) {
      return [NoneV()];
    } else {
      return [
        Container(
          // height: lineHeight - 15,
          width: cellWidth,
          // margin: EdgeInsets.only(bottom: 8),
          child: Row(
            children: [
              SizedBox(
                width: SizeConfig.blockSizeHorizontal * 16,
              ),
              // 最新跟进进展信息
              Text(newFollowTime, style: jm_text_gray_style14)
            ],
          ),
        ),
        SizedBox(
          height: lineSpace,
        ),
        Row(
          children: [
            SizedBox(
              width: SizeConfig.blockSizeHorizontal * 16,
            ),
            SizedBox(
              width:
                  SizeConfig.screenWidth - SizeConfig.blockSizeHorizontal * 19,
              child: Text(
                clientIntention,
                style: jm_text_gray_style14,
              ),
            ),
          ],
        ),
        widget.model['expect'] != null && widget.model['expect'].length > 0
            ? SizedBox(
                height: lineSpace + 3,
              )
            : NoneV(),
        widget.model['expect'] != null && widget.model['expect'].length > 0
            ? Row(
                children: [
                  // 客户意向
                  Container(
                    margin: EdgeInsets.only(
                        left: SizeConfig.blockSizeHorizontal * 16),
                    // padding:
                    //     EdgeInsets.only(left: SizeConfig.blockSizeHorizontal * 3),
                    // height: lineHeight,
                    width: SizeConfig.blockSizeHorizontal * 80,
                    decoration: BoxDecoration(
                        color: Color.fromRGBO(247, 248, 251, 1),
                        borderRadius: BorderRadius.circular(5)),
                    child: Padding(
                      padding: EdgeInsets.fromLTRB(
                          widthScale * 1.9, 6, widthScale * 3, 6),
                      child: Text('下次跟进时间  ${widget.model['expect'] ?? ''}',
                          style: jm_text_black_style13),
                    ),
                  )
                ],
              )
            : NoneV(),
      ];
    }
  }

  Widget frameText(text,
      {@required double height,
      @required double width,
      double maxWidth,
      @required Color textColor,
      @required double fontSize}) {
    double selfMaxWidth = maxWidth ?? width;
    return UnconstrainedBox(
      child: Container(
        // width: width,
        // height: height,
        alignment: Alignment.centerLeft,
        constraints: BoxConstraints(minWidth: width, maxWidth: selfMaxWidth),
        child: Text(
          text,
          maxLines: null,
          style: TextStyle(color: textColor, fontSize: fontSize),
        ),
      ),
    );
  }
}
