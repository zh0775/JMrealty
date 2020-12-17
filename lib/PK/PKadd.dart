import 'package:JMrealty/Login/viewModel/LoginViewModel.dart';
import 'package:JMrealty/PK/viewModel/PKaddViewModel.dart';
import 'package:JMrealty/components/CustomAppBar.dart';
import 'package:JMrealty/components/CustomMarkInput.dart';
import 'package:JMrealty/components/CustomSubmitButton.dart';
import 'package:JMrealty/components/ShowDepNode.dart';
import 'package:JMrealty/components/TreeNode.dart';
import 'package:JMrealty/const/Default.dart';
import 'package:JMrealty/utils/sizeConfig.dart';
import 'package:JMrealty/utils/toast.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class PKadd extends StatefulWidget {
  @override
  _PKaddState createState() => _PKaddState();
}

class _PKaddState extends State<PKadd> {
  LoginViewModel depModel;
  PKaddViewModel pkaddModel;
  double widthScale;
  double margin;
  double selfWidth;
  double outMargin;
  double lineHeight;
  DateTime startTime;
  DateTime endTime;
  DateFormat dateFormat;
  List unitList; // pk指标
  Map pkTarget; // 参与单位
  String pkName; // pk赛名称
  String award; // 奖励
  String rules; // 规则
  Map medalData; //奖章
  List targetDataList;
  List<TreeNode> treeData;
  List pkType; // pk赛类型
  int pkTypeValue; // pk类型
  @override
  void initState() {
    treeData = [];
    pkaddModel = PKaddViewModel();
    pkaddModel.loadTarget(success: (value) {
      setState(() {
        targetDataList = value;
      });
    });
    depModel = LoginViewModel();
    depModel.loadRegistDeptSelectList(success: (value) {
      setState(() {
        treeData = value;
      });
    });
    pkaddModel.loadPkType(
      success: (data) {
        setState(() {
          pkType = data.map((e) {
            return Map<String, dynamic>.from(
                {'title': e['dictLabel'], 'value': e['dictValue']});
          }).toList();
        });
      },
    );
    unitList = [];
    dateFormat = DateFormat('yyyy-MM-dd');
    startTime = DateTime.now();
    endTime = startTime.add(Duration(days: 7));
    super.initState();
  }

  @override
  void dispose() {
    pkaddModel.dispose();
    depModel.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    SizeConfig().init(context);
    widthScale = SizeConfig.blockSizeHorizontal;
    margin = widthScale * 6;
    outMargin = widthScale * 4;
    selfWidth = SizeConfig.screenWidth - margin * 2;
    lineHeight = 50;
    return Scaffold(
      appBar: CustomAppbar(title: '新建PK赛'),
      body: GestureDetector(
        onTap: () {
          FocusScope.of(context).requestFocus(FocusNode());
        },
        child: SingleChildScrollView(
          child: Column(
            children: [
              Row(
                children: [
                  SizedBox(
                    width: margin,
                    height: 40,
                  ),
                  Text(
                    'PK赛信息',
                    style: jm_text_black_bold_style18,
                  ),
                ],
              ),
              JMline(width: SizeConfig.screenWidth, height: 0.5),
              CustomInput(
                title: 'PK赛名称',
                hintText: '请输入',
                text: pkName ?? '',
                valueChange: (value) {
                  pkName = value;
                },
              ),
              JMline(width: selfWidth, height: 0.5),
              getDateWidget(title: '开始时间', start: true),
              JMline(width: selfWidth, height: 0.5),
              getDateWidget(title: '结束时间', start: false),
              JMline(width: selfWidth, height: 0.5),
              SelectView(
                title: 'PK赛类型',
                dataList: pkType,
                margin: margin,
                selectValueChange: (value, data) {
                  pkTypeValue = value;
                },
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    children: [
                      SizedBox(
                        width: margin,
                        height: lineHeight,
                      ),
                      Text(
                        '参与单位',
                        style: jm_text_black_style15,
                      ),
                    ],
                  ),
                  Row(
                    children: [
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.end,
                        children: [
                          ...getUnitList(),
                          RawMaterialButton(
                              key: ValueKey('addUnit_button'),
                              constraints: BoxConstraints(
                                  maxHeight: lineHeight, maxWidth: 50),
                              child: Row(
                                children: [
                                  Icon(
                                    Icons.add,
                                    size: 15,
                                    color: jm_appTheme,
                                  ),
                                  Text(
                                    '添加',
                                    style: jm_text_apptheme_style13,
                                  )
                                ],
                              ),
                              onPressed: () {
                                ShowDepNode(
                                    size: Size(
                                      SizeConfig.blockSizeHorizontal * 80,
                                      SizeConfig.blockSizeVertical * 80,
                                    ),
                                    treeData: treeData,
                                    nodeSelected: (TreeNode node) {
                                      setState(() {
                                        unitList.add(node);
                                      });
                                    }).show();
                              }),
                        ],
                      ),
                      SizedBox(
                        width: margin,
                        height: lineHeight,
                      ),
                    ],
                  )
                ],
              ),
              JMline(width: selfWidth, height: 0.5),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    children: [
                      SizedBox(
                        width: margin,
                        height: lineHeight,
                      ),
                      Text(
                        'PK赛指标',
                        style: jm_text_black_style15,
                      ),
                    ],
                  ),
                  Row(
                    children: [
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.end,
                        children: [
                          ...getTargetList(),
                          RawMaterialButton(
                              key: ValueKey('addTarget_button'),
                              constraints: BoxConstraints(
                                  maxHeight: lineHeight, maxWidth: 50),
                              child: Row(
                                children: [
                                  Icon(
                                    Icons.add,
                                    size: 15,
                                    color: jm_appTheme,
                                  ),
                                  Text(
                                    '添加',
                                    style: jm_text_apptheme_style13,
                                  )
                                ],
                              ),
                              onPressed: () {
                                showTargetSelect((data) {
                                  setState(() {
                                    pkTarget = Map.from(data);
                                    rules = pkTarget['remark'];
                                  });
                                });
                              }),
                        ],
                      ),
                      SizedBox(
                        width: margin,
                        height: lineHeight,
                      ),
                    ],
                  )
                ],
              ),
              JMline(width: selfWidth, height: 0.5),
              SizedBox(
                height: 10,
              ),
              Row(
                children: [
                  SizedBox(
                    width: margin,
                    height: 30,
                  ),
                  Text(
                    'PK赛奖励',
                    style: jm_text_black_bold_style18,
                  ),
                ],
              ),
              CustomMarkInput(
                valueChange: (value) {
                  award = value;
                },
              ),
              CustomInput(
                key: ValueKey('CustomInput_project_1'),
                text: medalData != null ? (medalData['name'] ?? '') : '',
                labelStyle: jm_text_black_bold_style14,
                textStyle: jm_text_black_style15,
                title: '奖章',
                hintText: '请输入奖章名称',
                valueChangeAndShowList: (value, state) {
                  if (value != '') {
                    pkaddModel.loadMedal(
                      value,
                      success: (data) {
                        if (data != null && data.length > 0) {
                          state.showList(data);
                        }
                      },
                    );
                  } else {
                    state.removeList();
                  }
                },
                showListClick: (data) {
                  setState(() {
                    medalData = data;
                  });
                },
              ),
              JMline(width: selfWidth, height: 0.5),
              SizedBox(
                height: 10,
              ),
              Row(
                children: [
                  SizedBox(
                    width: margin,
                    height: 30,
                  ),
                  Text(
                    'PK赛规则',
                    style: jm_text_black_bold_style18,
                  ),
                ],
              ),
              CustomMarkInput(
                text: rules ?? '',
                valueChange: (value) {
                  rules = value;
                },
              ),
              // JMline(width: selfWidth, height: 0.5),
              SizedBox(
                height: 20,
              ),
              CustomSubmitButton(buttonClick: () {
                if (pkName == null || pkName.length == 0) {
                  ShowToast.normal('请输入PK赛名称');
                  return;
                }
                if (award == null || award.length == 0) {
                  ShowToast.normal('请输入奖励内容');
                  return;
                }
                if (medalData == null) {
                  ShowToast.normal('请选择奖章');
                  return;
                }
                if (pkTypeValue == null) {
                  ShowToast.normal('请选择PK赛类型');
                  return;
                }
                if (pkTarget == null) {
                  ShowToast.normal('请选择PK赛指标');
                  return;
                }
                // if (rules == null || rules.length == 0) {
                //   ShowToast.normal('请选择奖章');
                //   return;
                // }
                Map params = {};
                params['name'] = pkName;
                params['award'] = award;
                params['rule'] = rules;
                if (medalData != null) {
                  params['medalId'] = medalData['id'];
                }
                params['quotaType'] = pkTarget['dictValue'];
                params['raceType'] = pkTypeValue;
                params['raceRankBOList'] = unitList.map((e) {
                  return Map<String, dynamic>.from({
                    'bussinesId': (e as TreeNode).id,
                    'bussinesName': (e as TreeNode).label
                  });
                }).toList();
                params['startTime'] = dateFormat.format(startTime);
                params['endTime'] = dateFormat.format(endTime);
                params['status'] = 0;
                pkaddModel.adPkRequest(Map<String, dynamic>.from(params),
                    success: (success) {
                  if (success) {
                    ShowToast.normal('新增PK赛成功');
                    Future.delayed(Duration(seconds: 1), () {
                      Navigator.pop(context);
                    });
                  }
                });
                // List unitList; // pk指标
                // List pkTargetList; // 参与单位
                // String pkName; // pk赛名称
                // String award; // 奖励
                // String rules; // 规则
                // Map medalData; //奖章
                // List targetDataList;
                // List<TreeNode> treeData;
                // List pkType; // pk赛类型
                // int pkTypeValue; // pk类型
              }),
              SizedBox(
                height: 20,
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget getDateWidget({@required String title, bool start = true}) {
    double labelWidth = widthScale * 22;
    return GestureDetector(
      onTap: () {
        FocusScope.of(context).requestFocus(FocusNode());
        showDatePick(start);
      },
      child: Row(
        children: [
          SizedBox(
            width: margin,
            height: lineHeight,
          ),
          Container(
            width: labelWidth,
            child: Text(
              title,
              style: jm_text_black_style15,
            ),
          ),
          Container(
            width: selfWidth - labelWidth - widthScale * 8,
            child: Text(
              dateFormat.format(start ? startTime : endTime),
              style: jm_text_black_style15,
            ),
          ),
          Icon(
            Icons.keyboard_arrow_right,
            size: widthScale * 8,
          )
        ],
      ),
    );
  }

  Future<void> showDatePick(bool isStart) async {
    final DateTime date = await showDatePicker(
      context: context,
      initialDate: isStart ? startTime : endTime,
      firstDate: DateTime(2018, 1),
      lastDate: DateTime(2022, 1),
      locale: Locale('zh')
    );
    if (date == null) return;
    setState(() {
      isStart ? startTime = date : endTime = date;
    });
  }

  List<Widget> getUnitList() {
    double buttonHeight = lineHeight * 0.5;
    List<Widget> units = [];
    for (TreeNode node in unitList) {
      units.add(SizedBox(
        height: 6,
      ));
      units.add(RawMaterialButton(
        onPressed: () {
          deleteUnit(node);
        },
        materialTapTargetSize: MaterialTapTargetSize.shrinkWrap,
        constraints:
            BoxConstraints(minHeight: buttonHeight, minWidth: widthScale * 50),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(buttonHeight / 2),
          side: BorderSide(color: jm_line_color, width: 0.5),
        ),
        child: Container(
          width: widthScale * 49,
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Padding(
                padding: const EdgeInsets.only(left: 8.0),
                child: Text(
                  node.label ?? '',
                  style: jm_text_black_style13,
                ),
              ),
              Icon(
                Icons.cancel,
                size: buttonHeight * 0.9,
                color: jm_line_color,
              ),
            ],
          ),
        ),
      ));
    }
    return units;
  }

  List<Widget> getTargetList() {
    double buttonHeight = lineHeight * 0.5;
    List<Widget> targets = [];
    Map item = pkTarget;
    if (pkTarget == null) return targets;
    targets.add(SizedBox(
      height: 6,
    ));
    targets.add(RawMaterialButton(
      onPressed: () {
        deleteTarget(item);
      },
      materialTapTargetSize: MaterialTapTargetSize.shrinkWrap,
      constraints:
          BoxConstraints(minHeight: buttonHeight, minWidth: widthScale * 50),
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(buttonHeight / 2),
        side: BorderSide(color: jm_line_color, width: 0.5),
      ),
      child: Container(
        width: widthScale * 49,
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Padding(
              padding: const EdgeInsets.only(left: 8.0),
              child: Text(
                item['dictLabel'] ?? '',
                style: jm_text_black_style13,
              ),
            ),
            Icon(
              Icons.cancel,
              size: buttonHeight * 0.9,
              color: jm_line_color,
            ),
          ],
        ),
      ),
    ));
    return targets;
  }

  void showDepSelect() {}

  void deleteUnit(TreeNode node) {
    if (node != null) {
      setState(() {
        unitList.remove(node);
      });
    }
  }

  void deleteTarget(Map item) {
    if (item != null) {
      setState(() {
        pkTarget = null;
      });
    }
  }

  void showTargetSelect(Function(Map data) selectData) {
    int idx;

    double dialogWidth = SizeConfig.screenWidth * 0.8;
    double dialogHeight = SizeConfig.screenHeight * 0.8;
    double dialogMargin = dialogWidth / 100 * 6;
    showGeneralDialog(
        context: context,
        barrierDismissible: true,
        barrierLabel: '',
        transitionDuration: Duration(milliseconds: 200),
        barrierColor: Colors.black.withOpacity(.5),
        pageBuilder: (BuildContext context, Animation<double> animation,
            Animation<double> secondaryAnimation) {
          return Material(
            color: Colors.transparent,
            child: Align(
                child: Container(
              width: dialogWidth,
              height: dialogHeight,
              color: Colors.white,
              child: Stack(
                children: [
                  Positioned(
                      top: 0,
                      right: 0,
                      left: 0,
                      height: dialogHeight - SizeConfig.screenWidth * 0.2,
                      child: ListView.builder(
                          padding: EdgeInsets.only(top: 20),
                          itemCount: targetDataList.length,
                          itemBuilder: (BuildContext context, int index) {
                            return GestureDetector(
                              onTap: () {
                                if (selectData != null) {
                                  selectData(targetDataList[index]);
                                }
                                Navigator.pop(context);
                                // setState(() {
                                //   cuttentData = targetDataList[index];
                                //   idx = index;
                                // });
                              },
                              child: Align(
                                child: Container(
                                  constraints: BoxConstraints(
                                    minHeight: 60,
                                  ),
                                  width: dialogWidth - dialogMargin * 2,
                                  child: Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      Text(
                                        (targetDataList[index])['dictLabel'] ??
                                            '',
                                        style: index == idx
                                            ? jm_text_apptheme_style17
                                            : jm_text_black_style17,
                                      ),
                                      Text(
                                        (targetDataList[index])['remark'] ?? '',
                                        style: index == idx
                                            ? jm_text_apptheme_style13
                                            : jm_text_gray_style13,
                                      ),
                                      Container(
                                          width: dialogWidth - dialogMargin * 2,
                                          child: Text(
                                              (targetDataList[index])[
                                                      'remark'] ??
                                                  '',
                                              maxLines: 100,
                                              style: index == idx
                                                  ? jm_text_apptheme_style13
                                                  : jm_text_gray_style13)),
                                      SizedBox(
                                        height: 20,
                                      )
                                    ],
                                  ),
                                ),
                              ),
                            );
                          })),
                  Positioned(
                      bottom: 0,
                      height: SizeConfig.screenWidth * 0.2,
                      left: 0,
                      right: 0,
                      child: Center(
                        child: RawMaterialButton(
                          elevation: 1,
                          highlightElevation: 1,
                          constraints:
                              BoxConstraints(minWidth: 90, minHeight: 40),
                          textStyle:
                              TextStyle(fontSize: 15, color: Colors.white),
                          fillColor: Color(0xff404351),
                          child: Text('确定'),
                          onPressed: () {
                            Navigator.pop(context);
                          },
                        ),
                      ))
                ],
              ),
            )),
          );
        });
  }
}
