import 'package:JMrealty/components/NoneV.dart';
import 'package:JMrealty/utils/EventBus.dart';
import 'package:JMrealty/utils/notify_default.dart';
import 'package:flutter/material.dart';

typedef void OnTabItemClick(int index);

class JMTabBar extends StatefulWidget {
  final OnTabItemClick tabItemClick;
  JMTabBar(this.tabItemClick);
  @override
  _JMTabBarState createState() => _JMTabBarState();
}

class _JMTabBarState extends State<JMTabBar> {
  EventBus _bus = EventBus();
  int _currentIndex = 2;
  int waitClientCount = 0;
  @override
  void initState() {
    _bus.on(NOTIFY_CLIENTWAIT_COUNT, (arg) {
      if (mounted) {
        setState(() {
          waitClientCount = arg;
        });
      }
    });
    super.initState();
  }

  @override
  void dispose() {
    _bus.off(NOTIFY_CLIENTWAIT_COUNT);
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return BottomNavigationBar(
      selectedFontSize: 13,
      unselectedFontSize: 13,
      currentIndex: _currentIndex,
      type: BottomNavigationBarType.fixed,
      items: [
        createItem('project', '项目'),
        createItem('client', '客户', have: true, count: waitClientCount),
        createItem('home', '首页'),
        createItem('message', '消息'),
        createItem('mine', '我的')
      ],
      onTap: (index) {
        widget.tabItemClick(index);
        setState(() {
          _currentIndex = index;
        });
      },
    );
  }
}

BottomNavigationBarItem createItem(String iconName, String title,
    {bool have = false, int count = 0}) {
  return BottomNavigationBarItem(
      icon: Container(
        height: 30,
        width: 30,
        child: Stack(
          overflow: Overflow.visible,
          children: [
            Image.asset(
              "assets/images/tabbar/tabbar_$iconName.png",
              width: 30,
            ),
            have && count != null && count > 0
                ? Positioned(
                    top: -2.5,
                    right: -2.5,
                    child: Container(
                      width: 18,
                      height: 18,
                      alignment: Alignment.center,
                      decoration: BoxDecoration(
                          color: Colors.red,
                          borderRadius: BorderRadius.circular(9)),
                      child: Text(
                        count.toString(),
                        style: TextStyle(color: Colors.white, fontSize: 10),
                      ),
                    ))
                : NoneV()
          ],
        ),
      ),
      activeIcon: Container(
        width: 30,
        height: 30,
        child: Stack(
          overflow: Overflow.visible,
          children: [
            Image.asset(
              "assets/images/tabbar/tabbar_${iconName}_selected.png",
              width: 30,
            ),
            have && count != null && count > 0
                ? Positioned(
                    top: -2.5,
                    right: -2.5,
                    child: Container(
                      width: 18,
                      height: 18,
                      alignment: Alignment.center,
                      decoration: BoxDecoration(
                          color: Colors.red,
                          borderRadius: BorderRadius.circular(9)),
                      child: Text(
                        count.toString(),
                        style: TextStyle(color: Colors.white, fontSize: 10),
                      ),
                    ))
                : NoneV()
          ],
        ),
      ),
      label: title);
}
