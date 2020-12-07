import 'package:JMrealty/Report/ReportListView.dart';
import 'package:JMrealty/const/Default.dart';
import 'package:JMrealty/utils/sizeConfig.dart';
import 'package:flutter/material.dart';

class Report extends StatefulWidget {
  @override
  _ReportState createState() => _ReportState();
}

class _ReportState extends State<Report> {
  // int projectIndex;
  TabController tabCtr;
  double widthScale;
  @override
  void initState() {
    // projectIndex = 0;
    // tabCtr = TabController(length: null, vsync: null)
    super.initState();
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
                  onPressed: () {},
                  child: Text(
                    '复制',
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
                ReportListView(status: 0),
                ReportListView(status: 10),
                ReportListView(status: 20),
                ReportListView(status: 21),
                ReportListView(status: 30),
                ReportListView(status: 40),
                ReportListView(status: 50),
                ReportListView(status: 60),
                ReportListView(status: 70),
                ReportListView(status: 80),
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
