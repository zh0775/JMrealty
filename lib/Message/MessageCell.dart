import 'package:JMrealty/Message/MessageTypeList.dart';
import 'package:JMrealty/Message/viewModel/MessageViewModel.dart';
import 'package:JMrealty/base/image_loader.dart';
import 'package:JMrealty/components/NoneV.dart';
import 'package:JMrealty/const/Default.dart';
import 'package:JMrealty/utils/EventBus.dart';
import 'package:JMrealty/utils/notify_default.dart';
import 'package:JMrealty/utils/sizeConfig.dart';
import 'package:JMrealty/utils/user_default.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'dart:convert' as convert;

class MessageCell extends StatefulWidget {
  final Function() needRefresh;
  final Map data;
  const MessageCell({this.data, this.needRefresh});
  @override
  _MessageCellState createState() => _MessageCellState();
}

class _MessageCellState extends State<MessageCell> {
  double margin;
  double widthScale;
  double axisSpace = 14;
  EventBus _eventBus = EventBus();
  MessageViewModel messageVM = MessageViewModel();
  @override
  void initState() {
    super.initState();
  }

  @override
  void dispose() {
    _eventBus.off(NOTIFY_USER_INFO);
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    SizeConfig().init(context);
    widthScale = SizeConfig.blockSizeHorizontal;
    double headIconWidth = widthScale * 15;
    margin = widthScale * 4;
    return GestureDetector(
      onTap: () {
        UserDefault.get(USERINFO).then((value) {
          Map userInfo = convert.jsonDecode(value);
          Map params = {
            'noticeId': widget.data['id'],
            'receiveId': userInfo['userId']
          };
          messageVM.loadRead(
            params,
            success: (success) {
              if (success && widget.needRefresh != null) {
                widget.needRefresh();
                // _eventBus.emit(NOTIFY_USER_INFO);
              }
            },
          );
          Navigator.of(context).push(CupertinoPageRoute(
            builder: (_) {
              return MessageTypeList(
                noticeType: widget.data['noticeType'],
              );
            },
          ));
        });
      },
      child: Container(
        padding: EdgeInsets.symmetric(vertical: axisSpace),
        width: SizeConfig.screenWidth,
        color: Colors.white,
        // decoration: BoxDecoration(
        //     border:
        //         Border(bottom: BorderSide(color: jm_line_color, width: 0.5))
        //         ),
        child: Stack(
          overflow: Overflow.visible,
          children: [
            Row(
              children: [
                SizedBox(
                  width: margin,
                ),
                Column(
                  children: [
                    Container(
                      width: headIconWidth,
                      height: headIconWidth,
                      padding: EdgeInsets.all(widthScale * 0.8),
                      child: widget.data['icon'] != null &&
                              (widget.data['icon'] as String).length > 0
                          ? Stack(
                              children: [
                                Positioned(
                                    top: 0,
                                    left: 0,
                                    right: 0,
                                    bottom: 0,
                                    child: ImageLoader(widget.data['icon'])),
                                widget.data['noticeId'] == null
                                    ? Positioned(
                                        top: 0,
                                        right: 0,
                                        child: Container(
                                          width: widthScale * 3.8,
                                          height: widthScale * 3.8,
                                          decoration: BoxDecoration(
                                              color: Colors.red,
                                              borderRadius:
                                                  BorderRadius.circular(
                                                      widthScale * 1.9)),
                                        ))
                                    : NoneV()
                              ],
                            )
                          : NoneV(),
                    )
                  ],
                ),
                SizedBox(
                  width: margin,
                ),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Container(
                      width:
                          SizeConfig.screenWidth - margin * 3 - headIconWidth,
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        // crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            widget.data['name'] ?? '',
                            style: jm_text_black_style15,
                          ),
                          Text(
                            widget.data['createTime'] ?? '',
                            style: jm_text_black_style13,
                          ),
                        ],
                      ),
                    ),
                    SizedBox(
                      height: 10,
                    ),
                    Container(
                      width:
                          SizeConfig.screenWidth - margin * 3 - headIconWidth,
                      child: Text(
                        widget.data['content'] ?? '',
                        style: jm_text_black_style15,
                        maxLines: 100,
                      ),
                    ),
                  ],
                ),
              ],
            ),
            Positioned(
                bottom: -15,
                right: 0,
                child: JMline(
                    width: SizeConfig.screenWidth - margin * 2 - headIconWidth,
                    height: 0.5))
          ],
        ),
      ),
    );
  }
}
