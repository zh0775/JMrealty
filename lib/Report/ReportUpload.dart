import 'dart:io';

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
// import 'package:flutter/services.dart';

class ReportUpload extends StatefulWidget {
  final Map data;
  ReportUpload({@required this.data});
  @override
  _ReportUploadState createState() => _ReportUploadState();
}

class _ReportUploadState extends State<ReportUpload> {
  ReportUploadViewModel viewModel;
  SelectImageView imgSelectV; // 选择图片视图
  double cellHeight;
  double widthScale;
  double outMargin;
  double labelSpace;
  String mark;
  List imageList;
  dynamic img;
  @override
  void initState() {
    viewModel = ReportUploadViewModel();
    imgSelectV = SelectImageView(
      count: 12,
      imageSelected: (images) {
        if (images != null) {
          viewModel.upLoadReportImages(images, callBack: () {
            setState(() {
              imageList.addAll(viewModel.imageDatas);
            });
          });
        }
      },
    );
    labelSpace = 3;
    imageList = [];
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
        title: '上传带看单',
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
            valueChange: (value) {
              mark = value;
            },
          ),
          CustomSubmitButton(
            buttonClick: () {
              Map<String, dynamic> mapParams = {};
              if (imageList != null && imageList.length > 0) {
                String imageStr = '';
                imageList.forEach((element) {
                  imageStr += element + ',';
                });
                imageStr = imageStr.substring(0, imageStr.length - 1);
                mapParams['images'] = imageStr;
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
              mapParams['remark'] = mark ?? '';
              mapParams['images'] = '';
              viewModel.uploadReportRecord(mapParams, (success) {
                if (success) {
                  ShowToast.normal('上传成功');
                  Future.delayed(Duration(seconds: 1)).then((value) {
                    Navigator.pop(context);
                  });
                }
              });
            },
          ),
        ],
      ),
    );
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
          widget.data['status'].toString() ?? '无',
          style: jm_text_black_style15,
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
}
