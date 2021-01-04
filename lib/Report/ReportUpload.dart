import 'package:JMrealty/Report/viewmodel/ReportUploadViewModel.dart';
import 'package:JMrealty/base/image_loader.dart';
import 'package:JMrealty/components/CustomAppBar.dart';
import 'package:JMrealty/components/CustomMarkInput.dart';
import 'package:JMrealty/components/CustomSubmitButton.dart';
import 'package:JMrealty/components/SelectImageView.dart';
import 'package:JMrealty/const/Default.dart';
import 'package:JMrealty/utils/sizeConfig.dart';
import 'package:JMrealty/utils/toast.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

// import 'package:flutter/services.dart';
enum ReportUploadStatus {
  upload,
  appointment,
  invalid,
  sign, // 需要填时间
  chargeback
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
  ReportUploadViewModel viewModel = ReportUploadViewModel();
  SelectImageView imgSelectV; // 选择图片视图
  String timeStr = DateFormat('yyyy-MM-dd HH:mm:ss').format(DateTime.now());
  double cellHeight;
  double widthScale;
  double outMargin;
  double labelSpace = 3;
  String mark;
  List imageList = [];
  dynamic img;
  @override
  void initState() {
    imgSelectV = SelectImageView(
      count: 9,
      imageSelected: (images) {
        if (images != null) {
          viewModel.upLoadReportImages(images, callBack: (strImages) {
            setState(() {
              imageList.addAll(strImages);
            });
          });
        }
      },
    );
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

            widget.uploadStatus == ReportUploadStatus.sign
                ? getDateWidget(title: '签约时间')
                : Container(
                    width: 0.0,
                    height: 0.0,
                  ),
            JMline(width: SizeConfig.screenWidth, height: 0.5),
            SizedBox(
              height: 15,
            ),
            Padding(
                padding: EdgeInsets.only(left: outMargin),
                child: Text(
                  '上传资料',
                  style: jm_text_black_bold_style17,
                )),
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
            CustomMarkInput(
              text: mark ?? '',
              valueChange: (value) {
                mark = value;
              },
            ),
            CustomSubmitButton(
              buttonClick: () {
                Map<String, dynamic> mapParams = {};
                mapParams['images'] = '';
                if (imageList != null && imageList.length > 0) {
                  String imageStr = '';
                  imageList.forEach((element) {
                    imageStr += element + ',';
                  });
                  imageStr = imageStr.substring(0, imageStr.length - 1);
                  mapParams['images'] = imageStr;
                } else {
                  ShowToast.normal('请上传图片');
                  return;
                }
                // print('data ==== ${widget.data}');
                // print('images ==== $mapParams');
                // print('123 === ${widget.data['status']}');
                if (widget.data['status'] != null) {
                  mapParams['beforeStatus'] = widget.data['status'];
                }
                if (widget.data['id'] != null) {
                  mapParams['reportId'] = widget.data['id'];
                }
                if (mark == null || mark.length == 0) {
                  ShowToast.normal('请填写备注信息');
                  return;
                }
                mapParams['remark'] = mark ?? '';
                if (widget.uploadStatus == ReportUploadStatus.sign) {
                  mapParams['visaTime'] = timeStr ?? '';
                }

                viewModel.uploadReportRecord(mapParams, (success) {
                  if (success) {
                    successBack();
                  }
                }, uploadStatus: widget.uploadStatus);
              },
            ),
          ],
        ),
      ),
    );
  }

  successBack() {
    ShowToast.normal('上传成功');
    Future.delayed(Duration(seconds: 1)).then((value) {
      Navigator.pop(context);
    });
  }

  checkImg(int index) {
    print(index);
  }

  addImage() {
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
              child: Container(
                width: widthScale * 29.3,
                height: widthScale * 30.0,
                child: Align(
                  child: Container(
                    width: widthScale * 25.3,
                    height: widthScale * 25.3,
                    // color: jm_line_color,
                    child: ImageLoader(imageList[i], widthScale * 25.3),
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
              timeStr ?? '',
              style: jm_text_black_style15,
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
