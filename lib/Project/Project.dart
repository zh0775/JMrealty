import 'package:JMrealty/Project/ProjectCell.dart';
import 'package:JMrealty/Project/ProjectSearch.dart';
import 'package:JMrealty/Project/ProjectViewModel.dart';
import 'package:JMrealty/components/CustomPullHeader.dart';
import 'package:JMrealty/components/EmptyView.dart';
import 'package:JMrealty/const/Default.dart';
import 'package:JMrealty/utils/EventBus.dart';
import 'package:JMrealty/utils/notify_default.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_easyrefresh/easy_refresh.dart';

class Project extends StatefulWidget {
  final IndexClick indexClick;
  const Project({this.indexClick});
  @override
  _ProjectState createState() => _ProjectState();
}

class _ProjectState extends State<Project> {
  EventBus _eventBus = EventBus();
  ProjectViewModel projectVM = ProjectViewModel();
  EasyRefreshController pullCtr = EasyRefreshController();
  GlobalKey _easyRefreshKey = GlobalKey();
  GlobalKey _pullHeaderKey = GlobalKey();
  List projectListData = [];
  @override
  void dispose() {
    pullCtr.dispose();
    super.dispose();
  }

  @override
  void initState() {
    _eventBus.on(NOTIFY_LOGIN_SUCCESS, (arg) {
      pullCtr.callRefresh();
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
          centerTitle: true,
          backgroundColor: jm_appTheme,
          automaticallyImplyLeading: false,
          leading: IconButton(
              icon: Icon(
                Icons.search,
                color: Colors.white,
                size: 30,
              ),
              onPressed: () {
                Navigator.of(context).push(CupertinoPageRoute(builder: (_) {
                  return ProjectSearch(
                    projectList: projectListData,
                  );
                }));
              }),
          title: Text(
            '项目',
            style: TextStyle(color: Colors.white, fontSize: 22),
          ),
          actions: []),
      body: EasyRefresh(
        // enableControlFinishRefresh: true,
        // enableControlFinishLoad: true,
        key: _easyRefreshKey,
        controller: pullCtr,
        header: CustomPullHeader(key: _pullHeaderKey),
        emptyWidget: projectListData.length == 0 ? EmptyView() : null,
        firstRefresh: true,
        onRefresh: () async {
          projectVM.loadProjectList((projectList, success) {
            // pullCtr.finishRefresh();
            if (success) {
              setState(() {
                projectListData = projectList;
              });
            }
          });
        },
        child: ListView.builder(
          itemCount: projectListData.length,
          itemBuilder: (context, index) {
            return ProjectCell(
              data: projectListData[index],
            );
          },
        ),
      ),
    );
  }
}
