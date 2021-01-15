import 'dart:ui';

import 'package:JMrealty/const/Default.dart';
import 'package:JMrealty/utils/sizeConfig.dart';
import 'package:flutter/material.dart';

class EmptyView extends StatelessWidget {
  final String tips;
  const EmptyView({this.tips = '暂无内容'});
  @override
  Widget build(BuildContext context) {
    SizeConfig().init(context);
    double widthScale = SizeConfig.blockSizeHorizontal;
    return Container(
      width: SizeConfig.screenWidth,
      height: SizeConfig.screenHeight - kToolbarHeight - 20,
      child: Center(
        child: Column(
          children: [
            SizedBox(
              height: SizeConfig.blockSizeVertical * 10,
            ),
            Container(
              width: widthScale * 51,
              height: widthScale * 39,
              child: Image.asset(
                'assets/images/icon/bg_empty.png',
                fit: BoxFit.fill,
              ),
            ),
            Text(
              tips,
              style: jm_text_gray_style15,
            ),
          ],
        ),
      ),
    );
  }
}
