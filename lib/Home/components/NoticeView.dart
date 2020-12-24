import 'dart:async';

import 'package:JMrealty/const/Default.dart';
import 'package:flutter/material.dart';

const MAX_COUNT = 0x7fffffff;

class NoticeView extends StatefulWidget {
  final List dataList;
  final Function(int index) noticeClick;
  final Size size;
  const NoticeView({this.dataList = const [], this.noticeClick, this.size});
  @override
  _NoticeViewState createState() => _NoticeViewState();
}

class _NoticeViewState extends State<NoticeView> {
  PageController pageController;
  int _index = 0;
  Timer timer;
  @override
  void initState() {
    double current = widget.dataList.length > 0
        ? (MAX_COUNT / 2) - ((MAX_COUNT / 2) % widget.dataList.length)
        : 0.0;
    pageController = PageController(initialPage: current.toInt());
    // pageController = PageController(
    //   initialPage: _index, //默认在第几个
    //   viewportFraction: 1, // 占屏幕多少，1为占满整个屏幕
    //   keepPage: true, //是否保存当前 Page 的状态，如果保存，下次回复保存的那个 page，initialPage被忽略，
    //   //如果为 false 。下次总是从 initialPage 开始。
    // );
    // timer = Timer.periodic(const Duration(seconds: 2), (timer) {
    //   _index++;
    //   pageController.animateToPage(
    //     _index % 3, //跳转到的位置
    //     duration: Duration(milliseconds: 16), //跳转的间隔时间
    //     curve: Curves.fastOutSlowIn, //跳转动画
    //   );
    // });
    start();
    super.initState();
  }

  start() {
    stop();
    timer = Timer.periodic(Duration(milliseconds: 5000), (timer) {
      if (widget.dataList.length > 0 &&
          pageController != null &&
          pageController.page != null) {
        pageController.animateToPage(pageController.page.toInt() + 1,
            duration: Duration(milliseconds: 300), curve: Curves.linear);
      }
    });
  }

  stop() {
    timer?.cancel();
    timer = null;
  }

  @override
  void dispose() {
    pageController.dispose();
    timer.cancel();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      width: widget.size.width,
      height: widget.size.height,
      child: PageView.builder(
        scrollDirection: Axis.vertical,
        controller: pageController,
        itemCount: widget.dataList.length > 0 ? MAX_COUNT : 0,
        itemBuilder: (context, index) {
          return Padding(
            padding: const EdgeInsets.only(left: 8.0),
            child: Align(
              alignment: Alignment.centerLeft,
              child: Text(
                (widget.dataList[index % widget.dataList.length])['zzTitle'] ??
                    '',
                maxLines: 1,
                overflow: TextOverflow.ellipsis,
                style: jm_text_black_style14,
              ),
            ),
          );
        },
      ),
    );
  }
}
