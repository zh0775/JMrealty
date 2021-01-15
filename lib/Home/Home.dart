import 'dart:convert' as convert;
import 'package:JMrealty/Client/ClientPool.dart';
import 'package:JMrealty/Client/viewModel/ClientListViewModel.dart';
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
import 'package:JMrealty/Report/SmartReport.dart';
import 'package:JMrealty/base/image_loader.dart';
import 'package:JMrealty/components/CustomPullHeader.dart';
import 'package:JMrealty/components/CustomWebV.dart';
import 'package:JMrealty/const/Default.dart';
import 'package:JMrealty/utils/EventBus.dart';
import 'package:JMrealty/utils/notify_default.dart';
import 'package:JMrealty/utils/sizeConfig.dart';
import 'package:JMrealty/utils/user_default.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_easyrefresh/easy_refresh.dart';
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
  // EasyRefreshController pullCtr = EasyRefreshController();
  // GlobalKey pullKey = GlobalKey();
  // GlobalKey pullHeaderKey = GlobalKey();
  List homeScheduleToDoData = [];
  var bannerList = [];
  List menus = [];
  List notices = [];
  List gladNotices = [];
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
    UserDefault.get(ACCESS_TOKEN).then((token) {
      if (token == null || token.length == 0) {
        Global.toLogin();
      }
    });
    loadReqest();
    _eventBus.on(NOTIFY_LOGIN_SUCCESS, (arg) {
      loadReqest();
    });
    widget.indexClick();
    super.initState();
  }

  void loadReqest() async {
    String token = await UserDefault.get(ACCESS_TOKEN);

    getBanner();
    homeVM.getHomeMenus((menuList, success) {
      if (success) {
        setState(() {
          menus = (menuList[3])['menu'];
        });
      }
    });
    if (token != null && token.length > 0) {
      homeVM.loadUserInfo(
        finish: () {
          UserDefault.get(USERINFO).then((value) {
            Map userInfo = convert.jsonDecode(value);
            if (userInfo != null && userInfo.isNotEmpty) {
              homeVM.getHomeNotice(
                  Map<String, dynamic>.from({
                    'userId': userInfo['userId'],
                    'deptId': userInfo['deptId']
                  }), (noticeList, success) {
                if (success) {
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
      homeVM.getHomeWaitToDo((waitToDoList, success) {
        if (success) {
          setState(() {
            homeScheduleToDoData = waitToDoList;
          });
        }
      });
      homeVM.getGladNotice((gladNoticeList, success) {
        if (success) {
          setState(() {
            gladNotices = gladNoticeList.map((e) {
              return {...e, 'zzTitle': e['content']};
            }).toList();
          });
        }
      });
      ClientListViewModel().loadClientList({'status': 0},
          success: (data, total) {
        _eventBus.emit(NOTIFY_CLIENTWAIT_COUNT, total);
      });
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
            HomeAnno(
              dataList: notices ?? [],
              noticeClick: (index) {},
            ),
            HomeGoodDeed(
              dataList: gladNotices ?? [],
              noticeClick: (index) {},
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
                  if (buttonData['menuId'] == 2061) {
                    // 新增报备
                    Navigator.of(context).push(CupertinoPageRoute(builder: (_) {
                      return AddReport();
                    }));
                  } else if (buttonData['menuId'] == 2063) {
                    // 报备记录
                    Navigator.of(context).push(CupertinoPageRoute(builder: (_) {
                      return Report();
                    }));
                  } else if (buttonData['menuId'] == 2080) {
                    // PK赛
                    Navigator.of(context).push(CupertinoPageRoute(builder: (_) {
                      return PKmain();
                    }));
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
                  } else if (buttonData['menuId'] == 2078) {
                    // 客户池
                    Navigator.of(context).push(CupertinoPageRoute(builder: (_) {
                      return ClientPool();
                    }));
                  } else if (buttonData['menuId'] == 2086) {
                    // 我的任务
                    Navigator.of(context).push(CupertinoPageRoute(builder: (_) {
                      return MyTasks();
                    }));
                  } else if (buttonData['menuId'] == 2084) {
                    // 智能报备
                    Navigator.of(context).push(CupertinoPageRoute(builder: (_) {
                      return SmartReport();
                    }));
                  } else if (buttonData['menuId'] == 2092) {
                    // 每日总结
                    // UserDefault.get(ACCESS_TOKEN).then((token) {
                    //   if (token != null) {
                    //     UserDefault.get(USERINFO).then((userInfo) {
                    //       if (userInfo != null) {
                    //         Map<String, dynamic> userInfoMap =
                    //             Map<String, dynamic>.from(
                    //                 convert.jsonDecode(userInfo));
                    //         Navigator.of(context)
                    //             .push(CupertinoPageRoute(builder: (_) {
                    //           return Follow(
                    //             token: token,
                    //             deptId: userInfoMap['deptId'],
                    //           );
                    //         }));
                    //       } else {
                    //         homeVM.loadUserInfo();
                    //       }
                    //     });
                    //   } else {
                    //     Global.toLogin(isLogin: true);
                    //   }
                    // });
                    push(CustomWebV(path: WebPath.summary), context);
                    // push(CustomWebV(path: WebPath.statisticsMain), context);
                  } else if (buttonData['menuId'] == 2082) {
                    // 榜单
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
                  }
                }),
              ],
            ),
            SizedBox(
              height: 10,
            )
          ],
        ),
      ),
    );
  }

  List<Widget> buttons(buttonClick) {
    double buttonWidth = SizeConfig.screenWidth / 5;
    double buttonHeight = SizeConfig.screenWidth / 5;
    List<Widget> allRow = [];
    if (menus != null && menus is List && menus.length > 0) {
      int i = 0;
      menus.forEach((e) {
        allRow.add(RawMaterialButton(
            constraints:
                BoxConstraints(minHeight: buttonHeight, minWidth: buttonWidth),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                SizedBox(
                  width: buttonWidth * 0.45,
                  height: buttonHeight * 0.45,
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
        i++;
      });
    }
    return allRow;
  }

  void getBanner() {
    homeVM.loadHomeBanner((banner, success) {
      if (success) {
        this.setState(() {
          this.bannerList = banner;
        });
      }
    });
  }
}
