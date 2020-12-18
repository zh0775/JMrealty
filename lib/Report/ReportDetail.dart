import 'package:JMrealty/Client/components/ClientSuccessWidget.dart';
import 'package:JMrealty/Report/viewmodel/ReportDetailViewModel.dart';
import 'package:JMrealty/base/base_viewmodel.dart';
import 'package:JMrealty/base/image_loader.dart';
import 'package:JMrealty/base/provider_widget.dart';
import 'package:JMrealty/components/CustomAppBar.dart';
import 'package:JMrealty/components/CustomGridImageV.dart';
import 'package:JMrealty/components/EmptyView.dart';
import 'package:JMrealty/components/ReportStatusBar.dart';
import 'package:JMrealty/components/SelectImageView.dart';
import 'package:JMrealty/components/ShowLoading.dart';
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
    labelSpace = 3;
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
            return getBody(context, value.reportDetailData);
          } else if (value.state == BaseState.LOADING) {
            return ShowLoading();
            // return Container(width: 0.0, height: 0.0);
          } else {
            return EmptyView();
            // return Container(width: 0.0, height: 0.0);
          }
        },
      ),
    );
  }

  checkImg(int index) {
    print(index);
  }

  addImage() {
    imgSelectV.showImage(context);
  }

  Widget getBody(BuildContext context, Map mapData) {
    return ListView(
      children: [
        ReportStatusBar(
            statusNo: (mapData['reportInfoVO'])['status'] ?? null,
            statusData: mapData['reportStatuses'] ?? null),
        JMline(width: SizeConfig.screenWidth, height: 0.5),
        SizedBox(
          height: 20,
        ),
        // 第一行
        getTitle(),
        SizedBox(
          height: 12,
        ),
        getProject(),
        SizedBox(
          height: labelSpace,
        ),
        getProtect(),
        SizedBox(
          height: labelSpace,
        ),
        getStatus(),
        SizedBox(
          height: labelSpace,
        ),
        getCompany(),
        SizedBox(
          height: labelSpace,
        ),
        getName(),
        SizedBox(
          height: labelSpace,
        ),
        getNum(),
        SizedBox(
          height: 15,
        ),
        JMline(width: SizeConfig.screenWidth, height: 0.5),
        SizedBox(
          height: 15,
        ),
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
        Padding(
          padding: EdgeInsets.only(left: outMargin),
          child: ClientSuccessWidget(
            successData: data['reportShopDetailVO'],
          ),
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
                checkImg(i);
              },
              child: Container(
                width: widthScale * 29.3,
                height: widthScale * 30.0,
                child: Align(
                  child: Container(
                    width: widthScale * 25.3,
                    height: widthScale * 25.3,
                    // color: jm_line_color,
                    child: ImageLoader(imageList[i], widthScale * 25.3),
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
              widget.data['employeeName'] ?? '无',
              style: jm_text_black_bold_style16,
            ),
            SizedBox(
              width: widthScale * 2,
            ),
            Text(
              widget.data['employeePhone'] ?? '无',
              style: jm_text_black_bold_style16,
            )
          ],
        ),
        Row(
          children: [
            Text(
              '已复制',
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
          widget.data['projectName'] ?? '无',
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

  // label
  Widget getLabel(String title) {
    return Container(
      width: widthScale * 22,
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
      return Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
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
            ),
          ),
          JMline(width: SizeConfig.screenWidth, height: 0.5)
        ],
      );
    } else {
      return Container(width: 0.0, height: 0.0);
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
