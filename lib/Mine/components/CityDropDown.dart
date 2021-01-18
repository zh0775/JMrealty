import 'package:JMrealty/components/NoneV.dart';
import 'package:JMrealty/const/Default.dart';
import 'package:JMrealty/utils/sizeConfig.dart';
import 'package:flutter/material.dart';

class CityDropDown extends StatefulWidget {
  final dynamic currentValue;
  final List dataList;
  final double width;
  final double margin;
  final double height;
  final double rowHeight;
  final double labelWidth;
  final String labelText;
  final String placeholder;
  final TextStyle placeholderStyle;
  final bool must;
  final bool bottomLine;
  final Color backgroundColor;
  final TextStyle labelStyle;
  final TextStyle style;
  final BorderSide border;
  final bool defalultValue;
  final int defalultValueIndex;
  final Function(dynamic value, Map data) valueChange;
  final EdgeInsets textPadding;
  final String valueKey;
  final String titleKey;
  const CityDropDown(
      {Key key,
      this.valueKey = 'value',
      this.titleKey = 'title',
      this.currentValue,
      this.width,
      this.margin,
      this.height = 50,
      this.rowHeight = 45.0,
      this.bottomLine = false,
      this.labelWidth = 0.0,
      this.labelText,
      this.placeholder = '',
      this.must = false,
      this.labelStyle = jm_text_black_style14,
      this.style = jm_text_black_style14,
      this.backgroundColor = Colors.transparent,
      this.placeholderStyle =
          const TextStyle(color: jm_placeholder_color, fontSize: 14),
      this.valueChange,
      this.border = BorderSide.none,
      this.defalultValue = false,
      this.defalultValueIndex = 0,
      this.textPadding = const EdgeInsets.fromLTRB(0, 0, 0, 0),
      this.dataList = const []});
  @override
  _CityDropDownState createState() => _CityDropDownState();
}

class _CityDropDownState extends State<CityDropDown> {
  GlobalKey _globalKey = GlobalKey();
  double widthScale;
  double otherWidth;
  double labelWidth;
  double selfWidth;
  double margin;
  String selfValue = '';
  TextStyle selfStyle;
  Map selfValueData = {};

  @override
  Widget build(BuildContext context) {
    if (widget.currentValue != null && widget.currentValue != '') {
      if (widget.dataList != null && widget.dataList.length > 0) {
        widget.dataList.forEach((e) {
          if (e[widget.valueKey] == widget.currentValue) {
            selfValue = e[widget.titleKey];
          }
        });
      }
    } else if (selfValue == '') {
      selfValue = widget.dataList != null && widget.dataList.length > 0
          ? (widget.defalultValue
              ? ((widget
                      .dataList[widget.defalultValueIndex])[widget.titleKey] ??
                  (widget.placeholder ?? ''))
              : widget.placeholder ?? '')
          : widget.placeholder ?? '';
    }

    selfStyle = selfValue != '' && selfValue != widget.placeholder
        ? widget.style
        : widget.placeholderStyle;

    SizeConfig().init(context);
    widthScale = SizeConfig.blockSizeHorizontal;
    if (widget.width == null) {
      if (widget.margin == null) {
        margin = widthScale * 6;
      }
      selfWidth = SizeConfig.screenWidth - margin * 2;
    } else {
      selfWidth = widget.width;
      margin = (SizeConfig.screenWidth - selfWidth) / 2;
    }
    widget.labelWidth == 0.0 && widget.labelText != null
        ? labelWidth = widthScale * 24
        : labelWidth = widget.labelWidth;
    otherWidth = selfWidth - labelWidth;

    return GestureDetector(
      onTap: () {
        FocusScope.of(context).requestFocus(FocusNode());
        RenderBox renderBox = _globalKey.currentContext.findRenderObject();
        Rect box = renderBox.localToGlobal(Offset.zero) & renderBox.size;
        Navigator.push(
            context,
            _DropDownMenuRoute(
                position: box,
                menuHeight: widget.dataList != null
                    ? widget.dataList.length * widget.rowHeight
                    : 0.0,
                content: Material(
                  child: Card(
                    elevation: 4.0,
                    child: SizedBox(
                      height: widget.rowHeight * 6,
                      child: SingleChildScrollView(
                        child: Column(
                          children: [
                            ...buttons(widget.dataList ?? [],
                                renderBox.size.width, widget.valueChange),
                          ],
                        ),
                      ),
                    ),
                  ),
                )));
      },
      child: UnconstrainedBox(
        child: Container(
          key: _globalKey,
          width: selfWidth + 4,
          height: widget.height,
          decoration: BoxDecoration(
              border: Border.all(width: 2, color: jm_line_color),
              borderRadius: BorderRadius.circular(widthScale * 2)),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Row(
                children: [
                  SizedBox(
                    width: widthScale * 5,
                  ),
                  Image.asset(
                    'assets/images/icon/icon_city_location.png',
                    width: widthScale * 4,
                    height: widthScale * 4,
                  ),
                  // Icon(
                  //   Icons.location_on,
                  //   size: widthScale * 4,
                  // ),
                  SizedBox(
                    width: widthScale * 3,
                  ),
                  Text(
                    selfValue,
                    style: selfStyle,
                  ),
                ],
              ),
              Row(
                children: [
                  Icon(
                    Icons.arrow_drop_down,
                    size: widthScale * 6,
                  ),
                  SizedBox(
                    width: widthScale * 3,
                  ),
                ],
              )
            ],
          ),
        ),
      ),
    );
  }

  List<Widget> buttons(
      List datas, double width, Function(dynamic value, Map data) valueChange) {
    double buttonHeight = widget.rowHeight != null ? widget.rowHeight : 40.0;
    List<Widget> buttons = [];
    if (datas != null && datas.length > 0) {
      for (var i = 0; i < datas.length; i++) {
        Map rowData = datas[i];
        buttons.add((RawMaterialButton(
          materialTapTargetSize: MaterialTapTargetSize.shrinkWrap,
          constraints: BoxConstraints(minWidth: width, minHeight: buttonHeight),
          onPressed: () {
            if (valueChange != null) {
              valueChange(rowData[widget.valueKey], rowData);
            }
            selfValue = rowData[widget.titleKey];

            Navigator.of(context).pop();
          },
          child: Container(
            padding: EdgeInsets.only(left: widthScale * 6),
            width: width,
            alignment: Alignment.centerLeft,
            height: buttonHeight,
            decoration: BoxDecoration(
                border: Border(
                    bottom: BorderSide(width: 0.5, color: jm_line_color))),
            child: Text(
              rowData[widget.titleKey],
              style: jm_text_black_style15,
            ),
          ),
        )));
      }
    }
    return buttons;
  }
}

class _DropDownMenuRouteLayout extends SingleChildLayoutDelegate {
  final Rect position;
  final double menuHeight;

  _DropDownMenuRouteLayout({this.position, this.menuHeight});

  @override
  BoxConstraints getConstraintsForChild(BoxConstraints constraints) {
    // return BoxConstraints(
    //     minWidth: position.right - position.left, minHeight: menuHeight);
    return BoxConstraints.loose(
        Size(position.right - position.left, menuHeight + 8));
  }

  @override
  Offset getPositionForChild(Size size, Size childSize) {
    return Offset(position.left, position.bottom);
  }

  @override
  bool shouldRelayout(SingleChildLayoutDelegate oldDelegate) {
    return true;
  }
}

class _DropDownMenuRoute extends PopupRoute {
  final Rect position;
  final double menuHeight;
  final Widget content;

  _DropDownMenuRoute({this.position, this.menuHeight, this.content});

  @override
  Color get barrierColor => null;

  @override
  bool get barrierDismissible => true;

  @override
  String get barrierLabel => null;

  @override
  Widget buildPage(BuildContext context, Animation<double> animation,
      Animation<double> secondaryAnimation) {
    return CustomSingleChildLayout(
      delegate:
          _DropDownMenuRouteLayout(position: position, menuHeight: menuHeight),
      child:
          // content ?? NoneV(),
          // PositionedTransition
          SizeTransition(
        sizeFactor: Tween<double>(begin: 0.0, end: 1.0).animate(animation),
        child: content ?? NoneV(),
      ),
    );
  }

  @override
  Duration get transitionDuration => Duration(milliseconds: 150);
}
