import 'package:JMrealty/const/Default.dart';
import 'package:JMrealty/utils/sizeConfig.dart';
import 'package:flutter/material.dart';

class EmptyView extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    SizeConfig().init(context);
    return Container(
      width: SizeConfig.screenWidth,
      height: double.infinity,
      child: Center(
        child: Text(
          '暂无数据',
          style: jm_text_gray_style16,
        ),
      ),
    );
  }
}
