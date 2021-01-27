import 'package:JMrealty/PK/PKadd.dart';
import 'package:JMrealty/PK/PKmainList.dart';
import 'package:JMrealty/const/Default.dart';
import 'package:JMrealty/utils/sizeConfig.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class PKmain extends StatefulWidget {
  @override
  _PKmainState createState() => _PKmainState();
}

class _PKmainState extends State<PKmain> {
  Color tabColor = Color(0xff404352);
  double topHeight = 178;
  double widthScale;
  double margin;
  double selfWidth;

  @override
  void initState() {
    super.initState();
  }

  @override
  void dispose() {
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    SizeConfig().init(context);
    widthScale = SizeConfig.blockSizeHorizontal;
    margin = widthScale * 6;
    selfWidth = SizeConfig.screenWidth - margin * 2;
    return Scaffold(
        body: DefaultTabController(
      length: 4,
      child: Container(
        constraints: BoxConstraints(
          maxHeight: SizeConfig.screenHeight,
          maxWidth: SizeConfig.screenWidth,
        ),
        width: SizeConfig.screenWidth,
        height: SizeConfig.screenHeight,
        child: Stack(
          children: [
            Positioned(
              top: 0,
              left: 0,
              right: 0,
              height: topHeight,
              child: Image.asset(
                "assets/images/home/bg_pkmain_topbar.png",
                fit: BoxFit.fill,
              ),
            ),
            Positioned(
              left: 0,
              top: 39,
              child: Container(
                  width: SizeConfig.screenWidth,
                  // height: topHeight,
                  // color: jm_appTheme,
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      IconButton(
                          icon: jm_naviBack_icon,
                          onPressed: () {
                            Navigator.pop(context);
                          }),
                      // Padding(
                      //   padding: const EdgeInsets.only(top: 12.0),
                      //   child: jm_naviTitle('PK赛'),
                      // ),
                      IconButton(
                          icon: jm_naviAdd_icon,
                          onPressed: () {
                            Navigator.of(context)
                                .push(CupertinoPageRoute(builder: (_) {
                              return PKadd();
                            }));
                          }),
                    ],
                  )),
            ),
            Positioned(
                left: margin,
                right: margin,
                top: 95,
                // height: 10,
                child: TabBar(
                    indicatorSize: TabBarIndicatorSize.label,
                    indicatorColor: tabColor,
                    indicatorWeight: 3.0,
                    indicatorPadding: EdgeInsets.only(bottom: 5),
                    // onTap: (value) {
                    //   print('value === $value');
                    // },
                    tabs: [
                      Tab(
                        child: Text(
                          '全部',
                          style: TextStyle(fontSize: 14, color: tabColor),
                        ),
                      ),
                      Tab(
                        child: Text(
                          '未开始',
                          style: TextStyle(fontSize: 14, color: tabColor),
                        ),
                      ),
                      Tab(
                        child: Text(
                          '进行中',
                          style: TextStyle(fontSize: 14, color: tabColor),
                        ),
                      ),
                      Tab(
                        child: Text(
                          '已结束',
                          style: TextStyle(fontSize: 14, color: tabColor),
                        ),
                      ),
                    ])),
            Positioned(
                left: 0,
                top: topHeight - 30,
                width: SizeConfig.screenWidth,
                height: SizeConfig.screenHeight - topHeight + 30,
                child: Container(
                    child: TabBarView(
                  children: [
                    PKmainList(
                      status: -1,
                    ),
                    PKmainList(
                      status: 0,
                    ),
                    PKmainList(
                      status: 1,
                    ),
                    PKmainList(
                      status: 2,
                    ),
                  ],
                )))
          ],
        ),
      ),
    ));
  }
}
