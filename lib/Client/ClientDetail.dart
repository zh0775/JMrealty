import 'package:JMrealty/Client/FollowTrack.dart';
import 'package:JMrealty/Client/components/ClientSuccessWidget.dart';
import 'package:JMrealty/Client/components/LevelIcon.dart';
import 'package:JMrealty/Client/viewModel/ClientDetailViewModel.dart';
import 'package:JMrealty/base/base_viewmodel.dart';
import 'package:JMrealty/base/provider_widget.dart';
import 'package:JMrealty/components/NoneV.dart';
import 'package:JMrealty/components/ShowLoading.dart';
import 'package:JMrealty/const/Default.dart';
import 'package:JMrealty/utils/sizeConfig.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'dart:convert' as convert;

class ClientDetail extends StatefulWidget {
  final Map clientData;
  ClientDetail({@required this.clientData});
  @override
  _ClientDetailState createState() => _ClientDetailState();
}

class _ClientDetailState extends State<ClientDetail> {
  ClientDetailViewModel clientDetailViewModel;
  double margin;
  double widthScale;
  double contentWidth;
  double lineHeight1;
  String sex;

  @override
  void initState() {
    // clientDetailViewModel = ClientDetailViewModel();
    // clientDetailViewModel.loadClientDetail(widget.clientData['id']);
    lineHeight1 = 25;
    if (widget.clientData['sex'] != null) {
      sex = widget.clientData['sex'] == 0 ? '先生' : '女士';
    }
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    SizeConfig().init(context);
    widthScale = SizeConfig.blockSizeHorizontal;
    margin = widthScale * 5;
    contentWidth = SizeConfig.screenWidth - margin * 2;
    return Scaffold(
        backgroundColor: jm_line_color,
        appBar: AppBar(
          centerTitle: true,
          backgroundColor: jm_appTheme,
          automaticallyImplyLeading: false,
          leading: IconButton(
            icon: Icon(
              Icons.navigate_before,
              size: 40,
              color: Colors.white,
            ),
            onPressed: () {
              Navigator.pop(context);
            },
          ),
          title: Text(
            '客户详情',
            style: TextStyle(color: Colors.white, fontSize: 18),
          ),
        ),
        body: ProviderWidget<ClientDetailViewModel>(
          model: ClientDetailViewModel(),
          onReady: (model) {
            clientDetailViewModel = model;
            model.loadClientDetail(widget.clientData['id']);
          },
          builder: (context, value, child) {
            if (value.state == BaseState.LOADING) {
              return ShowLoading();
            } else if (value.state == BaseState.CONTENT) {
              return getBody(value.clientData);
            } else {
              return Center(
                child: Text(
                  '暂无数据',
                  style: TextStyle(fontSize: 18, color: jm_text_gray),
                ),
              );
            }
          },
        ));
  }

  Widget getBody(Map clientData) {
    Map customerVO = clientData['customerVO'];
    List customerProgress = clientData['customerProgress'];

    return SingleChildScrollView(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          getTop(customerVO),
          JMline(width: SizeConfig.screenWidth, height: 0.5),
          getClientInfo(customerVO, clientData),
          JMline(width: SizeConfig.screenWidth, height: 15),
          // 成交信息
          clientData['reportShopDetailVOS'] != null &&
                  (clientData['reportShopDetailVOS'] is List) &&
                  (clientData['reportShopDetailVOS'] as List).length > 0
              ? successInfo(clientData['reportShopDetailVOS'])
              : NoneV(),
          clientData['progressSize'] != null && clientData['progressSize'] > 0
              ? getCell(
                  isFollow: true,
                  count: clientData['progressSize'],
                  followData: customerProgress)
              : NoneV(),
          Container(
            width: SizeConfig.screenWidth,
            height: 0.5,
            color: Color(0xfff0f2f5),
          ),
          clientData['custmoerReportSize'] != null &&
                  clientData['custmoerReportSize'] > 0
              ? getCell(
                  isFollow: false,
                  count: clientData['custmoerReportSize'],
                  followData: clientData['custmoerReportInfoVOS'] != null &&
                          (clientData['custmoerReportInfoVOS'] is List)
                      ? clientData['custmoerReportInfoVOS']
                      : [])
              : NoneV(),
          SizedBox(
            height: 40,
          )
        ],
      ),
    );
  }

  String yyFormat(dynamic str) {
    String yyData = '';
    if (str == null) {
      return '-';
    }
    if (!(str is String)) {
      yyData = str.toString();
    } else {
      yyData = str;
    }
    if (yyData.length > 0) {
      return yyData;
    }
    return '-';
  }

  getTop(Map customerVO) {
    String clientStatus = '待跟进';
    switch (customerVO['status']) {
      case 0:
        clientStatus = '待跟进';
        break;
      case 10:
        clientStatus = '已带看';
        break;
      case 20:
        clientStatus = '已预约';
        break;
      case 30:
        clientStatus = '已成交';
        break;
      case 40:
        clientStatus = '公开';
        break;
      default:
    }

    return Container(
      color: Colors.white,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Padding(
            padding: EdgeInsets.only(left: margin),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                SizedBox(
                  height: 20,
                ),
                Container(
                    width: contentWidth - widthScale * 20,
                    child: Text(
                      customerVO['name'],
                      style: jm_text_black_bold_style22,
                      maxLines: 100,
                    )),
                SizedBox(
                  height: 5,
                ),
                Row(
                  children: [
                    LevelIcon(desireId: widget.clientData['desireId'] ?? 0),
                    SizedBox(width: SizeConfig.blockSizeHorizontal * 2),
                    // 性别
                    Container(
                        height: lineHeight1,
                        decoration: BoxDecoration(
                            color: Color.fromRGBO(243, 249, 255, 1),
                            borderRadius:
                                BorderRadius.circular((lineHeight1) / 2)),
                        child: Center(
                          child: Padding(
                            padding: EdgeInsets.symmetric(
                                horizontal: widthScale * 3),
                            child: Text(
                              sex,
                              style: jm_text_black_style13,
                            ),
                          ),
                        )),
                  ],
                ),
                SizedBox(
                  height: 20,
                )
              ],
            ),
          ),
          Padding(
            padding: EdgeInsets.only(right: margin),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              // mainAxisSize: MainAxisSize.min,
              children: [
                Image.asset('assets/images/icon/icon_client_status.png'),
                SizedBox(
                  height: 2,
                ),
                Text(
                  clientStatus,
                  style: TextStyle(fontSize: 12, color: jm_text_black),
                )
              ],
            ),
          )
        ],
      ),
    );
  }

  getClientInfo(Map customerVO, Map clientData) {
    String phone = '';
    if (customerVO['phone'] != null) {
      phone = customerVO['isSensitive'] == 1 &&
              (customerVO['phone'] as String).length > 7
          ? (customerVO['phone'] as String).replaceRange(3, 7, '****')
          : customerVO['phone'];
    }
    return Container(
        color: Colors.white,
        width: SizeConfig.screenWidth,
        child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
          SizedBox(
            height: 20,
          ),
          Padding(
            padding: EdgeInsets.only(left: margin),
            child: Text(
              '联系电话',
              textAlign: TextAlign.start,
              style: TextStyle(fontSize: 13, color: jm_text_gray),
            ),
          ),
          SizedBox(
            height: 5,
          ),
          RawMaterialButton(
              splashColor: Colors.transparent,
              // highlightColor: Colors.transparent,
              padding: EdgeInsets.only(left: margin),
              materialTapTargetSize: MaterialTapTargetSize.shrinkWrap,
              constraints: BoxConstraints(minHeight: 0),
              onPressed: () {
                callPhone(phone);
              },
              child: Row(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Text(
                    phone,
                    style: TextStyle(fontSize: 17, color: jm_text_black),
                  ),
                  SizedBox(
                    width: widthScale * 2,
                  ),
                  Image.asset(
                    'assets/images/icon_client_phone.png',
                    height: SizeConfig.blockSizeHorizontal * 5,
                    width: SizeConfig.blockSizeHorizontal * 5,
                  )
                ],
              )),
          SizedBox(
            height: 20,
          ),
          Padding(
            padding: EdgeInsets.only(left: margin),
            child: Text(
              '客户要求',
              textAlign: TextAlign.start,
              style: TextStyle(fontSize: 13, color: jm_text_gray),
            ),
          ),
          SizedBox(
            height: 5,
          ),
          Padding(
            padding: EdgeInsets.only(left: margin),
            child: Text(
              '${yyFormat(customerVO['area'])} | ${yyFormat(customerVO['paymentsBudget'])} | ${yyFormat(customerVO['source'])} | ${yyFormat(clientData['project'])} | ${yyFormat(customerVO['type'])}',
              textAlign: TextAlign.start,
              maxLines: 2,
              style: TextStyle(fontSize: 13, color: jm_text_black),
            ),
          ),
          SizedBox(
            height: 15,
          ),
          getClientInfoLine('客户职业', customerVO['occupation'] ?? '-'),
          getClientInfoLine('几次置业', customerVO['shopTimes'] ?? '-'),
          getClientInfoLine('意向楼层', customerVO['floor'] ?? '-'),
          getClientInfoLine('决策人', customerVO['policymaker'] ?? '-'),
          getClientInfoLine('看房时间', customerVO['seeTime'] ?? '-'),
          getClientInfoLine('特殊要求', customerVO['remarks'] ?? '-',
              bottomText: true),
          SizedBox(
            height: 20,
          ),
        ]));
  }

  Widget getClientInfoLine(String title, dynamic value,
      {bool bottomText = false}) {
    String val = value is String ? value : value.toString();

    List<Widget> list = [
      SizedBox(
        width: widthScale * 22,
        height: 28,
        child: Align(
          alignment: Alignment.centerLeft,
          child: Text(
            title,
            style: jm_text_gray_style13,
          ),
        ),
      ),
      SizedBox(
        height: 6,
      ),
      Text(
        val,
        style: jm_text_black_style13,
        maxLines: 100,
      )
    ];

    return bottomText
        ? Padding(
            padding: EdgeInsets.only(left: margin),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [...list],
            ),
          )
        : Row(
            children: [
              SizedBox(
                width: margin,
              ),
              ...list
            ],
          );
  }

  Widget frameText(text,
      {@required double height,
      @required double width,
      @required Color textColor,
      @required double fontSize,
      Alignment alignment = Alignment.center}) {
    return Container(
      width: width,
      height: height,
      child: Align(
        alignment: alignment,
        child: Text(
          text,
          style: TextStyle(color: textColor, fontSize: fontSize),
        ),
      ),
    );
  }

  Widget getCell({bool isFollow, int count, List followData}) {
    String titleText;
    Map progress;
    if ((followData is List) && followData.length > 0) {
      progress = followData[0];
    }
    if (isFollow) {
      titleText = '客户跟进' + '(' + count.toString() + ')';
    } else {
      titleText = '带看轨迹' + '(' + count.toString() + ')';
    }
    return Container(
        padding: EdgeInsets.only(left: margin, bottom: 15),
        color: Colors.white,
        width: SizeConfig.screenWidth,
        // height: 180,
        child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisSize: MainAxisSize.min,
            children: [
              SizedBox(
                height: 10,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Row(
                    children: [
                      Image.asset('assets/images/icon/' +
                          (isFollow
                              ? 'icon_clientdetail_follow.png'
                              : 'icon_clientdetail_take.png')),
                      SizedBox(
                        width: widthScale * 1,
                      ),
                      Text(
                        titleText,
                        style: TextStyle(fontSize: 20, color: jm_text_black),
                      ),
                    ],
                  ),
                  // 写跟进
                  // isFollow
                  //     ? writeButton(() {
                  //         WriteFollow(
                  //             clientData: widget.clientData,
                  //             addFollowConfirm: () {
                  //               clientDetailViewModel.loadClientDetail(
                  //                   widget.clientData['id']);
                  //             }).loadNextFollow();
                  //       })
                  //     : Container(
                  //         width: 0.0,
                  //         height: 0.0,
                  //       )
                ],
              ),
              SizedBox(
                height: 15,
              ),
              Row(
                children: [
                  Container(
                    width: 10,
                    height: 10,
                    decoration: BoxDecoration(
                        color: jm_appTheme,
                        borderRadius: BorderRadius.circular(5)),
                  ),
                  SizedBox(
                    width: widthScale * 3,
                  ),
                  progress != null
                      ? (isFollow
                          ? Container(
                              width:
                                  contentWidth - 10 - widthScale * 3 - margin,
                              child: Text(
                                progress['result'] ?? '',
                                maxLines: 100,
                                style: TextStyle(
                                    color: jm_text_black, fontSize: 14),
                              ),
                            )
                          : Container(
                              width:
                                  contentWidth - 10 - widthScale * 3 - margin,
                              child: Text(
                                progress['projectName'] ?? '',
                                style: TextStyle(
                                    color: jm_text_black, fontSize: 14),
                              ),
                            ))
                      : Container(
                          width: 0.0,
                          height: 0.0,
                        )
                ],
              ),
              SizedBox(
                height: 3,
              ),
              Row(
                children: [
                  SizedBox(
                    width: widthScale * 3 + 10,
                  ),
                  progress != null
                      ? (Text(
                          isFollow
                              ? '${(progress['visitDate'] ?? '')}  ${progress['userName'] ?? ''} ${progress['postName'] ?? ''}'
                              : '${(progress['createTime'] ?? '')}  ${progress['employeeName'] ?? ''}  ${progress['employeePosition'] ?? ''}',
                          style: TextStyle(color: jm_text_gray, fontSize: 14)))
                      : NoneV()
                ],
              ),
              SizedBox(
                height: 15,
              ),
              Container(
                width: contentWidth,
                height: 40,
                decoration: BoxDecoration(
                    color: Color(0xfffaf1df),
                    borderRadius: BorderRadius.circular(8)),
                child: TextButton(
                  onPressed: () {
                    push(FollowTrack(data: followData, isFollow: isFollow),
                        context);
                  },
                  child: Text(
                    '查看全部' + '(' + count.toString() + ')',
                    style: TextStyle(fontSize: 18, color: jm_text_black),
                  ),
                ),
              ),
              SizedBox(
                height: 10,
              )
            ]));
  }

  Widget writeButton(void Function() buttonClick) {
    return Container(
        width: SizeConfig.blockSizeHorizontal * 20,
        height: 30,
        child: RawMaterialButton(
          highlightElevation: 0,
          elevation: 0,
          fillColor: Colors.white,
          shape: RoundedRectangleBorder(
            side: BorderSide(width: 0.5, color: Color.fromRGBO(87, 93, 116, 1)),
            borderRadius: BorderRadius.circular(6),
          ),
          onPressed: () {
            buttonClick();
            // if (widget.writeFollowClick != null) {
            //   widget.writeFollowClick(
            //       widget.status, widget.index, widget.model, context);
            // }
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
                '写跟进',
                style: TextStyle(
                    fontSize: 14, color: Color.fromRGBO(87, 93, 116, 1)),
              )
            ],
          ),
        ));
  }

  Widget successInfo(List successList) {
    List<Widget> successWidgetList = [];
    for (var i = 0; i < successList.length; i++) {
      Map successData = successList[i];
      successWidgetList.add(ClientSuccessWidget(
        successData: successData,
        margin: margin,
      ));
    }
    return Container(
      padding: EdgeInsets.only(top: 20),
      margin: EdgeInsets.only(bottom: 15),
      width: SizeConfig.screenWidth,
      color: Colors.white,
      child: Column(
        children: [...successWidgetList],
      ),
    );
  }
}
