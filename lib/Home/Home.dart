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
        '''http://n.sinaimg.cn/news/1_img/vcg/2b0c102b/64/w1024h640/20181024/wBkr-hmuuiyw6863395.jpg''',
        '''''');
    bannerList.add(item);
    item = BannerItem.defaultBannerItem(
        '''http://n.sinaimg.cn/news/1_img/vcg/2b0c102b/99/w1024h675/20181024/FGXD-hmuuiyw6863401.jpg''',
        '''邱水平、郝平、林建华均为“老北大人”，都曾离开北大，又重归北大任职。图为2018年5月4日，北京大学举行建校120周年纪念大会，时任北京大学党委书记郝平讲话''');
    bannerList.add(item);
    item = BannerItem.defaultBannerItem(
        '''http://n.sinaimg.cn/news/1_img/vcg/2b0c102b/107/w1024h683/20181024/kZj2-hmuuiyw6863420.jpg''',
        '''此番卸任的林建华，亦是北大出身，历任重庆大学、浙江大学、北京大学三所“双一流”高校校长。图为2018年5月4日，北京大学举行建校120周年纪念大会，时任北京大学校长林建华讲话。''');
    bannerList.add(item);
    item = BannerItem.defaultBannerItem(
        '''http://n.sinaimg.cn/news/1_img/vcg/2b0c102b/105/w1024h681/20181024/tOiL-hmuuiyw6863462.jpg''',
        '''书记转任校长的郝平，为十九届中央委员会候补委员。从北大毕业后留校，后离开北大，历任北京外国语大学校长、教育部副部长。2016年12月，时隔11年，郝平再回北大，出任北大党委书记。''');
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
