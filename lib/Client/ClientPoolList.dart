import 'package:JMrealty/Client/viewModel/ClientPoolViewModel.dart';
import 'package:JMrealty/components/CustomAlert.dart';
import 'package:JMrealty/components/CustomPullHeader.dart';
import 'package:JMrealty/components/EmptyView.dart';
import 'package:JMrealty/utils/EventBus.dart';
import 'package:JMrealty/utils/notify_default.dart';
import 'package:flutter/material.dart';
import 'package:flutter_easyrefresh/easy_refresh.dart';

import 'components/WaitFollowUpCell.dart';

class ClientPoolList extends StatefulWidget {
  final Map clientPoolParams;
  // final Function(Map data) followClick;
  final int poolType;
  const ClientPoolList({this.poolType, this.clientPoolParams});
  @override
  _ClientPoolListState createState() => _ClientPoolListState();
}

class _ClientPoolListState extends State<ClientPoolList>
    with AutomaticKeepAliveClientMixin {
  EasyRefreshController pullCtr = EasyRefreshController();
  GlobalKey pullKey = GlobalKey();
  GlobalKey pullHeaderKey = GlobalKey();
  ClientPoolViewModel clientPoolVM = ClientPoolViewModel();
  List dataList = [];
  Map data = {};
  EventBus _eventBus = EventBus();
  @override
  void initState() {
    _eventBus.on(NOTIFY_CLIENT_POOL_LIST_REFRASH, (arg) {
      loadRequest();
    });
    super.initState();
  }

  @override
  void dispose() {
    clientPoolVM.dispose();
    pullCtr.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    super.build(context);
    return EasyRefresh(
        header: CustomPullHeader(key: pullHeaderKey),
        key: pullKey,
        controller: pullCtr,
        firstRefresh: true,
        emptyWidget:
            dataList == null || dataList.length == 0 ? EmptyView() : null,
        onRefresh: () async {
          loadRequest();
        },
        child: ListView.builder(
          itemCount: dataList.length,
          // itemCount: model.listData.length,
          itemBuilder: (context, index) {
            return WaitFollowUpCell(
              model: dataList[index],
              index: index,
              pool: true,
              takeOrderClick: (Map cellData) {
                CustomAlert(title: '提示', content: '您要跟进该用户吗？').show(
                  confirmClick: () {
                    clientPoolVM.takeClientRequest(cellData['id'], () {
                      loadRequest();
                    });
                  },
                );
              },
              // writeFollowClick: widget.writeFollowClick,
              // cellReportClick: widget.cellReportClick,
            );
          },
        ));
  }

  loadRequest() {
    clientPoolVM.loadClientPoolList(
        params: Map<String, dynamic>.from(
            {...widget.clientPoolParams, 'customerPoolTepe': widget.poolType}),
        success: (data) {
          setState(() {
            data = Map<String, dynamic>.from(data);
            dataList = data['rows'];
          });
        });
  }

  @override
  bool get wantKeepAlive => true;
}
