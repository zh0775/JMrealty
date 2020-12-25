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
  bool isCopy = false;
  // int projectIndex;
  TabController tabCtr;
  double widthScale;
  EventBus _eventBus = EventBus();
  @override
  void initState() {
    // projectIndex = 0;
    // tabCtr = TabController(length: null, vsync: null)
    super.initState();
  }

  @override
  void dispose() {
    _eventBus.off(NOTIFY_REPORT_SELECT_COPY_REFRASH);
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
        body: Column(
          children: [
            Container(
              height: 40,
              width: SizeConfig.screenWidth,
              decoration: BoxDecoration(
                  color: Colors.white,
                  border: Border(
                      bottom: BorderSide(width: 0.5, color: jm_line_color))),
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
                        onPressed: () {},
                        child: Text(
                          '所有项目',
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
    );
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
