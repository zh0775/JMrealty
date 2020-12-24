import 'package:JMrealty/Client/components/WaitFollowUpCell.dart';
import 'package:JMrealty/Client/viewModel/ClientPoolViewModel.dart';
import 'package:JMrealty/components/CustomPullHeader.dart';
import 'package:JMrealty/components/EmptyView.dart';
import 'package:JMrealty/const/Default.dart';
import 'package:JMrealty/utils/sizeConfig.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_easyrefresh/easy_refresh.dart';

class ClientPool extends StatefulWidget {
  @override
  _ClientPoolState createState() => _ClientPoolState();
}

class _ClientPoolState extends State<ClientPool> {
  EasyRefreshController pullCtr = EasyRefreshController();
  GlobalKey pullKey = GlobalKey();
  GlobalKey pullHeaderKey = GlobalKey();
  ClientPoolViewModel clientPoolVM;
  int currentSelectIndex;
  Map selectData = Map<String, dynamic>.from({});
  Map value1;
  Map value2;
  Map value3;
  bool selectExpand;
  List clientList = [];
  Map clientData = Map<String, dynamic>.from({});
  Map clientPoolParams = Map<String, dynamic>.from({});
  @override
  void initState() {
    currentSelectIndex = 1;
    value1 = {'title': '级别', 'value': '-1'};
    value2 = {'title': '类型', 'value': '-1'};
    value3 = {'title': '面积', 'value': '-1'};
    selectExpand = false;
    clientPoolVM = ClientPoolViewModel();
    clientPoolVM.loadSelectData((Map data) {
      setState(() {
        selectData = Map<String, dynamic>.from(data);
      });
    });
    super.initState();
  }

  @override
  void dispose() {
    clientPoolVM.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    SizeConfig().init(context);
    String key;
    switch (currentSelectIndex) {
      case 1:
        key = 'jb';
        break;
      case 2:
        key = 'lx';
        break;
      case 3:
        key = 'mj';
        break;
    }
    // print('key === $key');
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
            '公共客户池',
            style: TextStyle(color: Colors.white, fontSize: 18),
          ),
        ),
        body: Container(
          width: double.infinity,
          height: double.infinity,
          child: Stack(children: [
            Positioned(
                left: 0,
                right: 0,
                top: 40,
                bottom: 0,
                child: EasyRefresh(
                  header: CustomPullHeader(key: pullHeaderKey),
                  key: pullKey,
                  controller: pullCtr,
                  firstRefresh: true,
                  emptyWidget: clientList == null || clientList.length == 0
                      ? EmptyView()
                      : null,
                  onRefresh: () async {
                    clientPoolVM.loadClientPoolList(
                        params: clientPoolParams,
                        success: (data) {
                          setState(() {
                            clientData = Map<String, dynamic>.from(data);
                            clientList = clientData['rows'];
                          });
                        });
                  },
                  child: ListView.builder(
                    itemCount: clientList.length,
                    // itemCount: model.listData.length,
                    itemBuilder: (context, index) {
                      return WaitFollowUpCell(
                        model: clientList[index],
                        index: index,
                        pool: true,
                        takeOrderClick: (Map data) {
                          showCupertinoDialog(
                              context: context,
                              builder: (context) {
                                return CupertinoAlertDialog(
                                  title: Text(
                                    '提示',
                                    style: TextStyle(
                                        fontSize: 14, color: jm_text_black),
                                  ),
                                  content: Text(
                                    '您要跟进该用户吗？',
                                    style: TextStyle(
                                        fontSize: 14, color: jm_text_black),
                                  ),
                                  actions: [
                                    TextButton(
                                        onPressed: () {
                                          Navigator.pop(context);
                                        },
                                        child: Text(
                                          '取消',
                                          style: TextStyle(
                                              fontSize: 14,
                                              color: jm_text_black),
                                        )),
                                    TextButton(
                                        onPressed: () {
                                          clientPoolVM.takeClientRequest(
                                              data['id'], () {
                                            Navigator.pop(context);
                                            pullCtr.callRefresh();
                                          });
                                        },
                                        child: Text(
                                          '确认',
                                          style: TextStyle(
                                              fontSize: 14,
                                              color: jm_text_black),
                                        ))
                                  ],
                                );
                              });
                        },
                        // writeFollowClick: widget.writeFollowClick,
                        // cellReportClick: widget.cellReportClick,
                      );
                    },
                  ),
                )),
            Positioned(
                left: 0,
                top: 0,
                child: GestureDetector(
                  onTap: () {
                    if (selectExpand) {
                      setState(() {
                        selectExpand = !selectExpand;
                      });
                    }
                  },
                  child: Container(
                    color: selectExpand
                        ? Color.fromRGBO(0, 0, 0, 0.3)
                        : Colors.transparent,
                    width: SizeConfig.screenWidth,
                    alignment: Alignment.topLeft,
                    height: selectExpand ? SizeConfig.screenHeight : 40,
                    child: Row(
                      children: [
                        topButton(value1['title'], () {
                          setState(() {
                            currentSelectIndex = 1;
                            selectExpand = !selectExpand;
                          });
                        }),
                        topButton(value2['title'], () {
                          setState(() {
                            currentSelectIndex = 2;
                            selectExpand = !selectExpand;
                          });
                        }),
                        topButton(value3['title'], () {
                          setState(() {
                            currentSelectIndex = 3;
                            selectExpand = !selectExpand;
                          });
                        })
                      ],
                    ),
                  ),
                )),
            selectExpand
                ? Positioned(
                    top: 40,
                    left: 0,
                    child: selectList(selectData[key] ?? [], (Map item) {
                      switch (currentSelectIndex) {
                        case 1:
                          value1 = item;
                          break;
                        case 2:
                          value2 = item;
                          break;
                        case 3:
                          value3 = item;
                          break;
                      }
                      setState(() {
                        selectExpand = false;
                      });
                      if (value1['value'] != '-1') {
                        clientPoolParams['desireId'] = value1['value'] is int
                            ? value1['value']
                            : int.parse(value1['value']);
                      } else {
                        clientPoolParams.remove('desireId');
                      }
                      if (value2['value'] != '-1') {
                        clientPoolParams['typeId'] = value2['value'] is int
                            ? value2['value']
                            : int.parse(value2['value']);
                      } else {
                        clientPoolParams.remove('typeId');
                      }
                      if (value3['value'] != '-1') {
                        clientPoolParams['areaId'] = value3['value'] is int
                            ? value3['value']
                            : int.parse(value3['value']);
                      } else {
                        clientPoolParams.remove('areaId');
                      }
                      // print('clientPoolParams ==== $clientPoolParams');
                      pullCtr.callRefresh();
                    }),
                  )
                : Container(width: 0.0, height: 0.0)
          ]),
        ));
  }

  Widget topButton(String title, void Function() click) {
    return GestureDetector(
      onTap: click,
      child: Container(
        decoration: BoxDecoration(
            color: Colors.white,
            border:
                Border(bottom: BorderSide(width: 0.5, color: jm_line_color))),
        width: SizeConfig.screenWidth / 3,
        height: 40,
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              title,
              style: TextStyle(color: jm_text_black, fontSize: 14),
            ),
            SizedBox(
              width: SizeConfig.blockSizeHorizontal * 1.5,
            ),
            Icon(Icons.arrow_drop_down_outlined)
          ],
        ),
      ),
    );
  }

  Widget selectList(List data, void Function(Map value) itemClick) {
    List textButtons = [];
    double buttonHeight = 40;
    double cHeight = data.length % 2 == 0
        ? (data.length / 2) * buttonHeight
        : (data.length ~/ 2 + 1) * buttonHeight;
    for (var i = 0; i < data.length; i++) {
      Map e = data[i];
      Widget button = TextButton(
        onPressed: () {
          itemClick(e);
        },
        child: Text(e['title'],
            style: TextStyle(fontSize: 14, color: jm_text_black)),
      );
      textButtons.add(button);
    }
    return Container(
      width: SizeConfig.screenWidth,
      height: cHeight,
      color: Colors.white,
      child: GridView.count(
        //水平子Widget之间间距
        // crossAxisSpacing: 0.0,
        //垂直子Widget之间间距
        // mainAxisSpacing: 1.0,
        //GridView内边距
        padding: EdgeInsets.all(0.0),
        //一行的Widget数量
        crossAxisCount: 2,
        //子Widget宽高比例
        childAspectRatio: SizeConfig.screenWidth / 2.0 / buttonHeight,
        //子Widget列表
        children: [...textButtons],
      ),
    );
  }
}
