import 'package:JMrealty/const/Default.dart';
import 'package:JMrealty/utils/sizeConfig.dart';
import 'package:flutter/material.dart';

class Report extends StatefulWidget {
  @override
  _ReportState createState() => _ReportState();
}

class _ReportState extends State<Report> {
  TabController tabCtr;
  double widthScale;
  @override
  void initState() {
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
        backgroundColor: Colors.white,
        body: TabBarView(children: [
          Center(
            child: Icon(Icons.accessibility_new_outlined),
          ),
          Center(
            child: Icon(Icons.accessibility_new_outlined),
          ),
          Center(
            child: Icon(Icons.accessibility_new_outlined),
          ),
          Center(
            child: Icon(Icons.accessibility_new_outlined),
          ),
          Center(
            child: Icon(Icons.accessibility_new_outlined),
          ),
          Center(
            child: Icon(Icons.accessibility_new_outlined),
          ),
          Center(
            child: Icon(Icons.accessibility_new_outlined),
          ),
          Center(
            child: Icon(Icons.accessibility_new_outlined),
          ),
          Center(
            child: Icon(Icons.accessibility_new_outlined),
          ),
          Center(
            child: Icon(Icons.accessibility_new_outlined),
          ),
        ]),
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
