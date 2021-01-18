import 'package:JMrealty/MyTasks/AddTask.dart';
import 'package:JMrealty/MyTasks/MyTasksList.dart';
import 'package:JMrealty/MyTasks/components/taskSelectButton.dart';
import 'package:JMrealty/MyTasks/viewModel/MyTasksViewModel.dart';
import 'package:JMrealty/components/NoneV.dart';
import 'package:JMrealty/const/Default.dart';
import 'package:JMrealty/utils/EventBus.dart';
import 'package:JMrealty/utils/notify_default.dart';
import 'package:JMrealty/utils/sizeConfig.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class MyTasks extends StatefulWidget {
  @override
  _MyTasksState createState() => _MyTasksState();
}

class _MyTasksState extends State<MyTasks> {
  Map<String, dynamic> listParams = Map<String, dynamic>.from({});
  Map value1 = {'title': '任务类型', 'value': -1};
  MyTasksViewModel myTaskVM = MyTasksViewModel();
  double topStatusBarHeight = 20;
  double appBarBottomHeight = 40;
  double widthScale;
  int topIndex = 0;
  int statusIndex = 1;
  bool showSelect = false;
  EventBus _eventBus = EventBus();
  List taskTypeList = [];
  // MyTasksViewModel tasksVM = MyTasksViewModel();
  // EasyRefreshController pullCtr = EasyRefreshController();
  // GlobalKey _easyRefreshKey = GlobalKey();
  // List tasksListData = [];

  @override
  void initState() {
    myTaskVM.loadTasksUrgency((data, success) {
      if (success && mounted) {
        setState(() {
          taskTypeList = data;
        });
      }
    });
    super.initState();
  }

  @override
  void dispose() {
    // _eventBus.off(NOTIFY_TASKS_LIST_REFRASH);
    // pullCtr.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    SizeConfig().init(context);
    widthScale = SizeConfig.blockSizeHorizontal;
    return DefaultTabController(
        length: 3,
        child: Scaffold(
            appBar: AppBar(
              flexibleSpace: Container(
                decoration: BoxDecoration(
                    image: DecorationImage(
                        fit: BoxFit.fill,
                        image:
                            AssetImage('assets/images/icon/bg_appbar_01.png'))),
              ),
              title: TaskSelectButton(
                clickIndex: (clickIndex) {
                  setState(() {
                    topIndex = clickIndex;
                  });
                  _eventBus
                      .emit(NOTIFY_TASKS_LIST_REFRASH, {'topIndex': topIndex});
                },
              ),
              leading: IconButton(
                icon: jm_naviBack_icon,
                onPressed: () {
                  Navigator.pop(context);
                },
              ),
              actions: [
                IconButton(
                    icon: Icon(
                      Icons.add_circle_outline,
                      size: 30,
                      color: Colors.white,
                    ),
                    onPressed: () {
                      Navigator.of(context)
                          .push(CupertinoPageRoute(builder: (_) {
                        return AddTask();
                      }));
                    })
              ],
              bottom: TabBar(
                indicatorSize: TabBarIndicatorSize.tab,
                indicatorColor: Colors.white,
                indicatorWeight: 4.0,
                indicatorPadding:
                    EdgeInsets.symmetric(horizontal: widthScale * 14),
                tabs: [
                  Tab(
                    child: Text(
                      '未完成',
                      style: TextStyle(fontSize: 14, color: Colors.white),
                    ),
                  ),
                  Tab(
                    child: Text(
                      '已延期',
                      style: TextStyle(fontSize: 14, color: Colors.white),
                    ),
                  ),
                  Tab(
                    child: Text(
                      '已完成',
                      style: TextStyle(fontSize: 14, color: Colors.white),
                    ),
                  ),
                ],
              ),
            ),
            body: Container(
              width: SizeConfig.screenWidth,
              height: double.infinity,
              child: Stack(
                children: [
                  Positioned(
                      top: 40,
                      left: 0,
                      right: 0,
                      bottom: 0,
                      child: TabBarView(
                        children: [
                          MyTasksList(
                            topIndex: topIndex,
                            status: 1,
                          ),
                          MyTasksList(
                            topIndex: topIndex,
                            status: 4,
                          ),
                          MyTasksList(
                            topIndex: topIndex,
                            status: 3,
                          )
                        ],
                      )),
                  Positioned(
                      top: 0,
                      left: 0,
                      child: GestureDetector(
                        onTap: () {
                          if (showSelect) {
                            setState(() {
                              showSelect = !showSelect;
                            });
                          }
                        },
                        child: Container(
                          decoration: BoxDecoration(
                              color: showSelect
                                  ? Color.fromRGBO(0, 0, 0, 0.3)
                                  : Colors.white,
                              border: Border(
                                  bottom: BorderSide(
                                      width: 0.5, color: jm_line_color))),
                          height: showSelect ? SizeConfig.screenHeight : 40,
                          width: SizeConfig.screenWidth,
                          alignment: Alignment.topLeft,
                          child: Row(
                            children: [
                              topButton(
                                  value1['title'] == '全部'
                                      ? '任务类型'
                                      : value1['title'], () {
                                setState(() {
                                  showSelect = !showSelect;
                                });
                              }),
                              Expanded(
                                  child: Container(
                                height: 40,
                                color: Colors.white,
                              )),
                            ],
                          ),
                        ),
                      )),
                  showSelect
                      ? Positioned(
                          top: 40,
                          left: 0,
                          right: 0,
                          child: selectList(taskTypeList ?? [], (Map item) {
                            value1 = item;
                            _eventBus.emit(NOTIFY_TASKS_LIST_REFRASH,
                                {'type': value1['value']});
                            setState(() {
                              showSelect = false;
                            });
                          }))
                      : NoneV()
                ],
              ),
            )));
  }

  Widget topButton(String title, void Function() click) {
    return GestureDetector(
      onTap: click,
      child: Container(
        decoration: BoxDecoration(
          color: Colors.white,
          // border:
          //     Border(bottom: BorderSide(width: 0.5, color: jm_line_color))
        ),
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
    );
  }
}
