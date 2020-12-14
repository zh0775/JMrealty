import 'package:JMrealty/PK/PKadd.dart';
import 'package:JMrealty/PK/PKdetail.dart';
import 'package:JMrealty/PK/viewModel/PKviewModel.dart';
import 'package:JMrealty/const/Default.dart';
import 'package:JMrealty/utils/sizeConfig.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_easyrefresh/easy_refresh.dart';

import 'components/PKmainListCell.dart';

class PKmain extends StatefulWidget {
  @override
  _PKmainState createState() => _PKmainState();
}

class _PKmainState extends State<PKmain> {
  void Function(Map cellData, int index) cellClick;
  List pkListData;
  double topHeight = 200;
  double widthScale;
  double margin;
  double selfWidth;
  EasyRefreshController pullCtr;
  ScrollController listViewCtr;
  PKviewModel pkVM;

  @override
  void initState() {
    cellClick = (Map cellData, int index) {
      Navigator.of(context).push(CupertinoPageRoute(builder: (_) {
        return PKdetail(pkData: cellData);
      }));
    };
    pkListData = [];
    pullCtr = EasyRefreshController();
    listViewCtr = ScrollController();
    pkVM = PKviewModel();
    pkVM.loadPKList(success: (dataList) {
      setState(() {
        pkListData = dataList;
      });
    });
    super.initState();
  }

  @override
  void dispose() {
    pullCtr.dispose();
    listViewCtr.dispose();
    pkVM.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    SizeConfig().init(context);
    widthScale = SizeConfig.blockSizeHorizontal;
    margin = widthScale * 6;
    selfWidth = SizeConfig.screenWidth - margin * 2;
    return Scaffold(
        body: EasyRefresh(
            controller: pullCtr,
            header: PhoenixHeader(),
            onRefresh: () async {
              pkVM.loadPKList(success: (dataList) {
                pullCtr.finishRefresh();
                setState(() {
                  pkListData = dataList;
                });
              });
            },
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
                    left: 0,
                    top: 0,
                    child: Container(
                      width: SizeConfig.screenWidth,
                      height: topHeight,
                      color: jm_appTheme,
                      child: Column(
                        children: [
                          SizedBox(
                            height: 20,
                          ),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              IconButton(
                                  icon: jm_naviBack_icon,
                                  onPressed: () {
                                    Navigator.pop(context);
                                  }),
                              Padding(
                                padding: const EdgeInsets.only(top: 12.0),
                                child: jm_naviTitle('PK赛'),
                              ),
                              IconButton(
                                  icon: jm_naviAdd_icon,
                                  onPressed: () {
                                    Navigator.of(context)
                                        .push(CupertinoPageRoute(builder: (_) {
                                      return PKadd();
                                    }));
                                  }),
                            ],
                          )
                        ],
                      ),
                    ),
                  ),
                  Positioned(
                      left: 0,
                      top: topHeight - 50,
                      width: SizeConfig.screenWidth,
                      height: SizeConfig.screenHeight - topHeight + 50,
                      child: Container(
                        child: ListView.builder(
                          controller: listViewCtr,
                          padding: EdgeInsets.only(top: 15),
                          itemCount: pkListData.length,
                          itemBuilder: (BuildContext context, int index) {
                            return PKmainListCell(
                              cellData: pkListData[index],
                              index: index,
                              cellClick: cellClick,
                            );
                          },
                        ),
                      ))
                ],
              ),
            )));
  }
}
