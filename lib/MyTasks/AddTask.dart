import 'package:JMrealty/MyTasks/viewModel/MyTasksViewModel.dart';
import 'package:JMrealty/Report/viewmodel/ReportViewModel.dart';
import 'package:JMrealty/components/CustomAlert.dart';
import 'package:JMrealty/components/CustomAppBar.dart';
import 'package:JMrealty/components/CustomLoading.dart';
import 'package:JMrealty/components/CustomMarkInput.dart';
import 'package:JMrealty/components/CustomSubmitButton.dart';
import 'package:JMrealty/components/CustomTextF.dart';
import 'package:JMrealty/components/CustomWebV.dart';
import 'package:JMrealty/components/DropdownSelectV.dart';
import 'package:JMrealty/const/Default.dart';
import 'package:JMrealty/services/Urls.dart';
import 'package:JMrealty/utils/EventBus.dart';
import 'package:JMrealty/utils/notify_default.dart';
import 'package:JMrealty/utils/sizeConfig.dart';
import 'package:JMrealty/utils/toast.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class AddTask extends StatefulWidget {
  @override
  _AddTaskState createState() => _AddTaskState();
}

class _AddTaskState extends State<AddTask> {
  EventBus _bus = EventBus();
  MyTasksViewModel tasksVM = MyTasksViewModel();
  ReportViewModel searchAgentVM = ReportViewModel();
  double widthScale;
  double margin;
  double lineHeight = 50;
  double selfWidth;
  String taskRecipient = '';
  List typeList = [];
  List urgencyList = [];
  // DateTime startDate = DateTime.now();
  // DateTime endDate = DateTime.now().add(Duration(days: 7));
  DateTime startDate;
  DateTime endDate;
  DateFormat dateFormat = DateFormat('yyyy-MM-dd');
  DateFormat timeFormat = DateFormat('HH:mm:ss');
  DateFormat allFormat = DateFormat('yyyy-MM-dd HH:mm:ss');
  Map<String, dynamic> params = {};
  List agentList = [];
  @override
  void initState() {
    // params['startTime'] = allFormat.format(startDate);
    // params['expireTime'] = allFormat.format(endDate);
    params['receiveIdList'] = [];
    tasksVM.loadTasksType((data, success) {
      if (success) {
        setState(() {
          typeList = data;
        });
      }
    });
    tasksVM.loadTasksUrgency((data, success) {
      if (success) {
        setState(() {
          urgencyList = data;
        });
      }
    });
    super.initState();
  }

  @override
  void dispose() {
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    SizeConfig().init(context);
    widthScale = SizeConfig.blockSizeHorizontal;
    margin = widthScale * 6;
    selfWidth = SizeConfig.screenWidth - margin * 2;

    return GestureDetector(
      onTap: () {
        FocusScope.of(context).requestFocus(FocusNode());
      },
      child: Scaffold(
        appBar: CustomAppbar(
          title: '新建任务',
        ),
        body: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // SizedBox(
              //   height: 8,
              // ),
              Container(
                height: 60,
                width: selfWidth,
                margin: EdgeInsets.only(left: margin),
                // color: Colors.red,
                alignment: Alignment.centerLeft,
                child: Text(
                  '任务明细',
                  style: jm_text_black_bold_style22,
                ),
              ),
              JMline(width: SizeConfig.screenWidth, height: 0.5),
              CustomInput(
                labelStyle: jm_text_black_bold_style15,
                title: '任务名称',
                must: true,
                text: params['name'] ?? '',
                hintText: '请输入任务名称',
                valueChange: (value) {
                  params['name'] = value;
                },
              ),
              JMline(width: selfWidth, height: 0.5),
              // SelectView(
              //   margin: margin,
              //   dataList: typeList,
              //   title: '任务类型',
              //   selectValueChange: (value, data) {
              //     params['type'] = value;
              //   },
              // ),
              Row(
                children: [
                  SizedBox(
                    width: widthScale * 6,
                  ),
                  DropdownSelectV(
                    // margin: margin,
                    width: selfWidth - widthScale * 6,
                    dataList: typeList,
                    must: true,
                    placeholder: '请选择任务类型',
                    labelText: '任务类型',
                    labelStyle: jm_text_black_bold_style15,
                    valueChange: (value, data) {
                      setState(() {
                        params['type'] = int.parse(value);
                      });
                    },
                  ),
                  Icon(
                    Icons.keyboard_arrow_right,
                    size: widthScale * 6,
                  )
                ],
              ),
              JMline(width: selfWidth, height: 0.5),
              // SelectView(
              //   margin: margin,
              //   dataList: urgencyList,
              //   title: '紧急程度',
              //   selectValueChange: (value, data) {
              //     params['priority'] = value;
              //   },
              // ),
              Row(
                children: [
                  SizedBox(
                    width: widthScale * 6,
                  ),
                  DropdownSelectV(
                    // margin: margin,
                    must: true,
                    labelStyle: jm_text_black_bold_style15,
                    width: selfWidth - widthScale * 6,
                    dataList: urgencyList ?? [],
                    placeholder: '请选择紧急程度',
                    labelText: '紧急程度',
                    valueChange: (value, data) {
                      setState(() {
                        params['priority'] = int.parse(value);
                      });
                    },
                  ),
                  Icon(
                    Icons.keyboard_arrow_right,
                    size: widthScale * 6,
                  )
                ],
              ),
              JMline(width: selfWidth, height: 0.5),
              getDateWidget(title: '开始时间', start: true),
              JMline(width: selfWidth, height: 0.5),
              getDateWidget(title: '结束时间', start: false),
              JMline(width: selfWidth, height: 0.5),
              Padding(
                padding: EdgeInsets.only(left: margin),
                child: CustomTextF(
                  leftTextPadding: 0,
                  must: true,
                  labelText: '任务接收人',
                  // labelWidth: labelWidth,
                  style: jm_text_black_style15,
                  labelStyle: jm_text_black_bold_style15,
                  // text: agentData != null && agentData['showName'] != null
                  //     ? agentData['showName']
                  //     : '',
                  onlyTap: true,
                  labelClick: () {
                    push(
                        CustomWebV(
                          path: WebPath.searchUser,
                          isMultiple: false,
                          returnSearchList: (searchDataList) {
                            if (searchDataList != null &&
                                searchDataList.length > 0) {
                              // Map agent = searchDataList[0];
                              for (var i = 0; i < searchDataList.length; i++) {
                                Map item = searchDataList[i];
                                bool isHave = false;
                                agentList.forEach((element) {
                                  if (element['userId'] == item['userId']) {
                                    isHave = true;
                                  }
                                });
                                if (!isHave) {
                                  agentList.add(item);
                                }
                              }
                              setState(() {});
                            }
                          },
                        ),
                        context);
                  },
                  placeholder: '添加任务接收人',
                ),
              ),
              // CustomInput(
              //   must: true,
              //   labelStyle: jm_text_black_bold_style15,
              //   title: '任务接收人',
              //   hintText: '搜索添加任务接收人',
              //   text: taskRecipient ?? '',
              //   searchUrl: Urls.agentFuzzySearch,
              //   // valueChange: (value) {
              //   //   taskRecipient = value;
              //   // },
              //   // valueChangeAndShowList: (value, state) {
              //   //   if (value != '') {
              //   //     searchAgentVM.loadAgentSearchData(
              //   //       value,
              //   //       success: (data) {
              //   //         if (data != null && data.length > 0) {
              //   //           state.showList(data);
              //   //         }
              //   //       },
              //   //     );
              //   //   }
              //   // },
              //   showListClick: (data) {
              //     bool isHave = false;
              //     agentList.forEach((element) {
              //       if (element['userId'] == data['userId']) {
              //         isHave = true;
              //         return;
              //       }
              //     });
              //     if (!isHave) {
              //       setState(() {
              //         agentList.add(data);
              //       });
              //     }
              //   },
              // ),
              ...pushPeoples(),
              SizedBox(
                height: agentList.length > 0 ? 10 : 0,
              ),
              JMline(width: selfWidth, height: 0.5),
              SizedBox(
                height: 20,
              ),
              Padding(
                padding: EdgeInsets.only(left: margin),
                child: Text(
                  '任务说明',
                  style: jm_text_black_bold_style15,
                ),
              ),
              SizedBox(
                height: 10,
              ),
              CustomMarkInput(
                text: params['taskExplain'] ?? '',
                valueChange: (value) {
                  params['taskExplain'] = value;
                },
              ),
              SizedBox(
                height: 15,
              ),
              Padding(
                padding: EdgeInsets.only(left: margin * 5),
                child: CustomSubmitButton(
                  height: 60,
                  margin: margin * 5,
                  buttonClick: () {
                    if (params['name'] == null || params['name'] == '') {
                      ShowToast.normal('请输入任务名称');
                      return;
                    }
                    if (params['type'] == null) {
                      ShowToast.normal('请选择任务类型');
                      return;
                    }
                    if (params['priority'] == null) {
                      ShowToast.normal('请选择任务紧急程度');
                      return;
                    }
                    if (params['startTime'] == null ||
                        (params['startTime'] as String).length == 0) {
                      ShowToast.normal('请选择开始时间');
                      return;
                    }
                    if (params['expireTime'] == null ||
                        (params['expireTime'] as String).length == 0) {
                      ShowToast.normal('请输入结束时间');
                      return;
                    }
                    if (allFormat
                        .parse(params['startTime'])
                        .isAfter(allFormat.parse(params['expireTime']))) {
                      ShowToast.normal('结束时间不能小于开始时间');
                      return;
                    }
                    if (params['taskExplain'] == null ||
                        params['taskExplain'] == '') {
                      ShowToast.normal('请输入任务说明');
                      return;
                    }
                    if (agentList == null || agentList.length == 0) {
                      ShowToast.normal('请添加任务接收人');
                      return;
                    }

                    params['receiveIdList'] =
                        agentList.map((e) => e['userId']).toList();
                    CustomAlert(title: '提示', content: '是否确认提交？').show(
                        confirmClick: () {
                      CustomLoading().show();
                      tasksVM.addTasksRequest(params, (success) {
                        CustomLoading().hide();
                        if (success) {
                          _bus.emit(NOTIFY_TASKS_LIST_REFRASH);
                          ShowToast.normal('新增成功');
                          Future.delayed(Duration(seconds: 1),
                              () => Navigator.pop(context));
                        }
                      });
                    });
                  },
                ),
              ),
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
    double labelWidth = widthScale * 24;
    dynamic dateData = start ? params['startTime'] : params['expireTime'];
    TextStyle textStyle = dateData != null && dateData != ''
        ? jm_text_black_style15
        : TextStyle(color: jm_placeholder_color, fontSize: 15);
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
            child: Row(
              children: [
                Text('*', style: TextStyle(color: Colors.red, fontSize: 13)),
                Text(
                  title,
                  style: jm_text_black_bold_style15,
                ),
              ],
            ),
          ),
          Container(
              width: selfWidth - labelWidth - widthScale * 6,
              child: Text(
                // dateFormat.format(start ? startDate : endDate),
                dateData ?? (start ? '请选择发布时间' : '请选择结束时间'),
                style: textStyle,
              )),
          Icon(
            Icons.keyboard_arrow_right,
            size: widthScale * 6,
          )
        ],
      ),
    );
  }

  Future<void> showDatePick(bool isStart) async {
    dynamic dateData = isStart ? startDate : endDate;
    final DateTime date = await showDatePicker(
        context: context,
        initialDate:
            dateData != null && dateData != '' ? dateData : DateTime.now(),
        firstDate: DateTime(2018, 1),
        lastDate: DateTime(2022, 1),
        locale: Locale('zh'));
    if (date == null) return;
    setState(() {
      isStart ? startDate = date : endDate = date;
      isStart
          ? params['startTime'] = dateFormat.format(date)
          : params['expireTime'] = dateFormat.format(date);
    });

    final TimeOfDay time = await showTimePicker(
      context: context,
      initialTime: TimeOfDay.now(),
    );

    // initialDate: isStart ? startDate : endDate,
    // firstDate: DateTime(2018, 1),
    // lastDate: DateTime(2022, 1),
    // locale: Locale('zh'));
    if (time == null) return;
    setState(() {
      isStart
          ? params['startTime'] += (' ' +
              getIntFormat(time.hour) +
              ':' +
              getIntFormat(time.minute) +
              ':00')
          : params['expireTime'] += (' ' +
              getIntFormat(time.hour) +
              ':' +
              getIntFormat(time.minute) +
              ':00');
      // isStart ? startDate = date : endDate = date;
    });
  }

  String getIntFormat(int value) {
    if (value < 10) {
      return '0' + value.toString();
    } else {
      return value.toString();
    }
  }

  List<Widget> pushPeoples() {
    double buttonWidth = widthScale * 50;
    List<Widget> peoplesList = [];
    for (var i = 0; i < agentList.length; i++) {
      Map item = agentList[i];
      peoplesList.add(Row(
        mainAxisAlignment: MainAxisAlignment.end,
        children: [
          RawMaterialButton(
              materialTapTargetSize: MaterialTapTargetSize.shrinkWrap,
              constraints: BoxConstraints(minHeight: 24, minWidth: buttonWidth),
              shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(12),
                  side: BorderSide(color: jm_line_color, width: 0.5)),
              child: Container(
                width: buttonWidth,
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Padding(
                      padding: EdgeInsets.only(left: widthScale * 3),
                      child: Text(
                        item['userName' ?? ''],
                        style: jm_text_black_style13,
                      ),
                    ),
                    Padding(
                      padding: EdgeInsets.only(right: widthScale * 1),
                      child: Icon(
                        Icons.cancel,
                        size: 22,
                        color: jm_text_gray,
                      ),
                    ),
                  ],
                ),
              ),
              onPressed: () {
                setState(() {
                  agentList.remove(item);
                });
              }),
          SizedBox(
            width: margin,
            height: 35,
          )
        ],
      ));
    }
    return peoplesList;
  }
}
