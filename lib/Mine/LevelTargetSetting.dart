import 'package:JMrealty/Mine/viewModel/LevelTargetViewModel.dart';
import 'package:JMrealty/base/base_viewmodel.dart';
import 'package:JMrealty/base/provider_widget.dart';
import 'package:JMrealty/components/CustomAppBar.dart';
import 'package:JMrealty/components/ShowLoading.dart';
import 'package:JMrealty/const/Default.dart';
import 'package:JMrealty/utils/sizeConfig.dart';
import 'package:JMrealty/utils/toast.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class LevelTargetSetting extends StatefulWidget {
  final int deptId;
  const LevelTargetSetting({this.deptId});
  @override
  _LevelTargetSettingState createState() => _LevelTargetSettingState();
}

class _LevelTargetSettingState extends State<LevelTargetSetting> {
  LevelTargetViewModel levelTargetVM;
  double topHeight = 300;
  double widthScale;
  double margin;
  double selfWidth;

  Function(int deleteIndex) deleteItem = (int deleteIndex) {};

  List citys;
  int cityValue;
  List itemsData;
  bool isEdit;
  Map newItem;
  @override
  void initState() {
    levelTargetVM = LevelTargetViewModel();
    cityValue = 0;
    isEdit = true;
    newItem = {'count': '', 'month': '', 'price': ''};
    itemsData = [
      {'id': 0, 'title': 'A1', 'month': 1, 'count': 1, 'price': 10000},
      {'id': 1, 'title': 'A2', 'month': 3, 'count': 4, 'price': 30000},
    ];
    citys = <DropdownMenuItem<int>>[
      DropdownMenuItem(
        child: Text('南宁'),
        value: 0,
      ),
      DropdownMenuItem(
        child: Text('北京'),
        value: 1,
      ),
      DropdownMenuItem(
        child: Text('天津'),
        value: 2,
      ),
      DropdownMenuItem(
        child: Text('河北'),
        value: 3,
      )
    ];
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    print('newItem === $newItem');
    SizeConfig().init(context);
    widthScale = SizeConfig.blockSizeHorizontal;
    margin = widthScale * 6;
    selfWidth = SizeConfig.screenWidth - margin * 2;
    return Scaffold(
      appBar: CustomAppbar(
        title: '等级规则设置',
      ),
      body: ProviderWidget<LevelTargetViewModel>(
          model: levelTargetVM,
          onReady: (model) {
            levelTargetVM.loadTarget(widget.deptId);
          },
          builder: (ctx, value, child) {
            if (value.state == BaseState.CONTENT) {
              return GestureDetector(
                onTap: () {
                  FocusScope.of(context).requestFocus(FocusNode());
                },
                child: SingleChildScrollView(
                  child: Container(
                    width: SizeConfig.screenWidth,
                    child: Column(
                      children: [
                        SizedBox(
                          height: 20,
                        ),
                        DropdownButton<int>(
                          icon: Icon(
                            Icons.expand_more,
                            size: 20,
                          ),
                          items: citys,
                          value: cityValue,
                          onChanged: (value) {
                            setState(() {
                              cityValue = value;
                            });
                          },
                        ),
                        ...getTargetCell(),
                        SizedBox(
                          height: 50,
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            RawMaterialButton(
                                elevation: 1.0,
                                highlightElevation: 1.0,
                                constraints: BoxConstraints(
                                  minWidth: 70,
                                  minHeight: 35,
                                ),
                                shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(8)),
                                textStyle: TextStyle(
                                    fontSize: 15, color: Colors.white),
                                fillColor: jm_appTheme,
                                child: Text(isEdit ? '下一步' : '确认'),
                                onPressed: () {
                                  setState(() {
                                    isEdit = !isEdit;
                                  });
                                })
                          ],
                        )
                      ],
                    ),
                  ),
                ),
              );
            } else if (value.state == BaseState.LOADING) {
              return ShowLoading();
            } else {
              return Container(width: 0.0, height: 0.0);
            }
          }),
    );
  }

  List<Widget> getTargetCell() {
    List<Widget> cell = [];
    for (var i = 0; i < (itemsData.length + 1); i++) {
      Map data;
      if (i == itemsData.length) {
        newItem['id'] = i;
        // newItem['title'] = 'A' + (i + 1).toString();
        data = newItem;
      } else {
        data = itemsData[i];
      }
      cell.add(Column(
        children: [
          isEdit || i == itemsData.length
              ? Container(
                  width: 0.0,
                  height: 0.0,
                )
              : Row(
                  children: [
                    SizedBox(
                      width: widthScale * 2,
                    ),
                    IconButton(
                        padding: EdgeInsets.zero,
                        constraints: BoxConstraints(minHeight: 0, minWidth: 0),
                        icon: Icon(
                          Icons.cancel,
                          size: 25,
                          color: jm_placeholder_color,
                        ),
                        onPressed: () {
                          deleteTarget(data);
                        })
                  ],
                ),
          SizedBox(
            height: 10,
          ),
          Row(
            children: [
              SizedBox(
                width: widthScale * 2,
              ),
              Container(
                width: widthScale * 17,
                constraints:
                    BoxConstraints(minHeight: 30, minWidth: widthScale * 17),
                child: CupertinoTextField(
                  keyboardType: TextInputType.text,
                  textAlign: TextAlign.center,
                  placeholder: '级别名称',
                  placeholderStyle:
                      TextStyle(fontSize: 13, color: jm_placeholder_color),
                  style: jm_text_black_style14,
                  controller: TextEditingController(text: data['title'] ?? ''),
                  onChanged: (value) {
                    if (i == itemsData.length) {
                      data['title'] = value;
                    } else {
                      (itemsData[i])['title'] = value;
                    }
                  },
                ),
              ),
              SizedBox(
                width: widthScale * 2,
              ),
              Container(
                width: widthScale * 17,
                constraints:
                    BoxConstraints(minHeight: 30, minWidth: widthScale * 17),
                child: CupertinoTextField(
                  keyboardType: TextInputType.number,
                  textAlign: TextAlign.center,
                  placeholder: '入职时间',
                  placeholderStyle:
                      TextStyle(fontSize: 13, color: jm_placeholder_color),
                  style: jm_text_black_style14,
                  controller:
                      TextEditingController(text: (data['month']).toString()),
                  onChanged: (value) {
                    if (i == itemsData.length) {
                      data['month'] = int.parse(value);
                    } else {
                      (itemsData[i])['month'] = int.parse(value);
                    }
                  },
                ),
              ),
              SizedBox(
                width: widthScale * 2,
              ),
              Text(
                '月',
                style: jm_text_black_style14,
              ),
              SizedBox(
                width: widthScale * 2,
              ),
              Container(
                width: widthScale * 17,
                constraints:
                    BoxConstraints(minHeight: 30, minWidth: widthScale * 17),
                child: CupertinoTextField(
                  keyboardType: TextInputType.number,
                  textAlign: TextAlign.center,
                  placeholder: '目标套数',
                  placeholderStyle:
                      TextStyle(fontSize: 13, color: jm_placeholder_color),
                  style: jm_text_black_style14,
                  controller:
                      TextEditingController(text: (data['count']).toString()),
                  onChanged: (value) {
                    if (i == itemsData.length) {
                      data['count'] = int.parse(value);
                    } else {
                      (itemsData[i])['count'] = int.parse(value);
                    }
                  },
                ),
              ),
              SizedBox(
                width: widthScale * 2,
              ),
              Text(
                '数量',
                style: jm_text_black_style14,
              ),
              SizedBox(
                width: widthScale * 2,
              ),
              Container(
                width: widthScale * 18,
                constraints:
                    BoxConstraints(minHeight: 30, minWidth: widthScale * 18),
                child: CupertinoTextField(
                  keyboardType: TextInputType.number,
                  textAlign: TextAlign.center,
                  placeholder: '目标业绩',
                  placeholderStyle:
                      TextStyle(color: jm_placeholder_color, fontSize: 13),
                  style: jm_text_black_style14,
                  controller:
                      TextEditingController(text: (data['price']).toString()),
                  onChanged: (value) {
                    if (i == itemsData.length) {
                      data['price'] = int.parse(value);
                    } else {
                      (itemsData[i])['price'] = int.parse(value);
                    }
                  },
                ),
              ),
              SizedBox(
                width: widthScale * 2,
              ),
              Text(
                '元',
                style: jm_text_black_style14,
              ),
            ],
          ),
          SizedBox(
            height: 10,
          ),
          i == itemsData.length
              ? Padding(
                  padding: const EdgeInsets.only(top: 8.0),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.end,
                    children: [
                      SizedBox(
                        width: widthScale * 18,
                        height: 35,
                        child: RawMaterialButton(
                            fillColor: Colors.white,
                            elevation: 0,
                            highlightElevation: 0,
                            shape: RoundedRectangleBorder(
                              side: BorderSide(width: 1, color: jm_line_color),
                              borderRadius:
                                  BorderRadius.circular(widthScale * 2),
                            ),
                            textStyle: jm_text_black_style14,
                            child: Text('新增'),
                            onPressed: () {
                              FocusScope.of(context).requestFocus(FocusNode());
                              if (newItem['title'] == null ||
                                  newItem['title'].length == 0) {
                                ShowToast.normal('请输入级别名称');
                                return;
                              }

                              if (newItem['month'] == null ||
                                  (newItem['month']).toString().length == 0) {
                                ShowToast.normal('请输入入职时间');
                                return;
                              }
                              if (newItem['count'] == null ||
                                  (newItem['count']).toString().length == 0) {
                                ShowToast.normal('请输入目标套数');
                                return;
                              }
                              if (newItem['price'] == null ||
                                  (newItem['price']).toString().length == 0) {
                                ShowToast.normal('请输入目标业绩');
                                return;
                              }
                              levelTargetVM.addTargetSetting(
                                  Map<String, dynamic>.from({
                                    'organizationId': widget.deptId,
                                    'amount': newItem['price'],
                                    'entryDays': newItem['month'] * 30,
                                    'num': newItem['count'],
                                    'gradeName': newItem['title'],
                                  }), () {
                                levelTargetVM.loadTarget(widget.deptId);
                              });

                              // itemsData.add(newItem);
                              // newItem = {'count': '', 'month': '', 'price': ''};
                            }),
                      ),
                      SizedBox(width: margin)
                    ],
                  ),
                )
              : Container(
                  width: 0.0,
                  height: 0.0,
                ),
        ],
      ));
    }
    return cell;
  }

  void deleteTarget(Map item) {
    levelTargetVM.deleteTarget(item['id'], () {
      levelTargetVM.loadTarget(widget.deptId);
    });
    // setState(() {
    //   itemsData.remove(item);
    // });
  }
}
