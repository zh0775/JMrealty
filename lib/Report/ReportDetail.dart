import 'package:JMrealty/Client/components/ClientSuccessWidget.dart';
import 'package:JMrealty/Report/viewmodel/ReporProjecttInfo.dart';
import 'package:JMrealty/Report/viewmodel/ReportDetailViewModel.dart';
import 'package:JMrealty/base/base_viewmodel.dart';
import 'package:JMrealty/base/image_loader.dart';
import 'package:JMrealty/base/provider_widget.dart';
import 'package:JMrealty/components/CustomAppBar.dart';
import 'package:JMrealty/components/CustomGridImageV.dart';
import 'package:JMrealty/components/CustomImagePage.dart';
import 'package:JMrealty/components/CustomLoading.dart';
import 'package:JMrealty/components/EmptyView.dart';
import 'package:JMrealty/components/NoneV.dart';
import 'package:JMrealty/components/ReportStatusBar.dart';
import 'package:JMrealty/components/SelectImageView.dart';
import 'package:JMrealty/const/Default.dart';
import 'package:JMrealty/utils/sizeConfig.dart';
import 'package:JMrealty/utils/tTools.dart';
import 'package:flutter/material.dart';

class ReportDetail extends StatefulWidget {
  final Map data;
  ReportDetail({@required this.data});
  @override
  _ReportDetailState createState() => _ReportDetailState();
}

class _ReportDetailState extends State<ReportDetail> {
  ReportDetailViewModel reportDetailModel;
  Map detailData; // data
  SelectImageView imgSelectV; // 选择图片视图
  double cellHeight;
  double widthScale;
  double outMargin;
  double labelSpace;
  String mark;
  dynamic img;
  @override
  void initState() {
    detailData = {};
    reportDetailModel = ReportDetailViewModel();
    // imgSelectV = SelectImageView(
    //   count: 12,
    //   imageSelected: (images) {
    //     // print('image === ${image.runtimeType.toString()}');
    //     if (images != null) {
    //       setState(() {
    //         imageList.addAll(images);
    //       });
    //     }
    //   },
    // );
    labelSpace = 5;
    super.initState();
  }

  @override
  void dispose() {
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    SizeConfig().init(context);
    widthScale = SizeConfig.blockSizeHorizontal;
    outMargin = widthScale * 6;
    return Scaffold(
      appBar: CustomAppbar(
        title: '报备详情',
      ),
      body: ProviderWidget<ReportDetailViewModel>(
        model: reportDetailModel,
        onReady: (model) {
          reportDetailModel.loadReportDetailRequest(widget.data['id']);
        },
        builder: (ctx, value, child) {
          // setState(() {
          //   detailData = value.reportDetailData;
          // });
          if (value.state == BaseState.CONTENT) {
            CustomLoading().hide();
            return getBody(context, value.reportDetailData);
          } else if (value.state == BaseState.LOADING) {
            CustomLoading().show();
            return NoneV();
            // return Container(width: 0.0, height: 0.0);
          } else {
            CustomLoading().hide();
            return EmptyView();
            // return Container(width: 0.0, height: 0.0);
          }
        },
      ),
    );
  }

  checkImg(int index, List imageList) {
    Navigator.of(context).push(PageRouteBuilder(
      pageBuilder: (context, animation, secondaryAnimation) {
        return ScaleTransition(
            scale: animation,
            alignment: Alignment.center,
            child: CustomImagePage(
              imageList: imageList ?? [],
              index: index,
              count: imageList?.length,
            ));
      },
    ));
  }

  addImage() {
    imgSelectV.showImage(context);
  }

  Widget getBody(BuildContext context, Map mapData) {
    Map projectInfo = mapData['reportInfoVO'] ?? {};
    return ListView(
      children: [
        ReportStatusBar(
            statusNo: (mapData['reportInfoVO'])['status'] ?? null,
            statusData: mapData['reportStatuses'] ?? null),
        JMline(width: SizeConfig.screenWidth, height: 1),
        SizedBox(
          height: 20,
        ),
        ReporProjecttInfo(
          data: widget.data,
          width: SizeConfig.screenWidth,
          margin: outMargin,
          labelSpace: labelSpace,
        ),
        SizedBox(
          height: labelSpace,
        ),
        ...getRemark(),
        SizedBox(
          height: 15,
        ),
        JMline(width: SizeConfig.screenWidth, height: 1),
        // SizedBox(
        //   height: 15,
        // ),

        ...getPhotoInfo(mapData['reportStatuses'] ?? []),
        (mapData['reportShopDetailVO'])['id'] != null
            ? getSuccessWidget(mapData)
            : Container(
                width: 0.0,
                height: 0.0,
              )
      ],
    );
  }

  Widget getSuccessWidget(Map data) {
    return Column(
      children: [
        SizedBox(
          height: 15,
        ),
        // // JMline(width: SizeConfig.screenWidth, height: 0.5),
        // SizedBox(
        //   height: 15,
        // ),
        ClientSuccessWidget(
          margin: outMargin,
          successData: data['reportShopDetailVO'],
        )
      ],
    );
  }

  List<Widget> getImageButtons() {
    List imageList = [];
    int lineCount = 3;
    List<Widget> widgetList = [];

    if (imageList != null && imageList != []) {
      List<Widget> widgetRow = [];
      for (var i = 0; i < imageList.length; i++) {
        if (i == imageList.length) {
          widgetRow.add(GestureDetector(
            onTap: addImage,
            child: Container(
              width: widthScale * 29.3,
              height: widthScale * 30,
              child: Align(
                child: Container(
                  width: widthScale * 25.3,
                  height: widthScale * 25.3,
                  color: jm_line_color,
                  child: Center(
                    child: Icon(
                      Icons.add_circle_outline,
                      size: 30,
                      color: Colors.black,
                    ),
                  ),
                ),
              ),
            ),
          ));
        } else {
          widgetRow.add(GestureDetector(
              onTap: () {
                checkImg(i, imageList);
              },
              child: Container(
                width: widthScale * 29.3,
                height: widthScale * 30.0,
                child: Align(
                  child: Container(
                    width: widthScale * 25.3,
                    height: widthScale * 25.3,
                    // color: jm_line_color,
                    child: ImageLoader(
                      imageList[i],
                      height: widthScale * 25.3,
                    ),
                  ),
                ),
              )));
        }

        if ((i + 1) % lineCount == 0) {
          widgetList.add(Row(
              // mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: List<Widget>.generate(widgetRow?.length, (int index) {
            return widgetRow[index];
          }, growable: true)));
          widgetRow.clear();
        } else if ((imageList.length + 1) % lineCount != 0 &&
            i == imageList.length) {
          widgetList.add(Row(
              // mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: List<Widget>.generate(widgetRow?.length, (int index) {
            return widgetRow[index];
          }, growable: true)));
          widgetRow.clear();
        }
      }
    }
    return widgetList;
  }

  // 姓名电话
  Widget getTitle() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Row(
          children: [
            SizedBox(
              width: outMargin,
            ),
            Text(
              widget.data['customerName'] ?? '无',
              style: jm_text_black_bold_style16,
            ),
            SizedBox(
              width: widthScale * 2,
            ),
            Text(
              widget.data['customerPhone'] ?? '无',
              style: jm_text_black_bold_style16,
            )
          ],
        ),
        Row(
          children: [
            Text(
              widget.data['isCopy'] == 1 ? '已复制' : '',
              style: jm_text_gray_style15,
            ),
            SizedBox(
              width: outMargin,
            )
          ],
        )
      ],
    );
  }

  Widget getProjectInfoCell(String title, String content) {
    return Row(
      children: [
        SizedBox(
          width: outMargin,
        ),
        getLabel(title),
        Text(
          content,
          style: jm_text_black_style15,
        )
      ],
    );
  }

  // 项目名称
  Widget getProject() {
    return Row(
      children: [
        SizedBox(
          width: outMargin,
        ),
        getLabel('报备项目'),
        Text(
          widget.data['projectName'] ?? '无',
          style: jm_text_black_style15,
        )
      ],
    );
  }

  // 项目保护期
  Widget getProtect() {
    return Row(
      children: [
        SizedBox(
          width: outMargin,
        ),
        getLabel('报备保护期'),
        Text(
          widget.data['projectProtect'] ?? '-',
          style: jm_text_black_style15,
        )
      ],
    );
  }

  // 报备状态
  Widget getStatus() {
    return Row(
      children: [
        SizedBox(
          width: outMargin,
        ),
        getLabel('报备状态'),
        Text(
          jm_getReportStatusStr(widget.data['status'] ?? -1),
          style: TextStyle(
              fontSize: 15,
              color: jm_getReportStatusColor(widget.data['status'] ?? -1)),
        )
      ],
    );
  }

  // 报备公司
  Widget getCompany() {
    return Row(
      children: [
        SizedBox(
          width: outMargin,
        ),
        getLabel('报备公司'),
        Text(
          widget.data['employeeCompany'] ?? '无',
          style: jm_text_black_style15,
        )
      ],
    );
  }

  // 员工名称
  Widget getName() {
    return Row(
      children: [
        SizedBox(
          width: outMargin,
        ),
        getLabel('员工名称'),
        Text(
          widget.data['employeeName'] ?? '无',
          style: jm_text_black_style15,
        )
      ],
    );
  }

  // 员工号码
  Widget getNum() {
    return Row(
      children: [
        SizedBox(
          width: outMargin,
        ),
        getLabel('员工号码'),
        Text(
          widget.data['employeePhone'] ?? '无',
          style: jm_text_black_style15,
        )
      ],
    );
  }

  List<Widget> getRemark() {
    return [
      Row(
        children: [
          SizedBox(
            width: outMargin,
          ),
          getLabel('备注'),
        ],
      ),
      SizedBox(
        height: labelSpace,
      ),
      Row(
        children: [
          SizedBox(
            width: outMargin,
          ),
          Container(
            width: SizeConfig.screenWidth - outMargin * 2,
            child: Text(
              widget.data['remarks'] ?? '-',
              style: jm_text_black_style15,
              maxLines: 100,
            ),
          )
        ],
      )
    ];
  }

  // label
  Widget getLabel(String title) {
    return Container(
      width: widthScale * 26,
      child: Text(
        title,
        style: jm_text_gray_style15,
      ),
    );
  }

  List<Widget> getPhotoInfo(List data) {
    List<Widget> widgets = [];
    if (data != null) {
      data.forEach((element) {
        widgets.add(getImageContent(element));
      });
    }
    return widgets;
  }

  Widget getImageContent(Map data) {
    if (data != null) {
      if (data['status'] == 0 || data['status'] == 5) {
        return NoneV();
      }
      return Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          SizedBox(
            height: 15,
          ),
          Row(
            children: [
              SizedBox(
                width: outMargin,
              ),
              Container(
                width: widthScale * 2.5,
                height: widthScale * 2.5,
                color: jm_appTheme,
              ),
              SizedBox(
                width: widthScale * 2,
              ),
              Text(
                getStatusString(data['status'] ?? 0),
                style: jm_text_black_bold_style15,
              ),
            ],
          ),
          Row(
            children: [
              SizedBox(
                width: widthScale * 10.5,
              ),
              Text(
                data['createTime'] ?? '',
                style: jm_text_gray_style13,
              ),
              SizedBox(
                width: widthScale * 1.5,
              ),
              Text(data['employeePosition'] ?? '', style: jm_text_gray_style13),
              SizedBox(
                width: widthScale * 1.5,
              ),
              Text(data['employeeName'] ?? '', style: jm_text_gray_style13),
            ],
          ),
          SizedBox(
            height: 15,
          ),
          Padding(
            padding: EdgeInsets.only(left: outMargin),
            child: CustomGridImageV(
              imageUrls: getImgUrls(data['images'] ?? ''),
              width: SizeConfig.screenWidth - outMargin * 2,
              needButton: false,
              imageClick: (index) {
                checkImg(
                    index,
                    data['images'] != null &&
                            (data['images'] as String).length > 0
                        ? (data['images'] as String).split(',')
                        : []);
              },
            ),
          ),
          data['remark'] != null && (data['remark']).length > 0
              ? Container(
                  margin: EdgeInsets.only(left: outMargin, bottom: 15),
                  width: SizeConfig.screenWidth - outMargin * 2,
                  child: Text(
                    '备注：' + (data['remark'] ?? ''),
                    style: jm_text_black_bold_style16,
                  ),
                )
              : NoneV(),
          JMline(width: SizeConfig.screenWidth, height: 1),
        ],
      );
    } else {
      return NoneV();
    }
  }

  List getImgUrls(String str) {
    if (str == null || str.length == 0) {
      return <String>[];
    } else {
      return str.split(',');
    }
  }
}
