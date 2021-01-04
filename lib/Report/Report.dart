import 'package:JMrealty/Project/ProjectViewModel.dart';
import 'package:JMrealty/Report/ReportListView.dart';
import 'package:JMrealty/const/Default.dart';
import 'package:JMrealty/utils/EventBus.dart';
import 'package:JMrealty/utils/notify_default.dart';
import 'package:JMrealty/utils/sizeConfig.dart';
import 'package:flutter/material.dart';

class Report extends StatefulWidget {
  @override
  _ReportState createState() => _ReportState();
}

class _ReportState extends State<Report> {
  ProjectViewModel projectVM = ProjectViewModel();
  bool isCopy = false;
  // int projectIndex;
  TabController tabCtr;
  double widthScale;
  EventBus _eventBus = EventBus();
  double topMenuHeight = 40;
  bool showMenu = false;
  Map currentSelect = {'title': '所有项目', 'value': null};
  List projectListData = [];
  @override
  void initState() {
    projectVM.loadProjectList((projectList, success) {
      if (success) {
        List listFormat = projectList.map((e) {
          return {'title': e['name'], 'value': e['id']};
        }).toList();
        setState(() {
          projectListData = [
            {'title': '所有项目', 'value': null},
            ...listFormat
          ];
        });
      }
    });
    // projectIndex = 0;
    // tabCtr = TabController(length: null, vsync: null)
    super.initState();
  }

  @override
  void dispose() {
    _eventBus.off(NOTIFY_REPORT_SELECT_COPY_REFRASH);
    _eventBus.off(NOTIFY_REPORT_SELECT_REFRASH);
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    SizeConfig().init(context);
    widthScale = SizeConfig.blockSizeHorizontal;
    return DefaultTabController(
      length: 10,
      child: Scaffold(
        appBar: AppBar(
            centerTitle: true,
            backgroundColor: jm_appTheme,
            automaticallyImplyLeading: false,
            title: Text(
              '报备记录',
              style: TextStyle(color: Colors.white, fontSize: 18),
            ),
            leading: IconButton(
              icon: Icon(
                Icons.navigate_before,
                size: 40,
                color: Colors.white,
              ),
              onPressed: () {
                Navigator.pop(context);
              },
            ),
            actions: [
              TextButton(
                  onPressed: () {
                    setState(() {
                      isCopy = !isCopy;
                    });
                    if (!isCopy) {
                      _eventBus.emit(NOTIFY_REPORT_SELECT_COPY_REFRASH);
                    }
                  },
                  child: Text(
                    isCopy ? '复制' : '多选复制',
                    style: TextStyle(fontSize: 15, color: Colors.white),
                  )),
            ],
            bottom: TabBar(
              isScrollable: true,
              indicatorSize: TabBarIndicatorSize.label,
              indicatorColor: Colors.white,
              indicatorWeight: 2.0,
              indicatorPadding: EdgeInsets.only(bottom: 5),
              tabs: [
                getTab('有效'),
                getTab('已带看'),
                getTab('已上传'),
                getTab('已预约'),
                getTab('已成交'),
                getTab('已签约'),
                getTab('已结款'),
                getTab('已结佣'),
                getTab('失效'),
                getTab('退单'),
              ],
            )),
        backgroundColor: Color(0xfff0f2f5),
        body: Container(
          width: double.infinity,
          height: double.infinity,
          child: Stack(
            children: [
              Positioned(
                top: 0,
                left: 0,
                right: 0,
                bottom: 0,
                child: Column(
                  children: [
                    Container(
                      height: topMenuHeight,
                      width: SizeConfig.screenWidth,
                      decoration: BoxDecoration(
                          color: Colors.white,
                          border: Border(
                              bottom: BorderSide(
                                  width: 0.5, color: jm_line_color))),
                      child: Row(
                        children: [
                          ButtonTheme(
                            layoutBehavior: ButtonBarLayoutBehavior.constrained,
                            minWidth: 0,
                            child: FlatButton(
                                onPressed: () {},
                                child: Text(
                                  '项目',
                                  style: jm_text_gray_style14,
                                )),
                          ),
                          ButtonTheme(
                            minWidth: 0,
                            layoutBehavior: ButtonBarLayoutBehavior.constrained,
                            child: FlatButton(
                                onPressed: () {
                                  setState(() {
                                    showMenu = !showMenu;
                                  });
                                },
                                child: Text(
                                  currentSelect['title'],
                                  style: jm_text_black_style15,
                                )),
                          ),
                        ],
                      ),
                    ),
                    Expanded(
                      child: TabBarView(children: [
                        ReportListView(
                          status: 0,
                          isCopy: isCopy,
                        ),
                        ReportListView(status: 10, isCopy: isCopy),
                        ReportListView(status: 20, isCopy: isCopy),
                        ReportListView(status: 21, isCopy: isCopy),
                        ReportListView(status: 30, isCopy: isCopy),
                        ReportListView(status: 40, isCopy: isCopy),
                        ReportListView(status: 50, isCopy: isCopy),
                        ReportListView(status: 60, isCopy: isCopy),
                        ReportListView(status: 70, isCopy: isCopy),
                        ReportListView(status: 80, isCopy: isCopy),
                      ]),
                    )
                  ],
                ),
              ),
              showMenu
                  ? Positioned(
                      top: topMenuHeight,
                      left: 0,
                      right: 0,
                      bottom: 0,
                      child: GestureDetector(
                        onTap: () {
                          setState(() {
                            showMenu = false;
                          });
                        },
                        child: Container(
                          color: Colors.black26,
                          child: SingleChildScrollView(
                            child: Column(
                              children: [...selectList()],
                            ),
                          ),
                        ),
                      ))
                  : Container(
                      width: 0.0,
                      height: 0.0,
                    ),
            ],
          ),
        ),
      ),
    );
  }

  List<Widget> selectList() {
    List<Widget> listWidget = [];
    projectListData.forEach((e) {
      listWidget.add(GestureDetector(
        onTap: () {
          setState(() {
            currentSelect = e;
            showMenu = false;
          });
          _eventBus.emit(NOTIFY_REPORT_SELECT_REFRASH, e['value']);
        },
        child: Container(
          color: Colors.white,
          height: 40,
          alignment: Alignment.centerLeft,
          width: SizeConfig.screenWidth,
          child: Padding(
            padding: EdgeInsets.only(left: widthScale * 5),
            child: Text(
              e['title'] ?? '',
            ),
          ),
        ),
      ));
    });
    return listWidget;
  }

  Widget getTab(String title) {
    return Tab(
      child: Text(
        title,
        style: TextStyle(fontSize: 14, color: Colors.white),
      ),
    );
  }
}
