import 'package:JMrealty/Client/AddClientVC.dart';
import 'package:JMrealty/Client/ClientDetail.dart';
import 'package:JMrealty/Client/components/WaitFollowUpCell.dart';
import 'package:JMrealty/Client/components/WriteFollow.dart';
import 'package:JMrealty/Client/viewModel/ClientListSelectViewModel.dart';
import 'package:JMrealty/Client/viewModel/ClientListViewModel.dart';
import 'package:JMrealty/base/base_viewmodel.dart';
import 'package:JMrealty/base/provider_widget.dart';
import 'package:JMrealty/const/Default.dart';
import 'package:JMrealty/utils/sizeConfig.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class Client extends StatefulWidget {
  @override
  _ClientState createState() => _ClientState();
}

class _ClientState extends State<Client> {
  SelectedForRowAtIndex selectedForRowAtIndex =
      (ClientStatus status, int index, Map model, BuildContext context) {
    Navigator.of(context).push(CupertinoPageRoute(builder: (_) {
      return ClientDetail(
        clientData: model,
      );
    }));
    // print('status === $status --- index === $index --- model === $model');
  };
  WriteFollowClick writeFollowClick =
      (ClientStatus status, int index, Map model, BuildContext context) {
    WriteFollow(
      clientData: model,
      addFollowConfirm: () {},
    ).loadNextFollow();
    print(
        'writeFollowClick status === $status --- index === $index --- model === $model');
  };
  CellReportClick cellReportClick =
      (ClientStatus status, int index, Map model, BuildContext context) {
    print(
        'cellReportClick status === $status --- index === $index --- model === $model');
  };
  @override
  void initState() {
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
        body: TabBarView(
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
    );
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

class _ClientListState extends State<ClientList> {
  // ClientListSelect1ViewModel selectVM1;
  // ClientListSelect2ViewModel selectVM2;
  // ClientListSelect3ViewModel selectVM3;
  // ClientListSelect4ViewModel selectVM4;
  // ClientListSelect5ViewModel selectVM5;
  // Widget selectPullWidget;
  int currentSelectIndex;
  Map value1;
  Map value2;
  Map value3;
  bool selectExpand;
  @override
  void initState() {
    // selectVM1 = ClientListSelect1ViewModel();
    // selectVM2 = ClientListSelect2ViewModel();
    // selectVM3 = ClientListSelect3ViewModel();
    // selectVM4 = ClientListSelect4ViewModel();
    // selectVM5 = ClientListSelect5ViewModel();
    // selectVM1.loadSelectData();
    // selectVM2.loadSelectData();
    // selectVM3.loadSelectData();
    // selectVM4.loadSelectData();
    // selectVM5.loadSelectData();
    value1 = {'title': '级别', 'value': '9'};
    value2 = {'title': '类型', 'value': '9'};
    value3 = {'title': '面积', 'value': '9'};
    selectExpand = false;
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Stack(children: [
      Positioned(
        left: 0,
        right: 0,
        top: 40,
        bottom: 0,
        child: ProviderWidget<ClientListViewModel>(
            model: ClientListViewModel(),
            onReady: (model) {
              model.loadClientList(widget.status);
            },
            builder: (ctx, model, child) {
              // print(
              //     'model.listData[widget.status.index] === ${model.listData[widget.status.index.toString()]}');
              return ListView.builder(
                itemCount:
                    model.listData[widget.status.index.toString()] == null
                        ? 0
                        : model.listData[widget.status.index.toString()].length,
                itemBuilder: (context, index) {
                  return WaitFollowUpCell(
                    model:
                        (model.listData[widget.status.index.toString()])[index],
                    status: widget.status,
                    index: index,
                    selectedForRowAtIndex: widget.selectedForRowAtIndex,
                    writeFollowClick: widget.writeFollowClick,
                    cellReportClick: widget.cellReportClick,
                  );
                },
              );
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
              top: 40, left: 0, child: getProVider(widget.status.index))
          : Container(width: 0.0, height: 0.0)
    ]);
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

  Widget getProVider(index) {
    ProviderWidget widget;
    switch (index) {
      case 0:
        widget = ProviderWidget<ClientListSelect1ViewModel>(
          onReady: (model) {
            model.loadSelectData();
          },
          model: ClientListSelect1ViewModel(),
          builder: (ctx, model, child) {
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
            return selectList(
                model.state == BaseState.CONTENT ? model.selectData[key] : [],
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
            });
          },
        );
        break;
      case 1:
        widget = ProviderWidget<ClientListSelect2ViewModel>(
          onReady: (model) {
            model.loadSelectData();
          },
          model: ClientListSelect2ViewModel(),
          builder: (ctx, model, child) {
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
            return selectList(
                model.state == BaseState.CONTENT ? model.selectData[key] : [],
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
            });
          },
        );
        break;
      case 2:
        widget = ProviderWidget<ClientListSelect3ViewModel>(
          onReady: (model) {
            model.loadSelectData();
          },
          model: ClientListSelect3ViewModel(),
          builder: (ctx, model, child) {
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
            return selectList(
                model.state == BaseState.CONTENT ? model.selectData[key] : [],
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
            });
          },
        );
        break;
      case 3:
        widget = ProviderWidget<ClientListSelect4ViewModel>(
          onReady: (model) {
            model.loadSelectData();
          },
          model: ClientListSelect4ViewModel(),
          builder: (ctx, model, child) {
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
            return selectList(
                model.state == BaseState.CONTENT ? model.selectData[key] : [],
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
            });
          },
        );
        break;
      case 4:
        widget = ProviderWidget<ClientListSelect5ViewModel>(
          onReady: (model) {
            model.loadSelectData();
          },
          model: ClientListSelect5ViewModel(),
          builder: (ctx, model, child) {
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
            return selectList(
                model.state == BaseState.CONTENT ? model.selectData[key] : [],
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
            });
          },
        );
        break;
    }
    return widget;
  }

  @override
  void dispose() {
    super.dispose();
  }
}
