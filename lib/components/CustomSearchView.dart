import 'package:JMrealty/Third/material_floating_search_bar.dart';
import 'package:JMrealty/components/CustomPullFooter.dart';
import 'package:JMrealty/components/CustomPullHeader.dart';
import 'package:JMrealty/components/EmptyView.dart';
import 'package:JMrealty/components/NoneV.dart';
import 'package:JMrealty/const/Default.dart';
import 'package:JMrealty/services/Urls.dart';
import 'package:JMrealty/services/http.dart';
import 'package:JMrealty/utils/sizeConfig.dart';
import 'package:JMrealty/utils/tTools.dart';
import 'package:JMrealty/utils/toast.dart';
import 'package:flutter/material.dart';
import 'package:flutter_easyrefresh/easy_refresh.dart';
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
  GlobalKey easyRefreshKey = GlobalKey();
  double widthScale;
  double margin;
  double selfWidth;
  double cellheight = 50;
  double projectCellheight;
  double clientCellheight;
  FuzzySearchViewModel searchVM = FuzzySearchViewModel();
  final controller = FloatingSearchBarController();
  BuildContext searchBarCtx;
  List searchDataList = [];
  int totalData = 0;
  int pageNum = 1;
  int pageSize = 10;
  String searchText;

  @override
  void dispose() {
    controller.dispose();
    super.dispose();
  }

  @override
  void initState() {
    projectCellheight = cellheight + 10;
    clientCellheight = cellheight;
    searchText = widget.text ?? '';
    getSearchList(searchText);

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
          searchText = query ?? '';
          getSearchList(searchText);
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
          Image.asset(
            'assets/images/icon/icon_fuzzy_search.png',
            width: widthScale * 6,
          ),
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
          // FloatingSearchBarAction.searchToClear(
          //   showIfClosed: false,
          // ),
          RawMaterialButton(
              materialTapTargetSize: MaterialTapTargetSize.shrinkWrap,
              onPressed: () {
                if (Navigator.canPop(context)) {
                  Navigator.pop(context);
                }
              },
              splashColor: Colors.transparent,
              constraints: BoxConstraints(minWidth: 30),
              child: Padding(
                padding: EdgeInsets.only(right: 5),
                child: Text('取消',
                    style: TextStyle(
                      color: Color(0xff62677D),
                      fontSize: 16,
                    )),
              )
              // Icon(
              //   Icons.arrow_back,
              //   size: 25,
              // ),
              )
        ],
        builder: (context, transition) {
          double realCellHeight = cellheight;
          if (widget.searchUrl == Urls.projectFuzzySearch) {
            realCellHeight = projectCellheight;
          } else if (widget.searchUrl == Urls.clientFuzzySearch) {
            realCellHeight = clientCellheight;
          }
          int maxCount = 10;
          double screenMaxCount =
              (SizeConfig.screenHeight - 90) / realCellHeight;
          if (screenMaxCount < 10) {
            maxCount = screenMaxCount ~/ 1;
          }
          return ClipRRect(
              borderRadius: BorderRadius.circular(8),
              child: Material(
                color: Colors.white,
                // elevation: 4.0,
                child: Container(
                  // color: Colors.white,
                  width: SizeConfig.screenWidth,
                  height: searchDataList != null
                      ? (searchDataList.length >= maxCount
                          ? realCellHeight * maxCount
                          : searchDataList.length * realCellHeight)
                      : 0,
                  child: EasyRefresh(
                    // controller: pullCtr,
                    header: CustomPullHeader(),
                    footer: CustomPullFooter(),
                    emptyWidget:
                        searchDataList == null || searchDataList.length == 0
                            ? EmptyView()
                            : null,
                    key: easyRefreshKey,
                    onRefresh: () async {
                      getSearchList(searchText);
                      // loadList();
                    },
                    onLoad: searchDataList != null &&
                            searchDataList.length >= totalData
                        ? null
                        : () async {
                            pageNum++;
                            getSearchList(searchText, isLoad: true);
                          },
                    child: ListView.builder(
                        itemCount:
                            searchDataList == null ? 0 : searchDataList.length,
                        itemBuilder: (context, index) {
                          Map data = searchDataList[index];
                          if (widget.searchUrl == Urls.projectFuzzySearch) {
                            return projectCell(data);
                          } else if (widget.searchUrl ==
                              Urls.clientFuzzySearch) {
                            return clientCell(data);
                          } else {
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
                                height: cellheight,
                                color: Colors.white,
                                alignment: Alignment.centerLeft,
                                child: Padding(
                                  padding: const EdgeInsets.only(left: 18.0),
                                  child: Text(
                                    data[widget.namekey] ?? '',
                                    style: jm_text_black_style15,
                                  ),
                                ),
                              ),
                            );
                          }
                        }),
                  ),
                ),
              ));
        });
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
        height: clientCellheight,
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
                  style: jm_text_black_bold_style15,
                ),
                SizedBox(
                  width: widthScale * 3,
                ),
                data['sex'] != null
                    ? Container(
                        decoration: BoxDecoration(
                          color: getSexBgColor(data['sex']),
                          borderRadius: BorderRadius.circular(4),
                        ),
                        child: Padding(
                          padding:
                              EdgeInsets.symmetric(horizontal: 6, vertical: 2),
                          child: Text(
                            data['sex'] == 0 ? '先生' : '女士',
                            style: TextStyle(
                                fontSize: 12,
                                color: getSexTextColor(data['sex'])),
                          ),
                        ),
                      )
                    : NoneV(),
              ],
            ),
            Padding(
              padding: EdgeInsets.only(right: margin),
              child: Text(
                data['phone'] ?? '',
                style: jm_text_black_bold_style15,
              ),
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
          ShowToast.normal('该项目已于${data['pauseTime']}暂停报备');
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
        height: projectCellheight,
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
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(
                      data['name'] ?? '',
                      style: data['status'] != null && data['status'] == 3
                          ? TextStyle(
                              color: Color.fromRGBO(0, 0, 0, 0.3),
                              fontSize: 16,
                              fontWeight: FontWeight.bold)
                          : jm_text_black_bold_style16,
                    ),
                    SizedBox(
                      height: 2,
                    ),
                    Row(
                      children: [
                        data['purpose'] != null && data['purpose'].length > 0
                            ? Container(
                                decoration: BoxDecoration(
                                    borderRadius:
                                        BorderRadius.circular(widthScale),
                                    color: getPurposeColor(data['purpose'])),
                                child: Padding(
                                  padding: EdgeInsets.symmetric(
                                      horizontal: 6, vertical: 2),
                                  child: Text(
                                    data['purpose'] ?? '',
                                    style: TextStyle(
                                        fontSize: 14, color: jm_text_black),
                                  ),
                                ),
                              )
                            : NoneV(),
                        SizedBox(
                          width: widthScale * 2,
                        ),
                        Text(
                          data['province'] ?? '',
                          style: jm_text_black_style14,
                        ),
                        // SizedBox(
                        //   width: widthScale * 1,
                        // ),
                        Text(
                          data['city'] ?? '',
                          style: jm_text_black_style14,
                        ),
                        Text(
                          data['region'] ?? '',
                          style: jm_text_black_style14,
                        ),
                      ],
                    )
                  ],
                ),
              ],
            ),
            Row(
              children: [
                Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.end,
                  children: [
                    data['status'] != null &&
                            data['status'] == 3 &&
                            data['pauseTime'] != null &&
                            data['pauseTime'].length > 0
                        ? Text(
                              pauseTimeFormat(data['pauseTime']),
                              style: TextStyle(
                                  color: Color(0xff8A8B8C), fontSize: 14),
                            ) ??
                            ''
                        : NoneV(),
                    SizedBox(
                      height: data['status'] != null &&
                              data['status'] == 3 &&
                              data['pauseTime'] != null &&
                              data['pauseTime'].length > 0
                          ? 2
                          : 0,
                    ),
                    Row(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        Container(
                            width: 8,
                            height: 8,
                            decoration: BoxDecoration(
                                color: data['status'] != null &&
                                        data['status'] == 3
                                    ? Color(0xffD8D8D8)
                                    : jm_appTheme,
                                borderRadius: BorderRadius.circular(4))),
                        SizedBox(
                          width: 7,
                        ),
                        Text(data['statusName'] ?? '',
                            style: data['status'] != null && data['status'] == 3
                                ? TextStyle(
                                    color: Color(0xffD8D8D8), fontSize: 16)
                                : jm_text_black_style16),
                      ],
                    )
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

  getSearchList(String text, {bool isLoad = false}) {
    if (!isLoad) {
      pageNum = 1;
    }
    searchVM.fuzzySearchRequest(widget.searchUrl, text, widget.requestKey,
        success: (dataList, success, total) {
      if (success && mounted && dataList != null && dataList is List) {
        totalData = total;
        setState(() {
          if (isLoad) {
            searchDataList.addAll(dataList);
          } else {
            searchDataList = dataList;
          }
        });
      }
    }, paging: widget.paging, size: pageSize, page: pageNum);
  }
}

class FuzzySearchViewModel {
  fuzzySearchRequest(String url, String name, String nameKey,
      {Function(List dataList, bool success, int total) success,
      bool paging,
      int size,
      int page}) {
    Http().get(
      url,
      Map<String, dynamic>.from(
          {nameKey: name, 'pageSize': size, 'pageNum': page}),
      success: (json) {
        if (json['code'] == 200) {
          if (success != null) {
            if (paging) {
              success((json['data'])['rows'] ?? [], true,
                  (json['data'])['total'] ?? 0);
            } else {
              success(json['data'], true, json['total'] ?? 0);
            }
          }
        } else {
          if (success != null) {
            success(null, false, 0);
          }
        }
      },
      fail: (reason, code) {
        if (success != null) {
          success(null, false, 0);
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
