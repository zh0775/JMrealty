import 'package:JMrealty/components/CustomTextF.dart';
import 'package:JMrealty/const/Default.dart';
import 'package:flutter/material.dart';

class ProjectSearchBar extends StatefulWidget implements PreferredSizeWidget {
  final Function(String value) valueChange;
  final FocusNode focusNode;
  final String text;
  const ProjectSearchBar({this.valueChange, this.focusNode, this.text});
  @override
  _ProjectSearchBarState createState() => _ProjectSearchBarState();
  @override
  Size get preferredSize => new Size.fromHeight(50);
}

class _ProjectSearchBarState extends State<ProjectSearchBar> {
  @override
  Widget build(BuildContext context) {
    return Container(
      height: 50,
      child: CustomTextF(
        height: 35,
        focusNode: widget.focusNode,
        text: widget.text,
        valueChange: widget.valueChange,
        backgroundColor: Colors.white,
        placeholder: '请输入项目名称',
        border: BorderSide(color: jm_line_color, width: 1),
      ),
    );
  }
}
