import 'package:JMrealty/components/CustomAppBar.dart';
import 'package:JMrealty/const/Default.dart';
import 'package:JMrealty/utils/sizeConfig.dart';
import 'package:flutter/material.dart';

class SmartReport extends StatefulWidget {
  @override
  _SmartReportState createState() => _SmartReportState();
}

class _SmartReportState extends State<SmartReport> {
  @override
  Widget build(BuildContext context) {
    SizeConfig().init(context);
    return Scaffold(
      backgroundColor: jm_appTheme,
      appBar: CustomAppbar(
        title: '智能报备',
      ),
    );
  }
}
