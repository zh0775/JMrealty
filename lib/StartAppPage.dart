import 'dart:async';

import 'package:JMrealty/base/appstart_viewmodel.dart';
// import 'package:JMrealty/base/base_viewmodel.dart';
// import 'package:JMrealty/base/image_loader.dart';
// import 'package:JMrealty/base/provider_widget.dart';
import 'package:JMrealty/components/NoneV.dart';
// import 'package:JMrealty/const/Routes.dart';
import 'package:JMrealty/utils/sizeConfig.dart';
import 'package:flutter/material.dart';

class StartAppPage extends StatefulWidget {
  final Function() timeOut;
  const StartAppPage({this.timeOut});
  @override
  _StartAppPageState createState() => _StartAppPageState();
}

class _StartAppPageState extends State<StartAppPage> {
  AppStartViewModel _appstartVM = AppStartViewModel();
  Timer passTimer;
  Timer imgWaitTimer;
  int waitTime = 4;
  String imageUrl;

  @override
  void dispose() {
    _appstartVM.dispose();
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
    super.initState();
    _appstartVM.load(
      success: (success, imgUrl) {
        if (success) {
          setState(() {
            imageUrl = imgUrl;
          });
        }
      },
    );
    passTimer = Timer(Duration(seconds: 5), () {
      toMain(context);
    });
  }

  void startShowImg() {
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
  }

  @override
  Widget build(BuildContext context) {
    SizeConfig().init(context);
    return Stack(
      children: [
        _getStartBg(),
        // Offstage(
        //   offstage: imageUrl == null,
        //   child: _getStartBg(),
        // ),
        _getStart(),
        // Offstage(
        //   offstage: imageUrl != null,
        //   child: _getStart(),
        // ),
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
                        borderRadius: BorderRadius.all(Radius.circular(15))),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text(
                          '跳过' + '   ' + waitTime.toString(),
                          style: TextStyle(color: Colors.white, fontSize: 13),
                        ),
                      ],
                    ),
                  ),
                ))
            : NoneV()
      ],
    );
  }

  Widget _getStart() {
    return imageUrl != null
        ? Image.network(imageUrl,
            width: double.infinity,
            height: double.infinity,
            fit: BoxFit.fill,
            gaplessPlayback: true,
            loadingBuilder: (context, child, loadingProgress) {
              if (loadingProgress != null &&
                  loadingProgress.expectedTotalBytes != null &&
                  loadingProgress.cumulativeBytesLoaded >
                      loadingProgress.expectedTotalBytes) {
                return _getStartBg();
              } else {
                startShowImg();
                return child;
              }

              // return _getStartBg();

              //             loadingProgress.expectedTotalBytes != null
              // ///                 ? loadingProgress.cumulativeBytesLoaded / loadingProgress.expectedTotalBytes
              // ///                 : null,

              //             if (loadingProgress == null) {
              //               startShowImg();
              //               return child;
              //             } else {
              //               return _getStartBg();
              //             }
            },
            errorBuilder: (context, error, stackTrace) => _getStartBg())
        : NoneV();

    // ImageLoader(
    //   imageUrl ?? '',
    //   height: SizeConfig.screenHeight,
    //   fit: BoxFit.fill,
    //   placeholder: (context, url) => _getStartBg(),
    //   errorWidget: (context, url, error) => _getStartBg(),
    // );
  }

  Widget _getStartBg() {
    return Image.asset(
      'assets/images/icon/screen-1242x2688.png',
      height: double.infinity,
      width: double.infinity,
      fit: BoxFit.fill,
    );
  }

  toMain(BuildContext context) {
    if (widget.timeOut != null) {
      widget.timeOut();
    }
    // Future.delayed(Duration(seconds: 0), () {
    //   // Navigator.of(context).push(route)
    //   // Navigator.of(context).popAndPushNamed(PageRouteBuilder(pageBuilder: ))
    //   Navigator.of(context).popAndPushNamed(Routes.main_page);
    //   // Navigator.of(context).replace(oldRoute: null, newRoute: null)
    // });
  }
}
