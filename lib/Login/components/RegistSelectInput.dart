import 'package:JMrealty/utils/sizeConfig.dart';
import 'package:flutter/material.dart';
import 'package:JMrealty/Login/components/BottomSelect.dart';

typedef void SelectedChange(int index, dynamic data);

class RegistSelectInput extends StatefulWidget {
  final String title;
  final List dataList;
  final SelectedChange selectedChange;
  final int defaultSelect;
  final double height;
  final Border border;
  RegistSelectInput(
      {@required this.dataList,
      @required this.selectedChange,
      @required this.title,
      this.height = 50,
      this.border = const Border(
        top: BorderSide(width: 0.5, color: Color.fromRGBO(0, 0, 0, 0.2)),
        bottom: BorderSide(width: 0.5, color: Color.fromRGBO(0, 0, 0, 0.2)),
      ),
      this.defaultSelect = 0});
  @override
  _RegistSelectInputState createState() => _RegistSelectInputState();
}

class _RegistSelectInputState extends State<RegistSelectInput> {
  Map callBackData;

  @override
  void initState() {
    callBackData = null;
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    SizeConfig().init(context);

    TextStyle textStyle;
    String text;
    if (callBackData != null) {
      textStyle = TextStyle(color: Colors.black, fontSize: 14);
      text = callBackData['title'];
    } else {
      textStyle = TextStyle(color: Color.fromRGBO(0, 0, 0, 0.2), fontSize: 14);
      text = '请选择组织级别';
    }
    return GestureDetector(
      onTap: () {
        BottomSelect(
            pickerChildren: widget.dataList,
            selectedChange: (value, data) {
              widget.selectedChange(value, data);
              setState(() {
                callBackData = {'value': value, 'title': data};
              });
            }).didClickSelectedGender(context);
      },
      child: Container(
        width: SizeConfig.screenWidth,
        height: widget.height,
        constraints: BoxConstraints(maxHeight: widget.height),
        decoration: BoxDecoration(border: widget.border),
        child: Row(
          children: [
            SizedBox(
              width: 20,
            ),
            Container(
              width: SizeConfig.blockSizeHorizontal * 30 - 20,
              child: Text(widget.title),
            ),
            Container(
              width: SizeConfig.blockSizeHorizontal * 70 - 55,
              child: Text(
                text,
                style: textStyle,
              ),
            ),
            Icon(
              Icons.keyboard_arrow_right,
              size: 25,
            ),
          ],
        ),
      ),
    );
  }
}
