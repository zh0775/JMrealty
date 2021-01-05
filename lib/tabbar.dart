import 'package:flutter/material.dart';

typedef void OnTabItemClick(int index);

class JMTabBar extends StatefulWidget {
  final OnTabItemClick tabItemClick;
  JMTabBar(this.tabItemClick);
  @override
  _JMTabBarState createState() => _JMTabBarState();
}

class _JMTabBarState extends State<JMTabBar> {
  int _currentIndex = 2;
  @override
  Widget build(BuildContext context) {
    return BottomNavigationBar(
      selectedFontSize: 13,
      unselectedFontSize: 13,
      currentIndex: _currentIndex,
      type: BottomNavigationBarType.fixed,
      items: [
        createItem('project', '项目'),
        createItem('client', '客户'),
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

BottomNavigationBarItem createItem(String iconName, String title) {
  return BottomNavigationBarItem(
      icon: Image.asset(
        "assets/images/tabbar/tabbar_$iconName.png",
        width: 30,
      ),
      activeIcon: Image.asset(
        "assets/images/tabbar/tabbar_${iconName}_selected.png",
        width: 30,
      ),
      label: title);
}
