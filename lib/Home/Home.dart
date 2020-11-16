import 'package:JMrealty/Home/components/HomeAnno.dart';
import 'package:JMrealty/Home/components/HomeGoodDeed.dart';
import 'package:JMrealty/Home/components/HomeNaviBar.dart';
import 'package:JMrealty/Home/components/HomeScheduleToDo.dart';
import 'package:JMrealty/Login/Login.dart';
import 'package:JMrealty/services/HomeService.dart';
import 'package:flutter/cupertino.dart';
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

// typedef void buttonClick(int buttonIndex, Map buttonData);

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
          ),
          buttons((int buttonIndex, Map buttonData) {
            if (buttonIndex == 0) {
              Navigator.of(context).push(CupertinoPageRoute(builder: (_) {
                return Login(
                  isLogin: true,
                );
              }));
            }
            print(
                'buttonIndex === $buttonIndex --- buttonData === $buttonData');
          })
        ],
      ),
    );
  }

  List buttonData = [
    [
      {
        'title': '报备',
        'path': '报备',
        'icon': 'assets/images/tabbar/food-bread.png'
      },
      {
        'title': '报备记录',
        'path': '报备记录',
        'icon': 'assets/images/tabbar/food-bread.png'
      },
      {
        'title': '业绩统计',
        'path': '业绩统计',
        'icon': 'assets/images/tabbar/food-bread.png'
      },
      {
        'title': '来访统计',
        'path': '来访统计',
        'icon': 'assets/images/tabbar/food-bread.png'
      },
      {
        'title': '榜单',
        'path': '榜单',
        'icon': 'assets/images/tabbar/food-bread.png'
      }
    ],
    [
      {
        'title': 'PK赛',
        'path': 'PK赛',
        'icon': 'assets/images/tabbar/food-bread.png'
      }
    ]
  ];

  Widget buttons(buttonClick) {
    List<Widget> row1 = [];
    List<Widget> row2 = [];
    TextStyle textStyle = TextStyle(color: Color.fromRGBO(163, 164, 172, 1));
    for (var i = 0; i < buttonData.length; i++) {
      List rowData = buttonData[i];
      for (var j = 0; j < rowData.length; j++) {
        var data = rowData[j];
        if (i == 0) {
          row1.add(
            TextButton(
                onPressed: () {
                  buttonClick(i * buttonData[0].length + j, data);
                },
                child: Column(
                  children: [
                    Image.asset(data['icon']),
                    SizedBox(
                      height: 10,
                    ),
                    Text(
                      data['title'],
                      style: textStyle,
                    ),
                  ],
                )),
          );
        } else {
          row2.add(TextButton(
              onPressed: () {
                buttonClick(i * buttonData[0].length + j, data);
              },
              child: Column(
                children: [
                  Image.asset(data['icon']),
                  Text(
                    data['title'],
                    style: textStyle,
                  ),
                ],
              )));
        }
      }
    }
    return Container(
      child: Column(
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: row1,
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              SizedBox(
                width: 7,
              ),
              ...row2
            ],
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
