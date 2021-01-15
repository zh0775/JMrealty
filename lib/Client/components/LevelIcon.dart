import 'package:JMrealty/utils/sizeConfig.dart';
import 'package:flutter/material.dart';

class LevelIcon extends StatelessWidget {
  final int desireId;
  final double lineHeight;
  const LevelIcon({@required this.desireId, this.lineHeight = 30});
  @override
  Widget build(BuildContext context) {
    SizeConfig().init(context);
    String level = '';
    double colorAlpha = 0.5;
    Color levelColor = Color.fromRGBO(233, 193, 112, 1);
    Color toColor = Color.fromRGBO(233, 193, 112, colorAlpha);
    if (desireId != null) {
      switch (desireId) {
        case 1:
          level = 'A级';
          levelColor = Color.fromRGBO(233, 193, 112, 1);
          toColor = Color.fromRGBO(233, 193, 112, colorAlpha);
          break;
        case 2:
          level = 'B级';
          levelColor = Color.fromRGBO(91, 93, 106, 1);
          toColor = Color.fromRGBO(91, 93, 106, colorAlpha);
          break;
        case 3:
          level = 'C级';
          levelColor = Color.fromRGBO(40, 143, 255, 1);
          toColor = Color.fromRGBO(40, 143, 255, colorAlpha);
          break;
      }
    }
    return Container(
      width: SizeConfig.blockSizeHorizontal * 10,
      height: lineHeight,
      decoration: BoxDecoration(
          // color: levelColor,
          gradient: LinearGradient(
              begin: Alignment.topLeft,
              end: Alignment.bottomRight,
              stops: [0.3, 1.0],
              colors: [levelColor, toColor]),
          borderRadius: BorderRadius.only(
            topRight: Radius.circular((lineHeight) / 2),
            bottomLeft: Radius.circular((lineHeight) / 2),
            bottomRight: Radius.circular((lineHeight) / 2),
          )),
      child: Center(
        child: Text(
          level,
          style: TextStyle(color: Colors.white, fontSize: 16),
        ),
      ),
    );
  }
}
