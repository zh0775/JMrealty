import 'package:JMrealty/Report/viewmodel/ReportDetailViewModel.dart';
import 'package:JMrealty/Report/viewmodel/ReportSuccessViewModel.dart';
import 'package:JMrealty/Report/viewmodel/ReportViewModel.dart';
import 'package:JMrealty/components/CustomAppBar.dart';
import 'package:JMrealty/components/CustomGridImageV.dart';
import 'package:JMrealty/components/CustomMarkInput.dart';
import 'package:JMrealty/components/CustomSubmitButton.dart';
import 'package:JMrealty/components/SelectImageView.dart';
import 'package:JMrealty/const/Default.dart';
import 'package:JMrealty/utils/sizeConfig.dart';
import 'package:JMrealty/utils/toast.dart';
import 'package:flutter/material.dart';

class ReportSuccess extends StatefulWidget {
  final Map data;
  ReportSuccess({@required this.data});
  @override
  _ReportSuccessState createState() => _ReportSuccessState();
}

class _ReportSuccessState extends State<ReportSuccess> {
  ReportViewModel searchAgentVM = ReportViewModel();
  ReportDetailViewModel reportDetailModel = ReportDetailViewModel();
  Map detailData; // data
  SelectImageView imgSelectV; // 选择图片视图
  double cellHeight;
  double widthScale;
  double outMargin;
  double labelSpace;
  String mark;
  dynamic img;
  List<String> imgUrls;
  Map successParams = Map<String, dynamic>.from({});
  String payPhone;
  String dealTotal;
  String houseArea;
  String buildNo;
  @override
  void initState() {
    payPhone = '';
    dealTotal = '';
    houseArea = '';
    buildNo = '';
    detailData = {};
    imgUrls = [];
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
          title: '成交信息录入',
        ),
        body: getBody(context));
  }

  checkImg(int index) {
    print(index);
  }

  addImage() {
    imgSelectV.showImage(context);
  }

  Widget getBody(BuildContext context) {
    return ListView(
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
        getTitleRow('成交信息表'),
        CustomInput(
          key: ValueKey('CustomInput_report_success_1'),
          labelStyle: jm_text_black_bold_style14,
          textStyle: jm_text_black_style15,
          title: '楼栋房号',
          hintText: '楼栋房号',
          text: successParams['buildNo'] ?? '',
          valueChange: (value) {
            // buildNo = value;
            successParams['buildNo'] = value;
          },
        ),
        JMline(
            margin: outMargin,
            width: SizeConfig.screenWidth - outMargin,
            height: 0.5),
        CustomInput(
          key: ValueKey('CustomInput_report_success_2'),
          labelStyle: jm_text_black_bold_style14,
          textStyle: jm_text_black_style15,
          title: '认购名称',
          hintText: '认购名称',
          text: successParams['payName'] ?? '',
          valueChange: (value) {
            // buildNo = value;
            successParams['payName'] = value;
          },
        ),
        JMline(
            margin: outMargin,
            width: SizeConfig.screenWidth - outMargin,
            height: 0.5),

        CustomInput(
          key: ValueKey('CustomInput_report_success_3'),
          labelStyle: jm_text_black_bold_style14,
          textStyle: jm_text_black_style15,
          title: '认购电话',
          hintText: '认购电话',
          keyboardType: TextInputType.phone,
          text: successParams['payPhone'] ?? '',
          valueChange: (value) {
            // buildNo = value;
            successParams['payPhone'] = value;
          },
        ),
        JMline(
            margin: outMargin,
            width: SizeConfig.screenWidth - outMargin,
            height: 0.5),
        CustomInput(
          key: ValueKey('CustomInput_report_success_4'),
          labelStyle: jm_text_black_bold_style14,
          textStyle: jm_text_black_style15,
          title: '身份证号',
          hintText: '身份证号',
          keyboardType: TextInputType.text,
          text: successParams['idCard'] ?? '',
          valueChange: (value) {
            // buildNo = value;
            successParams['idCard'] = value;
          },
        ),
        JMline(
            margin: outMargin,
            width: SizeConfig.screenWidth - outMargin,
            height: 0.5),
        CustomInput(
          key: ValueKey('CustomInput_report_success_5'),
          labelStyle: jm_text_black_bold_style14,
          textStyle: jm_text_black_style15,
          title: '房屋面积·平',
          hintText: '房屋面积',
          keyboardType: TextInputType.number,
          text: successParams['houseArea'] ?? '',
          valueChange: (value) {
            // houseArea = value;
            successParams['houseArea'] = value;
          },
        ),
        JMline(
            margin: outMargin,
            width: SizeConfig.screenWidth - outMargin,
            height: 0.5),
        CustomInput(
          key: ValueKey('CustomInput_report_success_6'),
          labelStyle: jm_text_black_bold_style14,
          textStyle: jm_text_black_style15,
          keyboardType: TextInputType.number,
          title: '成交总价格·万',
          hintText: '成交总价格',
          text: successParams['dealTotal'] ?? '',
          valueChange: (value) {
            // dealTotal = value;
            successParams['dealTotal'] = value;
          },
        ),
        JMline(
            margin: outMargin,
            width: SizeConfig.screenWidth - outMargin,
            height: 0.5),
        JMline(width: SizeConfig.screenWidth, height: 0.5),
        SizedBox(
          height: 15,
        ),
        getTitleRow('备注'),

        CustomMarkInput(),
        SizedBox(
          height: 15,
        ),
        JMline(
            width: SizeConfig.screenWidth,
            height: 0.5),
        SizedBox(
          height: 15,
        ),
        getTitleRow('佣金'),
        CustomInput(title: '搜索分佣人',hintText: '搜索添加分佣人',
          valueChangeAndShowList: (value, state){
          searchAgentVM.loadAgentSearchData(value,success:(data){
            if (data != null && data.length > 0) {
              state.showList(data);
            }
          });
        },
          showListClick: (clickData) {
            if(successParams['reportShopPartnerBOList'] == null) {
              successParams['reportShopPartnerBOList'] = List.from([]);
            }

            (successParams['reportShopPartnerBOList'] as List).forEach((element) {
              if(element['id'] == clickData['id']) {
                return;
              }
            });
            setState(() {
              (successParams['reportShopPartnerBOList'] as List).add(clickData);
            });
          },),
        ...getCommissionList(),
        SizedBox(
          height: 15,
        ),
        SizedBox(
          height: 15,
        ),
        JMline(
            width: SizeConfig.screenWidth,
            height: 0.5),
        SizedBox(
          height: 15,
        ),
        getImageContent(),
        SizedBox(
          height: 15,
        ),
        CustomSubmitButton(
          buttonClick: () {
            print('widget === ${widget.data}');
            successParams['beforeStatus'] = widget.data['status'];
            successParams['reportId'] = widget.data['id'];
            successParams['customerId'] = widget.data['customerId'];
            if (imgUrls != null && imgUrls.length > 0) {
              String imageStr = '';
              imgUrls.forEach((element) {
                imageStr += element + ',';
              });
              imageStr = imageStr.substring(0, imageStr.length - 1);
              successParams['images'] = imageStr;
            }
            ReportSuccessViewModel().reportSuccessRequest(successParams, (success) {
              if (success) {
                ShowToast.normal('恭喜，提交成功');
                Future.delayed(Duration(seconds: 2)).then((value) {
                  Navigator.pop(context);
                });
              }
            });
          },
        ),
        SizedBox(
          height: 40,
        )
      ],
    );
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

  Widget getImageContent() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        getTitleRow('上传资料'),
        SizedBox(
          height: 15,
        ),
        Padding(
          padding: EdgeInsets.only(left: outMargin),
          child: CustomGridImageV(
            imageUrls: imgUrls,
            width: SizeConfig.screenWidth - outMargin * 2,
            needButton: true,
            addImages: (images) {
              setState(() {
                imgUrls.addAll(images);
              });
            },
          ),
        ),
      ],
    );
  }

  List getImgUrls(String str) {
    if (str == null || str.length == 0) {
      return <String>[];
    } else {
      return str.split(',');
    }
  }

  Widget getTitleRow(String title) {
    return Row(
      children: [
        SizedBox(
          width: outMargin,
        ),
        Container(
          width: widthScale * 2.5,
          height: widthScale * 2.5,
          decoration: BoxDecoration(
              color: Color(0xff6ad09c),
              borderRadius: BorderRadius.circular(widthScale * 1.25)),
        ),
        SizedBox(
          width: widthScale * 1.5,
        ),
        Text(
          title,
          style: jm_text_black_bold_style15,
        ),
      ],
    );
  }

  List<Widget> getCommissionList () {
    List<Widget> list = [getCommissionInput({'userName': 'zhanghan'})];
    if (successParams['reportShopPartnerBOList'] == null) {
      return list;
    }
    (successParams['reportShopPartnerBOList'] as List).forEach((e) {
      list.add(getCommissionInput(e));
    });
    return list;
  }

  Widget getCommissionInput (Map data) {
    double lableWidth = widthScale * 25;
    return Row(children: [
      SizedBox(width: outMargin,height: 50,),
      Container(width: lableWidth,child: Text(data['userName'] ?? '',style: jm_text_black_style14,),),
      JMline(width: 0.5, height: 50),
      Container(
        constraints: BoxConstraints(
          maxHeight: 50,
          maxWidth: SizeConfig.screenWidth - lableWidth - outMargin * 2,
        ),
        child: TextField(
          decoration: InputDecoration(
            // fillColor: Colors.red,
            border: OutlineInputBorder(
              // borderRadius: widget.borderRadius,
                borderSide: BorderSide.none),
          ),
        ),
      )
    ],);
  }
}
