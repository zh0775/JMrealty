import 'package:flutter/material.dart';
import './JMHomeBanner.dart';
import '../../services/HomeService.dart';

class HomeNaviBar extends StatefulWidget {
  @override
  _HomeNaviBarState createState() => _HomeNaviBarState();
}

class _HomeNaviBarState extends State<HomeNaviBar> {
  @override
  void initState() {
    HomeService().getHomeBanner().then((value) {
      if (value['code'] == 0) {
        this.initBannerData(value);
      }
    });
    super.initState();
  }

  List<BannerItem> bannerList = [];
  double widgetHeight = 280.0;
  @override
  Widget build(BuildContext context) {
    return Stack(children: [
      ClipRRect(
        borderRadius: BorderRadius.vertical(
            top: Radius.circular(0), bottom: Radius.circular(15)),
        child: Container(
          color: Colors.transparent,
          child: BannerWidget(
            widgetHeight,
            bannerList,
            bannerPress: (post, item) {
              print('window.innerHeight == ${MediaQuery.of(context).size}');
              print('post === $post --- item === $item');
            },
          ),
        ),
      ),
      Container(
        decoration: BoxDecoration(
          borderRadius: BorderRadius.all(Radius.circular(10.0)),
          color: Color.fromRGBO(0, 0, 0, 0.4),
        ),
        width: MediaQuery.of(context).size.width - 40,
        margin: EdgeInsets.fromLTRB(20, 50, 0, 0),
        height: 50,
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Padding(
              padding: EdgeInsets.fromLTRB(10, 0, 0, 0),
              child: Row(
                children: [
                  Image.asset("assets/images/tabbar/food-cake.png"),
                  Padding(
                    padding: EdgeInsets.fromLTRB(10, 0, 0, 0),
                    child: Text(
                      '南宁  多云  18-22°C',
                      style: TextStyle(color: Colors.white, fontSize: 14),
                    ),
                  )
                ],
              ),
            ),
            Padding(
              padding: const EdgeInsets.fromLTRB(0, 0, 10, 0),
              child: Icon(
                Icons.search,
                color: Colors.white,
              ),
            )
          ],
        ),
      ),
    ]);
  }

  void initBannerData(value) {
    for (var i = 0; i < value['data'].length; i++) {
      var data = value['data'][i];
      BannerItem item = BannerItem.defaultBannerItem(data['imgUrl']);
      setState(() {
        bannerList.add(item);
      });
    }
  }
}