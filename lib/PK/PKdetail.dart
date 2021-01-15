import 'package:JMrealty/components/CustomAppBar.dart';
import 'package:JMrealty/const/Default.dart';
import 'package:JMrealty/utils/sizeConfig.dart';
import 'package:flutter/material.dart';

class PKdetail extends StatefulWidget {
  final Map pkData;
  const PKdetail({@required this.pkData});
  @override
  _PKdetailState createState() => _PKdetailState();
}

class _PKdetailState extends State<PKdetail> {
  double widthScale;
  double margin;
  double selfWidth;
  double outMargin;
  // PKviewModel pkVM;

  @override
  void initState() {
    // pkVM = PKviewModel();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    SizeConfig().init(context);
    widthScale = SizeConfig.blockSizeHorizontal;
    margin = widthScale * 6;
    outMargin = widthScale * 4;
    selfWidth = SizeConfig.screenWidth - margin * 2;
    return Scaffold(
      backgroundColor: jm_appTheme,
      appBar: CustomAppbar(
        title: 'PK赛详情',
      ),
      body: SingleChildScrollView(
        child: Align(
          child: Container(
            margin: EdgeInsets.only(top: margin),
            constraints: BoxConstraints(
              maxWidth: selfWidth,
              minWidth: selfWidth,
              // minHeight: SizeConfig.screenHeight * 50,
            ),
            decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(widthScale * 4),
                color: Colors.white),
            child: Column(
              children: [
                SizedBox(
                  height: 13,
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: [
                    Container(
                      width: widthScale * 16,
                      height: 28,
                      child: Stack(
                        overflow: Overflow.visible,
                        children: [
                          Positioned(
                              right: 0,
                              top: 0,
                              width: widthScale * 17,
                              height: 25,
                              child: Image.asset(
                                'assets/images/icon/icon_pk_status_bg.png',
                                fit: BoxFit.fill,
                              )),
                          Positioned(
                            right: 0,
                            top: -1,
                            width: widthScale * 17,
                            height: 25,
                            child: Center(
                              child: Text(
                                jm_getPKStatus(widget.pkData['status'] ?? 0),
                                style: jm_text_black_bold_style11,
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                    SizedBox(
                      width: outMargin,
                    ),
                  ],
                ),
                SizedBox(
                  height: 7,
                ),
                Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Row(
                      children: [
                        SizedBox(
                          width: outMargin,
                        ),
                        Container(
                          width: widthScale * 33,
                          // constraints:
                          //     BoxConstraints(minWidth: widthScale * 33),
                          child: Text(
                            widget.pkData['name'] ?? '',
                            // '搜已佛寺度佛isU盾佛isU盾噢ifUS噢ID富哦is杜甫爱神的箭拉会计师的徕卡技术的',
                            maxLines: 100,
                            style: jm_text_black_bold_style16,
                          ),
                        ),
                      ],
                    ),
                    Row(
                      children: [
                        Text(
                          '时间：' +
                              (widget.pkData['startTime'] ?? '') +
                              ' 至 ' +
                              (widget.pkData['endTime'] ?? ''),
                          style: jm_text_gray_style11,
                        ),
                        SizedBox(
                          width: outMargin,
                        ),
                      ],
                    )
                  ],
                ),
                SizedBox(
                  height: 10,
                ),
                JMline(width: selfWidth, height: 0.5),
                SizedBox(
                  height: 10,
                ),
                Row(
                  children: [
                    SizedBox(
                      height: 10,
                    ),
                    SizedBox(
                      width: outMargin,
                    ),
                    Text(
                      'PK赛奖励',
                      style: jm_text_gray_style14,
                    ),
                    SizedBox(
                      width: widthScale * 7,
                    ),
                    Container(
                        width: widthScale * 55,
                        child: Text(
                          widget.pkData['award'] ?? '',
                          style: jm_text_black_style14,
                        )),
                  ],
                ),
                SizedBox(
                  height: 10,
                ),
                Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    SizedBox(
                      width: outMargin,
                    ),
                    Text(
                      'PK赛规则',
                      style: jm_text_gray_style14,
                    ),
                    SizedBox(
                      width: widthScale * 7,
                    ),
                    Container(
                        width: widthScale * 55,
                        child: Text(
                          widget.pkData['rule'] ?? '',
                          style: jm_text_black_style14,
                          maxLines: 100,
                        )),
                  ],
                ),
                SizedBox(
                  height: 10,
                ),
                JMline(width: selfWidth, height: 0.5),
                ...getCell(),
                SizedBox(
                  height: 10,
                )
              ],
            ),
          ),
        ),
      ),
    );
  }

  List<Widget> getCell() {
    List<Widget> cells = [];
    for (var i = 0; i < (widget.pkData['raceRankList']).length ?? 0; i++) {
      Map<String, dynamic> data = (widget.pkData['raceRankList'])[i];
      cells.add(Row(
        children: [
          SizedBox(
            width: outMargin,
            // height: 40,
          ),
          // Text(
          //   '排名: ' + (data['sort'] != null ? (data['sort']).toString() : ''),
          //   style: jm_text_black_style15,
          // ),
          // Icon(
          //   Icons.emoji_events,
          //   size: 15,
          //   color: jm_appTheme,
          // ),
          i < 3
              ? Image.asset(
                  'assets/images/icon/icon_pk_rank${(i + 1).toString()}.png',
                  width: widthScale * 5.5,
                )
              : SizedBox(
                  width: widthScale * 5.5,
                ),
          SizedBox(width: widthScale * 4),
          Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              SizedBox(
                height: 5,
              ),
              Container(
                width:
                    widthScale * (100 - 5.5 - 4) - outMargin * 2 - margin * 2,
                child: Text(
                  (data['bussinesName'] != null
                      ? (data['bussinesName']).toString()
                      : ''),
                  style: jm_text_black_style14,
                  maxLines: 100,
                ),
              ),
              Container(
                width:
                    widthScale * (100 - 5.5 - 4) - outMargin * 2 - margin * 2,
                child: Text(
                  '${data["number"] != null && data["number"] != 0 ? (data["number"]).toString() + "套  " : ""}${(data["commission"] != null ? data["commission"].toString() + "元  " : "")}${data["saleRate"] != null ? "成交率" + (data["saleRate"] * 100).toString() + "%" : ""}',
                  style: jm_text_gray_style12,
                ),
              ),
              SizedBox(
                height: 5,
              ),
            ],
          ),
          // JMline(margin: widthScale * 3 ,width: selfWidth - widthScale * 6, height: 0.5)
        ],
      ));
      cells.add(JMline(
          margin: outMargin, width: selfWidth - outMargin * 2, height: 0.5));
    }
    // cells.add(Container(
    //   height: 40,
    //   child: Row(
    //     mainAxisAlignment: MainAxisAlignment.center,
    //     children: [
    //       Text('查看详情'),
    //       Icon(Icons.chevron_right,size: 23,color: jm_line_color,)
    //     ],
    //   ),
    // ));
    return cells;
  }
}
