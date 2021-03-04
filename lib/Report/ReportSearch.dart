import 'package:JMrealty/Project/ProjectViewModel.dart';
import 'package:JMrealty/Report/ReportListCell.dart';
import 'package:JMrealty/Report/ReportSearchBar.dart';
import 'package:JMrealty/Report/viewmodel/ReportListViewModel.dart';
import 'package:JMrealty/components/CustomAppBar.dart';
import 'package:JMrealty/components/CustomPullFooter.dart';
import 'package:JMrealty/components/CustomPullHeader.dart';
import 'package:JMrealty/components/EmptyView.dart';
import 'package:JMrealty/components/NoneV.dart';
import 'package:JMrealty/const/Default.dart';
import 'package:JMrealty/utils/sizeConfig.dart';
import 'package:JMrealty/utils/tTools.dart';
import 'package:JMrealty/utils/toast.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_easyrefresh/easy_refresh.dart';
import 'package:intl/intl.dart';

class ReportSearch extends StatefulWidget {
  final Map buttonAuth;
  final int selfUserId;
  const ReportSearch({this.buttonAuth = const {}, this.selfUserId});
  @override
  _ReportSearchState createState() => _ReportSearchState();
}

class _ReportSearchState extends State<ReportSearch> {
  ProjectViewModel projectVM = ProjectViewModel();
  ReportListViewModel reportListVM = ReportListViewModel();
  EasyRefreshController easyRefreshCtr = EasyRefreshController();
  DateFormat dateFormat = DateFormat('yyyy-MM-dd');
  double widthScale;
  double searchBarHeight = 75;
  double timeHeight = 45;
  double projetHeight = 40;
  Map currentSelectProject = {'title': '所有项目', 'value': null};
  List projectListData;
  String startTime;
  String endTime;
  List dataList = [];
  int total = 0;
  int pageNum = 1;
  bool selectExpand = false;
  String filterStr = '';
  @override
  void initState() {
    getProjectListFilter();
    super.initState();
  }

  @override
  void dispose() {
    easyRefreshCtr.dispose();
    super.dispose();
  }

  loadList({int pageSize = 10, int page = 1, bool isLoad = false}) {
    if (!isLoad) {
      pageNum = 1;
    }
    // Map<String, dynamic> params = Map<String, dynamic>.from({
    //   'pageSize': pageSize,
    //   'pageNum': page,
    //   'startTime': startTime ?? '',
    //   'endTime': endTime ?? '',
    //   'customerPhone': '',
    //   'employeeName': '',
    // });
    Map<String, dynamic> params =
        Map<String, dynamic>.from({'pageSize': pageSize, 'pageNum': page});

    if (startTime != null && startTime.length > 0) {
      params['startTime'] = startTime;
    }
    if (endTime != null && endTime.length > 0) {
      params['endTime'] = endTime;
    }
    if (filterStr != null && filterStr.length > 0) {
      if (isNumber(filterStr)) {
        params['customerPhone'] = filterStr;
      } else {
        params['employeeName'] = filterStr;
      }
    }

    reportListVM.loadListData(params, projectId: currentSelectProject['value'],
        success: (List list, success, count) {
      if (success && mounted) {
        setState(() {
          total = count;
          if (isLoad) {
            dataList.addAll(list);
          } else {
            dataList = list;
          }
        });
      }
    });
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
  Widget build(BuildContext context) {
    SizeConfig().init(context);
    widthScale = SizeConfig.blockSizeHorizontal;
    return GestureDetector(
      onTap: () => FocusScope.of(context).requestFocus(FocusNode()),
      child: Scaffold(
        backgroundColor: Color(0xfff0f2f5),
        appBar: CustomAppbar(
          title: '搜索',
          backClick: () {
            FocusScope.of(context).requestFocus(FocusNode());
            if (Navigator.canPop(context)) {
              Navigator.pop(context);
            }
          },
        ),
        body: Stack(
          children: [
            Positioned(
              top: 0,
              left: 0,
              height: searchBarHeight,
              right: 0,
              child: Container(
                color: Colors.white,
                child: ReportSearchBar(
                  placeholder: '输入业务员姓名、手机号或客户手机号',
                  valueChange: (value) {
                    filterStr = value;
                    loadList();
                  },
                ),
              ),
            ),
            Positioned(
                top: searchBarHeight,
                left: 0,
                right: 0,
                height: timeHeight,
                child: Container(
                    decoration: BoxDecoration(
                        color: Colors.white,
                        border: Border(
                            bottom:
                                BorderSide(width: 1, color: jm_line_color))),
                    child: Row(
                      children: [
                        timeWidget(isStart: true),
                        // JMline(width: 1, height: timeHeight),
                        timeWidget(isStart: false),
                        projectWidget()
                        // JMline(width: 1, height: timeHeight),
                      ],
                    ))),
            // Positioned(
            //     top: searchBarHeight + timeHeight,
            //     left: 0,
            //     right: 0,
            //     height: projetHeight,
            //     child: GestureDetector(
            //       behavior: HitTestBehavior.opaque,
            //       onTap: () {
            //         FocusScope.of(context).requestFocus(FocusNode());
            //         if (projectListData == null ||
            //             projectListData.length == 0) {
            //           getProjectListFilter();
            //         }
            //         setState(() {
            //           selectExpand = !selectExpand;
            //         });
            //       },
            //       child: Container(
            //         decoration: BoxDecoration(
            //             color: Colors.white,
            //             border: Border(
            //                 bottom:
            //                     BorderSide(width: 1, color: jm_line_color))),
            //         child: Row(
            //           mainAxisAlignment: MainAxisAlignment.spaceBetween,
            //           children: [
            //             Row(
            //               children: [
            //                 SizedBox(
            //                   width: widthScale * 4,
            //                 ),
            //                 Text(
            //                   '项目',
            //                   style: jm_text_gray_style14,
            //                 ),
            //                 SizedBox(
            //                   width: widthScale * 4,
            //                 ),
            //                 Text(
            //                   currentSelectProject['title'],
            //                   style: selectExpand
            //                       ? jm_text_apptheme_style15
            //                       : jm_text_black_style15,
            //                 ),
            //               ],
            //             ),
            //             Padding(
            //               padding: EdgeInsets.only(right: widthScale * 3),
            //               child: Icon(
            //                 Icons.arrow_drop_down,
            //                 size: widthScale * 6.5,
            //                 color: jm_text_gray,
            //               ),
            //             )
            //           ],
            //         ),
            //       ),
            //     )),
            Positioned(
                top: searchBarHeight + timeHeight,
                left: 0,
                right: 0,
                // bottom: 0,
                height: SizeConfig.screenHeight -
                    kToolbarHeight -
                    20 -
                    (searchBarHeight + timeHeight + projetHeight),
                child: EasyRefresh(
                  controller: easyRefreshCtr,
                  header: CustomPullHeader(),
                  footer: CustomPullFooter(),
                  emptyWidget: dataList.length == 0
                      ? EmptyView(
                          height: SizeConfig.screenHeight -
                              kToolbarHeight -
                              20 -
                              (searchBarHeight + timeHeight + projetHeight),
                        )
                      : null,
                  firstRefresh: true,
                  onRefresh: () async {
                    loadList();
                  },
                  onLoad: dataList != null && dataList.length >= total
                      ? null
                      : () async {
                          pageNum++;
                          loadList(isLoad: true, page: pageNum);
                        },
                  child: ListView.builder(
                    itemCount: dataList.length,
                    itemBuilder: (context, index) {
                      // print(index);
                      return ReportListCell(
                        data: dataList[index],
                        index: index,
                        selfUserId: widget.selfUserId,
                        buttonAuth: widget.buttonAuth,
                        needRefrash: () {
                          loadList();
                        },
                        // copyItem: (data, add) {
                        //   if (add) {
                        //     copyList.add(data);
                        //   } else {
                        //     copyList.remove(data);
                        //   }
                        // },
                        copyOneItem: (data, showPhone) {
                          ShowToast.normal('已复制');
                          Clipboard.setData(
                              ClipboardData(text: copyString(data)));

                          reportListVM.copyReportRequest([data['id']],
                              (success) {
                            if (success) {
                              loadList();
                            }
                          });
                        },
                        // copyStatus: widget.isCopy,
                      );
                    },
                  ),
                )),
            selectExpand
                ? Positioned(
                    top: searchBarHeight + timeHeight,
                    left: 0,
                    right: 0,
                    bottom: 0,
                    child: GestureDetector(
                      onTap: () {
                        setState(() {
                          selectExpand = false;
                        });
                      },
                      child: Container(
                        color: Colors.black26,
                        child: SingleChildScrollView(
                          physics: ClampingScrollPhysics(),
                          child: Column(
                            children: [...projectSelectList()],
                          ),
                        ),
                      ),
                    ))
                : Align(
                    child: NoneV(),
                  )
          ],
        ),
      ),
    );
  }

  List<Widget> projectSelectList() {
    List<Widget> list = [];
    projectListData.forEach((e) {
      list.add(GestureDetector(
        onTap: () {
          setState(() {
            currentSelectProject = e;
            selectExpand = false;
          });
          loadList();
          // _eventBus.emit(NOTIFY_REPORT_SELECT_REFRASH, e['value']);
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
    return list;
  }

  Widget projectWidget() {
    TextStyle textStyle;
    String text = currentSelectProject['title'] ?? '';
    if (currentSelectProject['value'] != null) {
      textStyle = jm_text_black_style14;
    } else {
      textStyle = TextStyle(color: jm_placeholder_color, fontSize: 15);
    }

    return GestureDetector(
      behavior: HitTestBehavior.opaque,
      onTap: () {
        FocusScope.of(context).requestFocus(FocusNode());
        FocusScope.of(context).requestFocus(FocusNode());
        if (projectListData == null || projectListData.length == 0) {
          getProjectListFilter();
        }
        setState(() {
          selectExpand = !selectExpand;
        });
      },
      child: Container(
        width: SizeConfig.screenWidth / 3,
        height: timeHeight,
        child: Row(
          // mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Row(
              children: [
                SizedBox(
                  width: widthScale * 3,
                ),
                SizedBox(
                  width: widthScale * 23.5,
                  child: Text(
                    text,
                    style: textStyle,
                  ),
                ),
              ],
            ),
            Row(
              children: [
                Icon(
                  Icons.arrow_drop_down,
                  size: widthScale * 6.5,
                  color: jm_text_gray,
                ),
                SizedBox(
                    // width: widthScale * 6,
                    ),
              ],
            )
          ],
        ),
      ),
    );
  }

  Widget timeWidget({bool isStart = true}) {
    TextStyle textStyle;
    String text;
    if (isStart) {
      if (startTime != null && startTime.length > 0) {
        text = startTime;
        textStyle = jm_text_black_style14;
      } else {
        text = '开始时间';
        textStyle = TextStyle(color: jm_placeholder_color, fontSize: 15);
      }
    } else {
      if (endTime != null && endTime.length > 0) {
        text = endTime;
        textStyle = jm_text_black_style14;
      } else {
        text = '结束时间';
        textStyle = TextStyle(color: jm_placeholder_color, fontSize: 15);
      }
    }

    return GestureDetector(
      behavior: HitTestBehavior.opaque,
      onTap: () {
        FocusScope.of(context).requestFocus(FocusNode());
        showDatePick(isStart: isStart);
      },
      child: Container(
        width: SizeConfig.screenWidth / 3 - widthScale * 1,
        height: timeHeight,
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Row(
              children: [
                SizedBox(
                  width: widthScale * 4,
                ),
                Text(
                  text,
                  style: textStyle,
                )
              ],
            ),
            Row(
              children: [
                Icon(
                  Icons.arrow_drop_down,
                  size: widthScale * 6.5,
                  color: jm_text_gray,
                ),
                SizedBox(
                    // width: widthScale * 6,
                    ),
              ],
            )
          ],
        ),
      ),
    );
  }

  Future<void> showDatePick({bool isStart = true}) async {
    dynamic time = isStart ? startTime : endTime;
    final DateTime date = await showDatePicker(
        context: context,
        initialDate: time != null
            ? DateFormat('yyyy-MM-dd').parse(time)
            : DateTime.now(),
        firstDate: DateTime(2018, 1),
        lastDate: DateTime.now().add(Duration(days: 365 * 3)),
        locale: Locale('zh'));
    if (date == null) return;

    if (startTime != null && endTime != null) {
      if (isStart) {
        if (dateFormat.parse(endTime).isBefore(date)) {
          ShowToast.normal('结束时间需大于开始时间');
          return;
        }
      } else {
        if (dateFormat.parse(startTime).isAfter(date)) {
          ShowToast.normal('结束时间需大于开始时间');
          return;
        }
      }
    }

    setState(() {
      isStart
          ? startTime = dateFormat.format(date)
          : endTime = dateFormat.format(date);
      // endTime = date.add(Duration(
      //     milliseconds:
      //         1000 * 60 * 60 * 23 + 60 * 1000 * 59 + 1000 * 59 + 999));
    });
    loadList();
  }
}
