import 'dart:async';
import 'dart:convert' as convert;
import 'package:JMrealty/Client/ClientPool.dart';
import 'package:JMrealty/Client/viewModel/ClientListViewModel.dart';
import 'package:JMrealty/Follow/Follow.dart';
import 'package:JMrealty/Home/components/HomeAnno.dart';
import 'package:JMrealty/Home/components/HomeGoodDeed.dart';
import 'package:JMrealty/Home/components/HomeNaviBar.dart';
import 'package:JMrealty/Home/components/HomeScheduleToDo.dart';
import 'package:JMrealty/Home/viewModel/HomeViewModel.dart';
import 'package:JMrealty/Message/MessageTypeList.dart';
import 'package:JMrealty/MyTasks/MyTasks.dart';
import 'package:JMrealty/PK/PKmain.dart';
import 'package:JMrealty/Report/AddReport.dart';
import 'package:JMrealty/Report/Report.dart';
import 'package:JMrealty/Report/SmartReport.dart';
import 'package:JMrealty/base/image_loader.dart';
import 'package:JMrealty/components/AppWait.dart';
import 'package:JMrealty/components/CustomWebPlugin.dart';
import 'package:JMrealty/components/CustomWebV.dart';
import 'package:JMrealty/components/NoneV.dart';
import 'package:JMrealty/components/ReadMe.dart';
import 'package:JMrealty/const/Default.dart';
import 'package:JMrealty/services/http_config.dart';
import 'package:JMrealty/utils/EventBus.dart';
import 'package:JMrealty/utils/notify_default.dart';
import 'package:JMrealty/utils/sizeConfig.dart';
import 'package:JMrealty/utils/user_default.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter/services.dart';
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
  IndexClick indexClick = () => {};
  @override
  void initState() {
    Future.delayed(Duration.zero, () {
      AppWait appWait = AppWait(context: context);
      appWait.show();
    });
    super.initState();
  }

  int _tabbarIndex = 2;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: IndexedStack(
        index: _tabbarIndex,
        children: [
          Project(indexClick: indexClick),
          Client(indexClick: indexClick),
          Home(
            indexClick: indexClick,
          ),
          Message(indexClick: indexClick),
          Mine(indexClick: indexClick)
        ],
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
  HomeViewModel homeVM = HomeViewModel();
  ClientListViewModel clientVM = ClientListViewModel();
  Timer reqestTimer;
  // EasyRefreshController pullCtr = EasyRefreshController();
  // GlobalKey pullKey = GlobalKey();
  // GlobalKey pullHeaderKey = GlobalKey();
  List homeScheduleToDoData = [];
  List bannerList = [];
  List menus = [];
  List notices = [];
  List gladNotices = [];
  int reportReceiveCount = 0;
  EventBus _eventBus = EventBus();
  Map userInfoData = {};
  @override
  void deactivate() {
    // print('deactivate === home_deactivate');
    // bool isCurrent = ModalRoute.of(context).isCurrent;
    // if(isCurrent) loadReqest();
    super.deactivate();
  }

  @override
  void initState() {
    UserDefault.get(ACCESS_TOKEN).then((token) {
      if (token == null || token.length == 0) {
        Global.toLogin(animation: false);
      }
    });
    loadReqest();
    _eventBus.on(NOTIFY_LOGIN_SUCCESS, (arg) {
      loadReqest();
    });
    widget.indexClick();
    super.initState();
  }

  @override
  void dispose() {
    if (reqestTimer != null) {
      reqestTimer.cancel();
      reqestTimer = null;
    }
    super.dispose();
  }

  void loadReqest() async {
    String token = await UserDefault.get(ACCESS_TOKEN);

    getBanner();

    if (token != null && token.length > 0) {
      // 获取用户信息
      homeVM.loadUserInfo(
        finish: () {
          UserDefault.get(USERINFO).then((value) {
            Map userInfo = convert.jsonDecode(value);
            if (userInfo != null && userInfo.isNotEmpty) {
              // 获取消息
              userInfoData = Map.from(userInfo);
              homeVM.getHomeNotice(
                  Map<String, dynamic>.from({
                    'userId': userInfo['userId'],
                    'deptId': userInfo['deptId']
                  }), (noticeList, success) {
                if (success && mounted) {
                  setState(() {
                    notices = noticeList.map((e) {
                      return {...e, 'zzTitle': e['noticeTitle']};
                    }).toList();
                  });
                }
              });
            }
          });
        },
      );
      // 待办
      homeVM.getHomeWaitToDo((waitToDoList, success) {
        if (success && mounted) {
          setState(() {
            homeScheduleToDoData = waitToDoList;
          });
        }
      });

      // app首页【成交喜报】列表
      homeVM.getGladNotice((gladNoticeList, success) {
        if (success && mounted) {
          setState(() {
            gladNotices = gladNoticeList.map((e) {
              return {...e, 'zzTitle': e['content']};
            }).toList();
          });
        }
      });
      // 当日待跟进客户数量
      clientVM.loadCountProgress((success, count) {
        if (success) {
          _eventBus.emit(NOTIFY_CLIENTWAIT_COUNT, count);
        }
      });
      // app菜单权限
      homeVM.getHomeMenus((menuList, success) {
        if (success && menuList != null && menuList is List) {
          for (var i = 0; i < menuList.length; i++) {
            var item = menuList[i];
            if (item['path'] != null && item['path'] == 'app,main') {
              if (mounted) {
                setState(() {
                  menus = item['menu'] ?? [];
                });
              }
              break;
            }
          }
        }
      });

      // 强制客户跟进提醒
      clientVM.findOvertime((success, data) {
        if (success && mounted) {}
      });
      // 待跟进数量
      homeVM.getReportCount((reportCount, success) {
        if (success && mounted) {
          setState(() {
            reportReceiveCount = reportCount;
          });
        }
      });
      if (reqestTimer == null) {
        reqestTimer = Timer.periodic(Duration(minutes: 3), (Timer timer) {
          // 定时获取当日待跟进客户数量
          clientVM.loadCountProgress((success, count) {
            if (success) {
              _eventBus.emit(NOTIFY_CLIENTWAIT_COUNT, count);
            }
          });

          // 待跟进数量
          homeVM.getReportCount((reportCount, success) {
            if (success && mounted) {
              setState(() {
                reportReceiveCount = reportCount;
              });
            }
          });
          // 定时获取强制客户跟进提醒
          clientVM.findOvertime((success, data) {
            if (success) {}
          });
          // 定时获取app菜单权限
          homeVM.getHomeMenus((menuList, success) {
            if (success && menuList != null && menuList is List) {
              for (var i = 0; i < menuList.length; i++) {
                var item = menuList[i];
                if (item['path'] != null && item['path'] == 'app,main') {
                  if (mounted) {
                    setState(() {
                      menus = item['menu'] ?? [];
                    });
                  }
                  break;
                }
              }
            }
          });
          homeVM.getHomeWaitToDo((waitToDoList, success) {
            if (success && mounted) {
              setState(() {
                homeScheduleToDoData = waitToDoList;
              });
            }
          });
          // banner
          getBanner();
        });
        // 待办

      }
    }
  }

  double widgetHeight = 180.0;

  @override
  Widget build(BuildContext context) {
    return MediaQuery.removePadding(
        removeTop: true, context: context, child: homeBody());
  }

  Widget homeBody() {
    return SingleChildScrollView(
      physics: ClampingScrollPhysics(),
      child: Column(
        children: [
          HomeNaviBar(
            bannerDatas: bannerList,
            bannerPress: (position, entity) {
              if ((bannerList[position])['jumpConnection'] != null) {
                push(
                    ReadMe(
                      url: (bannerList[position])['jumpConnection'],
                      title: '公告',
                    ),
                    context);
              }
            },
          ),
          HomeAnno(
            dataList: notices ?? [],
            noticeClick: (index) {
              String url = (notices[index])['noticeUrl'];
              if (url != null && url.length > 0) {
                push(
                    ReadMe(
                        url: url, title: (notices[index])['noticeTitle'] ?? ''),
                    context);
              }
            },
          ),
          HomeGoodDeed(
            dataList: gladNotices ?? [],
            noticeClick: (index) {
              push(
                  MessageTypeList(
                    noticeType: 10,
                  ),
                  context);
            },
          ),
          HomeScheduleToDo(
            data: homeScheduleToDoData,
          ),
          SizedBox(
            height: 8,
          ),
          Wrap(
            children: [
              ...buttons((int buttonIndex, Map buttonData) {
                if (buttonData['path'] == 'app:main:report:list') {
                  // 新增报备
                  Navigator.of(context).push(CupertinoPageRoute(builder: (_) {
                    return AddReport(selfUserId: userInfoData['userId']);
                  }));
                } else if (buttonData['path'] == 'app:report:list') {
                  // 报备记录
                  Navigator.of(context).push(CupertinoPageRoute(builder: (_) {
                    return Report(
                      selfUserId: userInfoData['userId'],
                    );
                  }));
                } else if (buttonData['path'] == 'app:pk competition:list') {
                  // PK赛
                  Navigator.of(context).push(CupertinoPageRoute(builder: (_) {
                    return PKmain();
                  }));
                } else if (buttonData['path'] ==
                    'app:Follow up on progress:list') {
                  // 跟进记录
                  push(CustomWebV(path: WebPath.followProgress), context);
                } else if (buttonData['path'] == 'app:customer pool:list') {
                  // 客户池
                  Navigator.of(context).push(CupertinoPageRoute(builder: (_) {
                    return ClientPool();
                  }));
                } else if (buttonData['path'] == 'app:task:list') {
                  // 我的任务
                  Navigator.of(context).push(CupertinoPageRoute(builder: (_) {
                    return MyTasks();
                  }));
                } else if (buttonData['path'] ==
                    'app:lntelligent report:list') {
                  // 智能报备
                  Navigator.of(context).push(CupertinoPageRoute(builder: (_) {
                    return SmartReport();
                  }));
                } else if (buttonData['path'] == 'app:summary:list') {
                  // _goToNativePage();
                  // 每日总结
                  // push(CustomWebPlugin(path: WebPaths.summary), context);
                  push(CustomWebV(path: WebPath.summary), context);
                } else if (buttonData['path'] == 'app:Top of the list:list') {
                  // 榜单

                  // push(CustomWebPlugin(path: WebPaths.rankingList), context);
                  push(CustomWebV(path: WebPath.rankingList), context);
                } else if (buttonIndex == 100) {
                  // 跟进记录
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
                } else if (buttonData['path'] ==
                    'app:unidentified personnel:list') {
                  // 未开单人员
                  push(CustomWebV(path: WebPath.follow), context);
                } else if (buttonData['path'] ==
                    'app:shell breaking rate:list') {
                  // 破壳率
                  push(CustomWebV(path: WebPath.breakingRate), context);
                } else if (buttonData['path'] == 'app:statistics:list') {
                  // 统计
                  push(CustomWebV(path: WebPath.statisticsMain), context);
                } else if (buttonData['path'] == 'app:main:lower') {
                  // 低绩效
                  push(CustomWebV(path: WebPath.lowPer), context);
                }
              }),
            ],
          ),
          SizedBox(
            height: 10,
          )
        ],
      ),
    );
  }

  Future<void> _goToNativePage() async {
    const platform = const MethodChannel('com.jm/jmGoToNativePage');
    try {
      String token = await UserDefault.get(ACCESS_TOKEN);
      String userInfo = await UserDefault.get(USERINFO);
      Map info = convert.jsonDecode(userInfo);
      Map params =
          Map<String, dynamic>.from({'token': token, 'deptId': info['deptId']});
      String json = convert.jsonEncode(params);
      // String js_String = "let json = " +
      //     "'" +
      //     json +
      //     "'" +
      //     '; ' +
      //     'getDataFromNative(json);';
      String jsString = "getDataFromNative('$json');";
      final int result = await platform.invokeMethod(
          'goToNativePage', {'url': WEB_URL + 'summary', 'json': jsString});
      print('result === $result');
    } on PlatformException catch (e) {
      print(e);
    }
  }

  List<Widget> buttons(buttonClick) {
    double buttonWidth = SizeConfig.screenWidth / 5;
    double buttonHeight = SizeConfig.screenWidth / 5;
    List<Widget> allRow = [];
    if (menus != null && menus is List && menus.length > 0) {
      int i = 0;
      menus.forEach((e) {
        if (e['path'] == 'app:report:list') {
          allRow.add(RawMaterialButton(
              constraints: BoxConstraints(
                  minHeight: buttonHeight, minWidth: buttonWidth),
              child: Stack(
                overflow: Overflow.visible,
                children: [
                  Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      SizedBox(
                        width: buttonWidth * 0.45,
                        height: buttonHeight * 0.45,
                        // child: Image.network(
                        //   e['icon'] ?? '',
                        //   fit: BoxFit.fill,
                        // )
                        child: ImageLoader(e['icon'] ?? ''),
                      ),
                      SizedBox(
                        height: 6,
                      ),
                      Text(
                        e['menuName'] ?? '',
                        style: jm_text_black_style14,
                      )
                    ],
                  ),
                  reportReceiveCount != null && reportReceiveCount > 0
                      ? Positioned(
                          right: 4,
                          top: -4,
                          child: Container(
                            width: 18,
                            height: 18,
                            alignment: Alignment.center,
                            decoration: BoxDecoration(
                                color: Colors.red,
                                borderRadius: BorderRadius.circular(9)),
                            child: Text(
                              reportReceiveCount > 99
                                  ? '99'
                                  : reportReceiveCount.toString(),
                              style:
                                  TextStyle(color: Colors.white, fontSize: 10),
                            ),
                          ))
                      : NoneV(),
                ],
              ),
              onPressed: () {
                buttonClick(i, e);
              }));
        } else {
          allRow.add(RawMaterialButton(
              constraints: BoxConstraints(
                  minHeight: buttonHeight, minWidth: buttonWidth),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  SizedBox(
                    width: buttonWidth * 0.45,
                    height: buttonHeight * 0.45,
                    // child: Image.network(
                    //   e['icon'] ?? '',
                    //   fit: BoxFit.fill,
                    // )
                    child: ImageLoader(e['icon'] ?? ''),
                  ),
                  SizedBox(
                    height: 6,
                  ),
                  Text(
                    e['menuName'] ?? '',
                    style: jm_text_black_style14,
                  )
                ],
              ),
              onPressed: () {
                buttonClick(i, e);
              }));
        }

        i++;
      });
    }
    return allRow;
  }

  void getBanner() {
    homeVM.loadHomeBanner((banner, success) {
      if (success) {
        setState(() {
          bannerList = banner;
        });
      }
    });
  }
}
