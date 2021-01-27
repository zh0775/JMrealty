import 'package:JMrealty/Message/MessageTypeCell.dart';
import 'package:JMrealty/Message/viewModel/MessageViewModel.dart';
import 'package:JMrealty/components/CustomAppBar.dart';
import 'package:JMrealty/components/CustomPullFooter.dart';
import 'package:JMrealty/components/CustomPullHeader.dart';
import 'package:JMrealty/components/EmptyView.dart';
import 'package:JMrealty/const/Default.dart';
import 'package:flutter/material.dart';
import 'package:flutter_easyrefresh/easy_refresh.dart';

class MessageTypeList extends StatefulWidget {
  final int noticeType;
  const MessageTypeList({this.noticeType});
  @override
  _MessageTypeListState createState() => _MessageTypeListState();
}

class _MessageTypeListState extends State<MessageTypeList> {
  MessageViewModel messageVM = MessageViewModel();
  EasyRefreshController pullCtr = EasyRefreshController();
  GlobalKey _easyRefreshKey = GlobalKey();
  GlobalKey _pullHeaderKey = GlobalKey();
  List messageList = [];
  int total = 0;
  int pageNum = 1;
  @override
  void initState() {
    // loadList();
    super.initState();
  }

  @override
  void dispose() {
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: jm_bg_gray_color,
      appBar: CustomAppbar(
        title: jm_getMessageTypeStr(widget.noticeType),
      ),
      body: EasyRefresh(
        header: CustomPullHeader(key: _pullHeaderKey),
        footer: CustomPullFooter(),
        enableControlFinishRefresh: true,
        enableControlFinishLoad: true,
        key: _easyRefreshKey,
        controller: pullCtr,
        emptyWidget: messageList.length == 0 ? EmptyView() : null,
        firstRefresh: true,
        onRefresh: () async {
          loadList();
        },
        onLoad: messageList != null && messageList.length >= total
            ? null
            : () async {
                pageNum++;
                loadList(isLoad: true, page: pageNum);
              },
        child: ListView.builder(
          itemCount: messageList.length,
          itemBuilder: (context, index) {
            return MessageTypeCell(
              data: messageList[index],
            );
          },
        ),
      ),
    );
  }

  loadList({int pageSize = 10, int page = 1, bool isLoad = false}) {
    if (!isLoad) {
      pageNum = 1;
    }
    messageVM.loadMessageTypeList(
        Map<String, dynamic>.from({
          'noticeType': widget.noticeType,
          'pageSize': pageSize,
          'pageNum': page
        }), (message, success, count) {
      pullCtr.finishRefresh();
      if (success) {
        setState(() {
          total = count;
          if (isLoad) {
            messageList.addAll(message);
          } else {
            messageList = message;
          }
        });
      }
    });
  }
}
