import 'package:JMrealty/PK/components/PKmainListCell.dart';
import 'package:JMrealty/PK/viewModel/PKviewModel.dart';
import 'package:JMrealty/components/CustomPullHeader.dart';
import 'package:JMrealty/utils/EventBus.dart';
import 'package:JMrealty/utils/notify_default.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_easyrefresh/easy_refresh.dart';

import 'PKdetail.dart';

class PKmainList extends StatefulWidget {
  final int status;
  const PKmainList({this.status});
  @override
  _PKmainListState createState() => _PKmainListState();
}

class _PKmainListState extends State<PKmainList> {
  EventBus _bus = EventBus();
  void Function(Map cellData, int index) cellClick;
  List pkListData = [];
  double topHeight = 178;
  double widthScale;
  double margin;
  double selfWidth;
  EasyRefreshController pullCtr = EasyRefreshController();
  GlobalKey pullKey = GlobalKey();
  GlobalKey pullHeaderKey = GlobalKey();
  PKviewModel pkVM = PKviewModel();

  @override
  void initState() {
    cellClick = (Map cellData, int index) {
      Navigator.of(context).push(CupertinoPageRoute(builder: (_) {
        return PKdetail(pkData: cellData);
      }));
    };
    _bus.on(NOTIFY_PK_LIST_REFRASH, (arg) {
      if (mounted) {
        loadList();
      }
    });
    loadList();
    super.initState();
  }

  @override
  void dispose() {
    _bus.off(NOTIFY_PK_LIST_REFRASH);
    pullCtr.dispose();
    // pkVM.dispose();
    super.dispose();
  }

  void loadList() {
    pkVM.loadPKList(widget.status, success: (dataList) {
      setState(() {
        pkListData = dataList;
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return EasyRefresh(
      key: pullKey,
      controller: pullCtr,
      header: CustomPullHeader(key: pullHeaderKey),
      onRefresh: () async {
        loadList();
      },
      child: ListView.builder(
        padding: EdgeInsets.only(top: 15),
        itemCount: pkListData.length,
        itemBuilder: (BuildContext context, int index) {
          return PKmainListCell(
            cellData: pkListData[index],
            index: index,
            cellClick: cellClick,
          );
        },
      ),
    );
  }
}
