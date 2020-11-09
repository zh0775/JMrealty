import 'package:flutter/material.dart';

typedef void OnTabItemClick(int index);

class JMTabBar extends StatefulWidget {
  final OnTabItemClick tabItemClick;
  JMTabBar(this.tabItemClick);
  @override
  _JMTabBarState createState() => _JMTabBarState();
}

class _JMTabBarState extends State<JMTabBar> {
  int _currentIndex = 0;
  @override
  Widget build(BuildContext context) {
    return BottomNavigationBar(
      selectedFontSize: 14,
      unselectedFontSize: 14,
      currentIndex: _currentIndex,
      type: BottomNavigationBarType.fixed,
      items: [
        createItem('cookie', '首页'),
        createItem('pudding', '项目'),
        createItem('cake', '资产'),
        createItem('avocado', '消息'),
        createItem('doughnut', '我的')
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
        "assets/images/tabbar/food-$iconName.png",
        width: 30,
      ),
      activeIcon: Image.asset(
        "assets/images/tabbar/food-bread.png",
        width: 30,
      ),
      label: title);
}
