import 'package:JMrealty/Report/viewmodel/ReportViewModel.dart';
import 'package:JMrealty/components/CustomAppBar.dart';
import 'package:JMrealty/const/Default.dart';
import 'package:JMrealty/utils/sizeConfig.dart';
import 'package:JMrealty/utils/user_default.dart';
import 'package:flutter/material.dart';
import 'dart:convert' as convert;
class AddReport extends StatefulWidget {
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
  }

  ReportViewModel model;
  double widthScale;
  double margin;
  double lineHeight;
  int addClientCount;
  List<Widget> addClientWidgets;
  List<Map> clientsData;
  Map projectData; // 项目数据
  Map agentData; // 经纪人数据
  String mark;
  Map userInfo;
  // String jjrSearchStr;
  // String clientSearchStr;
  // String projectSearchStr;
  @override
  void initState() {
    UserDefault.get('userInfo').then((value) {
      userInfo = convert.jsonDecode(value);
      setState(() {
        agentData = {
          'userId': userInfo['userId'],
          'userName': userInfo['userName'],
          'phonenumber': userInfo['phonenumber'],
        };
      });
    });

    mark = '';
    model = ReportViewModel();
    addClientCount = 0;
    addClientWidgets = [];
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
    return Scaffold(
      appBar: CustomAppbar(
        title: '报备',
      ),
      body: ListView(
        children: [
          Container(
            height: 50,
            margin: EdgeInsets.only(left: margin),
            child: Align(
              alignment: Alignment.centerLeft,
              child: Text(
                '项目1',
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
          ...addClientWidgets,
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
            title: '搜索内容',
            hintText: '请输入名称和手机号码',
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
          Align(
            child: Container(
                // 提交按钮
                width: SizeConfig.screenWidth - margin * 2,
                height: lineHeight,
                margin: EdgeInsets.only(bottom: 50),
                decoration: BoxDecoration(
                    color: jm_appTheme,
                    borderRadius: BorderRadius.all(Radius.circular(8))),
                child: TextButton(
                  onPressed: () {
                    FocusScope.of(context).requestFocus(FocusNode());
                    // sendRegist();
                    model.addReportRequest({
                      'client': clientsData,
                      'agent': agentData,
                      'project': projectData,
                      'mark': mark
                    }, (bool success) {
                      if (success) {
                        Future.delayed(Duration(seconds: 1), () {
                          Navigator.pop(context);
                        });
                      }
                    });
                  },
                  child: Text(
                    '提交',
                    style: TextStyle(fontSize: 15, color: Colors.white),
                  ),
                )),
          )
        ],
      ),
    );
  }

  void addClient() {
    // addClientWidgets.add(value)
    // Container()
    addClientCount++;
    if (clientsData == null) {
      clientsData = [];
    }
    Map map = {'sex': 1};
    clientsData.insert(0, map);
    addClientWidgets.insert(
        0,
        ClientSourceWidget(
          key: ValueKey(addClientCount.toString()),
          margin: SizeConfig.blockSizeHorizontal * 6,
          title: '客源' + addClientCount.toString(),
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
    // addClientWidgets.add(ClientSourceWidget(
    //   key: ValueKey(addClientCount.toString()),
    //   margin: SizeConfig.blockSizeHorizontal * 6,
    //   title: '客源' + addClientCount.toString(),
    //   deleteClick: (widget) {
    //     for (var i = 0; i < addClientWidgets.length; i++) {
    //       Widget w = addClientWidgets[i];
    //       if (w == widget) {
    //         addClientWidgets.remove(w);
    //         addClientCount--;
    //         break;
    //       }
    //     }
    //     setState(() {});
    //   },
    // ));
  }
}

class ClientSourceWidget extends StatefulWidget {
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
      Key key,
      this.clientDataUpdate})
      : super(key: key);
  @override
  _ClientSourceWidgetState createState() => _ClientSourceWidgetState();
}

enum ClientSourceStatus { normal, clientSource, input }

class _ClientSourceWidgetState extends State<ClientSourceWidget> {
  ReportViewModel model;
  ClientSourceStatus status;
  double margin;
  List reportType;
  Sex sex;
  Map clientData;
  @override
  void initState() {
    model = ReportViewModel();
    sex = Sex.boy;
    reportType = [
      {'title': '客源报备', 'value': 0},
      {'title': '录入手机号报备', 'value': 1}
    ];
    status = ClientSourceStatus.normal;
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
        SelectView(
          title: '报备方式',
          dataList: reportType,
          margin: margin,
          selectValueChange: (value, data) {
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
    if (status == ClientSourceStatus.clientSource) {
      return Column(
        children: [
          CustomInput(
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
              setState(() {
                status = ClientSourceStatus.input;
              });
              Future.delayed(Duration(milliseconds: 100), () {
                setState(() {
                  clientData = Map.from(data);
                });
              });
            },
          ),
        ],
      );
    } else if (status == ClientSourceStatus.input) {
      return Column(
        children: [
          CustomInput(
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
          ),
          SexCell(
            labelStyle: jm_text_black_bold_style14,
            margin: margin,
            title: '客户性别',
            lineHeight: widget.lineHeight,
            sex: clientData != null && clientData['sex'] != null
                ? (clientData['sex'] == 1 ? Sex.boy : Sex.girl)
                : sex,
            valueChange: (newSex) {
              if (clientData == null) {
                clientData = {};
              }
              clientData['sex'] = newSex == Sex.boy ? 2 : 1;
              if (widget.clientDataUpdate != null) {
                widget.clientDataUpdate(widget, clientData);
              }
            },
          ),
          CustomInput(
            key: ValueKey('CustomInput_client_4'),
            labelStyle: jm_text_black_bold_style14,
            textStyle: jm_text_black_style15,
            title: '手机号',
            hintText: '请输入客户手机号码',
            text: clientData != null && clientData['phone'] != null
                ? clientData['phone']
                : '',
            valueChange: (value) {
              if (clientData == null) {
                clientData = {};
              }
              clientData['csutomerPhone'] = value;
              if (widget.clientDataUpdate != null) {
                widget.clientDataUpdate(widget, clientData);
              }
            },
          ),
          CustomInput(
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
          ),
        ],
      );
    }
    return Container(
      width: 0.0,
      height: 0.0,
    );
  }
}
