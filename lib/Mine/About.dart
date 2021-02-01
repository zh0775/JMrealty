import 'package:JMrealty/components/CustomAppBar.dart';
import 'package:JMrealty/components/ReadMe.dart';
import 'package:JMrealty/const/Default.dart';
import 'package:JMrealty/utils/sizeConfig.dart';
import 'package:flutter/material.dart';
import 'package:package_info/package_info.dart';

class About extends StatefulWidget {
  @override
  _AboutState createState() => _AboutState();
}

class _AboutState extends State<About> {
  double widthScale;
  double margin;
  double selfWidth;
  String version;
  String buildVersion;
  @override
  void initState() {
    PackageInfo.fromPlatform().then((PackageInfo packageInfo) {
      if (packageInfo != null) {
        if (mounted) {
          setState(() {
            version = packageInfo.version;
            buildVersion = packageInfo.buildNumber;
          });
        }
      }
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    SizeConfig().init(context);
    widthScale = SizeConfig.blockSizeHorizontal;
    margin = widthScale * 6;
    selfWidth = SizeConfig.screenWidth - margin * 2;
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: CustomAppbar(
        title: '关于',
      ),
      body: Container(
        width: SizeConfig.screenWidth,
        height: SizeConfig.screenHeight - kToolbarHeight,
        child: Stack(
          children: [
            Padding(
              padding: EdgeInsets.only(top: 30),
              child: Align(
                alignment: Alignment.topCenter,
                child: Column(
                  children: [
                    Image.asset(
                      'assets/images/icon/icon-app.png',
                      width: widthScale * 20,
                      height: widthScale * 20,
                    ),
                    Padding(
                      padding: EdgeInsets.only(top: 10),
                      child: Text(
                        'Version  ' +
                            (version ?? '') +
                            (buildVersion != null && buildVersion.length > 0
                                ? ('(' + buildVersion + ')')
                                : ''),
                        style: jm_text_black_bold_style17,
                      ),
                    ),
                  ],
                ),
              ),
            ),
            Positioned(
                top: SizeConfig.blockSizeVertical * 25,
                left: margin,
                child: GestureDetector(
                  onTap: () {
                    push(
                        ReadMe(
                          path: ReadPath.about,
                          title: '关于',
                        ),
                        context);
                  },
                  child: Container(
                    width: selfWidth,
                    height: 50,
                    decoration: BoxDecoration(
                        border: Border(
                            top: BorderSide(width: 1, color: jm_line_color),
                            bottom:
                                BorderSide(width: 1, color: jm_line_color))),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Row(
                          children: [
                            SizedBox(
                              width: widthScale * 6,
                            ),
                            Text(
                              '公司简介',
                              style: jm_text_black_style15,
                            ),
                          ],
                        ),
                        Icon(
                          Icons.chevron_right,
                          color: jm_text_gray,
                          size: widthScale * 6,
                        ),
                      ],
                    ),
                  ),
                )),
            GestureDetector(
              onTap: () {
                push(
                    ReadMe(
                      path: ReadPath.agree,
                      title: '隐私政策',
                    ),
                    context);
              },
              child: Padding(
                padding: EdgeInsets.only(bottom: 20),
                child: Align(
                  alignment: Alignment.bottomCenter,
                  child: Text(
                    '《隐私政策》',
                    style: jm_text_apptheme_style15,
                  ),
                ),
              ),
            )
          ],
        ),
      ),
    );
  }
}
