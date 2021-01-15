import 'package:JMrealty/services/Urls.dart';
import 'package:JMrealty/services/http.dart';
import 'package:JMrealty/utils/notify_default.dart';
import 'package:JMrealty/utils/user_default.dart';
import 'dart:convert' as convert;

class MessageViewModel {
  loadMessageList(Function(List messageList, bool success) success) {
    UserDefault.get(USERINFO).then((userInfo) {
      if (userInfo != null && userInfo != 'null') {
        Map<String, dynamic> userInfoMap =
            Map<String, dynamic>.from(convert.jsonDecode(userInfo));

        Http().get(
          Urls.messageList,
          {'userId': userInfoMap['userId'], 'deptId': userInfoMap['deptId']},
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
    });
  }

  loadMessageTypeList(
      int noticeType, Function(List messageList, bool success) success) {
    UserDefault.get(USERINFO).then((userInfo) {
      if (userInfo != null) {
        Map<String, dynamic> userInfoMap =
            Map<String, dynamic>.from(convert.jsonDecode(userInfo));

        Http().get(
          Urls.messageTypeList,
          {
            'userId': userInfoMap['userId'],
            'deptId': userInfoMap['deptId'],
            'noticeType': noticeType
          },
          success: (json) {
            if (json['code'] == 200) {
              if (success != null) {
                success(
                    json['data'] != null ? (json['data'])['rows'] : [], true);
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
    });
  }

  // loadUserInfo({Function() finish}) {
  //   Http().get(
  //     Urls.getUserInfo,
  //     {},
  //     success: (json) {
  //       UserDefault.saveStr(USERINFO, convert.jsonEncode(json['data']))
  //           .then((value) {
  //         if (value) {
  //           bus.emit(NOTIFY_USER_INFO, convert.jsonEncode(json['data']));
  //           if (finish != null) {
  //             finish();
  //           }
  //         }
  //       });
  //     },
  //     fail: (reason, code) {},
  //     after: () {},
  //   );
  // }
  loadRead(Map params, {Function(bool success) success}) {
    Http().get(
      Urls.messageRead,
      Map<String, dynamic>.from(params),
      success: (json) {
        if (json['code'] == 200) {
          if (success != null) {
            success(true);
          }
        } else {
          if (success != null) {
            success(false);
          }
        }
      },
      fail: (reason, code) {
        if (success != null) {
          success(false);
        }
      },
    );
  }
}
