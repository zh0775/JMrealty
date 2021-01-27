import 'package:JMrealty/Project/components/ProjectSearchBar.dart';
import 'package:JMrealty/utils/sizeConfig.dart';
import 'package:flutter/material.dart';
import './JMHomeBanner.dart';

class HomeNaviBar extends StatefulWidget {
  final List bannerDatas;
  final double height;
  final Function(int position, BannerItem entity) bannerPress;
  const HomeNaviBar({this.bannerDatas, this.height = 260.0, this.bannerPress});
  @override
  _HomeNaviBarState createState() => _HomeNaviBarState();
}

class _HomeNaviBarState extends State<HomeNaviBar> {
  List<BannerItem> bannerList = [];
  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    SizeConfig().init(context);
    return Stack(children: [
      ClipRRect(
        borderRadius: BorderRadius.vertical(
            top: Radius.circular(0), bottom: Radius.circular(0)),
        child: Container(
          color: Colors.transparent,
          child: BannerWidget(
            widget.height,
            initBannerData(widget.bannerDatas),
            bannerPress: (post, item) {
              if (widget.bannerPress != null) {
                widget.bannerPress(post, item);
              }
              // print('window.innerHeight == ${MediaQuery.of(context).size}');
              // print('post === $post --- item === $item');
            },
          ),
        ),
      ),
      Positioned(
          left: SizeConfig.blockSizeHorizontal * 6,
          top: 64,
          child: ProjectSearchBar(
            toProjectSearch: true,
          ))
    ]);
  }

  List<BannerItem> initBannerData(value) {
    List<BannerItem> list = [];
    for (var i = 0; i < value.length; i++) {
      var data = value[i];
      BannerItem item = BannerItem.defaultBannerItem(data['rotationChart']);
      list.add(item);
    }
    return list;
  }
}
