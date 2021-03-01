import 'package:JMrealty/Report/viewmodel/ReportListViewModel.dart';
import 'package:JMrealty/components/CustomPullFooter.dart';
import 'package:JMrealty/components/CustomPullHeader.dart';
import 'package:JMrealty/components/EmptyView.dart';
import 'package:JMrealty/utils/EventBus.dart';
import 'package:JMrealty/utils/notify_default.dart';
import 'package:JMrealty/utils/tTools.dart';
import 'package:JMrealty/utils/toast.dart';
import 'package:flutter/material.dart';
import 'package:JMrealty/Report/ReportListCell.dart';
import 'package:flutter/services.dart';
import 'package:flutter_easyrefresh/easy_refresh.dart';
// import 'package:flutter_easyrefresh/phoenix_header.dart';
// import 'package:flutter_easyrefresh/phoenix_footer.dart';

class ReportListView extends StatefulWidget {
  final int status;
  final bool isCopy;
  final Map buttonAuth;
  ReportListView({@required this.status, this.isCopy = false, this.buttonAuth});
  @override
  _ReportListViewState createState() => _ReportListViewState();
}

class _ReportListViewState extends State<ReportListView>
    with AutomaticKeepAliveClientMixin {
  EventBus _eventBus = EventBus();
  ReportListViewModel reportListVM = ReportListViewModel();
  EasyRefreshController easyRefreshCtr = EasyRefreshController();
  GlobalKey _easyRefreshKey = GlobalKey();
  GlobalKey pullHeaderKey = GlobalKey();

  int total = 0;
  int pageNum = 1;
  List dataList = [];
  List copyList = [];
  int projectId;
  // bool unNeedDispose;
  @override
  void initState() {
    _eventBus.on(NOTIFY_REPORT_SELECT_REFRASH, (arg) {
      projectId = arg;
      loadList();
    });
    _eventBus.on(NOTIFY_REPORT_LIST_REFRASH, (arg) {
      loadList();
    });
    _eventBus.on(NOTIFY_REPORT_SELECT_COPY_REFRASH, (arg) {
      if (copyList != null && copyList.length > 0) {
        List params = [];
        String copyStr = '';
        int i = 0;
        copyList.forEach((e) {
          params.add(e['id']);
          copyStr += copyString(e);
          if (i != copyList.length - 1) {
            copyStr += '\n';
          }
          i++;
        });

        Clipboard.setData(ClipboardData(text: copyStr));
        ShowToast.normal('复制成功');
        reportListVM.copyReportRequest(params, (success) {
          loadList();
        });
      }
    });
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
      header: CustomPullHeader(key: pullHeaderKey),
      footer: CustomPullFooter(),
      key: _easyRefreshKey,
      emptyWidget: dataList.length == 0 ? EmptyView() : null,
      firstRefresh: true,
      onRefresh: () async {
        loadList();
      },
      onLoad: dataList != null && dataList.length >= total
          ? null
          : () async {
              pageNum++;
              loadList(isLoad: true, page: pageNum);
            },
      child: ListView.builder(
        itemCount: dataList.length,
        itemBuilder: (context, index) {
          // print(index);
          return ReportListCell(
            data: dataList[index],
            index: index,
            buttonAuth: widget.buttonAuth,
            needRefrash: () {
              bus.emit(NOTIFY_REPORT_LIST_REFRASH);
            },
            copyItem: (data, add) {
              if (add) {
                copyList.add(data);
              } else {
                copyList.remove(data);
              }
            },
            copyOneItem: (data) {
              ShowToast.normal('已复制');
              Clipboard.setData(ClipboardData(text: copyString(data)));

              reportListVM.copyReportRequest([data['id']], (success) {
                if (success) {
                  loadList();
                }
              });
            },
            copyStatus: widget.isCopy,
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

  loadList({int pageSize = 10, int page = 1, bool isLoad = false}) {
    if (!isLoad) {
      pageNum = 1;
    }
    Map<String, dynamic> params = Map<String, dynamic>.from(
        {'status': widget.status, 'pageSize': pageSize, 'pageNum': page});

    reportListVM.loadListData(params, projectId: projectId,
        success: (List list, success, count) {
      if (success && mounted) {
        setState(() {
          total = count;
          if (isLoad) {
            dataList.addAll(list);
          } else {
            dataList = list;
          }
        });
      }
    });
  }

  @override
  bool get wantKeepAlive => true;
}
