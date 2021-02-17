import 'package:JMrealty/utils/sizeConfig.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class ReportSearchBar extends StatefulWidget {
  final Function(String value) valueChange;
  final String placeholder;
  final String text;
  const ReportSearchBar({this.valueChange, this.text, this.placeholder = ''});
  @override
  _ReportSearchBarState createState() => _ReportSearchBarState();
}

class _ReportSearchBarState extends State<ReportSearchBar> {
  @override
  Widget build(BuildContext context) {
    SizeConfig().init(context);
    double widthScale = SizeConfig.blockSizeHorizontal;
    return Align(
      child: Container(
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
              SizedBox(
                height: 50,
                width: widthScale * 68,
                child: CupertinoTextField(
                  placeholder: widget.placeholder ?? '',
                  // focusNode: widget.focusNode,
                  padding: EdgeInsets.only(left: 10),
                  style: TextStyle(fontSize: 15, color: Colors.white),
                  decoration: BoxDecoration(color: Colors.transparent),
                  placeholderStyle:
                      TextStyle(fontSize: 14, color: Colors.white),
                  onChanged: (value) {
                    if (widget.valueChange != null) {
                      widget.valueChange(value);
                    }
                  },
                ),
              ),
              Image.asset(
                'assets/images/icon/icon_project_searchbar_right.png',
                height: widthScale * 6,
                width: widthScale * 6,
              ),
              // SizedBox(
              //   height: widthScale * 2,
              // ),
            ],
          )),
    );
  }
}
