import 'package:JMrealty/Client/components/WaitFollowUpCell.dart';
import 'package:JMrealty/Client/viewModel/ClientPoolViewModel.dart';
import 'package:JMrealty/base/base_viewmodel.dart';
import 'package:JMrealty/base/provider_widget.dart';
import 'package:JMrealty/components/ShowLoading.dart';
import 'package:JMrealty/const/Default.dart';
import 'package:JMrealty/utils/sizeConfig.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class ClientPool extends StatefulWidget {
  @override
  _ClientPoolState createState() => _ClientPoolState();
}

class _ClientPoolState extends State<ClientPool> {
  ClientPoolViewModel clientPoolVM;
  int currentSelectIndex;
  Map selectData;
  Map value1;
  Map value2;
  Map value3;
  bool selectExpand;
  @override
  void initState() {
    currentSelectIndex = 1;
    value1 = {'title': '级别', 'value': '9'};
    value2 = {'title': '类型', 'value': '9'};
    value3 = {'title': '面积', 'value': '9'};
    selectExpand = false;
    clientPoolVM = ClientPoolViewModel();
    clientPoolVM.loadSelectData((Map data) {
      setState(() {
        selectData = Map.from(data);
        // print('selectdata === $selectData');
      });
    });
    super.initState();
  }

  @override
  void dispose() {
    // clientPoolVM.dispose();
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
              child: ProviderWidget<ClientPoolViewModel>(
                  model: clientPoolVM,
                  onReady: (model) {
                    model.loadClientPoolList();
                  },
                  builder: (ctx, model, child) {
                    if (model.state == BaseState.CONTENT) {
                      List clientList = model.listData['rows'];
                      // print(
                      //     'model.listData[widget.status.index] === ${model.listData[widget.status.index.toString()]}');
                      return ListView.builder(
                        itemCount: clientList.length,
                        // itemCount: model.listData.length,
                        itemBuilder: (context, index) {
                          return WaitFollowUpCell(
                            model: clientList[index],
                            index: index,
                            pool: true,
                            takeOrderClick: (Map data) {
                              // print('data === ${data['id']}');

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
                                              clientPoolVM.takeClientRequest(
                                                  data['id'], () {
                                                Navigator.pop(context);
                                                clientPoolVM
                                                    .loadClientPoolList();
                                              });
                                            },
                                            child: Text(
                                              '确认',
                                              style: TextStyle(
                                                  fontSize: 14,
                                                  color: jm_text_black),
                                            )),
                                        TextButton(
                                            onPressed: () {
                                              Navigator.pop(context);
                                            },
                                            child: Text(
                                              '取消',
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
                      );
                    } else if (model.state == BaseState.LOADING) {
                      return ShowLoading();
                    } else {
                      return Container();
                    }
                  }),
            ),
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
