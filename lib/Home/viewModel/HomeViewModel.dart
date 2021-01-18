import 'package:JMrealty/base/base_viewmodel.dart';
import 'package:JMrealty/services/Urls.dart';
import 'package:JMrealty/services/http.dart';
import 'package:JMrealty/utils/EventBus.dart';
import 'package:JMrealty/utils/notify_default.dart';
import 'package:JMrealty/utils/user_default.dart';
import 'package:intl/intl.dart';
import 'dart:convert' as convert;

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
      },
      fail: (reason, code) {},
      after: () {},
    );
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
    start = start.subtract(Duration(days: start.weekday - 1));
    DateTime end = DateTime.now();
    end = end.add(Duration(days: (7 - end.weekday)));
    DateFormat dateFormat = DateFormat('yyyy-MM-dd');
    Http().get(
      Urls.getHomeWaitToDo,
      {
        'startTime': dateFormat.format(start),
        'endTime': dateFormat.format(end)
      },
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
}
