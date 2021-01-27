import 'package:JMrealty/Home/components/NoticeView.dart';
import 'package:JMrealty/Message/MessageTypeList.dart';
import 'package:JMrealty/const/Default.dart';
import 'package:JMrealty/utils/sizeConfig.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class HomeGoodDeed extends StatefulWidget {
  final List dataList;
  final Function(int index) noticeClick;
  const HomeGoodDeed({this.dataList = const [], this.noticeClick});
  @override
  _HomeGoodDeedState createState() => _HomeGoodDeedState();
}

class _HomeGoodDeedState extends State<HomeGoodDeed> {
  double thisHeight = 45.0;
  @override
  Widget build(BuildContext context) {
    SizeConfig().init(context);
    return Align(
      child: Container(
        width: SizeConfig.screenWidth - 40,
        height: thisHeight,
        margin: EdgeInsets.only(top: 20),
        decoration: BoxDecoration(
            color: Color(0xffF7F8FB), borderRadius: BorderRadius.circular(10)),
        child: Stack(
          children: [
            Positioned(
              height: thisHeight,
              left: 10,
              top: 0,
              child: Image.asset(
                "assets/images/home/icon_home_gladnotice.png",
                height: 30,
                width: 30,
              ),
            ),
            Positioned(
              height: thisHeight,
              right: 40,
              left: 30,
              child: TextButton(
                  onPressed: null,
                  child: NoticeView(
                    dataList: widget.dataList,
                    noticeClick: widget.noticeClick,
                    size: Size(SizeConfig.screenWidth - 120, thisHeight),
                  )),
            ),
            Positioned(
              height: thisHeight,
              right: -5,
              child: TextButton(
                onPressed: () {
                  Navigator.of(context).push(CupertinoPageRoute(
                    builder: (_) {
                      return MessageTypeList(
                        noticeType: 10,
                      );
                    },
                  ));
                },
                child: Text(
                  '更多',
                  style: TextStyle(color: Color(0XFF9fa1a8), fontSize: 13),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
