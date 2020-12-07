import 'dart:io';

import 'package:JMrealty/components/CustomAppBar.dart';
import 'package:JMrealty/components/CustomMarkInput.dart';
import 'package:JMrealty/components/CustomSubmitButton.dart';
import 'package:JMrealty/components/SelectImageView.dart';
import 'package:JMrealty/const/Default.dart';
import 'package:JMrealty/utils/sizeConfig.dart';
import 'package:flutter/material.dart';

class ReportUpload extends StatefulWidget {
  Map data;
  ReportUpload({@required this.data});
  @override
  _ReportUploadState createState() => _ReportUploadState();
}

class _ReportUploadState extends State<ReportUpload> {
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
    imgSelectV = SelectImageView(
      imageSelected: (image) {
        Navigator.pop(context);
        // print('image === ${image.runtimeType.toString()}');
        setState(() {
          if (image != null) {
            imageList.add(image);
          } else {
            print('No image selected.');
          }
        });
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
              // height: 300,
              // color: Colors.red,
              // child: GridView.count(
              //   //水平子Widget之间间距
              //   // crossAxisSpacing: 0.0,
              //   //垂直子Widget之间间距
              //   mainAxisSpacing: 1.0,
              //   //GridView内边距
              //   padding: EdgeInsets.all(0.0),
              //   //一行的Widget数量
              //   crossAxisCount: 3,
              //   //子Widget宽高比例
              //   // childAspectRatio: SizeConfig.screenWidth / 2.0 / buttonHeight,
              //   //子Widget列表
              //   children: [...getImageButtons()],
              // ),
              child: Column(
                children: [
                  ...getImageButtons(),
                ],
              ),
            ),
          ),
          // child: Expanded(
          //   child: GridView.count(
          //     //水平子Widget之间间距
          //     // crossAxisSpacing: 0.0,
          //     //垂直子Widget之间间距
          //     mainAxisSpacing: 1.0,
          //     //GridView内边距
          //     padding: EdgeInsets.all(0.0),
          //     //一行的Widget数量
          //     crossAxisCount: 3,
          //     //子Widget宽高比例
          //     // childAspectRatio: SizeConfig.screenWidth / 2.0 / buttonHeight,
          //     //子Widget列表
          //     children: [...getImageButtons()],
          //   ),
          // )

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
            buttonClick: () {},
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
                  color: jm_line_color,
                ),
              ),
            ),
          ));
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
