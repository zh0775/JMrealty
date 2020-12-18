import 'package:JMrealty/Project/ProjectCell.dart';
import 'package:JMrealty/Project/ProjectViewModel.dart';
import 'package:JMrealty/components/EmptyView.dart';
import 'package:JMrealty/const/Default.dart';
import 'package:flutter/material.dart';
import 'package:flutter_easyrefresh/easy_refresh.dart';

class Project extends StatefulWidget {
  @override
  _ProjectState createState() => _ProjectState();
}

class _ProjectState extends State<Project> {
  ProjectViewModel projectVM = ProjectViewModel();
  EasyRefreshController pullCtr = EasyRefreshController();
  GlobalKey _easyRefreshKey = GlobalKey();
  List projectListData = [];
  @override
  void dispose() {
    pullCtr.dispose();
    super.dispose();
  }

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
          centerTitle: true,
          backgroundColor: jm_appTheme,
          automaticallyImplyLeading: false,
          title: Text(
            '项目',
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
        emptyWidget: projectListData.length == 0 ? EmptyView() : null,
        firstRefresh: true,
        onRefresh: () async {
          projectVM.loadProjectList((projectList) {
            pullCtr.finishRefresh();
            setState(() {
              projectListData = projectList;
            });
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
