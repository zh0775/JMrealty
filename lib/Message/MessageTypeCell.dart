import 'package:JMrealty/const/Default.dart';
import 'package:JMrealty/utils/sizeConfig.dart';
import 'package:flutter/material.dart';

class MessageTypeCell extends StatefulWidget {
  final Map data;
  const MessageTypeCell({this.data});
  @override
  _MessageTypeCellState createState() => _MessageTypeCellState();
}

class _MessageTypeCellState extends State<MessageTypeCell> {
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
        // Navigator.of(context).push(CupertinoPageRoute(
        //   builder: (_) {
        //     return MessageTypeList(
        //       noticeType: widget.data['noticeType'],
        //     );
        //   },
        // ));
      },
      child: Column(
        children: [
          Padding(
            padding: EdgeInsets.fromLTRB(0, widthScale * 5, 0, widthScale * 3),
            child: Text(widget.data['createTime'] ?? ''),
          ),
          Container(
            padding: EdgeInsets.symmetric(vertical: margin),
            width: SizeConfig.screenWidth - margin * 2,
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(widthScale * 4),
            ),
            child: Row(
              children: [
                SizedBox(
                  width: margin,
                ),
                // Column(
                //   children: [
                //     Container(
                //       width: 60,
                //       height: 60,
                //       child: ImageLoader('imgUrl'),
                //     )
                //   ],
                // ),
                // SizedBox(
                //   width: margin,
                // ),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Container(
                      // margin: EdgeInsets.symmetric(horizontal: margin),
                      // width: SizeConfig.screenWidth - margin * 3 - 60,
                      child: Text(
                        widget.data['name'] ?? '',
                        style: jm_text_black_bold_style15,
                      ),
                    ),
                    Padding(
                      padding: EdgeInsets.symmetric(vertical: 12),
                      child: JMline(
                          width: SizeConfig.screenWidth - margin * 4,
                          height: 0.5),
                    ),
                    Container(
                      width: SizeConfig.screenWidth - margin * 4,
                      child: Text(
                        widget.data['content'] ?? '',
                        style: jm_text_black_style14,
                        maxLines: 100,
                      ),
                    )
                  ],
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
