import 'package:JMrealty/Client/ClientPoolList.dart';
import 'package:JMrealty/Client/viewModel/ClientPoolViewModel.dart';
import 'package:JMrealty/const/Default.dart';
import 'package:JMrealty/utils/EventBus.dart';
import 'package:JMrealty/utils/notify_default.dart';
import 'package:JMrealty/utils/sizeConfig.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class ClientPool extends StatefulWidget {
  @override
  _ClientPoolState createState() => _ClientPoolState();
}

class _ClientPoolState extends State<ClientPool> {
  EventBus _eventBus = EventBus();
  int currentSelectIndex = 1;
  double filterBarHeight = 50;
  Map selectData = Map<String, dynamic>.from({});
  Map value1 = {'title': '级别', 'value': '-1'};
  Map value2 = {'title': '类型', 'value': '-1'};
  Map value3 = {'title': '面积', 'value': '-1'};
  bool selectExpand = false;
  List clientList = [];
  Map clientData = Map<String, dynamic>.from({});
  Map clientPoolParams = Map<String, dynamic>.from({});
  ClientPoolViewModel clientPoolVM = ClientPoolViewModel();
  @override
  void initState() {
    clientPoolVM.loadSelectData((Map data) {
      setState(() {
        selectData = Map<String, dynamic>.from(data);
      });
    });

    super.initState();
  }

  @override
  void dispose() {
    _eventBus.off(NOTIFY_CLIENT_POOL_LIST_REFRASH);
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
          flexibleSpace: Container(
            decoration: BoxDecoration(
                image: DecorationImage(
                    fit: BoxFit.fill,
                    image: AssetImage('assets/images/icon/bg_appbar_01.png'))),
          ),
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
          child: DefaultTabController(
            length: 2,
            child: Stack(children: [
              Positioned(
                  left: 0,
                  right: 0,
                  top: 0,
                  height: filterBarHeight,
                  child: Container(
                    width: SizeConfig.screenWidth,
                    height: filterBarHeight,
                    decoration: BoxDecoration(
                        border: Border(
                            bottom:
                                BorderSide(width: 0.5, color: jm_line_color))),
                    child: TabBar(
                      indicatorSize: TabBarIndicatorSize.tab,
                      indicatorColor: jm_appTheme,
                      indicatorWeight: 3.0,
                      indicatorPadding: EdgeInsets.symmetric(
                          horizontal: SizeConfig.blockSizeHorizontal * 23),
                      tabs: [
                        Tab(
                          child: Text(
                            '服 务 点',
                            style: jm_text_black_style15,
                          ),
                        ),
                        Tab(
                          child: Text(
                            '市级客户池',
                            style: jm_text_black_style15,
                          ),
                        ),
                      ],
                    ),
                  )),
              Positioned(
                  left: 0,
                  right: 0,
                  top: 80,
                  bottom: 0,
                  child: TabBarView(children: [
                    ClientPoolList(
                      clientPoolParams: clientPoolParams,
                      poolType: 0,
                    ),
                    ClientPoolList(
                      clientPoolParams: clientPoolParams,
                      poolType: 1,
                    ),
                  ])),
              Positioned(
                  left: 0,
                  top: filterBarHeight,
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
                      height: selectExpand ? SizeConfig.screenHeight : filterBarHeight,
                      child: Row(
                        children: [
                          topButton(
                              value1['title'] == '全部' ? '级别' : value1['title'],
                              () {
                            setState(() {
                              currentSelectIndex = 1;
                              selectExpand = !selectExpand;
                            });
                          }),
                          topButton(
                              value2['title'] == '全部' ? '类型' : value2['title'],
                              () {
                            setState(() {
                              currentSelectIndex = 2;
                              selectExpand = !selectExpand;
                            });
                          }),
                          topButton(
                              value3['title'] == '全部' ? '面积' : value3['title'],
                              () {
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
                      top: 80,
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
                        _eventBus.emit(NOTIFY_CLIENT_POOL_LIST_REFRASH);
                        // print('clientPoolParams ==== $clientPoolParams');
                      }),
                    )
                  : Container(width: 0.0, height: 0.0)
            ]),
          ),
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
        height: filterBarHeight,
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
    double buttonHeight = filterBarHeight;
    // double cHeight = data.length % 2 == 0
    //     ? (data.length / 2) * buttonHeight
    //     : (data.length ~/ 2 + 1) * buttonHeight;
    for (var i = 0; i < data.length; i++) {
      Map e = data[i];
      Widget button = RawMaterialButton(
        constraints: BoxConstraints(
            minHeight: buttonHeight, minWidth: SizeConfig.screenWidth),
        onPressed: () {
          itemClick(e);
        },
        child: Container(
          width: SizeConfig.screenWidth,
          height: buttonHeight,
          alignment: Alignment.centerLeft,
          padding: EdgeInsets.only(left: SizeConfig.blockSizeHorizontal * 12),
          child: Text(e['title'],
              style: TextStyle(fontSize: 14, color: jm_text_black)),
        ),
      );
      textButtons.add(button);
    }
    return Container(
      width: SizeConfig.screenWidth,
      // height: cHeight,
      color: Colors.white,
      child: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [...textButtons],
        ),
      ),
      // child: GridView.count(
      //   //水平子Widget之间间距
      //   // crossAxisSpacing: 0.0,
      //   //垂直子Widget之间间距
      //   // mainAxisSpacing: 1.0,
      //   //GridView内边距
      //   padding: EdgeInsets.all(0.0),
      //   //一行的Widget数量
      //   crossAxisCount: 2,
      //   //子Widget宽高比例
      //   childAspectRatio: SizeConfig.screenWidth / 2.0 / buttonHeight,
      //   //子Widget列表
      //   children: [...textButtons],
      // ),
    );
  }
}
