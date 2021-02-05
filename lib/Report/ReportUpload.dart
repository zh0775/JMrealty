import 'package:JMrealty/Client/components/ClientSuccessWidget.dart';
import 'package:JMrealty/Report/viewmodel/ReporProjecttInfo.dart';
import 'package:JMrealty/Report/viewmodel/ReportDetailViewModel.dart';
import 'package:JMrealty/Report/viewmodel/ReportUploadViewModel.dart';
import 'package:JMrealty/components/CustomAlert.dart';
import 'package:JMrealty/components/CustomAppBar.dart';
import 'package:JMrealty/components/CustomImagePage.dart';
import 'package:JMrealty/components/CustomLoading.dart';
import 'package:JMrealty/components/CustomMarkInput.dart';
import 'package:JMrealty/components/CustomSubmitButton.dart';
import 'package:JMrealty/components/DropdownSelectV.dart';
import 'package:JMrealty/components/NoneV.dart';
import 'package:JMrealty/components/SelectImageView.dart';
import 'package:JMrealty/const/Default.dart';
import 'package:JMrealty/utils/EventBus.dart';
import 'package:JMrealty/utils/notify_default.dart';
import 'package:JMrealty/utils/sizeConfig.dart';
import 'package:JMrealty/utils/toast.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:multi_image_picker/multi_image_picker.dart';

enum ReportUploadStatus {
  upload,
  appointment,
  invalid,
  sign, // 需要填时间
  chargeback,
  disputed,
  checkDeal,
  checkAppointment
}

class ReportUpload extends StatefulWidget {
  final int status;
  final Map data;
  final ReportUploadStatus uploadStatus;
  const ReportUpload(
      {@required this.data,
      this.status,
      this.uploadStatus = ReportUploadStatus.upload});
  @override
  _ReportUploadState createState() => _ReportUploadState();
}

class _ReportUploadState extends State<ReportUpload> {
  ReportDetailViewModel reportDetailModel = ReportDetailViewModel();
  int imageCount = 15;
  ReportUploadViewModel viewModel = ReportUploadViewModel();
  EventBus _eventBus = EventBus();
  SelectImageView imgSelectV; // 选择图片视图
  // String timeStr = DateFormat('yyyy-MM-dd HH:mm:ss').format(DateTime.now());
  String timeStr = '';
  double cellHeight;
  double widthScale;
  double outMargin;
  double labelSpace = 3;
  String mark;
  List imageList = [];
  List invalidTmpList = [];
  Map reportDetailData;
  // String currentInvalidTmpList = '';
  dynamic img;
  @override
  void initState() {
    if (widget.uploadStatus == ReportUploadStatus.invalid) {
      viewModel.loadInvalidTmp((dataList, success) {
        if (success) {
          invalidTmpList = dataList;
          mark = (dataList[0])['remark'];
          if (mounted) {
            setState(() {});
          }
        }
      });
      // if ()
    }
    imgSelectV = SelectImageView(
      count: imageCount,
      imageSelected: (images) {
        if (images != null && mounted) {
          setState(() {
            imageList.addAll(images);
            if (imageList.length >= imageCount) {
              ShowToast.normal('最多上传$imageCount张照片，长按照片可删除');
              imageList.removeRange(imageCount, imageList.length);
            }
          });
        }
      },
    );

    if (widget.uploadStatus == ReportUploadStatus.checkDeal) {
      reportDetailModel.loadReportDetailRequest(
        widget.data['id'],
        success: (detailData, success) {
          setState(() {
            reportDetailData = detailData;
          });
        },
      );
    }
    super.initState();
  }

  @override
  void dispose() {
    super.dispose();
  }

// upload,
//   appointment,
//   invalid,
//   sign, // 需要填时间
//   chargeback
  @override
  Widget build(BuildContext context) {
    String title = '上传带看单';
    switch (widget.uploadStatus) {
      case ReportUploadStatus.upload:
        title = '上传带看单';
        break;
      case ReportUploadStatus.appointment:
        title = '预约';
        break;
      case ReportUploadStatus.invalid:
        title = '失效';
        break;
      case ReportUploadStatus.sign:
        title = '签约';
        break;
      case ReportUploadStatus.chargeback:
        title = '退单';
        break;
      case ReportUploadStatus.disputed:
        title = '争议单';
        break;
      case ReportUploadStatus.checkDeal:
        title = '审核成交';
        break;
      case ReportUploadStatus.checkDeal:
        title = '审核成交';
        break;
      case ReportUploadStatus.checkAppointment:
        title = '审核预约';
        break;
      default:
    }

    SizeConfig().init(context);
    widthScale = SizeConfig.blockSizeHorizontal;
    outMargin = widthScale * 6;
    return GestureDetector(
      onTap: () => FocusScope.of(context).requestFocus(FocusNode()),
      child: Scaffold(
        appBar: CustomAppbar(
          title: title,
        ),
        body: ListView(
          children: [
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
            widget.uploadStatus == ReportUploadStatus.sign
                ? getDateWidget(title: '签约时间')
                : Container(
                    width: 0.0,
                    height: 0.0,
                  ),
            JMline(width: SizeConfig.screenWidth, height: 1.5),
            widget.uploadStatus == ReportUploadStatus.checkDeal &&
                    reportDetailData != null &&
                    reportDetailData['reportShopDetailVO'] != null
                ? Padding(
                    padding: EdgeInsets.only(top: 15),
                    child: ClientSuccessWidget(
                      margin: outMargin,
                      successData: reportDetailData['reportShopDetailVO'],
                    ),
                  )
                : NoneV(),
            JMline(width: SizeConfig.screenWidth, height: 1.5),
            SizedBox(
              height: 15,
            ),
            Padding(
                padding: EdgeInsets.only(left: outMargin),
                child: Text(
                  '上传资料',
                  style: jm_text_black_bold_style17,
                )),
            getUploadTips(),
            SizedBox(
              height: 13,
            ),
            Align(
              child: Container(
                width: SizeConfig.screenWidth - outMargin * 2,
                child: Column(
                  children: [
                    ...getImageButtons(),
                  ],
                ),
              ),
            ),
            SizedBox(
              height: 15,
            ),
            Padding(
                padding: EdgeInsets.only(left: outMargin),
                child: Text(
                  '备注',
                  style: jm_text_black_bold_style17,
                )),
            widget.uploadStatus == ReportUploadStatus.invalid
                ? DropdownSelectV(
                    labelText: '失效模板',
                    titleKey: 'remark',
                    valueKey: 'dictValue',
                    defalultValue: true,
                    dataList: invalidTmpList,
                    valueChange: (value, data) {
                      setState(() {
                        mark = data['remark'];
                      });
                    },
                  )
                : NoneV(),
            CustomMarkInput(
              maxLength: 200,
              text: mark ?? '',
              valueChange: (value) {
                mark = value;
              },
            ),
            SizedBox(
              height: 15,
            ),
            CustomSubmitButton(
              buttonClick: () {
                Map<String, dynamic> mapParams = {};
                mapParams['images'] = '';
                if (widget.data['status'] != null) {
                  mapParams['beforeStatus'] = widget.data['status'];
                }
                if (widget.data['id'] != null) {
                  mapParams['reportId'] = widget.data['id'];
                }
                mapParams['remark'] = mark ?? '';
                if (widget.uploadStatus == ReportUploadStatus.sign) {
                  if (timeStr == null || timeStr.length == 0) {
                    ShowToast.normal('请选择签约时间');
                    return;
                  }
                  mapParams['visaTime'] = timeStr;
                }

                CustomAlert(title: '提示', content: '是否确认提交？').show(
                    confirmClick: () {
                  CustomLoading().show();
                  if (imageList != null && imageList.length > 0) {
                    viewModel.upLoadReportImages(imageList,
                        callBack: (strImages) {
                      String imageStr = '';
                      strImages.forEach((element) {
                        imageStr += element + ',';
                      });
                      imageStr = imageStr.substring(0, imageStr.length - 1);
                      mapParams['images'] = imageStr;
                      viewModel.uploadReportRecord(mapParams, (success) {
                        if (success) {
                          successBack();
                        } else {}
                      }, uploadStatus: widget.uploadStatus);
                    });
                  } else {
                    viewModel.uploadReportRecord(mapParams, (success) {
                      if (success) {
                        successBack();
                      }
                    }, uploadStatus: widget.uploadStatus);
                  }
                });
              },
            ),
            SizedBox(
              height: 40,
            )
          ],
        ),
      ),
    );
  }

  List<Widget> getRemark() {
    return [
      Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          SizedBox(
            width: outMargin,
          ),
          Container(
            width: widthScale * 25,
            child: Text(
              '备注',
              style: jm_text_gray_style15,
            ),
          ),
          Container(
            width: SizeConfig.screenWidth - outMargin * 2 - widthScale * 25,
            child: Text(
              widget.data['remarks'] == null ||
                      widget.data['remarks'].length == 0
                  ? '-'
                  : widget.data['remarks'],
              style: jm_text_black_style15,
              maxLines: 100,
            ),
          )
        ],
      )
    ];
  }

  Widget getUploadTips() {
    String tips = '';
    if (widget.uploadStatus != ReportUploadStatus.upload &&
        widget.uploadStatus != ReportUploadStatus.sign) {
      return NoneV();
    }
    switch (widget.uploadStatus) {
      case ReportUploadStatus.upload:
        tips = '1、甲方公司的带看/转介确认单，2、客户本人和置业顾问在带看楼盘的现场照片';
        break;
      case ReportUploadStatus.sign:
        tips = '1、商品房买卖合同，需要提供合同封面及有成交房号信息相关内容页面';
        break;
      default:
    }

    return Align(
      child: Container(
        margin: EdgeInsets.only(top: 10),
        width: SizeConfig.screenWidth - outMargin * 2,
        child: Text(
          tips,
          style: jm_text_gray_style13,
        ),
      ),
    );
  }

  successBack() {
    CustomLoading().hide();
    ShowToast.normal('提交成功');
    Future.delayed(Duration(seconds: 1)).then((value) {
      _eventBus.emit(NOTIFY_REPORT_LIST_REFRASH);
      Navigator.pop(context);
    });
  }

  checkImg(int index) {
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
    if (imageList.length >= imageCount) {
      ShowToast.normal('最多上传$imageCount张照片，长按照片可删除');
      return;
    }
    imgSelectV.showImage(context);
  }

  List<Widget> getImageButtons() {
    int lineCount = 3;
    List<Widget> widgetList = [];

    if (imageList != null && imageList != []) {
      List<Widget> widgetRow = [];
      for (var i = 0; i < (imageList.length + 1); i++) {
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
              onLongPress: () {
                CustomAlert(content: '是否确认删除该照片').show(
                  confirmClick: () {
                    if (mounted) {
                      setState(() {
                        imageList.removeAt(i);
                      });
                    }
                  },
                );
              },
              child: Container(
                width: widthScale * 29.3,
                height: widthScale * 30.0,
                child: Align(
                  child: Container(
                      width: widthScale * 25.3,
                      height: widthScale * 25.3,
                      // color: jm_line_color,
                      child: Image(
                          image: AssetThumbImageProvider(imageList[i],
                              width: (widthScale * 25.3).round(),
                              height: (widthScale * 25.3).round()))

                      // ImageLoader(
                      //   imageList[i],
                      //   height: widthScale * 25.3,
                      // ),
                      // Image.memory(imageList[i].buffer.asUint8List(),fit: BoxFit.cover,height: widthScale * 25.3,width: widthScale * 25.3,)
                      //   FutureBuilder<dynamic>(
                      //       future: imageList[i].getThumbByteData((widthScale * 25.3).round(), (widthScale * 25.3).round()),
                      //       builder: (context,snapshot) {
                      //         if (snapshot.connectionState == ConnectionState.done) {
                      //           return Image.memory(snapshot.data.buffer.asUint8List(),fit: BoxFit.cover,height: widthScale * 25.3,width: widthScale * 25.3,);
                      //         } else {
                      //           return Container(width: 0.0,height: 0.0,);
                      //         }
                      //       },
                      // ),
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

  Future<void> showDatePick() async {
    final DateTime date = await showDatePicker(
        context: context,
        // builder: (context, child) {
        //   return Theme(
        //     isMaterialAppTheme: true,
        //     data: ThemeData.dark(),
        //     child: child,
        //   );
        // },
        initialDate: DateTime.now(),
        firstDate: DateTime(2015, 1),
        lastDate: DateTime(2022, 1),
        locale: Locale('zh'));
    if (date == null) return;
    setState(() {
      timeStr = DateFormat('yyyy-MM-dd').format(date);
    });

    final TimeOfDay time = await showTimePicker(
      context: context,
      initialTime: TimeOfDay.now(),
    );
    if (time == null) return;
    setState(() {
      timeStr += (' ' +
          getIntFormat(time.hour) +
          ':' +
          getIntFormat(time.minute) +
          ':00');
    });
  }

  String getIntFormat(int value) {
    if (value < 10) {
      return '0' + value.toString();
    } else {
      return value.toString();
    }
  }

  Widget getDateWidget({@required String title}) {
    double labelWidth = widthScale * 22;
    return GestureDetector(
      onTap: () {
        FocusScope.of(context).requestFocus(FocusNode());
        showDatePick();
      },
      child: Row(
        children: [
          SizedBox(
            width: outMargin,
            height: 48,
          ),
          Container(
            width: labelWidth,
            child: Text(
              title,
              style: jm_text_black_style15,
            ),
          ),
          Container(
            width: SizeConfig.screenWidth -
                outMargin * 2 -
                labelWidth -
                widthScale * 8,
            child: Text(
              // dateFormat.format(start ? startDate : endDate),
              timeStr == null || timeStr.length == 0 ? '请选择签约时间' : timeStr,
              style: timeStr == null || timeStr.length == 0
                  ? TextStyle(color: jm_placeholder_color, fontSize: 15)
                  : jm_text_black_style15,
            ),
          ),
          Icon(
            Icons.keyboard_arrow_right,
            size: widthScale * 8,
          )
        ],
      ),
    );
  }
}
