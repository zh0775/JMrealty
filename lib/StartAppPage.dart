import 'dart:async';

import 'package:JMrealty/base/appstart_viewmodel.dart';
import 'package:JMrealty/base/base_viewmodel.dart';
import 'package:JMrealty/base/image_loader.dart';
import 'package:JMrealty/base/provider_widget.dart';
import 'package:JMrealty/components/NoneV.dart';
import 'package:JMrealty/const/Routes.dart';
import 'package:JMrealty/utils/sizeConfig.dart';
import 'package:flutter/material.dart';

class StartAppPage extends StatefulWidget {
  @override
  _StartAppPageState createState() => _StartAppPageState();
}

class _StartAppPageState extends State<StartAppPage> {
  Timer passTimer;
  Timer imgWaitTimer;
  int waitTime = 4;

  @override
  void dispose() {
    if (passTimer != null) {
      passTimer.cancel();
      passTimer = null;
    }
    if (imgWaitTimer != null) {
      imgWaitTimer.cancel();
      imgWaitTimer = null;
    }
    super.dispose();
  }

  @override
  void initState() {
    passTimer = Timer(Duration(seconds: 2), () {
      toMain(context);
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    SizeConfig().init(context);
    return ProviderWidget<AppStartViewModel>(
        model: AppStartViewModel(),
        onReady: (model) {
          model.load();
        },
        builder: (context, model, child) {
          if (model.state == BaseState.CONTENT && model.startImgUrl != null) {
            if (passTimer != null) {
              passTimer.cancel();
              passTimer = null;
            }
            if (imgWaitTimer == null) {
              imgWaitTimer = Timer.periodic(Duration(seconds: 1), (timer) {
                setState(() {
                  waitTime--;
                });
                if (waitTime == 0) {
                  timer.cancel();
                  timer = null;
                  toMain(context);
                }
              });
            }
            return Stack(
              children: [
                Positioned(
                    left: 0,
                    right: 0,
                    top: 0,
                    bottom: 0,
                    child: ImageLoader(
                      model.startImgUrl,
                      height: SizeConfig.screenHeight,
                      fit: BoxFit.fill,
                    )),
                waitTime <= 3
                    ? Positioned(
                        right: 15,
                        bottom: 30,
                        child: TextButton(
                          onPressed: () {
                            if (passTimer != null) {
                              passTimer.cancel();
                              passTimer = null;
                            }
                            if (imgWaitTimer != null) {
                              imgWaitTimer.cancel();
                              imgWaitTimer = null;
                            }
                            toMain(context);
                          },
                          child: Container(
                            height: 30,
                            width: 80,
                            decoration: BoxDecoration(
                                color: Color.fromRGBO(0, 0, 0, 0.5),
                                borderRadius:
                                    BorderRadius.all(Radius.circular(15))),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Text(
                                  '跳过' + '   ' + waitTime.toString(),
                                  style: TextStyle(
                                      color: Colors.white, fontSize: 13),
                                ),
                              ],
                            ),
                          ),
                        ))
                    : NoneV()
              ],
            );
          }
          return Container(
            color: Colors.white,
          );
        });
  }

  toMain(BuildContext context) {
    Future.delayed(Duration(seconds: 0), () {
      Navigator.of(context).popAndPushNamed(Routes.main_page);
      // Navigator.of(context).replace(oldRoute: null, newRoute: null)
    });
  }
}
