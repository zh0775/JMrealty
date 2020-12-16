import 'package:JMrealty/Client/AddClientVC.dart';
import 'package:JMrealty/Client/ClientDetail.dart';
import 'package:JMrealty/Client/components/WaitFollowUpCell.dart';
import 'package:JMrealty/Client/components/WriteFollow.dart';
import 'package:JMrealty/Client/viewModel/ClientListSelectViewModel.dart';
import 'package:JMrealty/Client/viewModel/ClientListViewModel.dart';
import 'package:JMrealty/components/EmptyView.dart';
import 'package:JMrealty/const/Default.dart';
import 'package:JMrealty/utils/EventBus.dart';
import 'package:JMrealty/utils/notify_default.dart';
import 'package:JMrealty/utils/sizeConfig.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_easyrefresh/easy_refresh.dart';

class Client extends StatefulWidget {
  @override
  _ClientState createState() => _ClientState();
}

class _ClientState extends State<Client> {
  bool selectExpand;
  int currentSelectIndex;
  Map value1;
  Map value2;
  Map value3;
  Map selectData;
  EventBus eventBus = EventBus();
  ClientListSelect1ViewModel topSelectVM;
  SelectedForRowAtIndex selectedForRowAtIndex =
      (ClientStatus status, int index, Map model, BuildContext context) {
    Navigator.of(context).push(CupertinoPageRoute(builder: (_) {
      return ClientDetail(
        clientData: model,
      );
    }));
    // print('status === $status --- index === $index --- model === $model');
  };
  WriteFollowClick writeFollowClick;
  CellReportClick cellReportClick =
      (ClientStatus status, int index, Map model, BuildContext context) {
    print(
        'cellReportClick status === $status --- index === $index --- model === $model');
  };
  @override
  void initState() {
    selectExpand = false;
    value1 = {'title': '级别', 'value': '-1'};
    value2 = {'title': '类型', 'value': '-1'};
    value3 = {'title': '面积', 'value': '-1'};
    topSelectVM = ClientListSelect1ViewModel();
    topSelectVM.loadSelectData(success: (data) {
      setState(() {
        selectData = data;
      });
    });
    writeFollowClick =
        (ClientStatus status, int index, Map model, BuildContext context) {
      WriteFollow(
        clientData: model,
        addFollowConfirm: () {
          eventBus.emit(NOTIFY_CLIENT_LIST_REFRASH_NORMAL);
        },
      ).loadNextFollow();
      print(
          'writeFollowClick status === $status --- index === $index --- model === $model');
    };
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    SizeConfig().init(context);
    return DefaultTabController(
      length: 5,
      child: Scaffold(
          appBar: AppBar(
            centerTitle: true,
            backgroundColor: jm_appTheme,
            automaticallyImplyLeading: false,
            title: Text(
              '客户',
              style: TextStyle(color: Colors.white, fontSize: 22),
            ),
            actions: [
              IconButton(
                  icon: Icon(
                    Icons.add_circle_outline,
                    color: Colors.white,
                    size: 30,
                  ),
                  onPressed: () {
                    Navigator.of(context).push(CupertinoPageRoute(builder: (_) {
                      return AddClientVC();
                    }));
                  })
            ],
            bottom: TabBar(
              indicatorSize: TabBarIndicatorSize.label,
              indicatorColor: Colors.white,
              indicatorWeight: 2.0,
              indicatorPadding: EdgeInsets.only(bottom: 5),
              tabs: [
                Tab(
                  child: Text(
                    '待跟进',
                    style: TextStyle(fontSize: 14, color: Colors.white),
                  ),
                ),
                Tab(
                  child: Text(
                    '已带看',
                    style: TextStyle(fontSize: 14, color: Colors.white),
                  ),
                ),
                Tab(
                  child: Text(
                    '已预约',
                    style: TextStyle(fontSize: 14, color: Colors.white),
                  ),
                ),
                Tab(
                  child: Text(
                    '已成交',
                    style: TextStyle(fontSize: 14, color: Colors.white),
                  ),
                ),
                Tab(
                  child: Text(
                    '水客',
                    style: TextStyle(fontSize: 14, color: Colors.white),
                  ),
                )
              ],
            ),
          ),
          backgroundColor: Colors.white,
          body: Container(
            width: double.infinity,
            height: double.infinity,
            child: Stack(
              children: [
                Positioned(
                  top: 40,
                  left: 0,
                  width: SizeConfig.screenWidth,
                  bottom: 0,
                  child: TabBarView(
                    children: [
                      ClientList(
                          status: ClientStatus.wait,
                          selectedForRowAtIndex: selectedForRowAtIndex,
                          cellReportClick: cellReportClick,
                          writeFollowClick: writeFollowClick),
                      ClientList(
                          status: ClientStatus.already,
                          selectedForRowAtIndex: selectedForRowAtIndex,
                          cellReportClick: cellReportClick,
                          writeFollowClick: writeFollowClick),
                      ClientList(
                          status: ClientStatus.order,
                          selectedForRowAtIndex: selectedForRowAtIndex,
                          cellReportClick: cellReportClick,
                          writeFollowClick: writeFollowClick),
                      ClientList(
                          status: ClientStatus.deal,
                          selectedForRowAtIndex: selectedForRowAtIndex,
                          cellReportClick: cellReportClick,
                          writeFollowClick: writeFollowClick),
                      ClientList(
                          status: ClientStatus.water,
                          selectedForRowAtIndex: selectedForRowAtIndex,
                          cellReportClick: cellReportClick,
                          writeFollowClick: writeFollowClick),
                    ],
                  ),
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
                    ? Positioned(top: 40, left: 0, child: getSelectView())
                    : Container(width: 0.0, height: 0.0)
              ],
            ),
          )),
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

  Widget getSelectView() {
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
    return selectList(selectData != null ? selectData[key] ?? [] : [],
        (Map item) {
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
      Map params = {};
      if (value1['value'] != '-1') {
        params['desireId'] = value1['value'] is int
            ? value1['value']
            : int.parse(value1['value']);
      }
      if (value2['value'] != '-1') {
        params['typeId'] = value2['value'] is int
            ? value2['value']
            : int.parse(value2['value']);
      }
      if (value3['value'] != '-1') {
        params['areaId'] = value3['value'] is int
            ? value3['value']
            : int.parse(value3['value']);
      }
      print('params ==== $params');
      eventBus.emit(NOTIFY_CLIENT_LIST_REFRASH, params);
    });
  }
}

class ClientList extends StatefulWidget {
  final WriteFollowClick writeFollowClick;
  final CellReportClick cellReportClick;
  final ClientStatus status;
  final SelectedForRowAtIndex selectedForRowAtIndex;
  ClientList(
      {@required this.status,
      this.selectedForRowAtIndex,
      this.cellReportClick,
      this.writeFollowClick});
  @override
  _ClientListState createState() => _ClientListState();
}

class _ClientListState extends State<ClientList>
    with AutomaticKeepAliveClientMixin {
  EventBus eventBus;
  GlobalKey easyRefreshKey = GlobalKey();
  EasyRefreshController pullCtr;
  ClientListViewModel listModel;
  List listData;
  Map statusParams;

  @override
  void initState() {
    int status = 0;
    switch (widget.status) {
      case ClientStatus.wait:
        status = 0;
        break;
      case ClientStatus.already:
        status = 10;
        break;
      case ClientStatus.order:
        status = 20;
        break;
      case ClientStatus.deal:
        status = 30;
        break;
      case ClientStatus.water:
        status = 40;
        break;
      default:
    }
    statusParams = Map<String, dynamic>.from({'status': status});
    pullCtr = EasyRefreshController();
    listModel = ClientListViewModel();
    listModel.loadClientList(statusParams, success: (data) {
      setState(() {
        listData = data;
      });
    });
    eventBus = EventBus();
    eventBus.on(NOTIFY_CLIENT_LIST_REFRASH, (arg) {
      if (arg['desireId'] != null) {
        statusParams['desireId'] = arg['desireId'];
      } else {
        statusParams.remove('desireId');
      }
      if (arg['areaId'] != null) {
        statusParams['areaId'] = arg['areaId'];
      } else {
        statusParams.remove('areaId');
      }
      if (arg['typeId'] != null) {
        statusParams['typeId'] = arg['typeId'];
      } else {
        statusParams.remove('typeId');
      }
      pullCtr.callRefresh();
    });
    eventBus.on(NOTIFY_CLIENT_LIST_REFRASH_NORMAL, (arg) {
      pullCtr.callRefresh();
    });
    super.initState();
  }

  @override
  void dispose() {
    // listModel.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    super.build(context);
    return EasyRefresh(
      controller: pullCtr,
      emptyWidget:
          listData == null || listData.length == 0 ? EmptyView() : null,
      key: easyRefreshKey,
      onRefresh: () async {
        print('statusParams ===== $statusParams');
        listModel.loadClientList(statusParams, success: (data) {
          pullCtr.finishRefresh();
          setState(() {
            listData = data;
          });
        });
      },
      child: ListView.builder(
        itemCount: listData == null ? 0 : listData.length,
        itemBuilder: (context, index) {
          return WaitFollowUpCell(
            model: listData[index],
            status: widget.status,
            index: index,
            selectedForRowAtIndex: widget.selectedForRowAtIndex,
            writeFollowClick: widget.writeFollowClick,
            cellReportClick: widget.cellReportClick,
          );
        },
      ),
    );
  }

  @override
  bool get wantKeepAlive => true;
}
