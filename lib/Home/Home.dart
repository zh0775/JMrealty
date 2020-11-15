import 'package:JMrealty/Home/components/HomeAnno.dart';
import 'package:JMrealty/Home/components/HomeGoodDeed.dart';
import 'package:JMrealty/Home/components/HomeNaviBar.dart';
import 'package:JMrealty/Home/components/HomeScheduleToDo.dart';
import 'package:JMrealty/services/HomeService.dart';
import 'package:flutter/material.dart';
import '../tabbar.dart';
import '../Project/Project.dart';
import '../Client/Client.dart';
import '../Message/Message.dart';
import '../Mine/Mine.dart';

class HomeBodyWidget extends StatefulWidget {
  @override
  _HomeBodyWidgetState createState() => _HomeBodyWidgetState();
}

class _HomeBodyWidgetState extends State<HomeBodyWidget> {
  int _tabbarIndex = 0;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: IndexedStack(
        index: _tabbarIndex,
        children: [Home(), Project(), Client(), Message(), Mine()],
      ),
      bottomNavigationBar: JMTabBar((index) {
        setState(() {
          _tabbarIndex = index;
        });
        // _tabbarIndex = index;
      }),
    );
  }
}

class Home extends StatefulWidget {
  @override
  _HomeState createState() => _HomeState();
}

class _HomeState extends State<Home> {
  var homeScheduleToDoData = [];
  var bannerList = [];
  @override
  void initState() {
    this.getBanner();
    this.getScheData();
    super.initState();
  }

  double widgetHeight = 180.0;

  @override
  Widget build(BuildContext context) {
    return MediaQuery.removePadding(
      removeTop: true,
      context: context,
      child: ListView(
        children: [
          HomeNaviBar(
            images: bannerList,
          ),
          HomeAnno(),
          HomeGoodDeed(),
          HomeScheduleToDo(
            data: homeScheduleToDoData,
          )
        ],
      ),
    );
  }

  void getScheData() {
    Map value = HomeService().getHomeSchedule();
    if (value['code'] == 0) {
      this.setState(() {
        this.homeScheduleToDoData = value['data'];
      });
    }
  }

  void getBanner() {
    Map value = HomeService().getHomeBanner();
    if (value['code'] == 0) {
      this.setState(() {
        this.bannerList = value['data'];
      });
      // this.initBannerData(value);
    }
  }
}
