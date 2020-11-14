import 'package:flutter/material.dart';

class HomeAnno extends StatefulWidget {
  @override
  _HomeAnnoState createState() => _HomeAnnoState();
}

class _HomeAnnoState extends State<HomeAnno> {
  double announcementHeght = 45.0;
  @override
  Widget build(BuildContext context) {
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
                      child: RichText(
                        maxLines: 1,
                        overflow: TextOverflow.ellipsis,
                        text: TextSpan(
                            text: '[公告]',
                            style: TextStyle(
                                color: Colors.red,
                                fontSize: 15,
                                fontWeight: FontWeight.bold),
                            children: <TextSpan>[
                              TextSpan(
                                text: ' ' +
                                    '公告内容大家啊快乐公告内容大家啊快乐公告内容大家啊快乐公告内容大家啊快乐公告内容大家啊快乐',
                                style: TextStyle(
                                    color: Colors.black,
                                    fontSize: 14,
                                    fontWeight: FontWeight.bold),
                              )
                            ]),
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
