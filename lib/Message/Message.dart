import 'package:JMrealty/Message/MessageCell.dart';
import 'package:JMrealty/Message/viewModel/MessageViewModel.dart';
import 'package:JMrealty/components/CustomPullHeader.dart';
import 'package:JMrealty/components/EmptyView.dart';
import 'package:JMrealty/const/Default.dart';
import 'package:JMrealty/utils/EventBus.dart';
import 'package:JMrealty/utils/notify_default.dart';
import 'package:flutter/material.dart';
import 'package:flutter_easyrefresh/easy_refresh.dart';

class Message extends StatefulWidget {
  final IndexClick indexClick;
  const Message({this.indexClick});
  @override
  _MessageState createState() => _MessageState();
}

class _MessageState extends State<Message> {
  MessageViewModel messageVM = MessageViewModel();
  EasyRefreshController pullCtr = EasyRefreshController();
  GlobalKey _easyRefreshKey = GlobalKey();
  GlobalKey _pullHeaderKey = GlobalKey();
  EventBus _eventBus = EventBus();
  List messageList = [];
  @override
  void initState() {
    _eventBus.on(NOTIFY_USER_INFO, (arg) {
      loadList();
    });
    loadList();
    super.initState();
  }

  @override
  void dispose() {
    pullCtr.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          '消息',
          style: TextStyle(color: Colors.white, fontSize: 22),
        ),
      ),
      body: EasyRefresh(
        header: CustomPullHeader(key: _pullHeaderKey),
        enableControlFinishRefresh: true,
        enableControlFinishLoad: true,
        key: _easyRefreshKey,
        controller: pullCtr,
        emptyWidget: messageList.length == 0 ? EmptyView() : null,
        firstRefresh: true,
        onRefresh: () async {
          loadList();
        },
        child: ListView.builder(
          itemCount: messageList.length,
          itemBuilder: (context, index) {
            return MessageCell(
              data: messageList[index],
            );
          },
        ),
      ),
    );
  }

  loadList() {
    messageVM.loadMessageList((message, success) {
      pullCtr.finishRefresh();
      if (success) {
        setState(() {
          messageList = message;
        });
      }
    });
  }
}
