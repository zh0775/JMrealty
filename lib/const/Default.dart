import 'package:JMrealty/Login/Login.dart';
import 'package:JMrealty/Login/components/RegistSelectInput.dart';
import 'package:JMrealty/Login/components/ZZInput.dart';
import 'package:JMrealty/utils/sizeConfig.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

enum Sex { boy, girl }

const Color jm_appTheme = Color.fromRGBO(230, 184, 92, 1);
const Color jm_appTheme_splash = Color.fromRGBO(230, 184, 92, 0.2);
const Color jm_line_color = Color.fromRGBO(0, 0, 0, 0.12);
const Color jm_text_black = Color(0xff404351);
const Color jm_text_gray = Color(0xffaaacb2);

const TextStyle jm_text_gray_style10 =
    TextStyle(fontSize: 10, color: jm_text_gray);
const TextStyle jm_text_gray_style11 =
    TextStyle(fontSize: 11, color: jm_text_gray);
const TextStyle jm_text_gray_style12 =
    TextStyle(fontSize: 12, color: jm_text_gray);
const TextStyle jm_text_gray_style13 =
    TextStyle(fontSize: 13, color: jm_text_gray);
const TextStyle jm_text_gray_style14 =
    TextStyle(fontSize: 14, color: jm_text_gray);
const TextStyle jm_text_gray_style15 =
    TextStyle(fontSize: 15, color: jm_text_gray);
const TextStyle jm_text_gray_style16 =
    TextStyle(fontSize: 16, color: jm_text_gray);
const TextStyle jm_text_gray_style17 =
    TextStyle(fontSize: 17, color: jm_text_gray);
const TextStyle jm_text_gray_style18 =
    TextStyle(fontSize: 18, color: jm_text_gray);
const TextStyle jm_text_gray_style19 =
    TextStyle(fontSize: 19, color: jm_text_gray);
const TextStyle jm_text_gray_style20 =
    TextStyle(fontSize: 20, color: jm_text_gray);

const TextStyle jm_text_apptheme_style10 =
    TextStyle(fontSize: 10, color: jm_appTheme);
const TextStyle jm_text_apptheme_style11 =
    TextStyle(fontSize: 11, color: jm_appTheme);
const TextStyle jm_text_apptheme_style12 =
    TextStyle(fontSize: 12, color: jm_appTheme);
const TextStyle jm_text_apptheme_style13 =
    TextStyle(fontSize: 13, color: jm_appTheme);
const TextStyle jm_text_apptheme_style14 =
    TextStyle(fontSize: 14, color: jm_appTheme);
const TextStyle jm_text_apptheme_style15 =
    TextStyle(fontSize: 15, color: jm_appTheme);
const TextStyle jm_text_apptheme_style16 =
    TextStyle(fontSize: 16, color: jm_appTheme);
const TextStyle jm_text_apptheme_style17 =
    TextStyle(fontSize: 17, color: jm_appTheme);
const TextStyle jm_text_apptheme_style18 =
    TextStyle(fontSize: 18, color: jm_appTheme);
const TextStyle jm_text_apptheme_style19 =
    TextStyle(fontSize: 19, color: jm_appTheme);
const TextStyle jm_text_apptheme_style20 =
    TextStyle(fontSize: 20, color: jm_appTheme);

const TextStyle jm_text_black_style10 =
    TextStyle(fontSize: 10, color: jm_text_black);
const TextStyle jm_text_black_style11 =
    TextStyle(fontSize: 11, color: jm_text_black);
const TextStyle jm_text_black_style12 =
    TextStyle(fontSize: 12, color: jm_text_black);
const TextStyle jm_text_black_style13 =
    TextStyle(fontSize: 13, color: jm_text_black);
const TextStyle jm_text_black_style14 =
    TextStyle(fontSize: 14, color: jm_text_black);
const TextStyle jm_text_black_style15 =
    TextStyle(fontSize: 15, color: jm_text_black);
const TextStyle jm_text_black_style16 =
    TextStyle(fontSize: 16, color: jm_text_black);
const TextStyle jm_text_black_style17 =
    TextStyle(fontSize: 17, color: jm_text_black);
const TextStyle jm_text_black_style18 =
    TextStyle(fontSize: 18, color: jm_text_black);
const TextStyle jm_text_black_style19 =
    TextStyle(fontSize: 19, color: jm_text_black);
const TextStyle jm_text_black_style20 =
    TextStyle(fontSize: 20, color: jm_text_black);

const TextStyle jm_text_black_bold_style10 =
    TextStyle(fontSize: 10, color: jm_text_black, fontWeight: FontWeight.bold);
const TextStyle jm_text_black_bold_style11 =
    TextStyle(fontSize: 11, color: jm_text_black, fontWeight: FontWeight.bold);
const TextStyle jm_text_black_bold_style12 =
    TextStyle(fontSize: 12, color: jm_text_black, fontWeight: FontWeight.bold);
const TextStyle jm_text_black_bold_style13 =
    TextStyle(fontSize: 13, color: jm_text_black, fontWeight: FontWeight.bold);
const TextStyle jm_text_black_bold_style14 =
    TextStyle(fontSize: 14, color: jm_text_black, fontWeight: FontWeight.bold);
const TextStyle jm_text_black_bold_style15 =
    TextStyle(fontSize: 15, color: jm_text_black, fontWeight: FontWeight.bold);
const TextStyle jm_text_black_bold_style16 =
    TextStyle(fontSize: 16, color: jm_text_black, fontWeight: FontWeight.bold);
const TextStyle jm_text_black_bold_style17 =
    TextStyle(fontSize: 17, color: jm_text_black, fontWeight: FontWeight.bold);
const TextStyle jm_text_black_bold_style18 =
    TextStyle(fontSize: 18, color: jm_text_black, fontWeight: FontWeight.bold);
const TextStyle jm_text_black_bold_style19 =
    TextStyle(fontSize: 19, color: jm_text_black, fontWeight: FontWeight.bold);
const TextStyle jm_text_black_bold_style20 =
    TextStyle(fontSize: 20, color: jm_text_black, fontWeight: FontWeight.bold);

class Global {
  static GlobalKey<NavigatorState> navigatorKey = GlobalKey<NavigatorState>();

  static void toLogin({bool isLogin = true}) {
    Navigator.of(Global.navigatorKey.currentState.context)
        .push(MaterialPageRoute(
            builder: (_) {
              return Login(
                isLogin: isLogin,
              );
            },
            fullscreenDialog: true));
  }
}

class JMline extends StatelessWidget {
  final double width;
  final double height;
  final double margin;
  const JMline({@required this.width, @required this.height, this.margin = 0});
  @override
  Widget build(BuildContext context) {
    return Container(
      width: width,
      height: height,
      color: jm_line_color,
      margin: EdgeInsets.only(left: margin),
    );
  }
}

class SelectView extends StatefulWidget {
  final double margin;
  final String title;
  final double labelWidth;
  final double lineHeight;
  final TextStyle labelStyle;
  final List dataList;

  final Function(int value, dynamic data) selectValueChange;
  SelectView(
      {this.margin = 0,
      this.title = '',
      this.labelWidth,
      @required this.dataList,
      this.lineHeight = 50,
      this.selectValueChange,
      this.labelStyle = jm_text_black_style14});
  @override
  _SelectViewState createState() => _SelectViewState();
}

class _SelectViewState extends State<SelectView> {
  @override
  Widget build(BuildContext context) {
    SizeConfig().init(context);
    return Padding(
      padding: EdgeInsets.only(left: widget.margin),
      child: RegistSelectInput(
        labelStyle: widget.labelStyle,
        title: widget.title,
        width: SizeConfig.screenWidth - widget.margin * 2,
        labelWidth: widget.labelWidth ?? SizeConfig.blockSizeHorizontal * 22,
        dataList: widget.dataList,
        hintText: '请选择' + widget.title,
        height: widget.lineHeight,
        border: Border.all(color: Colors.transparent, width: 0.0),
        selectedChange: widget.selectValueChange != null
            ? widget.selectValueChange
            : (int value, dynamic data) {},
      ),
    );
  }
}

class CustomInput extends StatefulWidget {
  final double margin;
  final String title;
  final double lineHeight;
  final double labelWidth;
  final bool must;
  final String hintText;
  final TextInputType keyboardType;
  final TextStyle labelStyle;
  final double otherWidth;
  final String text;
  final bool enable;
  final TextStyle textStyle;
  final Function(Map data) showListClick;
  final Function(String value) valueChange;
  final Function(String value, _CustomInputState state) valueChangeAndShowList;
  CustomInput(
      {Key key,
      this.title = '',
      this.otherWidth,
      this.valueChange,
      this.lineHeight = 50,
      this.labelWidth,
      this.must = false,
      this.hintText = '',
      this.keyboardType = TextInputType.text,
      this.labelStyle = jm_text_black_style14,
      this.margin,
      this.text = '',
      this.enable = true,
      this.textStyle = jm_text_black_style14,
      this.valueChangeAndShowList,
      this.showListClick})
      : super(key: key);
  @override
  _CustomInputState createState() => _CustomInputState();
}

class _CustomInputState extends State<CustomInput> {
  double margin;
  double lableWidth;
  OverlayEntry _overlayEntry;
  bool isShow = false;
  final LayerLink _layerLink = LayerLink();
  @override
  Widget build(BuildContext context) {
    SizeConfig().init(context);
    margin = widget.margin != null
        ? widget.margin
        : SizeConfig.blockSizeHorizontal * 6;
    lableWidth = widget.labelWidth != null
        ? widget.labelWidth
        : SizeConfig.blockSizeHorizontal * 22;
    return CompositedTransformTarget(
      link: this._layerLink,
      child: Align(
        child: Container(
          width: SizeConfig.screenWidth - margin * 2,
          height: widget.lineHeight,
          child: Row(
            children: [
              Container(
                  width: lableWidth,
                  height: widget.lineHeight,
                  child: Align(
                      alignment: Alignment.centerLeft,
                      child: getlabel(widget.title, widget.must))),
              ZZInput(
                textStyle: widget.textStyle,
                enable: widget.enable,
                text: widget.text,
                leftPadding: 0,
                height: widget.lineHeight,
                width: widget.otherWidth ??
                    SizeConfig.screenWidth - margin * 2 - lableWidth,
                keyboardType: widget.keyboardType,
                backgroundColor: Colors.transparent,
                needCleanButton: true,
                valueChange: (String value) {
                  if (widget.valueChange != null) {
                    widget.valueChange(value);
                  }
                  if (widget.valueChangeAndShowList != null) {
                    widget.valueChangeAndShowList(value, this);
                  }
                },
                hintText: widget.hintText,
              )
            ],
          ),
        ),
      ),
    );
  }

  void showList(List data) {
    if (!isShow) {
      this._overlayEntry = this.createOverlayEntry(data);
      Overlay.of(context).insert(this._overlayEntry);
      isShow = true;
    }
  }

  void removeList() {
    // Overlay.of(context).
    if (isShow) {
      _overlayEntry.remove();
      isShow = false;
    }
  }

  OverlayEntry createOverlayEntry(List data) {
    RenderBox renderBox = context.findRenderObject();
    var size = renderBox.size;

    return OverlayEntry(
        builder: (context) => Positioned(
              width: size.width,
              child: CompositedTransformFollower(
                link: this._layerLink,
                showWhenUnlinked: false,
                offset: Offset(0.0, size.height + 5.0),
                child: Material(
                  elevation: 4.0,
                  child: ListView.builder(
                    padding: EdgeInsets.zero,
                    shrinkWrap: true,
                    itemCount: data.length,
                    itemBuilder: (context, index) {
                      return ListTile(
                        title: Text((data[index])['name']),
                        onTap: () {
                          if (widget.showListClick != null) {
                            widget.showListClick(data[index]);
                          }
                          removeList();
                        },
                      );
                    },
                  ),
                ),
              ),
            ));
  }

  Widget getlabel(String title, bool must) {
    Widget textWidget;
    if (must) {
      textWidget = RichText(
        text: TextSpan(
            text: '*',
            style: TextStyle(color: Colors.red, fontSize: 14),
            children: <TextSpan>[
              TextSpan(text: title, style: widget.labelStyle)
            ]),
      );
    } else {
      textWidget = Text(
        title,
        style: widget.labelStyle,
      );
    }
    return textWidget;
  }
}

class SexCell extends StatefulWidget {
  final double margin;
  final String title;
  final double lineHeight;
  final double labelWidth;
  final TextStyle labelStyle;
  final Sex sex;
  final Function(Sex newSex) valueChange;
  SexCell(
      {this.margin,
      this.title = '',
      this.lineHeight = 50,
      this.labelWidth,
      this.labelStyle = jm_text_black_style14,
      this.sex,
      this.valueChange});
  @override
  _SexCellState createState() => _SexCellState();
}

class _SexCellState extends State<SexCell> {
  double margin;
  double labelWidth;
  Sex sex;
  @override
  void initState() {
    sex = widget.sex != null ? widget.sex : Sex.boy;
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    SizeConfig().init(context);
    margin = widget.margin != null
        ? widget.margin
        : SizeConfig.blockSizeHorizontal * 6;
    labelWidth = widget.labelWidth != null
        ? widget.labelWidth
        : SizeConfig.blockSizeHorizontal * 22;
    return Align(
        child: Container(
      width: SizeConfig.screenWidth - margin * 2,
      height: widget.lineHeight,
      child: Row(
        children: [
          Container(
            width: labelWidth,
            child: Text(
              widget.title,
              style: widget.labelStyle,
            ),
          ),
          sexButton(context, Sex.boy, (Sex value) {
            setState(() {
              if (widget.valueChange != null) {
                widget.valueChange(value);
              }
              sex = value;
            });
          }),
          SizedBox(
            width: SizeConfig.blockSizeHorizontal * 6,
          ),
          sexButton(context, Sex.girl, (Sex value) {
            setState(() {
              if (widget.valueChange != null) {
                widget.valueChange(value);
              }
              sex = value;
            });
          }),
        ],
      ),
    ));
  }

  Widget sexButton(
      BuildContext context, Sex buttonSex, Function(Sex sexValue) valueChange) {
    double sexButtonHeight = widget.lineHeight * 0.7;
    return Align(
      child: Container(
        width: 60,
        height: sexButtonHeight,
        decoration: BoxDecoration(
            border:
                Border.all(width: 0.5, color: Color.fromRGBO(64, 67, 82, 1)),
            color:
                buttonSex == sex ? Color.fromRGBO(64, 67, 82, 1) : Colors.white,
            borderRadius: BorderRadius.circular(sexButtonHeight / 2)),
        child: TextButton(
          onPressed: () {
            if (buttonSex != sex) {
              if (valueChange != null) {
                valueChange(buttonSex);
              }
            }
          },
          child: Text(
            buttonSex == Sex.boy ? '男' : '女',
            style: TextStyle(
                // textBaseline: TextBaseline.alphabetic,
                fontSize: 15,
                color: buttonSex != sex
                    ? Color.fromRGBO(64, 67, 82, 1)
                    : Colors.white),
          ),
        ),
      ),
    );
  }
}
