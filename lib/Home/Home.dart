import 'dart:convert' as convert;
import 'package:JMrealty/Client/ClientPool.dart';
import 'package:JMrealty/Follow/Follow.dart';
import 'package:JMrealty/Home/components/HomeAnno.dart';
import 'package:JMrealty/Home/components/HomeGoodDeed.dart';
import 'package:JMrealty/Home/components/HomeNaviBar.dart';
import 'package:JMrealty/Home/components/HomeScheduleToDo.dart';
import 'package:JMrealty/Home/viewModel/HomeViewModel.dart';
import 'package:JMrealty/MyTasks/MyTasks.dart';
import 'package:JMrealty/PK/PKmain.dart';
import 'package:JMrealty/Report/AddReport.dart';
import 'package:JMrealty/Report/Report.dart';
import 'package:JMrealty/const/Default.dart';
import 'package:JMrealty/services/HomeService.dart';
import 'package:JMrealty/utils/EventBus.dart';
import 'package:JMrealty/utils/notify_default.dart';
import 'package:JMrealty/utils/sizeConfig.dart';
import 'package:JMrealty/utils/user_default.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import '../tabbar.dart';
import '../Project/Project.dart';
import '../Client/Client.dart';
import '../Message/Message.dart';
import '../Mine/Mine.dart';

class MainPageWidget extends StatefulWidget {
  @override
  _MainPageWidgetState createState() => _MainPageWidgetState();
}

class _MainPageWidgetState extends State<MainPageWidget> {
  IndexClick indexClick = ()=>{};
  @override
  void initState() {
    super.initState();
  }
  int _tabbarIndex = 0;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: IndexedStack(
        index: _tabbarIndex,
        children: [
          Home(indexClick: indexClick,),
          Project(indexClick: indexClick),
          Client(indexClick: indexClick),
          Message(indexClick: indexClick),
          Mine(indexClick: indexClick)],
      ),
      bottomNavigationBar: JMTabBar((index) {
        indexClick();
        setState(() {
          _tabbarIndex = index;
        });
        // _tabbarIndex = index;
      }),
    );
  }

  @override
  void dispose() {
    super.dispose();
  }
}

// typedef void buttonClick(int buttonIndex, Map buttonData);

class Home extends StatefulWidget {
  final IndexClick indexClick;
  const Home({this.indexClick});
  @override
  _HomeState createState() => _HomeState();
}

class _HomeState extends State<Home> {
  HomeViewModel homeVM;
  var homeScheduleToDoData = [];
  var bannerList = [];
  EventBus _eventBus = EventBus();

  @override
  void deactivate() {
    // print('deactivate === home_deactivate');
    // bool isCurrent = ModalRoute.of(context).isCurrent;
    // if(isCurrent) loadReqest();
    super.deactivate();
  }

  @override
  void initState() {
    _eventBus.on(NOTIFY_LOGIN_SUCCESS, (arg) {
      loadReqest();
    });
    widget.indexClick();
    homeVM = HomeViewModel();
    super.initState();
  }
  void loadReqest() async {
    homeVM.loadUserInfo();
    String token = await UserDefault.get(ACCESS_TOKEN);
    getBanner();
    if (token != null && token.length > 0) {
      getScheData();
    }
  }
  double widgetHeight = 180.0;

  @override
  Widget build(BuildContext context) {
    return MediaQuery.removePadding(
      removeTop: true,
      context: context,
      child: SingleChildScrollView(
        child: Column(
        children: [
          HomeNaviBar(
            bannerDatas: bannerList,
          ),
          HomeAnno(),
          HomeGoodDeed(),
          HomeScheduleToDo(
            data: homeScheduleToDoData,
          ),
          buttons((int buttonIndex, Map buttonData) {
            if (buttonIndex == 0) {
              Navigator.of(context).push(CupertinoPageRoute(builder: (_) {
                return AddReport();
              }));
            } else if (buttonIndex == 1) {
              Navigator.of(context).push(CupertinoPageRoute(builder: (_) {
                return Report();
              }));
            } else if (buttonIndex == 5) {
              Navigator.of(context).push(CupertinoPageRoute(builder: (_) {
                return PKmain();
              }));
            } else if (buttonIndex == 7) {
              UserDefault.get(ACCESS_TOKEN).then((token) {
                if (token != null) {
                  UserDefault.get(USERINFO).then((userInfo) {
                    if (userInfo != null) {
                      Map<String, dynamic> userInfoMap =
                          Map<String, dynamic>.from(
                              convert.jsonDecode(userInfo));
                      Navigator.of(context)
                          .push(CupertinoPageRoute(builder: (_) {
                        return Follow(
                          token: token,
                          deptId: userInfoMap['deptId'],
                        );
                      }));
                    } else {
                      homeVM.loadUserInfo();
                    }
                  });
                } else {
                  Global.toLogin(isLogin: true);
                }
              });
            } else if (buttonIndex == 10) {
              Navigator.of(context).push(CupertinoPageRoute(builder: (_) {
                return ClientPool();
              }));
            } else if (buttonIndex == 11) {
              Navigator.of(context).push(CupertinoPageRoute(builder: (_) {
                return MyTasks();
              }));
            } else {
              Global.toLogin(isLogin: true);
            }

            print(
                'buttonIndex === $buttonIndex --- buttonData === $buttonData');
          })
        ],
      ),
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
      },
      {
        'title': '智能报备',
        'path': '智能报备',
        'icon': 'assets/images/tabbar/food-bread.png'
      },
      {
        'title': '跟进进度',
        'path': '跟进进度',
        'icon': 'assets/images/tabbar/food-bread.png'
      },
      {
        'title': 'WI分',
        'path': 'WI分',
        'icon': 'assets/images/tabbar/food-bread.png'
      },
      {
        'title': '业绩对比',
        'path': '业绩对比',
        'icon': 'assets/images/tabbar/food-bread.png'
      }
    ],
    [
      {
        'title': '客户池',
        'path': '客户池',
        'icon': 'assets/images/tabbar/food-bread.png'
      },
      {
        'title': '我的任务',
        'path': '我的任务',
        'icon': 'assets/images/tabbar/food-bread.png'
      },
      {
        'title': '每日总结',
        'path': '每日总结',
        'icon': 'assets/images/tabbar/food-bread.png'
      },
      {
        'title': '破壳率',
        'path': '破壳率',
        'icon': 'assets/images/tabbar/food-bread.png'
      },
      {
        'title': '未开发人员',
        'path': '未开发人员',
        'icon': 'assets/images/tabbar/food-bread.png'
      }
    ]
  ];

  Widget buttons(buttonClick) {
    List<Widget> allRow = [];
    // List<Widget> row2 = [];
    // Column column = Column();
    // TextStyle textStyle = TextStyle(color: jm_text_black);
    for (var i = 0; i < buttonData.length; i++) {
      List rowData = buttonData[i];
      Row row;
      List<Widget> rowList = [];
      for (var j = 0; j < rowData.length; j++) {
        var data = rowData[j];
        // if (i == 0) {
        rowList.add(Container(
          width: SizeConfig.blockSizeHorizontal * 20,
          height: 80,
          child: TextButton(
              onPressed: () {
                buttonClick(i * buttonData[0].length + j, data);
              },
              child: Column(
                children: [
                  Image.asset(
                    data['icon'],
                    height: 30,
                    width: SizeConfig.blockSizeHorizontal * 15,
                  ),
                  SizedBox(
                    height: 10,
                  ),
                  Text(
                    data['title'],
                    maxLines: 1,
                    style: jm_text_black_style14,
                  ),
                ],
              )),
        ));
        // } else {
        //   row.children.add(TextButton(
        //       onPressed: () {
        //         buttonClick(i * buttonData[0].length + j, data);
        //       },
        //       child: Column(
        //         children: [
        //           Image.asset(data['icon']),
        //           Text(
        //             data['title'],
        //             style: textStyle,
        //           ),
        //         ],
        //       )));
        // }
      }
      row = Row(mainAxisAlignment: MainAxisAlignment.spaceAround, children: [
        ...rowList,
      ]);
      allRow.add(row);
      // column.children.add(Row());
      // column.children.add(SizedBox(
      //   width: 7,
      // ));
    }
    return Container(
      child: Column(
        children: [
          ...allRow,
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
    homeVM.loadHomeBanner((banner, success) {
      if (success) {
        this.setState(() {
          this.bannerList = banner;
        });
      }
    });

    // Map value = HomeService().getHomeBanner();
    // if (value['code'] == 0) {
    //   this.setState(() {
    //     this.bannerList = value['data'];
    //   });
    //   // this.initBannerData(value);
    // }
  }
}
