import 'package:JMrealty/components/CustomAppBar.dart';
import 'package:flutter/material.dart';

class Report extends StatefulWidget {
  @override
  _ReportState createState() => _ReportState();
}

class _ReportState extends State<Report> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: CustomAppbar(
      title: '报备记录',
    ));
  }
}
