import 'package:JMrealty/Home/viewModel/HomeViewModel.dart';
import 'package:JMrealty/Mine/LevelTargetSetting.dart';
import 'package:JMrealty/Mine/components/MineTop.dart';
import 'package:JMrealty/Mine/viewModel/MineViewModel.dart';
import 'package:JMrealty/const/Default.dart';
import 'package:JMrealty/utils/EventBus.dart';
import 'package:JMrealty/utils/notify_default.dart';
import 'package:JMrealty/utils/sizeConfig.dart';
import 'package:JMrealty/utils/user_default.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'dart:convert' as convert;
import 'package:flutter_easyrefresh/easy_refresh.dart';

class Mine extends StatefulWidget {
  final IndexClick indexClick;
  const Mine({this.indexClick});
  @override
  _MineState createState() => _MineState();
}

class _MineState extends State<Mine> {
  HomeViewModel homeVM = HomeViewModel();
  MineViewModel mineVM = MineViewModel();
  EasyRefreshController pullCtr = EasyRefreshController();
  GlobalKey pullKey = GlobalKey();
  double topHeight = 200;
  double widthScale;
  double margin;
  double selfWidth;

  Map userInfo = {};
  Map targetData = {};
  var bus = EventBus();
  @override
  void initState() {
    loadMineRequest();
    bus.on(NOTIFY_USER_INFO, (arg) {
      setState(() {
        userInfo = Map<String, dynamic>.from(convert.jsonDecode(arg));
      });
    });
    bus.on(NOTIFY_LOGIN_SUCCESS, (arg) {
      loadMineRequest();
    });
    super.initState();
  }
  @override
  void dispose() {
    super.dispose();
  }

  loadMineRequest(){
    homeVM.loadUserInfo(
      finish: () {
        UserDefault.get(USERINFO).then((value) {
          setState(() {
            userInfo =
            Map<String, dynamic>.from(convert.jsonDecode(value));
            mineVM.loadMonthTarget(userInfo['userId'], (success, data) {
              if (success) {
                setState(() {
                  targetData = data;
                });
              }
            });
          });
        });
      },
    );
  }

  changeInfo(Map info) {
    mineVM.changeInfo(info, (success){
      if (success) {
        loadMineRequest();
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    SizeConfig().init(context);
    widthScale = SizeConfig.blockSizeHorizontal;
    margin = widthScale * 6;
    selfWidth = SizeConfig.screenWidth - margin * 2;

    return Scaffold(
      backgroundColor: Colors.white,
      body: EasyRefresh(
        key: pullKey,
          // controller: pullCtr,
          // header: PhoenixHeader(),
          onRefresh: () async {
            loadMineRequest();
          },
          child: SingleChildScrollView(
            child: Column(
              children: [
                MineTop(
                  data: userInfo,
                  height: topHeight,
                  targetData: targetData,
                  toLevelSetting: () {

                  },
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    RawMaterialButton(
                      fillColor: jm_appTheme,
                      elevation: 2,
                      highlightElevation: 2,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(widthScale * 3),
                      ),
                      onPressed: () {},
                      child: SizedBox(
                        width: widthScale * 30,
                        height: 50,
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Icon(
                              Icons.flag,
                              color: Color(0xfff9e6c2),
                            ),
                            SizedBox(
                              width: widthScale * 1,
                            ),
                            Text(
                              '设置目标',
                              style:
                                  TextStyle(color: Colors.white, fontSize: 15),
                            )
                          ],
                        ),
                      ),
                    ),
                  ],
                ),
                SizedBox(
                  height: 20,
                ),
                JMline(width: SizeConfig.screenWidth, height: 0.5),
                getCell('等级目标设置', Icons.grading, () {
                  Navigator.of(context).push(CupertinoPageRoute(
                    builder: (_) {
                      return LevelTargetSetting(deptId: userInfo['deptId']);
                    },
                  ));
                }),
                JMline(width: SizeConfig.screenWidth, height: 0.5),
                getCell('日报模板管理', Icons.grading, () {}),
                JMline(
                    margin: margin,
                    width: SizeConfig.screenWidth - margin,
                    height: 0.5),
                getCell('关于', Icons.info, () {}),
                JMline(
                    margin: margin,
                    width: SizeConfig.screenWidth - margin,
                    height: 0.5),
                // getCell('版本更新', Icons.update, () {}),
                // JMline(width: SizeConfig.screenWidth, height: 0.5),
              ],
            ),
          )),
    );
  }

  Widget getCell(String title, IconData icons, Function() onPressed) {
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
                Icon(
                  icons,
                  size: widthScale * 5,
                  color: jm_appTheme,
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
