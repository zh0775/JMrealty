import 'package:flutter/material.dart';
import 'package:flutter_easyrefresh/easy_refresh.dart';

class CustomPullHeader extends CustomHeader {
  final Key key;

  CustomPullHeader({
    this.key,
  }) : super(
          headerBuilder: (context,
              refreshState,
              pulledExtent,
              refreshTriggerPullDistance,
              refreshIndicatorExtent,
              axisDirection,
              float,
              completeDuration,
              enableInfiniteRefresh,
              success,
              noMore) {
            return Image.asset('assets/images/icon/animation_pulldown.gif');
          },
        );

  // key: key,
  // refreshText: '拉动刷新',
  // refreshReadyText: '释放刷新',
  // refreshingText: '正在刷新...',
  // refreshedText: '刷新完成',
  // refreshFailedText: '刷新失败',
  // noMoreText: '没有更多数据',
  // infoText: '更新于 %T',

}
