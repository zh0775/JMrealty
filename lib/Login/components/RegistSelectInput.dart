import 'package:JMrealty/components/TreeNode.dart';
import 'package:JMrealty/components/TreeSelectView.dart';
import 'package:JMrealty/const/Default.dart';
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
  final double width;
  final double labelWidth;
  final Border border;
  final bool showTree;
  final void Function(TreeNode node) nodeSelected;
  final void Function(List<TreeNode> nodes) nodesSelected;
  final String hintText;
  final TextStyle labelStyle;
  RegistSelectInput(
      {@required this.dataList,
      @required this.title,
      this.selectedChange,
      this.nodeSelected,
      this.nodesSelected,
      this.showTree = false,
      this.height = 50,
      this.width,
      this.labelWidth,
      this.border = const Border(
        top: BorderSide(width: 0.5, color: Color.fromRGBO(0, 0, 0, 0.2)),
        bottom: BorderSide(width: 0.5, color: Color.fromRGBO(0, 0, 0, 0.2)),
      ),
      this.defaultSelect,
      this.hintText = '',
      this.labelStyle = jm_text_black_style14});
  @override
  _RegistSelectInputState createState() => _RegistSelectInputState();
}

class _RegistSelectInputState extends State<RegistSelectInput> {
  Map callBackData;
  double width;
  double labelWidth;
  @override
  void initState() {
    callBackData = null;
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    SizeConfig().init(context);
    widget.width != null
        ? width = widget.width
        : width = SizeConfig.screenWidth;
    widget.labelWidth != null
        ? labelWidth = widget.labelWidth
        : labelWidth = SizeConfig.blockSizeHorizontal * 30 - 20;
    TextStyle textStyle;
    String text;
    if (callBackData != null) {
      textStyle = widget.labelStyle;
      text = callBackData['title'];
    } else {
      textStyle = TextStyle(color: Color.fromRGBO(0, 0, 0, 0.2), fontSize: 14);
      text = widget.hintText;
    }
    void Function() cellTap;
    if (widget.showTree) {
      cellTap = () {
        showGeneralDialog(
            context: context,
            barrierDismissible: true,
            barrierLabel: '',
            transitionDuration: Duration(milliseconds: 200),
            barrierColor: Colors.black.withOpacity(.5),
            pageBuilder: (BuildContext context, Animation<double> animation,
                Animation<double> secondaryAnimation) {
              return TreeSelectView(
                size: Size(SizeConfig.blockSizeHorizontal * 80,
                    SizeConfig.blockSizeVertical * 80),
                treeData: widget.dataList,
                nodeSelected: (node) {
                  if (widget.nodeSelected != null) {
                    widget.nodeSelected(node);
                  }
                  setState(() {
                    callBackData = {'value': node.id, 'title': node.label};
                  });
                },
                nodesSelected: (nodes) {
                  if (widget.nodesSelected != null) {
                    widget.nodesSelected(nodes);
                  }
                },
              );
            });
      };
    } else {
      cellTap = () {
        BottomSelect(
            pickerChildren: widget.dataList,
            selectedChange: (value, data) {
              if (widget.selectedChange != null) {
                widget.selectedChange(value, data);
              }
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
            // SizedBox(
            //   width: 20,
            // ),
            Container(
              width: labelWidth,
              child: Text(widget.title),
            ),
            Container(
              width: width - labelWidth - 25,
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
