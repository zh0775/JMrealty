import 'package:JMrealty/Report/viewmodel/ReportViewModel.dart';
import 'package:JMrealty/components/CustomAlert.dart';
import 'package:JMrealty/components/CustomAppBar.dart';
import 'package:JMrealty/components/CustomSubmitButton.dart';
import 'package:JMrealty/components/DropdownSelectV.dart';
import 'package:JMrealty/components/NoneV.dart';
import 'package:JMrealty/const/Default.dart';
import 'package:JMrealty/utils/notify_default.dart';
import 'package:JMrealty/utils/sizeConfig.dart';
import 'package:JMrealty/utils/toast.dart';
import 'package:JMrealty/utils/user_default.dart';
import 'package:flutter/material.dart';
import 'dart:convert' as convert;

import 'package:multi_image_picker/multi_image_picker.dart';

class AddReport extends StatefulWidget {
  final Map userData;
  const AddReport({this.userData});
  @override
  _AddReportState createState() => _AddReportState();
}

class _AddReportState extends State<AddReport> {
  void clientDataUpdate(ClientSourceWidget widget, Map clientData) {
    for (var i = 0; i < addClientWidgets.length; i++) {
      Widget w = addClientWidgets[i];
      if (identical(w, widget)) {
        clientsData[i] = clientData;
        break;
      }
    }
    print('clientsData ==== ${clientsData}');
  }

  ReportViewModel model = ReportViewModel();
  double widthScale;
  double margin;
  double lineHeight;
  int addClientCount = 0;
  List<Widget> addClientWidgets = [];
  List<Map> clientsData = [];
  Map projectData; // 项目数据
  Map agentData; // 经纪人数据
  String mark = '';
  Map userInfo;
  // String jjrSearchStr;
  // String clientSearchStr;
  // String projectSearchStr;
  @override
  void initState() {
    UserDefault.get(USERINFO).then((value) {
      userInfo = convert.jsonDecode(value);
      setState(() {
        agentData = {
          'userId': userInfo['userId'],
          'userName': userInfo['userName'],
          'phonenumber': userInfo['phonenumber'],
        };
      });
    });

    if (widget.userData != null) {
      Future.delayed(Duration.zero, () {
        addClient(client: widget.userData);
      });
    }

    super.initState();
  }

  @override
  void dispose() {
    if (model != null) {
      model.dispose();
    }
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    SizeConfig().init(context);
    lineHeight = 50;
    widthScale = SizeConfig.blockSizeHorizontal;
    margin = widthScale * 6;
    return GestureDetector(
      onTap: () => FocusScope.of(context).requestFocus(FocusNode()),
      child: Scaffold(
        appBar: CustomAppbar(
          title: '报备',
          backClick: () {
            CustomAlert(
                    cancelText: '返回首页',
                    confirmText: '继续报备',
                    title: '退出',
                    content: '退出后信息将不再保存，是否确定退出')
                .show(
              cancelClick: () {
                Navigator.pop(context);
              },
            );
          },
        ),
        body: ListView(
          children: [
            Container(
              height: 50,
              margin: EdgeInsets.only(left: margin),
              child: Align(
                alignment: Alignment.centerLeft,
                child: Text(
                  '项目',
                  style: jm_text_black_bold_style17,
                ),
              ),
            ),
            JMline(
              width: SizeConfig.screenWidth - margin,
              height: 0.5,
              margin: margin,
            ),
            CustomInput(
              key: ValueKey('CustomInput_project_1'),
              text: projectData != null && projectData['name'] != null
                  ? projectData['name']
                  : '',
              labelStyle: jm_text_black_bold_style14,
              textStyle: jm_text_black_style15,
              title: '项目搜索',
              hintText: '请输入项目名称',
              valueChangeAndShowList: (value, state) {
                if (value != '') {
                  model.loadProjectList(
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
                  projectData = data;
                });
              },
            ),
            JMline(
              width: SizeConfig.screenWidth - margin,
              height: 0.5,
              margin: margin,
            ),
            CustomInput(
              key: ValueKey('CustomInput_project_2'),
              labelStyle: jm_text_black_bold_style14,
              textStyle: jm_text_black_style15,
              title: '最早到场时间',
              hintText: '项目名称',
              text: projectData != null && projectData['approachDate'] != null
                  ? projectData['approachDate']
                  : '',
              enable: false,
            ),
            projectData != null
                ? Align(
                    alignment: Alignment.centerLeft,
                    child: Container(
                      margin:
                          EdgeInsets.only(left: widthScale * 30, bottom: 10),
                      width:
                          SizeConfig.screenWidth - margin * 2 - widthScale * 24,
                      // color: Colors.red,
                      child: Text(
                        '该项目要求提前报备' +
                            projectData['reportBeforeTime'].toString() +
                            '分钟;' +
                            (projectData['isSensitive'] == 1
                                ? '要求手机号前三后四;'
                                : '要求全号报备'),
                        style: jm_text_gray_style12,
                        maxLines: null,
                      ),
                    ),
                  )
                : NoneV(),
            JMline(
              width: SizeConfig.screenWidth - margin,
              height: 0.5,
              margin: margin,
            ),
            CustomInput(
              key: ValueKey('CustomInput_project_3'),
              labelStyle: jm_text_black_bold_style14,
              textStyle: jm_text_black_style15,
              title: '对接公司',
              hintText: '对接公司',
              text: projectData != null && projectData['companyName'] != null
                  ? projectData['companyName']
                  : '',
              enable: false,
            ),
            JMline(
              width: SizeConfig.screenWidth,
              height: 6,
            ),
            ...addClientWidgets,
            GestureDetector(
              onTap: () {
                setState(() {
                  addClient();
                });
              },
              child: Container(
                margin: EdgeInsets.only(left: margin),
                height: lineHeight,
                width: SizeConfig.screenWidth - margin,
                child: Row(
                  children: [
                    Icon(
                      Icons.add_circle_outline,
                      size: 20,
                      color: jm_appTheme,
                    ),
                    Padding(
                      padding: const EdgeInsets.only(left: 5),
                      child: Text(
                        '添加客源',
                        style: jm_text_apptheme_style15,
                      ),
                    )
                  ],
                ),
              ),
            ),
            JMline(
              width: SizeConfig.screenWidth,
              height: 6,
            ),
            CustomInput(
              key: ValueKey('CustomInput_agent_1'),
              labelStyle: jm_text_black_bold_style14,
              textStyle: jm_text_black_style15,
              text: agentData != null && agentData['showName'] != null
                  ? agentData['showName']
                  : '',
              title: '搜索',
              hintText: '请输入名称',
              valueChange: (value) {},
              valueChangeAndShowList: (value, state) {
                if (value != '') {
                  model.loadAgentSearchData(
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
                  agentData = data;
                  agentData['showName'] = data['userName'];
                });
              },
            ),
            JMline(
              width: SizeConfig.screenWidth - margin,
              height: 0.5,
              margin: margin,
            ),
            CustomInput(
              key: ValueKey('CustomInput_agent_2'),
              labelStyle: jm_text_black_bold_style14,
              textStyle: jm_text_black_style15,
              title: '带看经纪人',
              text: agentData != null && agentData['userName'] != null
                  ? agentData['userName']
                  : '',
              enable: false,
            ),
            JMline(
              width: SizeConfig.screenWidth - margin,
              height: 0.5,
              margin: margin,
            ),
            CustomInput(
              key: ValueKey('CustomInput_agent_3'),
              labelStyle: jm_text_black_bold_style14,
              textStyle: jm_text_black_style15,
              title: '联系方式',
              text: agentData != null && agentData['phonenumber'] != null
                  ? agentData['phonenumber']
                  : '',
              enable: false,
            ),
            JMline(
              width: SizeConfig.screenWidth,
              height: 6,
            ),
            Container(
              height: lineHeight,
              margin: EdgeInsets.only(left: margin),
              alignment: Alignment.centerLeft,
              child: Text(
                '备注（选填）',
                style: jm_text_black_style14,
              ),
            ),
            Container(
              constraints: BoxConstraints(maxHeight: 100, minHeight: 90),
              width: SizeConfig.screenWidth - margin * 2,
              padding: EdgeInsets.fromLTRB(margin, 10, margin, 10),
              child: TextField(
                maxLength: 200,
                maxLines: 10,
                minLines: 3,
                decoration: InputDecoration(
                    contentPadding: EdgeInsets.fromLTRB(10, 10, 10, 10),
                    // border: OutlineInputBorder(
                    //     borderRadius: BorderRadius.circular(10),
                    //     borderSide:
                    //         BorderSide(width: 0.1, color: Colors.red)),
                    // fillColor: Color(0xfff7f8fb),
                    // contentPadding: EdgeInsets.all(20.0),
                    hintText: '请输入',
                    filled: true,
                    enabledBorder: OutlineInputBorder(
                      //未选中时候的颜色
                      borderRadius: BorderRadius.circular(10.0),
                      borderSide: BorderSide(
                        color: jm_line_color,
                      ),
                    ),
                    focusedBorder: OutlineInputBorder(
                      //选中时外边框颜色
                      borderRadius: BorderRadius.circular(10.0),
                      borderSide: BorderSide(
                        color: jm_line_color,
                      ),
                    )),
                onChanged: (value) {
                  mark = value;
                },
              ),
            ),
            SizedBox(
              height: 8,
            ),
            CustomSubmitButton(
              buttonClick: () {
                FocusScope.of(context).requestFocus(FocusNode());

                if (projectData == null) {
                  ShowToast.normal('请选择项目信息');
                  return;
                }

                List clients = [];
                if (clientsData == null || clientsData.length == 0) {
                  ShowToast.normal('请选择客源信息');
                  return;
                }

                clientsData.forEach((e) {
                  // print(e);
                  // if (e['name'] != null && e['csutomerPhone'] != null) {
                  clients.add(e);
                  // }
                });
                model.addReportRequest({
                  'client': clients,
                  'agent': agentData,
                  'project': projectData,
                  'mark': mark
                }, (bool success) {
                  if (success) {
                    ShowToast.normal('提交成功');
                    Future.delayed(Duration(seconds: 1), () {
                      Navigator.pop(context);
                    });
                  }
                });
              },
            ),
          ],
        ),
      ),
    );
  }

  void addClient({Map client}) {
    FocusScope.of(context).requestFocus(FocusNode());
    addClientCount++;
    if (clientsData == null) {
      clientsData = [];
    }
    Map map = client ?? {'sex': 0};
    clientsData.add(map);
    addClientWidgets.add(ClientSourceWidget(
      key: ValueKey(addClientCount.toString()),
      margin: SizeConfig.blockSizeHorizontal * 6,
      title: '客源' + addClientCount.toString(),
      clientData: client,
      deleteClick: (widget) {
        int index = 0;
        for (var i = 0; i < addClientWidgets.length; i++) {
          Widget w = addClientWidgets[i];
          if (identical(w, widget)) {
            index = i;
            addClientWidgets.remove(w);
            addClientCount--;
            break;
          }
        }
        clientsData.removeAt(index);
        setState(() {});
      },
      clientDataUpdate: clientDataUpdate,
    ));
  }
}

class ClientSourceWidget extends StatefulWidget {
  final Map clientData;
  final double margin;
  final String title;
  final double lineHeight;
  final void Function(ClientSourceWidget widget) deleteClick;
  final void Function(ClientSourceWidget widget, Map clientData)
      clientDataUpdate;
  ClientSourceWidget(
      {this.title,
      this.margin,
      this.deleteClick,
      this.lineHeight = 50,
      this.clientData,
      Key key,
      this.clientDataUpdate})
      : super(key: key);
  @override
  _ClientSourceWidgetState createState() => _ClientSourceWidgetState();
}

enum ClientSourceStatus { normal, clientSource, input }

class _ClientSourceWidgetState extends State<ClientSourceWidget> {
  ReportViewModel model = ReportViewModel();
  ClientSourceStatus status;
  double margin;
  List reportType = [
    {'title': '客源报备', 'value': 0},
    {'title': '录入手机号报备', 'value': 1}
  ];
  Sex sex = Sex.boy;
  Map clientData;
  bool searchSuccess = false;

  @override
  void initState() {
    status = widget.clientData != null
        ? ClientSourceStatus.input
        : ClientSourceStatus.normal;
    clientData = Map<String, dynamic>.from(
        widget.clientData != null ? widget.clientData : {'sex': 0});
    super.initState();
  }

  @override
  void dispose() {
    if (model != null) {
      model.dispose();
    }
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    SizeConfig().init(context);
    margin = widget.margin != null
        ? widget.margin
        : SizeConfig.blockSizeHorizontal * 6;
    return Column(
      children: [
        JMline(width: SizeConfig.screenWidth, height: 0.5),
        Container(
          height: widget.lineHeight,
          width: SizeConfig.screenWidth - margin * 2,
          margin: EdgeInsets.only(left: margin),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                widget.title,
                style: jm_text_black_bold_style17,
              ),
              TextButton(
                  onPressed: () {
                    if (widget.deleteClick != null) {
                      widget.deleteClick(widget);
                    }
                  },
                  child: Text('删除', style: jm_text_apptheme_style15))
            ],
          ),
        ),
        JMline(width: SizeConfig.screenWidth, height: 0.5),
        DropdownSelectV(
          labelStyle: jm_text_black_bold_style14,
          style: jm_text_black_style15,
          labelText: '报备方式',
          placeholder: '请选择报备方式',
          dataList: reportType ?? [],
          textPadding:
              EdgeInsets.only(left: SizeConfig.blockSizeHorizontal * 0.5),
          valueChange: (value, data) {
            if (value == 0) {
              if (status != ClientSourceStatus.clientSource) {
                setState(() {
                  status = ClientSourceStatus.clientSource;
                });
              }
            } else if (value == 1) {
              if (status != ClientSourceStatus.input) {
                setState(() {
                  status = ClientSourceStatus.input;
                });
              }
            }
          },
        ),
        changeWidget(),
      ],
    );
  }

  Widget changeWidget() {
    return Column(
      children: [
        status == ClientSourceStatus.clientSource
            ? CustomInput(
                labelStyle: jm_text_black_bold_style14,
                textStyle: jm_text_black_style15,
                title: '搜索内容',
                hintText: '请输入搜索用户信息',
                valueChangeAndShowList: (value, state) {
                  if (value != '') {
                    model.loadClientSearchData(
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
                  if (widget.clientDataUpdate != null) {
                    widget.clientDataUpdate(widget, data);
                  }
                  // setState(() {
                  //   status = ClientSourceStatus.input;
                  // });
                  Future.delayed(Duration(milliseconds: 100), () {
                    setState(() {
                      searchSuccess = true;
                      clientData = Map.from(data);
                    });
                  });
                },
              )
            : NoneV(),
        searchSuccess || status == ClientSourceStatus.input
            ? CustomInput(
                key: ValueKey('CustomInput_client_1'),
                labelStyle: jm_text_black_bold_style14,
                textStyle: jm_text_black_style15,
                title: '客户姓名',
                hintText: '请输入客户姓名',
                text: clientData != null && clientData['name'] != null
                    ? clientData['name']
                    : '',
                valueChange: (value) {
                  if (clientData == null) {
                    clientData = {};
                  }
                  clientData['name'] = value;
                  if (widget.clientDataUpdate != null) {
                    widget.clientDataUpdate(widget, clientData);
                  }
                },
              )
            : NoneV(),
        searchSuccess || status == ClientSourceStatus.input
            ? SexCell(
                labelStyle: jm_text_black_bold_style14,
                margin: margin,
                title: '客户性别',
                lineHeight: widget.lineHeight,
                sex: clientData != null && clientData['sex'] != null
                    ? (clientData['sex'] == 0 ? Sex.boy : Sex.girl)
                    : sex,
                valueChange: (newSex) {
                  if (clientData == null) {
                    clientData = {};
                  }
                  clientData['sex'] = (newSex == Sex.boy ? 0 : 1);
                  if (widget.clientDataUpdate != null) {
                    widget.clientDataUpdate(widget, clientData);
                  }
                },
              )
            : NoneV(),
        searchSuccess || status == ClientSourceStatus.input
            ? CustomInput(
                key: ValueKey('CustomInput_client_4'),
                labelStyle: jm_text_black_bold_style14,
                textStyle: jm_text_black_style15,
                title: '手机号',
                hintText: '请输入客户手机号码',
                keyboardType: TextInputType.phone,
                text: clientData != null && clientData['phone'] != null
                    ? clientData['phone']
                    : '',
                valueChange: (value) {
                  if (clientData == null) {
                    clientData = {};
                  }
                  clientData['phone'] = value;
                  if (widget.clientDataUpdate != null) {
                    widget.clientDataUpdate(widget, clientData);
                  }
                },
              )
            : NoneV(),
        searchSuccess || status == ClientSourceStatus.input
            ? CustomInput(
                key: ValueKey('CustomInput_client_5'),
                labelStyle: jm_text_black_bold_style14,
                textStyle: jm_text_black_style15,
                title: '身份证（选填）',
                hintText: '请输入身份证',
                valueChange: (value) {
                  if (clientData == null) {
                    clientData = {};
                  }
                  clientData['custmoerCard'] = value;
                  if (widget.clientDataUpdate != null) {
                    widget.clientDataUpdate(widget, clientData);
                  }
                },
              )
            : NoneV(),
      ],
    );
  }
}
