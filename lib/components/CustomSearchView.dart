import 'package:JMrealty/Third/material_floating_search_bar.dart';
import 'package:JMrealty/components/NoneV.dart';
import 'package:JMrealty/const/Default.dart';
import 'package:JMrealty/services/Urls.dart';
import 'package:JMrealty/services/http.dart';
import 'package:JMrealty/utils/sizeConfig.dart';
import 'package:JMrealty/utils/toast.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

// import 'package:material_floating_search_bar/material_floating_search_bar.dart';

typedef void NeedQuery(String queryText);
void pushSearchView(BuildContext context,
    {String hintText = '搜索',
    String searchUrl,
    String nameKey,
    String text = '',
    String requestKey,
    bool paging,
    List dataList = const [],
    Function(Map searchData) cellClick}) {
  // Navigator.of(context).push(CustomRoute(CustomSearchView()));
  // push(CustomSearchView(), context);
  Navigator.of(context).push(CustomRoute(CustomSearchView(
      hintText: hintText,
      dataList: dataList,
      cellClick: cellClick,
      searchUrl: searchUrl,
      namekey: nameKey,
      paging: paging,
      requestKey: requestKey,
      text: text)));
}

class CustomSearchView extends StatefulWidget {
  final List dataList;
  final String hintText;
  final Function(Map searchData) cellClick;
  final String text;
  final String searchUrl;
  final bool paging;
  final String namekey;
  final String requestKey;
  final NeedQuery needQuery;
  const CustomSearchView(
      {this.hintText = '搜索',
      this.searchUrl,
      this.namekey,
      this.paging,
      this.requestKey,
      this.dataList = const [],
      this.cellClick,
      this.text,
      this.needQuery});
  @override
  _CustomSearchViewState createState() => _CustomSearchViewState();
}

class _CustomSearchViewState extends State<CustomSearchView> {
  double widthScale;
  double margin;
  double selfWidth;
  double cellheight = 45;
  FuzzySearchViewModel searchVM = FuzzySearchViewModel();
  final controller = FloatingSearchBarController();
  BuildContext searchBarCtx;
  List searchDataList = [];
  @override
  void dispose() {
    controller.dispose();
    super.dispose();
  }

  @override
  void initState() {
    // controller.query = widget.text;
    getSearchList(widget.text);

    Future.delayed(Duration(milliseconds: 100), () {
      controller.open();
    });

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    SizeConfig().init(context);
    widthScale = SizeConfig.blockSizeHorizontal;
    margin = widthScale * 6;
    selfWidth = SizeConfig.screenWidth - margin * 2;
    return Scaffold(
      backgroundColor: Colors.transparent,
      // backgroundColor: Colors.black.withOpacity(0.3),
      body: Stack(
        // fit: StackFit.expand,
        children: [
          // buildMap(),
          // buildBottomNavigationBar(),
          buildFloatingSearchBar(),
        ],
      ),
    );
  }

  Widget buildFloatingSearchBar() {
    final isPortrait =
        MediaQuery.of(context).orientation == Orientation.portrait;

    return FloatingSearchBar(
      hint: widget.hintText,
      // title: Text(widget.text),
      // closeOnBackdropTap: false,
      controller: controller,
      // autocorrect: true,
      // backdropColor: Colors.transparent,
      scrollPadding: const EdgeInsets.only(top: 16, bottom: 56),
      transitionDuration: const Duration(milliseconds: 300),
      transitionCurve: Curves.easeInOut,
      physics: const BouncingScrollPhysics(),
      axisAlignment: isPortrait ? 0.0 : -1.0,
      openAxisAlignment: 0.0,
      automaticallyImplyBackButton: false,
      maxWidth: isPortrait ? 600 : 500,
      debounceDelay: const Duration(milliseconds: 500),
      onQueryChanged: (query) {
        getSearchList(query);
      },
      // body: GestureDetector(
      //     onTap: () {
      //       if (Navigator.canPop(context)) {
      //         Navigator.pop(context);
      //       }
      //     },
      //     child: Container(
      //       color: Colors.black.withOpacity(0.2),
      //     )),
      clickDropBg: () {
        if (Navigator.canPop(context)) {
          Navigator.pop(context);
        }
      },
      leadingActions: [
        RawMaterialButton(
          materialTapTargetSize: MaterialTapTargetSize.shrinkWrap,
          onPressed: () {
            if (Navigator.canPop(context)) {
              Navigator.pop(context);
            }
          },
          splashColor: Colors.transparent,
          constraints: BoxConstraints(minWidth: 30),
          child: Icon(
            Icons.arrow_back,
            size: 25,
          ),
        )
      ],
      // Specify a custom transition to be used for
      // animating between opened and closed stated.
      transition: CircularFloatingSearchBarTransition(),
      actions: [
        // FloatingSearchBarAction(
        //   showIfOpened: false,
        //   child: CircularButton(
        //     icon: const Icon(Icons.place),
        //     onPressed: () {},
        //   ),
        // ),
        // FloatingSearchBarAction(
        //   showIfOpened: false,
        //   child: CircularButton(
        //     icon: const Icon(Icons.place),
        //     onPressed: () {},
        //   ),
        // ),
        FloatingSearchBarAction.searchToClear(
          showIfClosed: false,
        ),
      ],
      builder: (context, transition) {
        return
            // Container(
            //   color: Colors.black12,
            // );
            ClipRRect(
          borderRadius: BorderRadius.circular(8),
          child: Material(
            color: Colors.transparent,
            elevation: 4.0,
            child: Column(
                mainAxisSize: MainAxisSize.min, children: [...getCell()]),
          ),
        );
      },
    );
  }

  List<Widget> getCell() {
    List<Widget> list = [];
    if (searchDataList == null || searchDataList.length == 0) {
      return list;
    }

    searchDataList.forEach((element) {
      if (widget.searchUrl == Urls.projectFuzzySearch) {
        list.add(projectCell(element));
      } else if (widget.searchUrl == Urls.clientFuzzySearch) {
        list.add(clientCell(element));
      } else {
        list.add(GestureDetector(
          onTap: () {
            if (widget.cellClick != null) {
              widget.cellClick(element);
            }
            if (Navigator.canPop(context)) {
              Navigator.pop(context);
            }
          },
          child: Container(
            height: cellheight,
            color: Colors.white,
            alignment: Alignment.centerLeft,
            child: Padding(
              padding: const EdgeInsets.only(left: 18.0),
              child: Text(
                element[widget.namekey] ?? '',
                style: jm_text_black_style15,
              ),
            ),
          ),
        ));
      }
    });

    return list;
  }

  Widget clientCell(Map data) {
    return GestureDetector(
      onTap: () {
        if (widget.cellClick != null) {
          widget.cellClick(data);
        }
        if (Navigator.canPop(context)) {
          Navigator.pop(context);
        }
      },
      child: Container(
        width: SizeConfig.screenWidth,
        height: cellheight,
        decoration: BoxDecoration(
            color: Colors.white,
            border:
                Border(bottom: BorderSide(width: 1, color: jm_bg_gray_color))),
        child: Row(
          // mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            SizedBox(
              width: margin,
            ),
            SizedBox(
              width: widthScale * 26,
              child: Text(
                data['name'] ?? '',
                style: jm_text_black_bold_style15,
              ),
            ),
            data['sex'] != null
                ? Container(
                    decoration: BoxDecoration(
                      color: jm_appTheme,
                      borderRadius: BorderRadius.circular(widthScale * 1.5),
                    ),
                    child: Padding(
                      padding: EdgeInsets.symmetric(horizontal: 6, vertical: 2),
                      child: Text(
                        data['sex'] == 0 ? '男士' : '女士',
                        style: TextStyle(fontSize: 14, color: Colors.white),
                      ),
                    ),
                  )
                : NoneV(),
            SizedBox(
              width: widthScale * 2,
            ),
            Text(
              data['phone'] ?? '',
              style: jm_text_black_bold_style15,
            )
          ],
        ),
      ),
    );
  }

  Widget projectCell(Map data) {
    return GestureDetector(
      onTap: () {
        if (data['status'] == null) {
          return;
        }
        if (data['status'] == 3) {
          ShowToast.normal('该项目已暂停，请选择其他项目');
          return;
        } else {
          if (widget.cellClick != null) {
            widget.cellClick(data);
          }
          if (Navigator.canPop(context)) {
            Navigator.pop(context);
          }
        }
      },
      child: Container(
        width: SizeConfig.screenWidth,
        height: cellheight + 10,
        decoration: BoxDecoration(
            color: Colors.white,
            border:
                Border(bottom: BorderSide(width: 1, color: jm_bg_gray_color))),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Row(
              children: [
                SizedBox(
                  width: margin,
                ),
                Text(
                  data['name'] ?? '',
                  style: jm_text_black_style15,
                ),
                SizedBox(
                  width: widthScale * 2,
                ),
                data['purpose'] != null && data['purpose'].length > 0
                    ? Container(
                        decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(widthScale * 2),
                            color: jm_appTheme),
                        child: Padding(
                          padding:
                              EdgeInsets.symmetric(horizontal: 6, vertical: 2),
                          child: Text(
                            data['purpose'] ?? '',
                            style: TextStyle(fontSize: 14, color: Colors.white),
                          ),
                        ),
                      )
                    : NoneV()
              ],
            ),
            Row(
              children: [
                Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.end,
                  children: [
                    Container(
                      decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(widthScale * 2),
                          color: jm_appTheme),
                      child: Padding(
                        padding:
                            EdgeInsets.symmetric(horizontal: 6, vertical: 2),
                        child: Text(
                          data['statusName'] ?? '',
                          style: TextStyle(fontSize: 14, color: Colors.white),
                        ),
                      ),
                    ),
                    SizedBox(
                      height: data['status'] != null &&
                              data['status'] == 3 &&
                              data['pauseTime'] != null &&
                              data['pauseTime'].length > 0
                          ? 5
                          : 0,
                    ),
                    data['status'] != null &&
                            data['status'] == 3 &&
                            data['pauseTime'] != null &&
                            data['pauseTime'].length > 0
                        ? Text(
                              pauseTimeFormat(data['pauseTime']),
                              style: jm_text_gray_style13,
                            ) ??
                            ''
                        : NoneV()
                  ],
                ),
                SizedBox(
                  width: margin,
                )
              ],
            )
          ],
        ),
      ),
    );
  }

  String pauseTimeFormat(String pauseTime) {
    if (pauseTime == null || pauseTime.length == 0) {
      return '';
    } else {
      DateTime date = DateFormat('yyyy-MM-dd HH:mm:ss').parse(pauseTime);
      return DateFormat('yyyy-MM-dd').format(date);
    }
  }

  String getStatusTitle(int status) {
    switch (status) {
      case 0:
        return '未开盘';
        break;
      case 1:
        return '在售';
        break;
      case 2:
        return '售罄';
        break;
      case 3:
        return '暂停';
        break;
      default:
        return '';
    }
  }

  getSearchList(String text) {
    searchVM.fuzzySearchRequest(
      widget.searchUrl,
      text,
      widget.requestKey,
      success: (dataList, success) {
        if (success && mounted && dataList != null && dataList is List) {
          setState(() {
            searchDataList = dataList;
          });
        }
      },
      paging: widget.paging,
    );
  }
}

class FuzzySearchViewModel {
  fuzzySearchRequest(String url, String name, String nameKey,
      {Function(List dataList, bool success) success, bool paging}) {
    Http().get(
      url,
      Map<String, dynamic>.from({nameKey: name}),
      success: (json) {
        if (json['code'] == 200) {
          if (success != null) {
            if (paging) {
              success((json['data'])['rows'], true);
            } else {
              success(json['data'], true);
            }
          }
        } else {
          if (success != null) {
            success(null, false);
          }
        }
      },
      fail: (reason, code) {
        if (success != null) {
          success(null, false);
        }
      },
    );
  }
}

class CustomRoute extends PageRouteBuilder {
  final Widget widget;
  @override
  String get barrierLabel => null;

  @override
  bool get opaque => false;

  @override
  bool get maintainState => true;

  //构造方法
  CustomRoute(this.widget)
      : super(
            transitionDuration: Duration(seconds: 1), //过渡时间
            pageBuilder: (
              //构造器
              BuildContext context,
              Animation<double> animation1,
              Animation<double> animation2,
            ) {
              return widget;
            },
            transitionsBuilder: (BuildContext context,
                Animation<double> animation1,
                Animation<double> animation2,
                Widget child) {
              return FadeTransition(
                opacity: Tween(begin: 0.0, end: 1.0).animate(CurvedAnimation(
                  parent: animation1,
                  curve: Curves.fastOutSlowIn, //动画曲线
                )),
                child: child,
              );
            });
}
