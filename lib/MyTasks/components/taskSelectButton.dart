import 'package:JMrealty/const/Default.dart';
import 'package:JMrealty/utils/sizeConfig.dart';
import 'package:flutter/material.dart';

class TaskSelectButton extends StatefulWidget {
  final Function(int clickIndex) clickIndex;
  const TaskSelectButton({this.clickIndex});
  @override
  _TaskSelectButtonState createState() => _TaskSelectButtonState();
}

class _TaskSelectButtonState extends State<TaskSelectButton> {
  double widthScale;
  double selfWidth;
  double selfHeight = 34;
  int currentIndex = 0;
  double boderRadius;
  @override
  Widget build(BuildContext context) {
    SizeConfig().init(context);
    widthScale = SizeConfig.blockSizeHorizontal;
    selfWidth = widthScale * 40;
    boderRadius = widthScale * 1.5;
    return Container(
      width: selfWidth + 3,
      height: 34,
      decoration: BoxDecoration(
          border: Border.all(width: 1.5, color: Colors.white),
          borderRadius: BorderRadius.circular(boderRadius)),
      child: Row(
        children: [
          getButton(0, '我发布的'),
          getButton(1, '我接收的'),
        ],
      ),
    );
  }

  Widget getButton(int index, String title) {
    return RawMaterialButton(
      materialTapTargetSize: MaterialTapTargetSize.shrinkWrap,
      constraints:
          BoxConstraints(minWidth: selfWidth / 2, minHeight: selfHeight),
      fillColor: index == currentIndex ? Colors.white : jm_appTheme,
      elevation: 0,
      highlightElevation: 0,
      shape: RoundedRectangleBorder(
          borderRadius: index == 0
              ? BorderRadius.horizontal(
                  left: Radius.circular(boderRadius * 0.7))
              : BorderRadius.horizontal(
                  right: Radius.circular(boderRadius * 0.7))),
      textStyle:
          TextStyle(color: index == currentIndex ? jm_appTheme : Colors.white),
      onPressed: () {
        if (index != currentIndex) {
          if (widget.clickIndex != null) {
            widget.clickIndex(index);
          }
          setState(() {
            currentIndex = index;
          });
        }
      },
      child: Text(title),
    );
  }
}
