import 'package:JMrealty/Message/MessageTypeList.dart';
import 'package:JMrealty/base/image_loader.dart';
import 'package:JMrealty/const/Default.dart';
import 'package:JMrealty/utils/sizeConfig.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class MessageCell extends StatefulWidget {
  final Map data;
  const MessageCell({this.data});
  @override
  _MessageCellState createState() => _MessageCellState();
}

class _MessageCellState extends State<MessageCell> {
  double margin;
  double widthScale;
  double axisSpace = 14;
  @override
  void initState() {
    super.initState();
  }

  @override
  void dispose() {
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    SizeConfig().init(context);
    widthScale = SizeConfig.blockSizeHorizontal;
    margin = widthScale * 4;
    return GestureDetector(
      onTap: () {
        Navigator.of(context).push(CupertinoPageRoute(
          builder: (_) {
            return MessageTypeList(
              noticeType: widget.data['noticeType'],
            );
          },
        ));
      },
      child: Container(
        padding: EdgeInsets.symmetric(vertical: axisSpace),
        width: SizeConfig.screenWidth,
        decoration: BoxDecoration(
            border:
                Border(bottom: BorderSide(color: jm_line_color, width: 0.5))),
        child: Row(
          children: [
            SizedBox(
              width: margin,
            ),
            Column(
              children: [
                Container(
                  width: 60,
                  height: 60,
                  child: ImageLoader('imgUrl'),
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
                  width: SizeConfig.screenWidth - margin * 3 - 60,
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
                        style: jm_text_black_style15,
                      ),
                    ],
                  ),
                ),
                SizedBox(
                  height: 16,
                ),
                Container(
                  width: SizeConfig.screenWidth - margin * 3 - 60,
                  child: Text(
                    widget.data['content'] ?? '',
                    style: jm_text_black_style15,
                    maxLines: 100,
                  ),
                )
              ],
            ),
          ],
        ),
      ),
    );
  }
}
