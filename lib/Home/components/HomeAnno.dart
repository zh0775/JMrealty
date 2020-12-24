import 'package:JMrealty/Home/components/NoticeView.dart';
import 'package:JMrealty/utils/sizeConfig.dart';
import 'package:flutter/material.dart';

class HomeAnno extends StatefulWidget {
  final List dataList;
  final Function(int index) noticeClick;
  const HomeAnno({this.dataList = const [], this.noticeClick});
  @override
  _HomeAnnoState createState() => _HomeAnnoState();
}

class _HomeAnnoState extends State<HomeAnno> {
  double announcementHeght = 45.0;

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    SizeConfig().init(context);
    return Align(
      child: Container(
          width: MediaQuery.of(context).size.width - 40,
          height: announcementHeght,
          margin: EdgeInsets.only(top: 20),
          alignment: Alignment.centerLeft,
          decoration: BoxDecoration(
              border: Border.all(color: Color(0xFFe5b763), width: 1.2),
              borderRadius: BorderRadius.all(Radius.circular(10))),
          child: Stack(
            overflow: Overflow.visible,
            children: [
              Positioned(
                left: -15,
                height: announcementHeght,
                child: Image.asset(
                  "assets/images/tabbar/food-cake.png",
                  width: 30,
                  height: 30,
                ),
              ),
              Positioned(
                  left: 10,
                  height: announcementHeght,
                  width: MediaQuery.of(context).size.width - 40 - 60,
                  child: TextButton(
                      onPressed: () {},
                      child: Row(
                        children: [
                          RichText(
                            maxLines: 1,
                            overflow: TextOverflow.ellipsis,
                            text: TextSpan(
                              text: '[公告]',
                              style: TextStyle(
                                  color: Colors.red,
                                  fontSize: 15,
                                  fontWeight: FontWeight.bold),
                            ),
                          ),
                          NoticeView(
                            dataList: widget.dataList ?? [],
                            noticeClick: widget.noticeClick,
                            size: Size(SizeConfig.screenWidth - 40 - 60 - 60,
                                announcementHeght),
                          )
                        ],
                      ))),
              Positioned(
                right: -5,
                height: announcementHeght,
                child: TextButton(
                  onPressed: () {},
                  child: Text(
                    '查看',
                    style: TextStyle(color: Color(0XFF9fa1a8), fontSize: 13),
                  ),
                ),
              )
            ],
          )),
    );
  }
}
