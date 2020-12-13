import 'package:JMrealty/base/image_loader.dart';
import 'package:JMrealty/const/Default.dart';
import 'package:JMrealty/utils/sizeConfig.dart';
import 'package:flutter/material.dart';

class MineTop extends StatelessWidget {
  final double height;
  final Map data;
  final Function() toLevelSetting;
  const MineTop({this.height, this.data, this.toLevelSetting});
  @override
  Widget build(BuildContext context) {
    SizeConfig().init(context);
    final double topSpace = 150;
    final double topImageHeight = 200;
    double topHeight = height ?? 280;
    double widthScale = SizeConfig.blockSizeHorizontal;
    double margin = widthScale * 6;
    // double selfWidth = SizeConfig.screenWidth - margin * 2;
    return Container(
      width: SizeConfig.screenWidth,
      height: topHeight,
      // color: Colors.red,
      child: Stack(
        children: [
          Positioned(
              top: 0,
              left: 0,
              right: 0,
              height: topImageHeight,
              child: Container(
                color: Colors.yellow,
              )),
          Positioned(
              top: topSpace,
              left: 0,
              right: 0,
              height: topHeight - topSpace,
              child: Container(
                color: Colors.white,
              )),
          Positioned(
              left: margin,
              top: 150 - widthScale * 10,
              child: Container(
                width: widthScale * 20,
                height: widthScale * 20,
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(widthScale * 3),
                ),
                child: Padding(
                  padding: EdgeInsets.all(widthScale * 2),
                  child: ClipRRect(
                      borderRadius: BorderRadius.circular(widthScale * 2),
                      child:
                          ImageLoader(data['avatar'] ?? '', widthScale * 15)),
                ),
              )),
          Positioned(
              top: topSpace - 35,
              left: widthScale * 18 + margin * 2,
              // width: 200,
              height: 50,
              child: Text(
                data['userName'] ?? '',
                style: TextStyle(
                    fontSize: 18,
                    color: Colors.white,
                    fontWeight: FontWeight.bold),
              )),
          Positioned(
              top: topSpace + 8,
              left: widthScale * 18 + margin * 2,
              // width: 200,
              height: 50,
              child: Text(
                '愿心中有丘壑，一往无前',
                style: jm_text_black_style13,
              )),
          Positioned(
              left: margin + widthScale * 2,
              top: topSpace + 35,
              child: Text(
                (data['psotName'] != null ? (data['psotName'] + ' | ') : '') +
                    (data['dept'] != null
                        ? (data['dept'])['deptName'] ?? ''
                        : ''),
                style: jm_text_gray_style13,
              )),
          Positioned(
            right: widthScale * 2,
            top: topSpace + 10,
            height: 30,
            width: widthScale * 25,
            child: RawMaterialButton(
              shape: RoundedRectangleBorder(
                  side: BorderSide(width: 1, color: jm_line_color),
                  borderRadius: BorderRadius.circular(widthScale * 2)),
              elevation: 0,
              highlightElevation: 0,
              textStyle: jm_text_black_style13,
              // onLongPress: () => print('onLongPress'),
              child: Text('等级目标设置'),
              onPressed: () {
                if (toLevelSetting != null) {
                  toLevelSetting();
                }
              },
            ),
          ),
          Positioned(
              left: margin,
              height: 150,
              width: SizeConfig.screenWidth - margin * 2,
              top: topSpace + 70,
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  getCommissionButton('总佣金', '50000', widthScale, () {}),
                  getCommissionButton('已结佣', '20000', widthScale, () {}),
                  getCommissionButton('待结佣', '30000', widthScale, () {}),
                ],
              ))
        ],
      ),
    );
  }

  Widget getCommissionButton(
      String title, String subTitle, double widthScale, Function() onPressed) {
    return RawMaterialButton(
      shape: RoundedRectangleBorder(
          // side: BorderSide(width: 1, color: jm_line_color),
          borderRadius: BorderRadius.circular(widthScale * 2)),
      elevation: 4.0,
      fillColor: Colors.white,
      highlightElevation: 10,
      child: Container(
        width: widthScale * 16,
        height: 50,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              title,
              style: jm_text_black_style14,
            ),
            Text(
              subTitle,
              style: jm_text_black_bold_style16,
            ),
          ],
        ),
      ),
      onPressed: onPressed,
    );
  }
}
