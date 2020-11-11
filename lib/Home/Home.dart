import 'package:flutter/material.dart';
import '../components/Home/JMHomeBanner.dart';
import '../tabbar.dart';
import '../Project/Project.dart';
import '../Client/Client.dart';
import '../Message/Message.dart';
import '../Mine/Mine.dart';
import '../services/HomeService.dart';

class HomeBodyWidget extends StatefulWidget {
  @override
  _HomeBodyWidgetState createState() => _HomeBodyWidgetState();
}

class _HomeBodyWidgetState extends State<HomeBodyWidget> {
  int _tabbarIndex = 0;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      // appBar: AppBar(title: Text('金慕'), centerTitle: true, actions: <Widget>[
      //   Padding(
      //     padding: const EdgeInsets.only(right: 80),
      //     child: IconButton(
      //       icon: Icon(
      //         Icons.mail,
      //       ),
      //       tooltip: '搜索',
      //       onPressed: () {
      //         print('click message');
      //       },
      //     ),
      //   ),
      // ]),
      body: IndexedStack(
        index: _tabbarIndex,
        children: [Home(), Project(), Client(), Message(), Mine()],
      ),
      bottomNavigationBar: JMTabBar((index) {
        setState(() {
          _tabbarIndex = index;
        });
        // _tabbarIndex = index;
      }),
    );
  }
}

class Home extends StatefulWidget {
  final d = '123';
  @override
  _HomeState createState() => _HomeState();
}

class _HomeState extends State<Home> {
  List<BannerItem> bannerList = [];
  @override
  void initState() {
    HomeService().getHomeBanner().then((value) {
      if (value['code'] == 0) {
        this.initBannerData(value);
      }
    });
    super.initState();
  }

  double widgetHeight = 180.0;
  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      height: double.infinity,
      decoration: BoxDecoration(color: Colors.grey),
      child: Column(
        children: [
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 20.0),
            child: ClipRRect(
              borderRadius: BorderRadius.circular(10),
              child: Container(
                height: widgetHeight,
                width: double.infinity,
                child: BannerWidget(
                  widgetHeight,
                  bannerList,
                  bannerPress: (post, item) {
                    print(
                        'window.innerHeight == ${MediaQuery.of(context).size}');
                    print('post === $post --- item === $item');
                  },
                ),
              ),
            ),
          ),
        ],
      ),
    );
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
