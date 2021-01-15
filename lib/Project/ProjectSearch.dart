import 'package:JMrealty/Project/ProjectCell.dart';
import 'package:JMrealty/Project/ProjectViewModel.dart';
import 'package:JMrealty/Project/components/ProjectSearchBar.dart';
import 'package:JMrealty/components/CustomAppBar.dart';
import 'package:JMrealty/utils/sizeConfig.dart';
import 'package:flutter/material.dart';

class ProjectSearch extends StatefulWidget {
  final List projectList;
  const ProjectSearch({this.projectList});
  @override
  _ProjectSearchState createState() => _ProjectSearchState();
}

class _ProjectSearchState extends State<ProjectSearch> {
  FocusNode focusNode = FocusNode();
  ProjectViewModel projectVM = ProjectViewModel();
  List projectDataList = [];
  String searchText = '';
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
              projectVM.searchProject(value, (projectList, success) {
                setState(() {
                  projectDataList = projectList;
                });
              });
            },
            focusNode: focusNode,
          ),
        ),
        body: SingleChildScrollView(
          child: Column(
            children: [
              Container(
                height: SizeConfig.screenHeight - 50,
                child: ListView.builder(
                  itemCount: projectDataList.length,
                  itemBuilder: (context, index) {
                    return ProjectCell(
                      data: projectDataList[index],
                    );
                  },
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
