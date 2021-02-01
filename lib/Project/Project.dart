import 'package:JMrealty/Project/ProjectCell.dart';
import 'package:JMrealty/Project/ProjectSearch.dart';
import 'package:JMrealty/Project/ProjectViewModel.dart';
import 'package:JMrealty/Project/components/ProjectDistrictSelectV.dart';
import 'package:JMrealty/components/CustomPullFooter.dart';
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
  double barHeight = 50;
  EventBus _eventBus = EventBus();
  ProjectViewModel projectVM = ProjectViewModel();
  EasyRefreshController pullCtr = EasyRefreshController();
  GlobalKey _easyRefreshKey = GlobalKey();
  GlobalKey _pullHeaderKey = GlobalKey();
  List projectListData = [];
  Map projectFliterParams = {};
  int total = 0;
  int pageNum = 1;
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
            leading: IconButton(
                icon: Icon(
                  Icons.search,
                  color: Colors.white,
                  size: 30,
                ),
                onPressed: () => push(ProjectSearch(), context)),
            title: Text(
              '主推热盘',
              style: TextStyle(color: Colors.white, fontSize: 22),
            ),
            actions: []),
        body: Stack(
          children: [
            Positioned(
              top: barHeight,
              left: 0,
              right: 0,
              bottom: 0,
              child: EasyRefresh(
                // enableControlFinishRefresh: true,
                // enableControlFinishLoad: true,
                key: _easyRefreshKey,
                controller: pullCtr,
                header: CustomPullHeader(key: _pullHeaderKey),
                footer: CustomPullFooter(),
                emptyWidget: projectListData.length == 0 ? EmptyView() : null,
                firstRefresh: true,
                onRefresh: () async {
                  loadProjectList();
                },
                onLoad:
                    projectListData != null && projectListData.length >= total
                        ? null
                        : () async {
                            pageNum++;
                            loadProjectList(isLoad: true, page: pageNum);
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
            ),
            Positioned(
                top: 0,
                left: 0,
                right: 0,
                child: ProjectDistrictSelectV(
                  barHeight: barHeight,
                  getProjectFilter: (projectParams) {
                    projectFliterParams = projectParams ?? {};
                    loadProjectList();
                  },
                ))
          ],
        ));
  }

  loadProjectList({int pageSize = 10, int page = 1, bool isLoad = false}) {
    if (!isLoad) {
      pageNum = 1;
    }
    Map<String, dynamic> params = Map<String, dynamic>.from({
      'pageSize': pageSize,
      'pageNum': page,
      'appShowFlag': 0,
      ...projectFliterParams
    });
    projectVM.loadProjectList(params, (projectList, success, count) {
      // pullCtr.finishRefresh();
      if (success) {
        total = count;
        setState(() {
          if (isLoad) {
            projectListData.addAll(projectList);
          } else {
            projectListData = projectList;
          }
        });
      }
    });
  }
}
