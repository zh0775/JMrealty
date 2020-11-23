import 'package:JMrealty/Login/model/PostListModel.dart';
import 'package:JMrealty/components/TreeSelectView.dart';
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
  final bool showTree;
  RegistSelectInput(
      {@required this.dataList,
      @required this.selectedChange,
      @required this.title,
      this.showTree = false,
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
    void Function() cellTap;
    if (widget.showTree) {
      cellTap = () {
        showGeneralDialog(
            context: context,
            barrierDismissible:true,
            barrierLabel: '123',
            transitionDuration: Duration(milliseconds: 200),
            barrierColor: Colors.black.withOpacity(.5),
            pageBuilder: (BuildContext context, Animation<double> animation,
                Animation<double> secondaryAnimation) {
              return TreeSelectView(size: Size(SizeConfig.blockSizeHorizontal*80, SizeConfig.blockSizeVertical*80),treeData: widget.dataList,);
            });
      };
    } else {
      cellTap = () {
        BottomSelect(
            pickerChildren: widget.dataList,
            selectedChange: (value, data) {
              widget.selectedChange(value, data);
              setState(() {
                callBackData = {'value': value, 'title': data};
              });
            }).didClickSelectedGender(context);
      };
    }
    return GestureDetector(
      onTap: cellTap,
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
