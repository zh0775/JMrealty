import 'package:JMrealty/Report/viewmodel/ReportListViewModel.dart';
import 'package:JMrealty/components/EmptyView.dart';
import 'package:flutter/material.dart';
import 'package:JMrealty/Report/ReportListCell.dart';
import 'package:flutter_easyrefresh/easy_refresh.dart';
// import 'package:flutter_easyrefresh/phoenix_header.dart';
// import 'package:flutter_easyrefresh/phoenix_footer.dart';

class ReportListView extends StatefulWidget {
  final int status;
  ReportListView({@required this.status});
  @override
  _ReportListViewState createState() => _ReportListViewState();
}

class _ReportListViewState extends State<ReportListView>
    with AutomaticKeepAliveClientMixin {
  ReportListViewModel reportListVM;
  EasyRefreshController easyRefreshCtr;
  GlobalKey _easyRefreshKey = GlobalKey();

  int total;
  int currentPage;
  int pageSize;
  List dataList;
  // bool unNeedDispose;
  @override
  void initState() {
    total = 0;
    currentPage = 1;
    pageSize = 10;
    dataList = [];
    // unNeedDispose = true;
    easyRefreshCtr = EasyRefreshController();
    reportListVM = ReportListViewModel();
    super.initState();
  }

  @override
  void dispose() {
    // unNeedDispose = false;
    if (easyRefreshCtr != null) {
      easyRefreshCtr.dispose();
    }
    if (reportListVM != null) {
      reportListVM.dispose();
    }
    print('dispose');
    // this.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    super.build(context);
    return EasyRefresh(
      controller: easyRefreshCtr,
      // header: PhoenixHeader(),
      // footer: PhoenixFooter(),
      enableControlFinishRefresh: true,
      enableControlFinishLoad: true,
      key: _easyRefreshKey,

      emptyWidget: dataList.length == 0 ? EmptyView() : null,
      firstRefresh: true,
      onRefresh: () async {
        loadList();
      },
      onLoad: () async {
        print('onLoad ---- loadListData');
        easyRefreshCtr.finishRefresh();
        easyRefreshCtr.finishLoad();
      },
      child: ListView.builder(
        itemCount: dataList.length,
        itemBuilder: (context, index) {
          // print(index);
          return ReportListCell(
            data: dataList[index],
            index: index,
            needRefrash: () {
              loadList();
            },
          );
        },
      ),
      // slivers: <Widget>[
      //   ListView.builder(
      //     itemCount: dataList.length,
      //     itemBuilder: (context, index) {
      //       print(index);
      //       return ReportListCell(
      //         data: dataList[index],
      //       );
      //     },
      //   ),
      // ],
    );
  }

  loadList() {
    reportListVM.loadListData(widget.status, success: (success) {
      // easyRefreshCtr.resetLoadState();
      easyRefreshCtr.finishRefresh();
      // easyRefreshCtr.finishLoad();
      if (success) {
        setState(() {
          total = reportListVM.listData['total'];
          dataList = reportListVM.listData['rows'];
        });
      }
    });
  }

  @override
  bool get wantKeepAlive => true;
}
