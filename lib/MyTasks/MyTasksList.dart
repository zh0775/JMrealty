import 'package:JMrealty/MyTasks/MyTasksCell.dart';
import 'package:JMrealty/MyTasks/viewModel/MyTasksViewModel.dart';
import 'package:JMrealty/components/EmptyView.dart';
import 'package:JMrealty/utils/EventBus.dart';
import 'package:JMrealty/utils/notify_default.dart';
import 'package:flutter/material.dart';
import 'package:flutter_easyrefresh/easy_refresh.dart';

class MyTasksList extends StatefulWidget {
  final int topIndex;
  final Map params;
  const MyTasksList({this.topIndex = 0, this.params = const {}});
  @override
  _MyTasksListState createState() => _MyTasksListState();
}

class _MyTasksListState extends State<MyTasksList> {
  MyTasksViewModel tasksVM = MyTasksViewModel();
  EasyRefreshController pullCtr = EasyRefreshController();
  GlobalKey _easyRefreshKey = GlobalKey();
  List tasksListData = [];
  EventBus eventBus = EventBus();
  int topIndex;
  Map params;
  @override
  void initState() {
    topIndex = widget.topIndex;
    params = widget.params;
    eventBus.on(NOTIFY_TASKS_LIST_REFRASH, (arg) {
      topIndex = arg['topIndex'];
      params = arg['params'];
      refrashList();
    });
    super.initState();
  }

  @override
  void dispose() {
    pullCtr.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return EasyRefresh(
      enableControlFinishRefresh: true,
      enableControlFinishLoad: true,
      key: _easyRefreshKey,
      controller: pullCtr,
      emptyWidget: tasksListData.length == 0 ? EmptyView() : null,
      firstRefresh: true,
      onRefresh: () async {
        refrashList();
      },
      child: ListView.builder(
        itemCount: tasksListData.length,
        itemBuilder: (context, index) {
          return MyTasksCell(
            data: tasksListData[index],
            status: widget.params['status'],
          );
        },
      ),
    );
  }

  refrashList() {
    if (topIndex == 0) {
      tasksVM.loadTasksPublishedList((tasksList, success) {
        pullCtr.finishRefresh();
        if (success) {
          setState(() {
            tasksListData = tasksList;
          });
        }
      }, params: Map<String, dynamic>.from(params));
    } else if (topIndex == 1) {
      tasksVM.loadTasksAcceptList((tasksList, success) {
        pullCtr.finishRefresh();
        if (success) {
          setState(() {
            tasksListData = tasksList;
          });
        }
      }, params: Map<String, dynamic>.from(params));
    }
  }
}
