import 'package:JMrealty/Report/viewmodel/ReportListViewModel.dart';
import 'package:JMrealty/components/CustomPullHeader.dart';
import 'package:JMrealty/components/EmptyView.dart';
import 'package:JMrealty/utils/EventBus.dart';
import 'package:JMrealty/utils/notify_default.dart';
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
  ReportListView({@required this.status, this.isCopy = false});
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
  int currentPage = 1;
  int pageSize = 10;
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
    _eventBus.off(NOTIFY_REPORT_SELECT_REFRASH);
    _eventBus.off(NOTIFY_REPORT_LIST_REFRASH);
    _eventBus.off(NOTIFY_REPORT_SELECT_COPY_REFRASH);
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

  loadList() {
    reportListVM.loadListData(widget.status, projectId: projectId,
        success: (success) {
      // easyRefreshCtr.resetLoadState();
      easyRefreshCtr.finishRefresh();
      // easyRefreshCtr.finishLoad();
      if (success && mounted) {
        setState(() {
          total = reportListVM.listData['total'];
          dataList = reportListVM.listData['rows'];
        });
      }
    });
  }

  String copyString(Map reportData) {
    String id = reportData['customerNumber'] != null
        ? ((reportData['customerNumber']).length > 6
            ? (reportData['customerNumber'] as String)
                .substring((reportData['customerNumber']).length - 6)
            : reportData['customerNumber'])
        : '';
    // String copyStr = '''
    // 报备楼盘：${reportData['projectName'] ?? ''}
    // 产品类型：${reportData['purpose'] ?? ''}
    // 报备公司：${reportData['company'] ?? ''}
    // 报备员工：${reportData['employeeName'] ?? ''}
    // 员工电话：${reportData['employeePhone'] ?? ''}
    // 报备客户：${reportData['customerName'] ?? ''}
    // 客户电话：${reportData['customerPhone'] ?? ''}
    // 报备日期：${reportData['createTime'] ?? ''}
    // 身份证后六位（选填）：$id
    // ''';
    String copyStr = '''''';

    copyStr += '''报备楼盘：${reportData['projectName'] ?? ''}\n''';
    copyStr += '''产品类型：${reportData['purpose'] ?? ''}\n''';
    copyStr += '''报备公司：${reportData['company'] ?? ''}\n''';
    copyStr += '''报备员工：${reportData['employeeName'] ?? ''}\n''';
    copyStr += '''员工电话：${reportData['employeePhone'] ?? ''}\n''';
    copyStr += '''报备客户：${reportData['customerName'] ?? ''}\n''';
    copyStr += '''客户电话：${reportData['customerPhone'] ?? ''}\n''';
    copyStr += '''报备日期：${reportData['createTime'] ?? ''}\n''';
    copyStr += '''身份证后六位（选填）：$id\n''';

    // copyStr += '产品类型：' + (reportData['purpose'] ?? '' + '\n');
    // copyStr += '报备公司：' + (reportData['company'] ?? '' + '\n');
    // copyStr += '报备员工：' + (reportData['employeeName'] ?? '' + '\n');
    // copyStr += '员工电话：' + (reportData['employeePhone'] ?? '' + '\n');
    // copyStr += '报备客户：' + (reportData['customerName'] ?? '' + '\n');
    // copyStr += '客户电话：' + (reportData['customerPhone'] ?? '' + '\n');
    // copyStr += '报备日期：' + (reportData['createTime'] ?? '' + '\n');
    // copyStr += '身份证后六位（选填）：' + id + '\n';
    print('copyStr === $copyStr');
    return copyStr;
  }

  @override
  bool get wantKeepAlive => true;
}
