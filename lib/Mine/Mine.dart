import 'package:JMrealty/utils/EventBus.dart';
import 'package:JMrealty/utils/notify_default.dart';
import 'package:flutter/material.dart';

class Mine extends StatefulWidget {
  @override
  _MineState createState() => _MineState();
}

class _MineState extends State<Mine> {
  var bus = EventBus();
  @override
  void initState() {
    bus.on(NOTIFY_USER_INFO, (arg) {
      print('arg ==== $arg');
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    // Future.delayed(Duration(seconds: 0), () {
    //   toLogin(context);
    // });
    return GestureDetector(
      onTap: () {},
      child: Container(
        color: Colors.blue,
      ),
    );
  }
}
