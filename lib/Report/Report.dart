import 'dart:convert' as convert;

import 'package:JMrealty/Project/ProjectViewModel.dart';
import 'package:JMrealty/Report/ReportListView.dart';
import 'package:JMrealty/Report/ReportSearch.dart';
import 'package:JMrealty/const/Default.dart';
import 'package:JMrealty/utils/EventBus.dart';
import 'package:JMrealty/utils/notify_default.dart';
import 'package:JMrealty/utils/sizeConfig.dart';
import 'package:JMrealty/utils/user_default.dart';
import 'package:flutter/material.dart';

class Report extends StatefulWidget {
  final int selfUserId;
  const Report({this.selfUserId});
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
  Map reportAuth = {};
  String userId = '';
  int selfUserId = -1;
  @override
  void initState() {
    getProjectListFilter();
    menus();

    if (widget.selfUserId == null) {
      this.getSelfuserId();
    } else {
      selfUserId = widget.selfUserId;
    }
    // projectIndex = 0;
    // tabCtr = TabController(length: null, vsync: null)
    super.initState();
  }

  void getSelfuserId() async {
    String u = await UserDefault.get(USERINFO);
    if (u == null) return;
    Map userInfo = convert.jsonDecode(u);
    setState(() {
      selfUserId = userInfo['userId'];
    });
  }

  void menus() async {
    dynamic value = await UserDefault.get(HOME_MENUS);
    if (value == null) return;
    List menus = convert.jsonDecode(value);

    menus.forEach((e) {
      if (e['path'] == 'app,main' && e['menu'] != null) {
        (e['menu'] as List).forEach((e2) {
          if (e2['path'] == 'app:report:list' && e2['menu'] != null) {
            (e2['menu'] as List).forEach((e3) {
              // print('${e3['path']}');
              reportAuth[e3['perms']] = e3;
            });
          }
        });
      }
    });
    setState(() {});
  }

  void getProjectListFilter() {
    projectVM.reportListProjectFilter((projectList, success, total) {
      if (success) {
        List listFormat = projectList.map((e) {
          return {'title': e['name'], 'value': e['id']};
        }).toList();
        setState(() {
          projectListData = [
            {'title': '全部项目', 'value': null},
            ...listFormat
          ];
        });
      }
    });
  }

  @override
  void dispose() {
    _eventBus.off(NOTIFY_REPORT_SELECT_REFRASH);
    _eventBus.off(NOTIFY_REPORT_LIST_REFRASH);
    _eventBus.off(NOTIFY_REPORT_SELECT_COPY_REFRASH);
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    SizeConfig().init(context);
    widthScale = SizeConfig.blockSizeHorizontal;
    return DefaultTabController(
      length: 13,
      child: Scaffold(
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
              RawMaterialButton(
                highlightColor: Colors.transparent,
                materialTapTargetSize: MaterialTapTargetSize.shrinkWrap,
                constraints:
                    BoxConstraints(minHeight: 0, minWidth: widthScale * 8),
                onPressed: () => push(
                    ReportSearch(
                      selfUserId: selfUserId,
                      buttonAuth: reportAuth,
                    ),
                    context),
                child: Icon(
                  Icons.search,
                  color: Colors.white,
                  size: 25,
                ),
              ),
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
                getTab(jm_getReportStatusStr(0)),
                getTab(jm_getReportStatusStr(5)),
                getTab(jm_getReportStatusStr(70)),
                getTab(jm_getReportStatusStr(10)),
                getTab(jm_getReportStatusStr(20)),
                getTab(jm_getReportStatusStr(22)),
                getTab(jm_getReportStatusStr(21)),
                getTab(jm_getReportStatusStr(30)),
                getTab(jm_getReportStatusStr(40)),
                getTab(jm_getReportStatusStr(50)),
                getTab(jm_getReportStatusStr(60)),
                getTab(jm_getReportStatusStr(63)),
                getTab(jm_getReportStatusStr(80)),
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
                      child: GestureDetector(
                        behavior: HitTestBehavior.opaque,
                        onTap: () {
                          if (projectListData == null ||
                              projectListData.length == 0) {
                            getProjectListFilter();
                          }
                          setState(() {
                            showMenu = !showMenu;
                          });
                        },
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Row(
                              children: [
                                SizedBox(
                                  width: widthScale * 4,
                                ),
                                Text(
                                  '项目',
                                  style: jm_text_gray_style14,
                                ),
                                SizedBox(
                                  width: widthScale * 4,
                                ),
                                Text(
                                  currentSelect['title'],
                                  style: showMenu
                                      ? jm_text_apptheme_style15
                                      : jm_text_black_style15,
                                ),
                                // ButtonTheme(
                                //   layoutBehavior:
                                //       ButtonBarLayoutBehavior.constrained,
                                //   minWidth: 0,
                                //   child: FlatButton(
                                //       onPressed: () {},
                                //       child: Text(
                                //         '项目',
                                //         style: jm_text_gray_style14,
                                //       )),
                                // ),
                                // ButtonTheme(
                                //   minWidth: 0,
                                //   layoutBehavior:
                                //       ButtonBarLayoutBehavior.constrained,
                                //   child: FlatButton(
                                //       onPressed: () {
                                //         if (projectListData == null ||
                                //             projectListData.length == 0) {
                                //           getProjectListFilter();
                                //         }
                                //         setState(() {
                                //           showMenu = !showMenu;
                                //         });
                                //       },
                                //       child: Text(
                                //         currentSelect['title'],
                                //         style: showMenu
                                //             ? jm_text_apptheme_style15
                                //             : jm_text_black_style15,
                                //       )),
                                // ),
                              ],
                            ),
                            Padding(
                              padding: EdgeInsets.only(right: widthScale * 3),
                              child: Icon(
                                Icons.arrow_drop_down,
                                size: widthScale * 6.5,
                                color: jm_text_gray,
                              ),
                            )
                          ],
                        ),
                      ),
                    ),
                    Expanded(
                      child: TabBarView(children: [
                        ReportListView(
                          status: 0,
                          isCopy: isCopy,
                          buttonAuth: reportAuth,
                          selfUserId: selfUserId,
                        ),
                        ReportListView(
                            status: 5,
                            isCopy: isCopy,
                            buttonAuth: reportAuth,
                            selfUserId: selfUserId),
                        ReportListView(
                            status: 70,
                            isCopy: isCopy,
                            buttonAuth: reportAuth,
                            selfUserId: selfUserId),
                        ReportListView(
                            status: 10,
                            isCopy: isCopy,
                            buttonAuth: reportAuth,
                            selfUserId: selfUserId),
                        ReportListView(
                            status: 20,
                            isCopy: isCopy,
                            buttonAuth: reportAuth,
                            selfUserId: selfUserId),
                        ReportListView(
                            status: 22,
                            isCopy: isCopy,
                            buttonAuth: reportAuth,
                            selfUserId: selfUserId),
                        ReportListView(
                            status: 21,
                            isCopy: isCopy,
                            buttonAuth: reportAuth,
                            selfUserId: selfUserId),
                        ReportListView(
                            status: 30,
                            isCopy: isCopy,
                            buttonAuth: reportAuth,
                            selfUserId: selfUserId),
                        ReportListView(
                            status: 40,
                            isCopy: isCopy,
                            buttonAuth: reportAuth,
                            selfUserId: selfUserId),
                        ReportListView(
                            status: 50,
                            isCopy: isCopy,
                            buttonAuth: reportAuth,
                            selfUserId: selfUserId),
                        ReportListView(
                            status: 60,
                            isCopy: isCopy,
                            buttonAuth: reportAuth,
                            selfUserId: selfUserId),
                        ReportListView(
                            status: 63,
                            isCopy: isCopy,
                            buttonAuth: reportAuth,
                            selfUserId: selfUserId),
                        ReportListView(
                            status: 80,
                            isCopy: isCopy,
                            buttonAuth: reportAuth,
                            selfUserId: selfUserId),
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
                            physics: ClampingScrollPhysics(),
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
