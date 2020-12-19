import 'package:JMrealty/MyTasks/AddTask.dart';
import 'package:JMrealty/MyTasks/MyTasksList.dart';
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
  Map<String, dynamic> listParams = Map<String, dynamic>.from({'status': 1});
  double topStatusBarHeight = 20;
  double appBarBottomHeight = 40;
  double widthScale;
  int topIndex = 0;
  int statusIndex = 1;
  EventBus _eventBus = EventBus();
  // MyTasksViewModel tasksVM = MyTasksViewModel();
  // EasyRefreshController pullCtr = EasyRefreshController();
  // GlobalKey _easyRefreshKey = GlobalKey();
  // List tasksListData = [];

  @override
  void dispose() {
    _eventBus.off(NOTIFY_TASKS_LIST_REFRASH);
    // pullCtr.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    SizeConfig().init(context);
    widthScale = SizeConfig.blockSizeHorizontal;
    return Scaffold(
      // appBar: AppBar(
      //     centerTitle: true,
      //     backgroundColor: jm_appTheme,
      //     automaticallyImplyLeading: false,
      //     title: Text(
      //       '我的任务',
      //       style: TextStyle(color: Colors.white, fontSize: 22),
      //     ),
      //     actions: [
      //       IconButton(
      //           icon: Icon(
      //             Icons.search,
      //             color: Colors.white,
      //             size: 30,
      //           ),
      //           onPressed: () {})
      //     ]),
      body: Container(
        width: SizeConfig.screenWidth,
        height: SizeConfig.screenHeight,
        child: Column(
          children: [
            Container(
              width: SizeConfig.screenWidth,
              height: kToolbarHeight + topStatusBarHeight + appBarBottomHeight,
              color: jm_appTheme,
              child: Stack(
                children: [
                  Positioned(
                      top: topStatusBarHeight,
                      left: 0,
                      child: IconButton(
                        icon: jm_naviBack_icon,
                        onPressed: () {
                          Navigator.pop(context);
                        },
                      )),
                  Positioned(
                      top: topStatusBarHeight,
                      right: 0,
                      child: IconButton(
                        icon: Icon(
                          Icons.add,
                          size: 40,
                          color: Colors.white,
                        ),
                        onPressed: () {
                          Navigator.of(context)
                              .push(CupertinoPageRoute(builder: (_) {
                            return AddTask();
                          }));
                        },
                      )),
                  Align(
                    alignment: Alignment.center,
                    child: Row(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        topButton(0, topButtonClick),
                        topButton(1, topButtonClick)
                      ],
                    ),
                  ),
                  Align(
                    alignment: Alignment.bottomLeft,
                    child: Row(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        SizedBox(
                          width: widthScale * 2,
                        ),
                        bottomButton('未完成', 1, buttonButtonClick),
                        bottomButton('进行中', 2, buttonButtonClick),
                        bottomButton('已完成', 3, buttonButtonClick),
                        bottomButton('已延期', 4, buttonButtonClick),
                        bottomButton('已取消', 5, buttonButtonClick),
                      ],
                    ),
                  )
                ],
              ),
            ),
            Expanded(
                child: MyTasksList(
              topIndex: topIndex,
              params: listParams,
            ))
          ],
        ),
      ),
    );
  }

  topButtonClick(int index) {
    print('index === $index)');
    setState(() {
      // listParams['index'] = index;
      topIndex = index;
    });
    _eventBus.emit(NOTIFY_TASKS_LIST_REFRASH,
        {'topIndex': topIndex, 'params': listParams});
  }

  buttonButtonClick(int index) {
    setState(() {
      listParams['status'] = index;
      statusIndex = index;
    });
    _eventBus.emit(NOTIFY_TASKS_LIST_REFRASH,
        {'topIndex': topIndex, 'params': listParams});
  }

  Widget topButton(int index, Function(int index) topButtonClick) {
    return RawMaterialButton(
      onPressed: () {
        if (topButtonClick != null) {
          topButtonClick(index);
        }
      },
      constraints: BoxConstraints(minWidth: widthScale * 20, minHeight: 30),
      textStyle: index == topIndex
          ? TextStyle(fontSize: 15, color: Colors.white)
          : jm_text_gray_style15,
      child: Text(index == 0 ? '我发布的' : '我接收的'),
    );
  }

  Widget bottomButton(
      String title, int index, Function(int index) buttonButtonClick) {
    return RawMaterialButton(
      onPressed: () {
        if (buttonButtonClick != null) {
          buttonButtonClick(index);
        }
      },
      constraints: BoxConstraints(minWidth: widthScale * 15, minHeight: 30),
      textStyle: index == statusIndex
          ? TextStyle(fontSize: 15, color: Colors.white)
          : jm_text_gray_style15,
      child: Text(title),
    );
  }
}
