import 'package:JMrealty/Home/components/HomeAnno.dart';
import 'package:JMrealty/Home/components/HomeGoodDeed.dart';
import 'package:JMrealty/Home/components/HomeNaviBar.dart';
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
  @override
  void initState() {
    super.initState();
  }

  double widgetHeight = 180.0;

  @override
  Widget build(BuildContext context) {
    return MediaQuery.removePadding(
      removeTop: true,
      context: context,
      child: ListView(
        children: [HomeNaviBar(), HomeAnno(), HomeGoodDeed()],
      ),
    );
  }
}
