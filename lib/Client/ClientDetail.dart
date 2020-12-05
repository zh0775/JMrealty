import 'package:JMrealty/Client/FollowTrack.dart';
import 'package:JMrealty/Client/components/WriteFollow.dart';
import 'package:JMrealty/Client/viewModel/ClientDetailViewModel.dart';
import 'package:JMrealty/base/base_viewmodel.dart';
import 'package:JMrealty/base/provider_widget.dart';
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
  String level;
  String sex;
  Color levelColor;

  @override
  void initState() {
    // clientDetailViewModel = ClientDetailViewModel();
    // clientDetailViewModel.loadClientDetail(widget.clientData['id']);
    lineHeight1 = 25;
    if (widget.clientData['sex'] != null) {
      sex = widget.clientData['sex'] == 0 ? '先生' : '女士';
    }
    if (widget.clientData['desireId'] != null) {
      switch (widget.clientData['desireId']) {
        case 3:
          level = 'A级';
          levelColor = Color.fromRGBO(233, 193, 112, 1);
          break;
        case 2:
          level = 'B级';
          levelColor = Color.fromRGBO(91, 93, 106, 1);
          break;
        case 1:
          level = 'C级';
          levelColor = Color.fromRGBO(40, 143, 255, 1);
          break;
      }
    }
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    // print('123===${widget.clientData}');
    SizeConfig().init(context);
    widthScale = SizeConfig.blockSizeHorizontal;
    margin = widthScale * 5;
    contentWidth = SizeConfig.screenWidth - margin * 2;
    return Scaffold(
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
    String clientStatus = '已跟进';
    String phone = '';
    if (customerVO['phone'] != null) {
      phone = customerVO['isSensitive'] == 1
          ? (customerVO['phone'] as String).replaceRange(3, 7, '****')
          : customerVO['phone'];
    }
    String clientYY = '';
    if (customerVO['type'] != null) {
      clientYY += customerVO['type'] + ' | ';
    }
    if (customerVO['area'] != null) {
      clientYY += customerVO['area'] + ' | ';
    }
    if (customerVO['floor'] != null) {
      clientYY += customerVO['floor'] + '楼' + ' | ';
    }

    if (clientYY != '') {
      clientYY =
          clientYY.replaceRange(clientYY.length - 2, clientYY.length, '');
    }

    switch (customerVO['status']) {
      case 1:
        clientStatus = '待跟进';
        break;
      case 2:
        clientStatus = '已带看';
        break;
      case 3:
        clientStatus = '已预约';
        break;
      case 4:
        clientStatus = '已成交';
        break;
      case 5:
        clientStatus = '水客';
        break;
      default:
    }

    return ListView(
      children: [
        Align(
          child: Container(
            height: 90,
            width: contentWidth,
            child: Stack(
              children: [
                Align(
                  alignment: Alignment.topLeft,
                  child: Padding(
                    padding: const EdgeInsets.only(top: 20),
                    child: Text(
                      customerVO['name'],
                      style: TextStyle(
                          fontSize: 22,
                          fontWeight: FontWeight.bold,
                          color: jm_text_black),
                    ),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.only(bottom: 13),
                  child: Align(
                    alignment: Alignment.bottomLeft,
                    child: Row(
                      children: [
                        // 级别
                        Container(
                          width: SizeConfig.blockSizeHorizontal * 10,
                          height: lineHeight1,
                          decoration: BoxDecoration(
                              color: levelColor,
                              borderRadius: BorderRadius.only(
                                topRight: Radius.circular((lineHeight1) / 2),
                                bottomLeft: Radius.circular((lineHeight1) / 2),
                                bottomRight: Radius.circular((lineHeight1) / 2),
                              )),
                          child: Center(
                            child: Text(
                              level,
                              style:
                                  TextStyle(color: Colors.white, fontSize: 13),
                            ),
                          ),
                        ),
                        SizedBox(width: SizeConfig.blockSizeHorizontal * 2),
                        // 性别
                        Container(
                          decoration: BoxDecoration(
                              color: Color.fromRGBO(243, 249, 255, 1),
                              borderRadius:
                                  BorderRadius.circular((lineHeight1) / 2)),
                          child: frameText(sex,
                              width: SizeConfig.blockSizeHorizontal * 12,
                              height: lineHeight1,
                              fontSize: 13,
                              textColor: Colors.black),
                        ),
                        SizedBox(width: SizeConfig.blockSizeHorizontal * 2),
                        // // 是否新房
                        // Container(
                        //   decoration: BoxDecoration(
                        //       color: Color.fromRGBO(243, 249, 255, 1),
                        //       borderRadius:
                        //           BorderRadius.circular((lineHeight1) / 2)),
                        //   child: frameText(widget.clientData['type'],
                        //       width: SizeConfig.blockSizeHorizontal * 12,
                        //       height: lineHeight1,
                        //       fontSize: 13,
                        //       textColor: Colors.black),
                        // ),
                      ],
                    ),
                  ),
                ),
                Align(
                  alignment: Alignment.centerRight,
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Icon(
                        Icons.check_circle_outline,
                        size: 40,
                        color: jm_appTheme,
                      ),
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
          ),
        ),
        // line
        Container(
          height: 0.5,
          width: SizeConfig.screenWidth,
          color: jm_line_color,
        ),
        Align(
          child: Container(
            height: 150,
            width: contentWidth,
            // color: jm_line_color,
            child: Align(
              alignment: Alignment.centerLeft,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisSize: MainAxisSize.min,
                children: [
                  Text(
                    '联系电话',
                    textAlign: TextAlign.start,
                    style: TextStyle(fontSize: 13, color: jm_text_gray),
                  ),
                  TextButton(
                      onPressed: () {},
                      child: Row(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          Text(
                            phone,
                            style:
                                TextStyle(fontSize: 17, color: jm_text_black),
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
                    height: 5,
                  ),
                  Text(
                    '客户要求',
                    textAlign: TextAlign.start,
                    style: TextStyle(fontSize: 13, color: jm_text_gray),
                  ),
                  SizedBox(
                    height: 5,
                  ),
                  Text(
                    clientYY,
                    textAlign: TextAlign.start,
                    maxLines: 2,
                    style: TextStyle(fontSize: 13, color: jm_text_black),
                  ),
                ],
              ),
            ),
          ),
        ),
        Container(
          width: SizeConfig.screenWidth,
          height: 6,
          color: Color(0xfff0f2f5),
        ),
        ...successInfo(),
        getCell(
            isFollow: true,
            count: clientData['progressSize'],
            followData: customerProgress),
        Container(
          width: SizeConfig.screenWidth,
          height: 6,
          color: Color(0xfff0f2f5),
        ),
        getCell(
            isFollow: false,
            count: clientData['progressSize'],
            followData: customerProgress),
        Container(
          width: SizeConfig.screenWidth,
          height: 6,
          color: Color(0xfff0f2f5),
        ),
        SizedBox(
          height: 40,
        )
      ],
      // ),
      // ProviderWidget<ClientDetailViewModel>(
      //   model: ClientDetailViewModel(),
      //   onReady: (model) {
      //     model.loadClientDetail(widget.clientData['id']);
      //   },
      //   builder: (context, model, child) {
      //     return
      //   },
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
    if (followData is List && followData.length > 0) {
      progress = followData[0];
    }
    if (isFollow) {
      titleText = '客户跟进' + '(' + count.toString() + ')';
    } else {
      titleText = '带看轨迹' + '(' + count.toString() + ')';
    }
    return Align(
      child: Container(
          width: contentWidth,
          height: 180,
          child: Align(
              alignment: Alignment.centerLeft,
              child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Row(
                          children: [
                            Icon(
                              Icons.satellite_outlined,
                              size: 20,
                            ),
                            SizedBox(
                              width: widthScale * 1,
                            ),
                            Text(
                              titleText,
                              style:
                                  TextStyle(fontSize: 20, color: jm_text_black),
                            ),
                          ],
                        ),
                        isFollow
                            ? writeButton(() {
                                WriteFollow(
                                    clientData: widget.clientData,
                                    addFollowConfirm: () {
                                      clientDetailViewModel.loadClientDetail(
                                          widget.clientData['id']);
                                    }).loadNextFollow();
                              })
                            : Container(
                                width: 0.0,
                                height: 0.0,
                              )
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
                        Text(
                          progress != null ? progress['result'] : '',
                          style: TextStyle(color: jm_text_black, fontSize: 14),
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
                        Text(progress != null ? progress['visitDate'] : '',
                            style: TextStyle(color: jm_text_gray, fontSize: 14))
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
                          Navigator.of(context)
                              .push(CupertinoPageRoute(builder: (_) {
                            return FollowTrack(
                                json: convert.jsonEncode(followData),
                                isFollow: true);
                          }));
                        },
                        child: Text(
                          '查看全部' + '(' + count.toString() + ')',
                          style: TextStyle(fontSize: 18, color: jm_text_black),
                        ),
                      ),
                    )
                  ]))),
    );
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

  List<Widget> successInfo() {
    return // 成交信息
        [
      Align(
          child: Container(
              width: contentWidth,
              height: 210,
              // color: jm_text_gray,
              child: Align(
                alignment: Alignment.centerLeft,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Row(
                      children: [
                        Icon(
                          Icons.thumb_up_alt,
                          size: 20,
                          color: jm_appTheme,
                        ),
                        SizedBox(
                          width: widthScale * 1,
                        ),
                        Text(
                          '成交信息',
                          style: TextStyle(fontSize: 18, color: jm_text_black),
                        )
                      ],
                    ),
                    SizedBox(
                      height: 5,
                    ),
                    Row(
                      children: [
                        frameText('成交渠道',
                            height: lineHeight1,
                            width: 75,
                            textColor: jm_text_gray,
                            fontSize: 14,
                            alignment: Alignment.centerLeft),
                        Text(
                          '金幕',
                          style: TextStyle(fontSize: 14, color: jm_text_black),
                        )
                      ],
                    ),
                    Row(
                      children: [
                        frameText('项目名称',
                            height: lineHeight1,
                            width: 75,
                            textColor: jm_text_gray,
                            fontSize: 14,
                            alignment: Alignment.centerLeft),
                        Text(
                          '龙光九龙湾',
                          style: TextStyle(fontSize: 14, color: jm_text_black),
                        )
                      ],
                    ),
                    Row(
                      children: [
                        frameText('房号',
                            height: lineHeight1,
                            width: 75,
                            textColor: jm_text_gray,
                            fontSize: 14,
                            alignment: Alignment.centerLeft),
                        Text(
                          '8-1-1801',
                          style: TextStyle(fontSize: 14, color: jm_text_black),
                        )
                      ],
                    ),
                    Row(
                      children: [
                        frameText('换签时间',
                            height: lineHeight1,
                            width: 75,
                            textColor: jm_text_gray,
                            fontSize: 14,
                            alignment: Alignment.centerLeft),
                        Text(
                          '2020-11-15',
                          style: TextStyle(fontSize: 14, color: jm_text_black),
                        )
                      ],
                    ),
                    Row(
                      children: [
                        frameText('认购时间',
                            height: lineHeight1,
                            width: 75,
                            textColor: jm_text_gray,
                            fontSize: 14,
                            alignment: Alignment.centerLeft),
                        Text(
                          '2020-11-18',
                          style: TextStyle(fontSize: 14, color: jm_text_black),
                        )
                      ],
                    ),
                    Row(
                      children: [
                        frameText('佣金',
                            height: lineHeight1,
                            width: 75,
                            textColor: jm_text_gray,
                            fontSize: 14,
                            alignment: Alignment.centerLeft),
                        Text(
                          '￥' + '20000',
                          style: TextStyle(fontSize: 14, color: jm_text_black),
                        )
                      ],
                    )
                  ],
                ),
              ))),
      Container(
        width: SizeConfig.screenWidth,
        height: 6,
        color: Color(0xfff0f2f5),
      )
    ];
  }
}
