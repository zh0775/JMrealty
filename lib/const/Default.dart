import 'package:JMrealty/Login/Login.dart';
import 'package:JMrealty/Login/components/RegistSelectInput.dart';
import 'package:JMrealty/components/CustomSearchView.dart';
import 'package:JMrealty/utils/sizeConfig.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';

enum Sex { boy, girl }

typedef IndexClick = Function();

const Color jm_appTheme = Color.fromRGBO(230, 184, 92, 1);
const Color jm_appTheme_disable = Color.fromRGBO(230, 184, 92, 0.6);
const Color jm_appTheme_splash = Color.fromRGBO(230, 184, 92, 0.2);
const Color jm_line_color = Color(0xFFF0F2F5);
// const Color jm_line_color = Color.fromRGBO(0, 0, 0, 0.12);
const Color jm_text_black = Color(0xff404351);
const Color jm_text_gray = Color(0xffaaacb2);
const Color jm_placeholder_color = Color(0xffaab2bd);
const Color jm_bg_gray_color = Color(0xFFF0F2F5);
const IconData jm_naviBack = Icons.navigate_before;
const Icon jm_naviBack_icon = Icon(
  jm_naviBack,
  size: 40,
  color: Colors.white,
);
const Icon jm_naviAdd_icon = Icon(
  Icons.add,
  size: 40,
  color: Colors.white,
);

void callPhone(String phone) {
  if (phone != null) {
    print('拨打电话--tel://$phone');
    launch('tel://$phone');
  }
}

void push(Widget widget, BuildContext context) {
  Navigator.of(context).push(CupertinoPageRoute(builder: (_) {
    return widget;
  }));
}

String jm_getPKStatus(int status) {
  switch (status) {
    case 0:
      return '未开始';
      break;
    case 1:
      return '进行中';
      break;
    case 2:
      return '已结束';
      break;
    case 3:
      return '已取消';
      break;
    default:
      return '其他';
      break;
  }
}

String jm_getReportStatusStr(int status) {
  String statusStr = '';
  switch (status) {
    case 0:
      statusStr = '待接收';
      break;
    case 5:
      statusStr = '已接收';
      break;
    case 10:
      statusStr = '已带看';
      break;
    case 20:
      statusStr = '已上传';
      break;
    case 22:
      statusStr = '待确认';
      break;
    case 24:
      statusStr = '待确认';
      break;
    case 21:
      statusStr = '已预约';
      break;
    case 30:
      statusStr = '已成交';
      break;
    case 40:
      statusStr = '已签约';
      break;
    case 50:
      statusStr = '已回款';
      break;
    case 60:
      statusStr = '已结佣';
      break;
    case 63:
      statusStr = '争议单';
      break;
    case 70:
      statusStr = '失效';
      break;
    case 80:
      statusStr = '退单';
      break;
    default:
      statusStr = '-';
  }
  return statusStr;
}

String jm_getMessageTypeStr(int noticeType) {
  // 0：报备 10：成交喜报 20：待跟进 30：跟进进度 40：PK赛 50：我接收的任务 60：我发布的任务 70：日报
  switch (noticeType) {
    case 0:
      return '报备';
      break;
    case 10:
      return '成交喜报';
      break;
    case 20:
      return '待跟进';
      break;
    case 30:
      return '跟进进度';
      break;
    case 40:
      return 'PK赛';
      break;
    case 50:
      return '我接收的任务';
      break;
    case 60:
      return '我发布的任务';
      break;
    case 70:
      return '日报';
      break;
    default:
      return '';
  }
}

Color jm_getReportStatusColor(int status) {
  Color statusColor = jm_text_black;
  switch (status) {
    case 0:
      statusColor = jm_appTheme;
      break;
    case 5:
      statusColor = jm_appTheme;
      break;
    case 10:
      statusColor = jm_appTheme;
      break;
    case 20:
      statusColor = jm_appTheme;
      break;
    case 22:
      statusColor = jm_appTheme;
      break;
    case 24:
      statusColor = jm_appTheme;
      break;
    case 21:
      statusColor = jm_appTheme;
      break;
    case 30:
      statusColor = jm_appTheme;
      break;
    case 40:
      statusColor = jm_appTheme;
      break;
    case 50:
      statusColor = jm_appTheme;
      break;
    case 60:
      statusColor = jm_appTheme;
      break;
    case 63:
      statusColor = jm_appTheme;
      break;
    case 70:
      statusColor = jm_appTheme;
      break;
    case 80:
      statusColor = jm_appTheme;
      break;
  }
  return statusColor;
}

Widget jm_naviTitle(String title) => Text(
      title,
      style: TextStyle(
          fontSize: 20, color: Colors.white, fontWeight: FontWeight.bold),
    );

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
const TextStyle jm_text_black_bold_style21 =
    TextStyle(fontSize: 21, color: jm_text_black, fontWeight: FontWeight.bold);
const TextStyle jm_text_black_bold_style22 =
    TextStyle(fontSize: 22, color: jm_text_black, fontWeight: FontWeight.bold);

class Global {
  static GlobalKey<NavigatorState> navigatorKey = GlobalKey<NavigatorState>();
  static bool showLogin = false;
  static void toLogin({bool isLogin = true}) {
    if (!showLogin) {
      showLogin = true;
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
      // color: Colors.red,
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
  final Widget contentWidet;
  final double margin;
  final String title;
  final bool paging;
  final double lineHeight;
  final double labelWidth;
  final bool must;
  final String hintText;
  final TextInputType keyboardType;
  final TextStyle labelStyle;
  final double otherWidth;
  final String text;
  final TextEditingController controller;
  final bool enable;
  final Color backgroundColor;
  final String lastLabelText;
  final TextStyle textStyle;
  final TextStyle hintStyle;
  final String searchUrl;
  final String requestKey;
  final String nameKey;
  final Function(Map data) showListClick;
  final Function(String value) valueChange;
  final Function(String value, _CustomInputState state) valueChangeAndShowList;
  CustomInput(
      {Key key,
      this.paging = true,
      this.nameKey = 'name',
      this.requestKey = 'name',
      this.searchUrl,
      this.lastLabelText,
      this.title = '',
      this.otherWidth,
      this.valueChange,
      this.controller,
      this.lineHeight = 50,
      this.labelWidth,
      this.must = false,
      this.hintText = '',
      this.keyboardType = TextInputType.text,
      this.labelStyle = jm_text_black_bold_style15,
      this.margin,
      this.text = '',
      this.enable = true,
      this.textStyle = jm_text_black_style14,
      this.valueChangeAndShowList,
      this.contentWidet,
      this.showListClick,
      this.hintStyle =
          const TextStyle(color: jm_placeholder_color, fontSize: 14),
      this.backgroundColor = Colors.transparent})
      : super(key: key);
  @override
  _CustomInputState createState() => _CustomInputState();
}

class _CustomInputState extends State<CustomInput>
    with AutomaticKeepAliveClientMixin {
  final FocusNode focusNode = FocusNode();
  String selfValue = '';
  double margin;
  double lableWidth;
  OverlayEntry _overlayEntry;
  bool isShow = false;
  double lastLabelWidth;
  // TextEditingController textCtr;
  final LayerLink _layerLink = LayerLink();
  @override
  bool get wantKeepAlive => true;
  @override
  void initState() {
    // textCtr = TextEditingController();
    super.initState();
  }

  @override
  void didUpdateWidget(covariant CustomInput oldWidget) {
    // textCtr.text = widget.text;
    super.didUpdateWidget(oldWidget);
  }

  @override
  void dispose() {
    focusNode.unfocus();
    focusNode.dispose();
    // print('_CustomInputState_dispose');
    // if (textCtr != null) {
    //   textCtr.dispose();
    //   textCtr = null;
    // }
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    super.build(context);
    SizeConfig().init(context);
    lastLabelWidth =
        widget.lastLabelText != null ? SizeConfig.blockSizeHorizontal * 22 : 0;
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
              // ZZInput(
              //   textStyle: widget.textStyle,
              //   enable: widget.enable,
              //   text: widget.text,
              //   leftPadding: 0,
              //   height: widget.lineHeight,
              //   width: widget.otherWidth ??
              //       SizeConfig.screenWidth - margin * 2 - lableWidth,
              //   keyboardType: widget.keyboardType,
              //   backgroundColor: Colors.transparent,
              //   needCleanButton: true,
              //   valueChange: (String value) {
              //     if (widget.valueChange != null) {
              //       widget.valueChange(value);
              //     }
              //     if (widget.valueChangeAndShowList != null) {
              //       widget.valueChangeAndShowList(value, this);
              //     }
              //   },
              //   hintText: widget.hintText,
              // )
              widget.searchUrl != null
                  ? GestureDetector(
                      behavior: HitTestBehavior.opaque,
                      onTap: () {
                        pushSearchView(context,
                            searchUrl: widget.searchUrl,
                            requestKey: widget.requestKey,
                            nameKey: widget.nameKey,
                            // dataList: data,
                            hintText: widget.hintText,
                            text: '', cellClick: (searchData) {
                          if (widget.showListClick != null) {
                            widget.showListClick(searchData);
                          }
                        }, paging: widget.paging);
                      },
                      child: Container(
                        width: widget.otherWidth ??
                            SizeConfig.screenWidth -
                                margin * 2 -
                                lableWidth -
                                lastLabelWidth,
                        height: widget.lineHeight,
                        padding: EdgeInsets.only(left: 10),
                        alignment: Alignment.centerLeft,
                        child: Text(
                          widget.text == null || widget.text.length == 0
                              ? widget.hintText
                              : widget.text,
                          style: widget.text == null || widget.text.length == 0
                              ? widget.hintStyle
                              : widget.textStyle,
                        ),
                      ),
                    )
                  : Container(
                      // color: Colors.red,
                      width: widget.otherWidth ??
                          SizeConfig.screenWidth -
                              margin * 2 -
                              lableWidth -
                              lastLabelWidth,
                      // constraints: BoxConstraints(
                      //     minHeight: widget.lineHeight, maxHeight: widget.lineHeight),
                      child: widget.contentWidet != null
                          ? widget.contentWidet
                          : TextField(
                              focusNode: focusNode,
                              key: widget.key,
                              controller: widget.controller ??
                                  TextEditingController.fromValue(
                                      TextEditingValue(
                                    text: widget.text ?? '',
                                    selection: TextSelection.fromPosition(
                                        TextPosition(
                                            affinity: TextAffinity.downstream,
                                            offset: widget.text.length ?? 0)),
                                  )),
                              enabled: widget.enable,
                              keyboardType: widget.keyboardType,
                              maxLines: 1,
                              style: widget.textStyle,
                              textInputAction:
                                  widget.valueChangeAndShowList != null
                                      ? TextInputAction.search
                                      : TextInputAction.done,
                              decoration: InputDecoration(
                                hintStyle: widget.hintStyle,
                                hintText: widget.hintText, isCollapsed: true,
                                // fillColor: widget.backgroundColor,
                                // focusedBorder: OutlineInputBorder(
                                //     borderSide:
                                //         BorderSide(width: 0, color: Colors.transparent)),
                                // disabledBorder: OutlineInputBorder(
                                //     borderSide:
                                //         BorderSide(width: 0, color: Colors.transparent)),
                                // enabledBorder: OutlineInputBorder(
                                //     borderSide:
                                //         BorderSide(width: 0, color: Colors.transparent)),
                                contentPadding:
                                    EdgeInsets.fromLTRB(10, 0, 10, 0),
                                border: OutlineInputBorder(
                                    // gapPadding: 0,
                                    borderRadius: BorderRadius.zero,
                                    borderSide: BorderSide.none),
                              ),
                              onChanged: (value) {
                                selfValue = value;
                                if (widget.valueChange != null) {
                                  widget.valueChange(value);
                                }
                              },
                              onEditingComplete: () {
                                if (widget.searchUrl != null) {
                                  focusNode.unfocus();
                                  pushSearchView(
                                    context,
                                    searchUrl: widget.searchUrl,
                                    requestKey: widget.requestKey,
                                    nameKey: widget.nameKey,
                                    // dataList: data,
                                    hintText: widget.hintText,
                                    text: selfValue,
                                    cellClick: (searchData) {
                                      if (widget.showListClick != null) {
                                        widget.showListClick(searchData);
                                      }
                                    },
                                  );
                                }
                                // if (widget.valueChangeAndShowList != null) {
                                //   widget.valueChangeAndShowList(selfValue, this);
                                // }
                              },
                            ),
                    ),
              Container(
                width: lastLabelWidth,
                child: Padding(
                  padding:
                      EdgeInsets.only(left: SizeConfig.blockSizeHorizontal * 2),
                  child: Text(
                    widget.lastLabelText ?? '',
                    style: widget.labelStyle,
                  ),
                ),
              )
            ],
          ),
        ),
      ),
    );
  }

  void showList(List data) {
    // focusNode.unfocus();
    // pushSearchView(
    //   context,
    //   dataList: data,
    //   hintText: widget.hintText,
    //   text: selfValue,
    // );
    // if (!isShow) {
    //   FocusScope.of(context).requestFocus(FocusNode());
    //   this._overlayEntry = this.createOverlayEntry(data);
    //   Overlay.of(context).insert(this._overlayEntry);
    //   isShow = true;
    // }
  }

  void removeList() {
    // Overlay.of(context).
    // if (isShow) {
    //   _overlayEntry.remove();
    //   isShow = false;
    // }
    if (isShow) {
      Navigator.pop(context);
    }
  }

  OverlayEntry createOverlayEntry(List data) {
    RenderBox renderBox = context.findRenderObject();
    var size = renderBox.size;
    Widget c = Container();
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
  final bool must;
  final Sex sex;
  final Function(Sex newSex) valueChange;
  SexCell(
      {this.margin,
      this.title = '',
      this.must = false,
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
    // sex = widget.sex != null ? widget.sex : Sex.boy;
    sex = widget.sex;
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
            child: widget.must
                ? RichText(
                    text: TextSpan(
                        text: '*',
                        style: TextStyle(color: Colors.red, fontSize: 12),
                        children: [
                        TextSpan(
                            text: widget.title ?? '', style: widget.labelStyle)
                      ]))
                : Text(widget.title ?? '', style: widget.labelStyle),
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
                height: 1.28,
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
