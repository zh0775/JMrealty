import 'package:JMrealty/Client/AddClientVC.dart';
import 'package:JMrealty/Client/ClientDetail.dart';
import 'package:JMrealty/Client/components/WaitFollowUpCell.dart';
import 'package:JMrealty/Client/components/WriteFollow.dart';
import 'package:JMrealty/Client/viewModel/ClientListSelectViewModel.dart';
import 'package:JMrealty/Client/viewModel/ClientListViewModel.dart';
import 'package:JMrealty/Report/AddReport.dart';
import 'package:JMrealty/components/CustomAlert.dart';
import 'package:JMrealty/components/CustomPullHeader.dart';
import 'package:JMrealty/components/EmptyView.dart';
import 'package:JMrealty/components/NoneV.dart';
import 'package:JMrealty/const/Default.dart';
import 'package:JMrealty/utils/EventBus.dart';
import 'package:JMrealty/utils/notify_default.dart';
import 'package:JMrealty/utils/sizeConfig.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_easyrefresh/easy_refresh.dart';

class Client extends StatefulWidget {
  final IndexClick indexClick;
  const Client({this.indexClick});
  @override
  _ClientState createState() => _ClientState();
}

class _ClientState extends State<Client> {
  int waitFollowCount = 8;
  bool selectExpand = false;
  int currentSelectIndex;
  Map value1 = {'title': '级别', 'value': '-1'};
  Map value2 = {'title': '类型', 'value': '-1'};
  Map value3 = {'title': '面积', 'value': '-1'};
  Map selectData;
  EventBus eventBus = EventBus();
  ClientListSelect1ViewModel topSelectVM = ClientListSelect1ViewModel();
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
  CellClientOpenClick cellClientOpenClick;
  CellReportClick cellReportClick =
      (ClientStatus status, int index, Map model, BuildContext context) {
    Navigator.of(context).push(CupertinoPageRoute(builder: (_) {
      return AddReport(
        userData: model,
      );
    }));
    print(
        'cellReportClick status === $status --- index === $index --- model === $model');
  };
  @override
  void initState() {
    eventBus.on(NOTIFY_LOGIN_SUCCESS, (arg) {
      refrashList();
    });
    eventBus.on(NOTIFY_CLIENTWAIT_COUNT, (arg) {
      if (mounted) {
        setState(() {
          waitFollowCount = arg;
        });
      }
    });
    topSelectVM.loadSelectData(success: (data) {
      setState(() {
        selectData = data;
      });
    });
    cellClientOpenClick =
        (ClientStatus status, int index, Map model, BuildContext context) {
      CustomAlert(content: '是否公开到客户池').show(
        confirmClick: () {
          topSelectVM.customToPullRequest(model['id'], (success) {
            if (success) {
              refrashList();
            }
          });
        },
      );
    };
    writeFollowClick =
        (ClientStatus status, int index, Map model, BuildContext context) {
      WriteFollow(
        clientData: model,
        addFollowConfirm: () {
          refrashList();
        },
      ).loadNextFollow();
      print(
          'writeFollowClick status === $status --- index === $index --- model === $model');
    };
    super.initState();
  }

  @override
  void dispose() {
    eventBus.off(NOTIFY_LOGIN_SUCCESS);
    eventBus.off(NOTIFY_CLIENTWAIT_COUNT);
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    SizeConfig().init(context);
    return DefaultTabController(
      length: 5,
      child: Scaffold(
          appBar: AppBar(
            flexibleSpace: Container(
              decoration: BoxDecoration(
                  image: DecorationImage(
                      fit: BoxFit.fill,
                      image:
                          AssetImage('assets/images/icon/bg_appbar_01.png'))),
            ),
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
              indicatorPadding: EdgeInsets.only(bottom: 5, left: 13, right: 13),
              tabs: [
                Tab(
                    child: Container(
                  width: 50,
                  height: 30,
                  alignment: Alignment.center,
                  child: Stack(
                    overflow: Overflow.visible,
                    children: [
                      Text(
                        '待跟进',
                        style: TextStyle(fontSize: 14, color: Colors.white),
                      ),
                      waitFollowCount > 0
                          ? Positioned(
                              right: -11,
                              top: -6,
                              child: Container(
                                width: 18,
                                height: 18,
                                alignment: Alignment.center,
                                decoration: BoxDecoration(
                                    color: Colors.red,
                                    borderRadius: BorderRadius.circular(9)),
                                child: Text(
                                  waitFollowCount.toString(),
                                  style: TextStyle(
                                      color: Colors.white, fontSize: 10),
                                ),
                              ))
                          : NoneV()
                    ],
                  ),
                )),
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
                    '公开',
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
                        writeFollowClick: writeFollowClick,
                        cellClientOpenClick: cellClientOpenClick,
                      ),
                      ClientList(
                          status: ClientStatus.already,
                          selectedForRowAtIndex: selectedForRowAtIndex,
                          cellReportClick: cellReportClick,
                          writeFollowClick: writeFollowClick,
                          cellClientOpenClick: cellClientOpenClick),
                      ClientList(
                          status: ClientStatus.order,
                          selectedForRowAtIndex: selectedForRowAtIndex,
                          cellReportClick: cellReportClick,
                          writeFollowClick: writeFollowClick,
                          cellClientOpenClick: cellClientOpenClick),
                      ClientList(
                          status: ClientStatus.deal,
                          selectedForRowAtIndex: selectedForRowAtIndex,
                          cellReportClick: cellReportClick,
                          writeFollowClick: writeFollowClick,
                          cellClientOpenClick: cellClientOpenClick),
                      ClientList(
                          status: ClientStatus.water,
                          selectedForRowAtIndex: selectedForRowAtIndex,
                          cellReportClick: cellReportClick,
                          writeFollowClick: writeFollowClick,
                          cellClientOpenClick: cellClientOpenClick),
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
                            topButton(
                                value1['title'] == '全部'
                                    ? '级别'
                                    : value1['title'], () {
                              setState(() {
                                currentSelectIndex = 1;
                                selectExpand = !selectExpand;
                              });
                            }),
                            topButton(
                                value2['title'] == '全部'
                                    ? '类型'
                                    : value2['title'], () {
                              setState(() {
                                currentSelectIndex = 2;
                                selectExpand = !selectExpand;
                              });
                            }),
                            topButton(
                                value3['title'] == '全部'
                                    ? '面积'
                                    : value3['title'], () {
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
    // double cHeight = data.length % 2 == 0
    //     ? (data.length / 2) * buttonHeight
    //     : (data.length ~/ 2 + 1) * buttonHeight;
    for (var i = 0; i < data.length; i++) {
      Map e = data[i];
      Widget button = RawMaterialButton(
        onPressed: () {
          itemClick(e);
        },

        // constraints: BoxConstraints(minWidth: SizeConfig.screenWidth),
        child: Container(
          width: SizeConfig.screenWidth - SizeConfig.blockSizeHorizontal * 6,
          height: buttonHeight,
          margin: EdgeInsets.only(left: SizeConfig.blockSizeHorizontal * 6),
          alignment: Alignment.centerLeft,
          child: Text(e['title'],
              textAlign: TextAlign.left,
              style: TextStyle(fontSize: 14, color: jm_text_black)),
        ),
      );
      textButtons.add(button);
    }
    return SingleChildScrollView(
      child: Container(
        width: SizeConfig.screenWidth,
        // height: cHeight,
        color: Colors.white,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [...textButtons],
        ),
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
      refrashList();
    });
  }

  refrashList() {
    Map params = {};
    if (value1['value'] != '-1') {
      params['desireId'] =
          value1['value'] is int ? value1['value'] : int.parse(value1['value']);
    }
    if (value2['value'] != '-1') {
      params['typeId'] =
          value2['value'] is int ? value2['value'] : int.parse(value2['value']);
    }
    if (value3['value'] != '-1') {
      params['areaId'] =
          value3['value'] is int ? value3['value'] : int.parse(value3['value']);
    }
    print('params ==== $params');
    eventBus.emit(NOTIFY_CLIENT_LIST_REFRASH, params);
  }
}

class ClientList extends StatefulWidget {
  final WriteFollowClick writeFollowClick;
  final CellReportClick cellReportClick;
  final CellClientOpenClick cellClientOpenClick;
  final ClientStatus status;
  final SelectedForRowAtIndex selectedForRowAtIndex;
  ClientList({
    @required this.status,
    this.selectedForRowAtIndex,
    this.cellReportClick,
    this.writeFollowClick,
    this.cellClientOpenClick,
  });
  @override
  _ClientListState createState() => _ClientListState();
}

class _ClientListState extends State<ClientList>
    with AutomaticKeepAliveClientMixin {
  GlobalKey pullHeaderKey = GlobalKey();
  EventBus eventBus = EventBus();
  GlobalKey easyRefreshKey = GlobalKey();
  EasyRefreshController pullCtr = EasyRefreshController();
  ClientListViewModel listModel = ClientListViewModel();
  List listData = [];
  Map statusParams;
  int totalData = 0;

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
    statusParams = Map<String, dynamic>.from(
        {'status': status, 'pageNum': 1, 'pageSize': 10});
    loadList();
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

      loadList();
    });
    eventBus.on(NOTIFY_CLIENT_LIST_REFRASH_NORMAL, (arg) {
      loadList();
    });
    super.initState();
  }

  @override
  void dispose() {
    eventBus.off(NOTIFY_CLIENT_LIST_REFRASH_NORMAL);
    eventBus.off(NOTIFY_CLIENT_LIST_REFRASH);
    // listModel.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    super.build(context);
    return EasyRefresh(
      controller: pullCtr,
      header: CustomPullHeader(key: pullHeaderKey),
      footer: MaterialFooter(backgroundColor: jm_appTheme),
      emptyWidget:
          listData == null || listData.length == 0 ? EmptyView() : null,
      key: easyRefreshKey,
      onRefresh: () async {
        print('statusParams ===== $statusParams');
        statusParams['pageNum'] = 1;
        loadList();
      },
      onLoad: listData != null && listData.length >= totalData
          ? null
          : () async {
              statusParams['pageNum'] += 1;
              loadList(isLoad: true);
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
            cellClientOpenClick: widget.cellClientOpenClick,
          );
        },
      ),
    );
  }

  loadList({bool isLoad = false}) {
    listModel.loadClientList(statusParams, success: (data, total) {
      if (mounted) {
        setState(() {
          totalData = total;
          if (isLoad) {
            listData.addAll(data);
          } else {
            listData = data;
          }
        });
      }
    });
  }

  @override
  bool get wantKeepAlive => true;
}
