import 'package:JMrealty/MyTasks/MyTasksCell.dart';
import 'package:JMrealty/MyTasks/viewModel/MyTasksViewModel.dart';
import 'package:JMrealty/components/EmptyView.dart';
import 'package:JMrealty/const/Default.dart';
import 'package:flutter/material.dart';
import 'package:flutter_easyrefresh/easy_refresh.dart';

class MyTasks extends StatefulWidget {
  @override
  _MyTasksState createState() => _MyTasksState();
}

class _MyTasksState extends State<MyTasks> {
  MyTasksViewModel tasksVM = MyTasksViewModel();
  EasyRefreshController pullCtr = EasyRefreshController();
  GlobalKey _easyRefreshKey = GlobalKey();
  List tasksListData = [];

  @override
  void dispose() {
    pullCtr.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
          centerTitle: true,
          backgroundColor: jm_appTheme,
          automaticallyImplyLeading: false,
          title: Text(
            '我的任务',
            style: TextStyle(color: Colors.white, fontSize: 22),
          ),
          actions: [
            IconButton(
                icon: Icon(
                  Icons.search,
                  color: Colors.white,
                  size: 30,
                ),
                onPressed: () {})
          ]),
      body: EasyRefresh(
        enableControlFinishRefresh: true,
        enableControlFinishLoad: true,
        key: _easyRefreshKey,
        controller: pullCtr,
        emptyWidget: tasksListData.length == 0 ? EmptyView() : null,
        firstRefresh: true,
        onRefresh: () async {
          tasksVM.loadTasksPublishedList((tasksList) {
            pullCtr.finishRefresh();
            setState(() {
              tasksListData = tasksList;
            });
          });
        },
        child: ListView.builder(
          itemCount: tasksListData.length,
          itemBuilder: (context, index) {
            return MyTasksCell(
              data: tasksListData[index],
            );
          },
        ),
      ),
    );
  }
}
