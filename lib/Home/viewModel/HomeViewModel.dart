import 'package:JMrealty/base/base_viewmodel.dart';
import 'package:JMrealty/const/Config.dart';
import 'package:JMrealty/services/Urls.dart';
import 'package:JMrealty/services/http.dart';
import 'package:JMrealty/services/http_config.dart';
import 'package:JMrealty/utils/EventBus.dart';
import 'package:JMrealty/utils/notify_default.dart';
import 'package:JMrealty/utils/user_default.dart';
import 'package:intl/intl.dart';
import 'dart:convert' as convert;

import 'package:jpush_flutter/jpush_flutter.dart';

class HomeViewModel extends BaseViewModel {
  Map<String, dynamic> userInfo;
  var bus = EventBus();
  loadUserInfo({Function() finish}) {
    state = BaseState.LOADING;
    notifyListeners();
    Http().get(
      Urls.getUserInfo,
      {},
      success: (json) {
        if (json['code'] == 200) {
          initPlatformState(json['data']);
          UserDefault.saveStr(USERINFO, convert.jsonEncode(json['data']))
              .then((value) {
            if (value) {
              bus.emit(NOTIFY_USER_INFO, convert.jsonEncode(json['data']));
              state = BaseState.CONTENT;
              notifyListeners();
              if (finish != null) {
                finish();
              }
            }
          });
        } else {}
      },
      fail: (reason, code) {},
      after: () {},
    );
  }

  Future<void> initPlatformState(Map user) async {
    if (user == null) return;
    final JPush jPush = JPush();

    // print('setAlias === ${user['userId']}_$JPUSH_ENVIRONMENT');
    String alias = '${user['userId']}_alias_$JPUSH_ENVIRONMENT';
    jPush.setAlias(alias).then((value) {
      print('setAlias: $value');
    });
    jPush.setTags([
      '${user['deptId']}_tag_$JPUSH_ENVIRONMENT',
      'jinMu_tag_$JPUSH_ENVIRONMENT',
    ]).then((value) {
      print('setTags: $value');
    });
  }

  loadHomeBanner(Function(List bannerList, bool success) success) {
    Http().get(
      Urls.getHomeBanner,
      {},
      success: (json) {
        if (json['code'] == 200) {
          if (success != null) {
            success(json['data'], true);
          }
        } else {
          if (success != null) {
            success(null, false);
          }
        }
      },
      fail: (reason, code) {
        if (success != null) {
          success(null, false);
        }
      },
    );
  }

  getHomeNotice(Map params, Function(List noticeList, bool success) success) {
    Http().get(
      Urls.getHomeNotice,
      params,
      success: (json) {
        if (json['code'] == 200) {
          if (success != null) {
            success((json['data'])['rows'], true);
          }
        } else {
          if (success != null) {
            success(null, false);
          }
        }
      },
      fail: (reason, code) {
        if (success != null) {
          success(null, false);
        }
      },
    );
  }

  getGladNotice(Function(List gladNoticeList, bool success) success) {
    Http().get(
      Urls.getGladNotice,
      {'noticeType': 10},
      success: (json) {
        if (json['code'] == 200) {
          if (success != null) {
            success(json['data'], true);
          }
        } else {
          if (success != null) {
            success(null, false);
          }
        }
      },
      fail: (reason, code) {
        if (success != null) {
          success(null, false);
        }
      },
    );
  }

  getHomeWaitToDo(Function(List waitToDoList, bool success) success) {
    DateTime start = DateTime.now();
    int weekDay = start.weekday == 7 ? 0 : start.weekday;
    start = start.subtract(Duration(days: weekDay));
    DateTime end = DateTime.now();
    end = start.add(Duration(days: 6));
    DateFormat dateFormat = DateFormat('yyyy-MM-dd');
    Http().get(
      Urls.allTodoHandler,
      {
        'startTime': dateFormat.format(start),
        'endTime': dateFormat.format(end)
      },
      success: (json) {
        if (json['code'] == 200) {
          if (success != null) {
            success(json['data'], true);
          }
        } else {
          if (success != null) {
            success(null, false);
          }
        }
      },
      fail: (reason, code) {
        if (success != null) {
          success(null, false);
        }
      },
    );
  }

  getHomeMenus(Function(List menuList, bool success) success) {
    Http().get(
      Urls.getHomeMenus,
      {},
      success: (json) {
        if (json['code'] == 200) {
          if (success != null) {
            UserDefault.saveStr(HOME_MENUS, convert.jsonEncode(json['data']))
                .then((value) {
              if (value) {
                bus.emit(NOTIFY_HOME_MENUS, convert.jsonEncode(json['data']));
                success(json['data'], true);
              }
            });
          }
        } else {
          if (success != null) {
            success(null, false);
          }
        }
      },
      fail: (reason, code) {
        if (success != null) {
          success(null, false);
        }
      },
    );
  }

  getReportCount(Function(int reportCount, bool success) success) {
    Http().get(
      Urls.selectReportCountByStatus,
      {'status': 0},
      success: (json) {
        if (json['code'] == 200) {
          if (success != null) {
            success(json['data'], true);
          }
        } else {
          if (success != null) {
            success(null, false);
          }
        }
      },
      fail: (reason, code) {
        if (success != null) {
          success(null, false);
        }
      },
    );
  }
}
