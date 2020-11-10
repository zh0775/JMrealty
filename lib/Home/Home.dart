import 'package:flutter/material.dart';
import '../components/Home/JMHomeBanner.dart';
import '../tabbar.dart';
import '../Project/Project.dart';
import '../Client/Client.dart';
import '../Message/Message.dart';
import '../Mine/Mine.dart';

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
  @override
  _HomeState createState() => _HomeState();
}

class _HomeState extends State<Home> {
  List<BannerItem> bannerList = [];

  @override
  void initState() {
    BannerItem item = BannerItem.defaultBannerItem(
        '''http://n.sinaimg.cn/news/1_img/vcg/2b0c102b/64/w1024h640/20181024/wBkr-hmuuiyw6863395.jpg''');
    bannerList.add(item);
    item = BannerItem.defaultBannerItem(
        '''http://n.sinaimg.cn/news/1_img/vcg/2b0c102b/99/w1024h675/20181024/FGXD-hmuuiyw6863401.jpg''');
    bannerList.add(item);
    item = BannerItem.defaultBannerItem(
        '''http://n.sinaimg.cn/news/1_img/vcg/2b0c102b/107/w1024h683/20181024/kZj2-hmuuiyw6863420.jpg''');
    bannerList.add(item);
    item = BannerItem.defaultBannerItem(
        '''http://n.sinaimg.cn/news/1_img/vcg/2b0c102b/105/w1024h681/20181024/tOiL-hmuuiyw6863462.jpg''');
    bannerList.add(item);
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
}
