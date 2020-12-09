import 'package:JMrealty/utils/sizeConfig.dart';
import 'package:flutter/material.dart';

class CustomGridImageV extends StatelessWidget {
  final List<String> imageUrls;
  final bool needButton;
  final double width;
  final int count;
  CustomGridImageV({this.imageUrls = const [],this.needButton = false,this.count = 3, this.width});
  double selfWidth;
  double margin;
  double widthScale;
  @override
  Widget build(BuildContext context) {
    SizeConfig().init(context);
    widthScale = SizeConfig.blockSizeHorizontal;
    margin = width != null ? (SizeConfig.screenWidth - width) / 2 : widthScale * 5;
    selfWidth = width ?? SizeConfig.screenWidth - margin * 2;
    return Container(
      width: width,
      margin: EdgeInsets.only(left: margin),
      child: Stack(
      ),
    );
  }
}
