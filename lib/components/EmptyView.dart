import 'dart:ui';

import 'package:JMrealty/const/Default.dart';
import 'package:JMrealty/utils/sizeConfig.dart';
import 'package:flutter/material.dart';

class EmptyView extends StatelessWidget {
  final String tips;
  final double height;
  const EmptyView({this.tips = '暂无内容', this.height});
  @override
  Widget build(BuildContext context) {
    SizeConfig().init(context);
    double widthScale = SizeConfig.blockSizeHorizontal;
    double selfHeight = height;
    if (selfHeight == null) {
      selfHeight = SizeConfig.screenHeight - kToolbarHeight - 20;
    }
    return Container(
      width: SizeConfig.screenWidth,
      height: selfHeight,
      child: Center(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Container(
              width: widthScale * 51,
              height: widthScale * 39,
              child: Image.asset(
                'assets/images/icon/bg_empty.gif',
                fit: BoxFit.fill,
              ),
            ),
            Text(
              tips,
              style: jm_text_gray_style15,
            ),
            SizedBox(
              height: SizeConfig.blockSizeVertical * 5,
            ),
          ],
        ),
      ),
    );
  }
}
