import 'package:JMrealty/Project/viewModel/ProjectDistrictViewModel.dart';
import 'package:JMrealty/components/NoneV.dart';
import 'package:JMrealty/const/Default.dart';
import 'package:JMrealty/utils/EventBus.dart';
import 'package:JMrealty/utils/notify_default.dart';
import 'package:JMrealty/utils/sizeConfig.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';

class ProjectDistrictSelectV extends StatefulWidget {
  final double barHeight;
  final Function(Map projectParams) getProjectFilter;
  const ProjectDistrictSelectV({this.barHeight = 50, this.getProjectFilter});
  @override
  _ProjectDistrictSelectVState createState() => _ProjectDistrictSelectVState();
}

class _ProjectDistrictSelectVState extends State<ProjectDistrictSelectV> {
  ProjectDistrictViewModel projectDistrictVM = ProjectDistrictViewModel();
  EventBus _bus = EventBus();
  bool expansion = false;
  double widthScale;
  double cellHeight = 40;
  int cellCount = 9;
  int cityId;
  double colunmMargin = 5;
  double margin;
  List level1Data = [];
  List level2Data = [];
  List level3Data = [];

  int level1Index = 0;
  int level2Index = 0;
  int level3Index = 0;

  bool isCity = false;
  @override
  void initState() {
    _bus.on(NOTIFY_LOGIN_SUCCESS, (arg) {
      level1Index = 0;
      level2Index = 0;
      level3Index = 0;
      level1Data = [];
      level2Data = [];
      level3Data = [];
      loadLevel1Data();
    });
    loadLevel1Data();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    SizeConfig().init(context);
    widthScale = SizeConfig.blockSizeHorizontal;
    margin = widthScale * 5;
    return GestureDetector(
      onTap: () {
        if (level1Data == null || level1Data.length == 0) {
          loadLevel1Data();
        }
        setState(() {
          expansion = !expansion;
        });
      },
      child: Container(
        alignment: Alignment.topLeft,
        color: Colors.black12,
        height: expansion
            ? (SizeConfig.screenHeight -
                kTextTabBarHeight -
                kToolbarHeight -
                20)
            : widget.barHeight,
        child: Column(
          children: [
            UnconstrainedBox(
              child: Container(
                height: widget.barHeight - 1,
                width: SizeConfig.screenWidth,
                decoration: BoxDecoration(
                  color: Colors.white,
                  // border:
                  //     Border(bottom: BorderSide(width: 0, color: jm_line_color)
                  // ),
                ),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Row(
                      children: [
                        SizedBox(
                          width: margin,
                        ),
                        Text(
                          '区域',
                          style: jm_text_gray_style13,
                        ),
                        SizedBox(
                          width: widthScale * 4,
                        ),
                        Text(
                          getTitleLabelText() ?? '',
                          style: jm_text_black_style14,
                        ),
                      ],
                    ),
                    Row(
                      children: [
                        Icon(
                          Icons.arrow_drop_down,
                          size: widthScale * 6.5,
                          color: jm_text_gray,
                        ),
                        SizedBox(
                          width: margin,
                        ),
                      ],
                    )
                  ],
                ),
              ),
            ),
            expansion
                ? Container(
                    margin: EdgeInsets.only(top: 0.5),
                    width: SizeConfig.screenWidth,
                    height: cellHeight * cellCount + colunmMargin * 2,
                    color: Colors.white,
                    child: Row(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        SizedBox(
                          width: SizeConfig.screenWidth / 4 - 1,
                          child: SingleChildScrollView(
                            child: Column(
                              children: [
                                SizedBox(
                                  height: colunmMargin,
                                ),
                                ...regionCell(1, SizeConfig.screenWidth / 4 - 1,
                                    tapRegionCell),
                                SizedBox(
                                  height: colunmMargin,
                                ),
                              ],
                            ),
                          ),
                        ),
                        JMline(
                            width: 1,
                            height: cellHeight * cellCount + colunmMargin * 2),
                        SizedBox(
                          width: SizeConfig.screenWidth / 4 - 1,
                          child: SingleChildScrollView(
                            child: Column(
                              children: [
                                SizedBox(
                                  height: colunmMargin,
                                ),
                                ...regionCell(2, SizeConfig.screenWidth / 4 - 1,
                                    tapRegionCell),
                                SizedBox(
                                  height: colunmMargin,
                                ),
                              ],
                            ),
                          ),
                        ),
                        JMline(
                            width: 1,
                            height: cellHeight * cellCount + colunmMargin * 2),
                        SizedBox(
                          width: SizeConfig.screenWidth / 2,
                          child: SingleChildScrollView(
                            child: Column(
                              children: [
                                SizedBox(
                                  height: colunmMargin,
                                ),
                                ...regionCell(3, SizeConfig.screenWidth / 2,
                                    tapRegionCell),
                                SizedBox(
                                  height: colunmMargin,
                                ),
                              ],
                            ),
                          ),
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

  void tapRegionCell(int level, int index, Map data) {
    setState(() {
      switch (level) {
        case 1:
          level1Index = index;
          break;
        case 2:
          level2Index = index;
          break;
        case 3:
          level3Index = index;
          break;
        default:
      }
    });
    if (level == 2) {
      level3Index = 0;
    }
    if (level == 2 && level2Index != 0 && !isCity) {
      loadLevel2Data(data['areaId'], 3);
    }
  }

  List<Widget> regionCell(
      int level, double width, Function(int level, int index, Map data) onTap) {
    List<Widget> list = [];
    List dataList;
    int currentIndex;
    TextStyle style;
    TextStyle selectedStyle;
    switch (level) {
      case 1:
        style = jm_text_black_style17;
        selectedStyle = jm_text_apptheme_style17;
        dataList = level1Data;
        currentIndex = level1Index;
        break;
      case 2:
        style = jm_text_black_style15;
        selectedStyle = jm_text_apptheme_style15;
        dataList = level2Data;
        currentIndex = level2Index;
        break;
      case 3:
        style = jm_text_black_style14;
        selectedStyle = jm_text_apptheme_style14;
        dataList = level3Data;
        currentIndex = level3Index;
        break;
      default:
    }
    if (dataList != null && dataList.length > 0) {
      for (var i = 0; i < dataList.length; i++) {
        Map e = dataList[i];
        list.add(GestureDetector(
          behavior: HitTestBehavior.opaque,
          onTap: () {
            if (onTap != null) {
              onTap(level, i, e);
            }
            if ((isCity ? level == 2 : level == 3) || e['areaId'] == -1) {
              expansion = false;
              projectFilterCallBack();
            }
          },
          child: UnconstrainedBox(
            child: Container(
              alignment: level == 3 ? Alignment.centerLeft : Alignment.center,
              width: width,
              height: cellHeight,
              child: Padding(
                padding: EdgeInsets.only(left: level == 3 ? widthScale * 7 : 0),
                child: Text(
                  e['areaName'] ?? '',
                  style: currentIndex == i ? selectedStyle : style,
                ),
              ),
            ),
          ),
        ));
      }
    }

    return list;
  }

  projectFilterCallBack() {
    if (widget.getProjectFilter != null) {
      Map<String, dynamic> params = {};
      if (isCity) {
        params['cityId'] = (level1Data[level1Index])['areaId'];
      } else {
        params['provinceId'] = (level1Data[level1Index])['areaId'];
      }

      if (level2Data != null && level2Data.length > 0 && level2Index != 0) {
        if (isCity) {
          params['regionId'] = (level2Data[level2Index])['areaId'];
        } else {
          params['cityId'] = (level2Data[level2Index])['areaId'];
        }
      }
      if (level3Data != null && level3Data.length > 0 && level3Index != 0) {
        if (!isCity) {
          params['regionId'] = (level3Data[level3Index])['areaId'];
        }
      }
      widget.getProjectFilter(params);
    }
  }

  loadLevel1Data() {
    projectDistrictVM.loadDepLevel1List((dataList, success) {
      if (success) {
        level1Data = [];
        setState(() {
          bool city = false;
          dataList.forEach((element) {
            if (element['isCity'] == 1) {
              // city = true;
              // if (level1Data.length == 0) {
              //   level1Data.add(element);
              // }
              cityId = element['areaId'];
            }
          });
          isCity = city;
          if (!isCity) {
            dataList.forEach((element) {
              if (element['isCity'] == 0 && element['isProvince'] == 1) {
                if (level1Data.length == 0) {
                  level1Data.add(element);
                }
              }
            });
          }
        });
        if (level1Data != null && level1Data.length > 0) {
          Map area = level1Data[0];
          loadLevel2Data(area['areaId'] ?? -1, 2);
        }
      }
    });
  }

  loadLevel2Data(int parentId, int index) {
    projectDistrictVM.loadDepLevel2List({'areaParentId': parentId},
        (dataList, success) {
      if (success) {
        setState(() {
          if (index == 2) {
            level2Data = [
              {'areaId': -1, 'areaName': '不限'}
            ];
            level2Data.addAll(dataList);
            if (cityId != null) {
              loadLevel2Data(cityId, 3);
              for (var i = 0; i < level2Data.length; i++) {
                Map item = level2Data[i];
                if (item['areaId'] == cityId) {
                  level2Index = i;
                  cityId = null;
                  break;
                }
              }
              projectFilterCallBack();
            }
          } else if (index == 3) {
            level3Data = [
              {'areaId': -1, 'areaName': '不限'}
            ];
            level3Data.addAll(dataList);
          }
        });
      }
    });
  }

  String getTitleLabelText() {
    String title = '';
    if (level1Data != null && level1Data.length > 0) {
      title += (level1Data[level1Index])['areaName'] ?? '';
    }
    if (level2Data != null && level2Data.length > 0 && level2Index != 0) {
      title += (level2Data[level2Index])['areaName'] ?? '';
    }
    if (level3Data != null && level3Data.length > 0 && level3Index != 0) {
      title += (level3Data[level3Index])['areaName'] ?? '';
    }
    return title;
  }
}
