import 'package:JMrealty/const/Default.dart';
import 'package:JMrealty/utils/sizeConfig.dart';
import 'package:flutter/material.dart';

class ClientDetail extends StatefulWidget {
  final Map clientData;
  ClientDetail({@required this.clientData});
  @override
  _ClientDetailState createState() => _ClientDetailState();
}

class _ClientDetailState extends State<ClientDetail> {
  double margin;
  double widthScale;
  double contentWidth;
  double lineHeight1;
  String level;
  String sex;
  Color levelColor;

  @override
  void initState() {
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
    print('123===${widget.clientData}');
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
      body: ListView(
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
                        widget.clientData['name'],
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
                                  bottomLeft:
                                      Radius.circular((lineHeight1) / 2),
                                  bottomRight:
                                      Radius.circular((lineHeight1) / 2),
                                )),
                            child: Center(
                              child: Text(
                                level,
                                style: TextStyle(
                                    color: Colors.white, fontSize: 13),
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
                          // 是否新房
                          Container(
                            decoration: BoxDecoration(
                                color: Color.fromRGBO(243, 249, 255, 1),
                                borderRadius:
                                    BorderRadius.circular((lineHeight1) / 2)),
                            child: frameText(widget.clientData['type'],
                                width: SizeConfig.blockSizeHorizontal * 12,
                                height: lineHeight1,
                                fontSize: 13,
                                textColor: Colors.black),
                          ),
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
                          '已成交',
                          style: TextStyle(fontSize: 10, color: jm_text_black),
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
                              widget.clientData['phone'],
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
                      (widget.clientData['type'] ?? '') +
                          '  |  ' +
                          (widget.clientData['area'] ?? ''),
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
          // 成交信息
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
                              style:
                                  TextStyle(fontSize: 18, color: jm_text_black),
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
                              style:
                                  TextStyle(fontSize: 14, color: jm_text_black),
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
                              style:
                                  TextStyle(fontSize: 14, color: jm_text_black),
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
                              style:
                                  TextStyle(fontSize: 14, color: jm_text_black),
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
                              style:
                                  TextStyle(fontSize: 14, color: jm_text_black),
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
                              style:
                                  TextStyle(fontSize: 14, color: jm_text_black),
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
                              style:
                                  TextStyle(fontSize: 14, color: jm_text_black),
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
          ),
          getCell(),
          Container(
            width: SizeConfig.screenWidth,
            height: 6,
            color: Color(0xfff0f2f5),
          ),
          getCell(),
          Container(
            width: SizeConfig.screenWidth,
            height: 6,
            color: Color(0xfff0f2f5),
          ),
          SizedBox(
            height: 40,
          )
        ],
      ),
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

  Widget getCell() {
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
                              '客户跟进(8)',
                              style:
                                  TextStyle(fontSize: 20, color: jm_text_black),
                            ),
                          ],
                        ),
                        writeButton(() {})
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
                          '客户已带看',
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
                        Text('2020.10.31 11:31 经纪人 金小慕',
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
                        onPressed: () {},
                        child: Text(
                          '查看全部(8)',
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
}
