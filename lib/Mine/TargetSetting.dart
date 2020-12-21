import 'package:JMrealty/components/CustomAppBar.dart';
import 'package:flutter/material.dart';

class TargetSetting extends StatefulWidget {
  @override
  _TargetSettingState createState() => _TargetSettingState();
}

class _TargetSettingState extends State<TargetSetting> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CustomAppbar(
        title: '设置目标',
      ),
    );
  }
}
