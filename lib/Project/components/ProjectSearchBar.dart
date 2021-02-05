import 'package:JMrealty/Project/ProjectSearch.dart';
import 'package:JMrealty/components/CustomTextF.dart';
import 'package:JMrealty/const/Default.dart';
import 'package:JMrealty/utils/sizeConfig.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class ProjectSearchBar extends StatefulWidget implements PreferredSizeWidget {
  final Function(String value) valueChange;
  final FocusNode focusNode;
  final String text;
  final bool toProjectSearch;
  const ProjectSearchBar(
      {this.valueChange,
      this.focusNode,
      this.text,
      this.toProjectSearch = false});
  @override
  _ProjectSearchBarState createState() => _ProjectSearchBarState();
  @override
  Size get preferredSize => new Size.fromHeight(50);
}

class _ProjectSearchBarState extends State<ProjectSearchBar> {
  @override
  Widget build(BuildContext context) {
    SizeConfig().init(context);
    double widthScale = SizeConfig.blockSizeHorizontal;
    return Container(
        height: 50,
        width: SizeConfig.screenWidth - widthScale * 12,
        decoration: BoxDecoration(
          color: Color(0x33404352),
          borderRadius: BorderRadius.circular(widthScale * 2),
        ),
        child: Row(
          children: [
            SizedBox(
              width: widthScale * 4,
            ),
            Image.asset(
              'assets/images/icon/icon_project_searchbar_left.png',
              height: widthScale * 7.5,
              width: widthScale * 7.5,
            ),
            widget.toProjectSearch
                ? GestureDetector(
                    behavior: HitTestBehavior.opaque,
                    onTap: () => push(ProjectSearch(), context),
                    child: Container(
                        height: 50,
                        width: widthScale * 68,
                        alignment: Alignment.centerLeft,
                        child: Padding(
                          padding: EdgeInsets.only(left: widthScale * 2),
                          child: Text(
                            widget.text ?? '',
                            style: TextStyle(fontSize: 15, color: Colors.white),
                          ),
                        )),
                  )
                : SizedBox(
                    height: 50,
                    width: widthScale * 68,
                    child: CupertinoTextField(
                      placeholder: '请输入项目名称',
                      focusNode: widget.focusNode,
                      padding: EdgeInsets.only(left: 10),
                      style: TextStyle(fontSize: 15, color: Colors.white),
                      decoration: BoxDecoration(color: Colors.transparent),
                      placeholderStyle:
                          TextStyle(fontSize: 15, color: Colors.white),
                      onChanged: (value) {
                        if (widget.valueChange != null) {
                          widget.valueChange(value);
                        }
                      },
                    ),
                  ),
            // CustomTextF(
            //     height: 50,
            //     width: widthScale * 68,
            //     focusNode: widget.focusNode,
            //     // text: widget.text,
            //     controller: null,
            //     valueChange: widget.valueChange,
            //     style: TextStyle(fontSize: 15, color: Colors.white),
            //     backgroundColor: Colors.transparent,
            //     hintStyle: TextStyle(fontSize: 15, color: Colors.white),
            //     // backgroundColor: Color(0x33404352),
            //     placeholder: '请输入项目名称',
            //     border: BorderSide.none,
            //   ),
            Image.asset(
              'assets/images/icon/icon_project_searchbar_right.png',
              height: widthScale * 6,
              width: widthScale * 6,
            ),
            // SizedBox(
            //   height: widthScale * 2,
            // ),
          ],
        ));
  }
}
