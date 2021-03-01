import 'package:JMrealty/components/CustomAlert.dart';
import 'package:JMrealty/components/CustomAppBar.dart';
import 'package:JMrealty/const/Default.dart';
import 'package:JMrealty/services/Urls.dart';
import 'package:JMrealty/services/http.dart';
import 'package:JMrealty/utils/notify_default.dart';
import 'package:JMrealty/utils/sizeConfig.dart';
import 'package:JMrealty/utils/user_default.dart';
import 'package:flutter/material.dart';
import 'package:jpush_flutter/jpush_flutter.dart';

class More extends StatefulWidget {
  @override
  _MoreState createState() => _MoreState();
}

class _MoreState extends State<More> {
  LogoutViewModel _logoutViewModel = LogoutViewModel();
  double widthScale;
  double margin;
  double selfWidth;
  @override
  Widget build(BuildContext context) {
    SizeConfig().init(context);
    widthScale = SizeConfig.blockSizeHorizontal;
    margin = widthScale * 6;
    selfWidth = SizeConfig.screenWidth - margin * 2;
    return Scaffold(
      appBar: CustomAppbar(
        title: '更多',
      ),
      body: Column(
        children: [
          getCell('离职', 'icon_mine_dimission.png', () {
            CustomAlert(content: '是否确认离职').show(
              confirmClick: () {
                _logoutViewModel.dimissionRequest(
                  success: (success) {
                    if (success) {
                      final jpush = JPush();
                      jpush.deleteAlias();
                      jpush.cleanTags();
                      // jpush.clearAllNotifications();
                      // jpush.setBadge(0);
                      // jpush.stopPush();
                      UserDefault.saveStr(USERINFO, null);
                      UserDefault.saveStr(ACCESS_TOKEN, null).then((value) {
                        if (value) {
                          Global.toLogin();
                        }
                      });
                      popToMine();
                    }
                  },
                );
              },
            );
          }),
          getCell('退出登录', 'icon_mine_logout.png', () {
            CustomAlert(content: '是否确认退出').show(
              confirmClick: () {
                final jpush = JPush();
                jpush.deleteAlias();
                jpush.cleanTags();
                // jpush.clearAllNotifications();
                // jpush.setBadge(0);
                // jpush.stopPush();
                UserDefault.saveStr(USERINFO, null);
                UserDefault.saveStr(ACCESS_TOKEN, null).then((value) {
                  if (value) {
                    Global.toLogin();
                  }
                });
                popToMine();
              },
            );
          }),
        ],
      ),
    );
  }

  void popToMine() {
    if (Navigator.canPop(context)) {
      Navigator.pop(context);
    }
  }

  Widget getCell(String title, String icons, Function() onPressed) {
    return GestureDetector(
      onTap: onPressed,
      child: Container(
        height: 50,
        color: Colors.white,
        width: SizeConfig.screenWidth,
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Row(
              children: [
                SizedBox(
                  width: margin,
                ),
                Image.asset(
                  'assets/images/icon/$icons',
                  width: title == '等级目标设置' ? widthScale * 5.5 : widthScale * 5,
                  height: title == '等级目标设置' ? widthScale * 5.5 : widthScale * 5,
                  fit: BoxFit.fill,
                ),
                SizedBox(
                  width: widthScale * 3,
                ),
                Text(
                  title,
                  style: jm_text_black_style14,
                )
              ],
            ),
            Row(
              children: [
                Icon(
                  Icons.arrow_forward_ios,
                  size: widthScale * 4,
                  color: Color(0xff828182),
                ),
                SizedBox(
                  width: margin,
                )
              ],
            ),
          ],
        ),
      ),
    );
  }
}

class LogoutViewModel {
  logOutRequest({Function(bool success) success}) {
    Http().delete(
      Urls.logout,
      {},
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

  dimissionRequest({Function(bool success) success}) {
    Http().get(
      Urls.dimission,
      {},
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
