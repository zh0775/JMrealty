import 'package:JMrealty/utils/sizeConfig.dart';
import 'package:flutter/material.dart';
import 'package:JMrealty/Login/components/BottomSelect.dart';

typedef void SelectedChange(int index, dynamic data);

class RegistSelectInput extends StatefulWidget {
  final String title;
  final List dataList;
  final SelectedChange selectedChange;
  final int defaultSelect;
  RegistSelectInput(
      {@required this.dataList,
      @required this.selectedChange,
      @required this.title,
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
        height: 50,
        constraints: BoxConstraints(maxHeight: 50),
        decoration: BoxDecoration(
            border: Border(
          top: BorderSide(width: 0.5, color: Color.fromRGBO(0, 0, 0, 0.2)),
          bottom: BorderSide(width: 0.5, color: Color.fromRGBO(0, 0, 0, 0.2)),
        )),
        child: Row(
          children: [
            SizedBox(
              width: 20,
            ),
            Text(widget.title),
            SizedBox(
              width: 40,
            ),
            Text(
              text,
              style: textStyle,
            ),
            Icon(Icons.keyboard_arrow_right),
            SizedBox(
              width: 20,
            )
          ],
        ),
      ),
    );
  }
}
