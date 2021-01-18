import 'package:JMrealty/Project/ProjectCell.dart';
import 'package:JMrealty/Project/ProjectViewModel.dart';
import 'package:JMrealty/Project/components/ProjectSearchBar.dart';
import 'package:JMrealty/components/CustomAppBar.dart';
import 'package:JMrealty/components/CustomPullFooter.dart';
import 'package:JMrealty/components/CustomPullHeader.dart';
import 'package:JMrealty/components/EmptyView.dart';
import 'package:JMrealty/utils/sizeConfig.dart';
import 'package:flutter/material.dart';
import 'package:flutter_easyrefresh/easy_refresh.dart';

class ProjectSearch extends StatefulWidget {
  final List projectList;
  const ProjectSearch({this.projectList});
  @override
  _ProjectSearchState createState() => _ProjectSearchState();
}

class _ProjectSearchState extends State<ProjectSearch> {
  FocusNode focusNode = FocusNode();
  ProjectViewModel projectVM = ProjectViewModel();
  GlobalKey _easyRefreshKey = GlobalKey();
  List projectDataList = [];
  String searchText = '';
  int total = 0;
  int pageNum = 1;
  @override
  void initState() {
    projectDataList = widget.projectList ?? [];
    Future.delayed(Duration(milliseconds: 1),
        () => FocusScope.of(context).requestFocus(focusNode));
    super.initState();
  }

  @override
  void dispose() {
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    SizeConfig().init(context);
    return GestureDetector(
      onTap: () => FocusScope.of(context).requestFocus(FocusNode()),
      child: Scaffold(
          appBar: CustomAppbar(
            title: '搜索项目',
            bottom: ProjectSearchBar(
              text: searchText,
              valueChange: (value) {
                searchText = value;
                loadProjectList(searchText ?? '');
              },
              focusNode: focusNode,
            ),
          ),
          body: EasyRefresh(
            key: _easyRefreshKey,
            header: CustomPullHeader(),
            footer: CustomPullFooter(),
            emptyWidget: projectDataList.length == 0 ? EmptyView() : null,
            onRefresh: () async {
              loadProjectList(searchText ?? '');
            },
            onLoad: projectDataList != null && projectDataList.length >= total
                ? null
                : () async {
                    pageNum++;
                    loadProjectList(searchText ?? '',
                        isLoad: true, page: pageNum);
                  },
            child: ListView.builder(
              itemCount: projectDataList.length,
              itemBuilder: (context, index) {
                return ProjectCell(
                  data: projectDataList[index],
                );
              },
            ),
          )),
    );
  }

  loadProjectList(String name,
      {int pageSize = 10, int page = 1, bool isLoad = false}) {
    if (!isLoad) {
      pageNum = 1;
    }
    Map<String, dynamic> params = Map<String, dynamic>.from(
        {'name': name, 'pageSize': pageSize, 'pageNum': page});
    projectVM.searchProject(params, (projectList, success, total) {
      total = total;
      if (success && mounted) {
        setState(() {
          if (isLoad) {
            projectDataList.addAll(projectList);
          } else {
            projectDataList = projectList;
          }
        });
      }
    });
  }
}
