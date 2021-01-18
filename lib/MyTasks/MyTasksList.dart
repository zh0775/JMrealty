import 'package:JMrealty/MyTasks/MyTasksCell.dart';
import 'package:JMrealty/MyTasks/viewModel/MyTasksViewModel.dart';
import 'package:JMrealty/components/CustomPullFooter.dart';
import 'package:JMrealty/components/CustomPullHeader.dart';
import 'package:JMrealty/components/EmptyView.dart';
import 'package:JMrealty/utils/EventBus.dart';
import 'package:JMrealty/utils/notify_default.dart';
import 'package:flutter/material.dart';
import 'package:flutter_easyrefresh/easy_refresh.dart';

class MyTasksList extends StatefulWidget {
  final int topIndex;
  final int status;
  final int type;
  const MyTasksList({this.topIndex, this.status, this.type = -1});
  @override
  _MyTasksListState createState() => _MyTasksListState();
}

class _MyTasksListState extends State<MyTasksList>
    with AutomaticKeepAliveClientMixin {
  MyTasksViewModel tasksVM = MyTasksViewModel();
  EasyRefreshController pullCtr = EasyRefreshController();
  GlobalKey _easyRefreshKey = GlobalKey();
  GlobalKey _pullHeaderKey = GlobalKey();
  List tasksListData = [];
  EventBus eventBus = EventBus();
  int total = 0;
  int pageNum = 1;
  @override
  void initState() {
    eventBus.on(NOTIFY_TASKS_LIST_REFRASH, (arg) {
      if (mounted) {
        refrashList(arg);
      }
    });
    super.initState();
  }

  @override
  void dispose() {
    eventBus.off(NOTIFY_TASKS_LIST_REFRASH);
    pullCtr.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    super.build(context);
    return EasyRefresh(
      // enableControlFinishRefresh: true,
      // enableControlFinishLoad: true,
      key: _easyRefreshKey,
      controller: pullCtr,
      header: CustomPullHeader(key: _pullHeaderKey),
      footer: CustomPullFooter(),
      emptyWidget: tasksListData.length == 0 ? EmptyView() : null,
      firstRefresh: true,
      onRefresh: () async {
        if (mounted) {
          refrashList(null);
        }
      },
      onLoad: tasksListData != null && tasksListData.length >= total
          ? null
          : () async {
              pageNum++;
              refrashList(null, isLoad: true, page: pageNum);
            },
      child: ListView.builder(
        itemCount: tasksListData.length,
        itemBuilder: (context, index) {
          return MyTasksCell(
            data: tasksListData[index],
            status: widget.status,
            needRefreshList: () {
              if (mounted) {
                refrashList(null);
              }
            },
          );
        },
      ),
    );
  }

  refrashList(Map parameter,
      {int pageSize = 10, int page = 1, bool isLoad = false}) {
    if (!isLoad) {
      pageNum = 1;
    }
    int topIndex = widget.topIndex;
    Map params = {'status': widget.status};
    if (widget.type != -1) {
      params['type'] = widget.type;
    }
    if (parameter != null) {
      if (parameter['topIndex'] != null) {
        topIndex = parameter['topIndex'];
      }
      if (parameter['status'] != null) {
        params['status'] = parameter['status'];
      }
      if (parameter['type'] != null && parameter['type'] != -1) {
        params['type'] = parameter['type'];
      }
    }
    params['pageSize'] = pageSize;
    params['pageNum'] = page;
    if (topIndex == 0) {
      tasksVM.loadTasksPublishedList((tasksList, success, total) {
        pullCtr.finishRefresh();
        if (success) {
          setState(() {
            if (isLoad) {
              tasksListData.addAll(tasksList);
            } else {
              tasksListData = tasksList;
            }
          });
        }
      }, params: Map<String, dynamic>.from(params));
    } else if (topIndex == 1) {
      tasksVM.loadTasksAcceptList((tasksList, success) {
        pullCtr.finishRefresh();
        if (success) {
          setState(() {
            if (isLoad) {
              tasksListData.addAll(tasksList);
            } else {
              tasksListData = tasksList;
            }
          });
        }
      }, params: Map<String, dynamic>.from(params));
    }
  }

  @override
  bool get wantKeepAlive => true;
}
