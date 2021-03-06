import 'package:JMrealty/Report/viewmodel/ReporProjecttInfo.dart';
import 'package:JMrealty/Report/viewmodel/ReportDetailViewModel.dart';
import 'package:JMrealty/Report/viewmodel/ReportSuccessViewModel.dart';
import 'package:JMrealty/Report/viewmodel/ReportUploadViewModel.dart';
import 'package:JMrealty/Report/viewmodel/ReportViewModel.dart';
import 'package:JMrealty/components/CustomAlert.dart';
import 'package:JMrealty/components/CustomAppBar.dart';
import 'package:JMrealty/components/CustomGridImageV.dart';
import 'package:JMrealty/components/CustomImagePage.dart';
import 'package:JMrealty/components/CustomLoading.dart';
import 'package:JMrealty/components/CustomMarkInput.dart';
import 'package:JMrealty/components/CustomSubmitButton.dart';
import 'package:JMrealty/components/CustomTextF.dart';
import 'package:JMrealty/components/CustomWebV.dart';
import 'package:JMrealty/components/NoneV.dart';
import 'package:JMrealty/const/Default.dart';
import 'package:JMrealty/utils/EventBus.dart';
import 'package:JMrealty/utils/notify_default.dart';
import 'package:JMrealty/utils/sizeConfig.dart';
import 'package:JMrealty/utils/toast.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class ReportSuccess extends StatefulWidget {
  final Map data;
  final Map userInfo;
  ReportSuccess({@required this.data, this.userInfo});
  @override
  _ReportSuccessState createState() => _ReportSuccessState();
}

class _ReportSuccessState extends State<ReportSuccess> {
  int imageCount = 15;
  EventBus _eventBus = EventBus();
  ReportViewModel searchAgentVM = ReportViewModel();
  ReportDetailViewModel reportDetailModel = ReportDetailViewModel();
  Map detailData; // data
  // SelectImageView imgSelectV; // 选择图片视图
  double cellHeight;
  double widthScale;
  double outMargin;
  double labelSpace;
  String mark;
  dynamic img;
  List imgAssets = [];
  Map successParams = Map<String, dynamic>.from({});
  String payPhone;
  String dealTotal;
  String houseArea;
  String buildNo;
  Map userInfo;
  List reportShopPartnerBOList = [];
  Map projectDetaiData = {};
  @override
  void initState() {
    // reportDetailModel.loadReportDetailRequest(
    //   widget.data['id'],
    //   success: (detailData, success) {
    //     if (success) {
    //       projectDetaiData = detailData;
    //       if (mounted) setState(() {});
    //     }
    //   },
    // );
    userInfo = Map<String, dynamic>.from(widget.userInfo);
    reportShopPartnerBOList.add({
      'userId': userInfo['userId'],
      'userName': userInfo['userName'],
      'userPhone': userInfo['phonenumber'],
      'ratio': 100
    });
    // imgSelectV = SelectImageView(
    //   count: 9,
    //   imageSelected: (images) {
    //     if (images != null) {
    //       setState(() {});

    //       ReportUploadViewModel().upLoadReportImages(images,
    //           callBack: (List strImages) {
    //         if (strImages != null && strImages.length > 0) {
    //           setState(() {
    //             imgAssets = strImages;
    //           });
    //           // if (widget.changeInfo != null) {
    //           //   widget.changeInfo(Map<String, dynamic>.from(
    //           //       {'avatar': avatarPath, 'userId': widget.data['userId']}));
    //           // }
    //         }
    //       });
    //     }
    //   },
    // );
    payPhone = '';
    dealTotal = '';
    houseArea = '';
    buildNo = '';
    detailData = {};
    labelSpace = 3;
    super.initState();
  }

  @override
  void dispose() {
    reportDetailModel.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    SizeConfig().init(context);
    widthScale = SizeConfig.blockSizeHorizontal;
    outMargin = widthScale * 6;
    return Scaffold(
        appBar: CustomAppbar(
          title: '上传成交资料',
        ),
        body: GestureDetector(
            onTap: () {
              FocusScope.of(context).requestFocus(FocusNode());
            },
            child: getBody(context)));
  }

  checkImg(int index) {
    print(index);
  }

  addImage() {
    // imgSelectV.showImage(context);
  }

  Widget getBody(BuildContext context) {
    return ListView(
      children: [
        SizedBox(
          height: 20,
        ),
        ReporProjecttInfo(
          data: widget.data ?? {},
          width: SizeConfig.screenWidth,
          margin: outMargin,
        ),
        // 第一行
        // getTitle(),
        // SizedBox(
        //   height: 12,
        // ),
        // getProject(),
        // SizedBox(
        //   height: labelSpace,
        // ),
        // getProtect(),
        // SizedBox(
        //   height: labelSpace,
        // ),
        // getStatus(),
        // SizedBox(
        //   height: labelSpace,
        // ),
        // getCompany(),
        // SizedBox(
        //   height: labelSpace,
        // ),
        // getName(),
        // SizedBox(
        //   height: labelSpace,
        // ),
        // getNum(),
        SizedBox(
          height: 15,
        ),
        JMline(width: SizeConfig.screenWidth, height: 1),
        SizedBox(
          height: 15,
        ),
        getTitleRow('成交信息'),
        CustomInput(
          key: ValueKey('CustomInput_report_success_1'),
          labelStyle: jm_text_black_bold_style14,
          textStyle: jm_text_black_style15,
          title: '楼栋房号',
          hintText: '请输入房号',
          text: successParams['buildNo'] ?? '',
          valueChange: (value) {
            // buildNo = value;
            successParams['buildNo'] = value;
          },
        ),
        JMline(
            margin: outMargin,
            width: SizeConfig.screenWidth - outMargin,
            height: 1),
        CustomInput(
          key: ValueKey('CustomInput_report_success_2'),
          labelStyle: jm_text_black_bold_style14,
          textStyle: jm_text_black_style15,
          title: '认购名称',
          hintText: '请输入认购名称',
          text: successParams['payName'] ?? '',
          valueChange: (value) {
            // buildNo = value;
            successParams['payName'] = value;
          },
        ),
        JMline(
            margin: outMargin,
            width: SizeConfig.screenWidth - outMargin,
            height: 1),

        CustomInput(
          key: ValueKey('CustomInput_report_success_3'),
          labelStyle: jm_text_black_bold_style14,
          textStyle: jm_text_black_style15,
          title: '认购电话',
          hintText: '请输入认购电话',
          keyboardType: TextInputType.number,
          text: successParams['payPhone'] ?? '',
          valueChange: (value) {
            // buildNo = value;
            successParams['payPhone'] = value;
          },
        ),
        JMline(
            margin: outMargin,
            width: SizeConfig.screenWidth - outMargin,
            height: 1),
        CustomInput(
          key: ValueKey('CustomInput_report_success_4'),
          labelStyle: jm_text_black_bold_style14,
          textStyle: jm_text_black_style15,
          title: '身份证号',
          hintText: '请输入身份证号',
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
            height: 1),
        CustomInput(
          key: ValueKey('CustomInput_report_success_5'),
          labelStyle: jm_text_black_bold_style14,
          textStyle: jm_text_black_style15,
          title: '成交面积',
          lastLabelText: '平方米',
          lastLabelWidth: widthScale * 15,
          hintText: '请输入成交面积',
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
            height: 1),
        CustomInput(
          key: ValueKey('CustomInput_report_success_6'),
          labelStyle: jm_text_black_bold_style14,
          textStyle: jm_text_black_style15,
          keyboardType: TextInputType.number,
          title: '成交总价',
          lastLabelText: '元',
          hintText: '请输入成交总价',
          text: successParams['dealTotal'] ?? '',
          valueChange: (value) {
            // dealTotal = value;
            successParams['dealTotal'] = value;
          },
        ),
        JMline(width: SizeConfig.screenWidth, height: 1),
        SizedBox(
          height: 15,
        ),
        getTitleRow('备注'),
        CustomMarkInput(
          maxLength: 200,
          text: successParams['remark'] ?? '',
          valueChange: (value) {
            successParams['remark'] = value;
          },
        ),
        SizedBox(
          height: 15,
        ),
        JMline(width: SizeConfig.screenWidth, height: 1),
        SizedBox(
          height: 15,
        ),
        getTitleRow('佣金'),
        Container(
          margin: EdgeInsets.only(left: outMargin, top: 10),
          width: SizeConfig.screenWidth - outMargin * 2,
          child: Text(
            '佣金计算只做参考，具体以实际为准',
            style: jm_text_gray_style13,
          ),
        ),
        CustomTextF(
          labelText: '搜索分佣人',
          // labelStyle: jm_text_black_bold_style16,
          // style: jm_text_black_style15,
          leftTextPadding: 0,
          onlyTap: true,
          labelClick: () {
            push(
                CustomWebV(
                  path: WebPath.searchUser,
                  isMultiple: false,
                  returnSearchList: (searchDataList) {
                    if (searchDataList != null && searchDataList.length > 0) {
                      for (var i = 0; i < searchDataList.length; i++) {
                        Map item = searchDataList[i];

                        bool isHave = false;
                        reportShopPartnerBOList.forEach((element) {
                          if (element['userId'] == item['userId']) {
                            isHave = true;
                          }
                        });
                        // if (isHave || userInfo['userId'] == item['userId']) {
                        //   return;
                        // }
                        if (!isHave) {
                          reportShopPartnerBOList.add({
                            'userId': item['userId'],
                            'userName': item['userName'],
                            'userPhone': item['phoneNumber'],
                            'ratio': 0
                          });
                        }
                      }
                      setState(() {});
                    }
                  },
                ),
                context);
          },
          placeholder: '搜索添加分佣人',
        ),
        // CustomInput(
        //   title: '搜索分佣人',
        //   hintText: '搜索添加分佣人',
        //   valueChangeAndShowList: (value, state) {
        //     searchAgentVM.loadAgentSearchData(value, success: (data) {
        //       if (data != null && data.length > 0) {
        //         state.showList(data);
        //       }
        //     });
        //   },
        //   showListClick: (clickData) {
        //     bool isHave = false;
        //     reportShopPartnerBOList.forEach((element) {
        //       if (element['userId'] == clickData['userId']) {
        //         isHave = true;
        //         return;
        //       }
        //     });
        //     if (isHave || userInfo['userId'] == clickData['userId']) {
        //       return;
        //     }
        //     setState(() {
        //       reportShopPartnerBOList.add({
        //         'userId': clickData['userId'],
        //         'userName': clickData['userName'],
        //         'userPhone': clickData['phonenumber'],
        //         'ratio': 0
        //       });
        //     });
        //   },
        // ),
        ...getCommissionList(),
        SizedBox(
          height: 15,
        ),
        SizedBox(
          height: 15,
        ),
        JMline(width: SizeConfig.screenWidth, height: 1),
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
            successParams['images'] = '';
            if (successParams['buildNo'] == null ||
                successParams['buildNo'] == '') {
              ShowToast.normal('请输入楼栋房号');
              return;
            }
            if (successParams['dealTotal'] == null ||
                successParams['dealTotal'] == '') {
              ShowToast.normal('请输入成交总价格');
              return;
            }
            if (successParams['houseArea'] == null ||
                successParams['houseArea'] == '') {
              ShowToast.normal('请输入房屋面积');
              return;
            }
            if (successParams['payName'] == null ||
                successParams['payName'] == '') {
              ShowToast.normal('请输入认购名称');
              return;
            }
            if (successParams['payPhone'] == null ||
                successParams['payPhone'] == '') {
              ShowToast.normal('请输入认购电话');
              return;
            }
            successParams['reportShopPartnerBOList'] = [];
            reportShopPartnerBOList?.forEach((e) {
              if (e['ratio'] != 0) {
                Map bo = Map<String, dynamic>.from({...e});
                bo['ratio'] = e['ratio'] / 100;
                successParams['reportShopPartnerBOList'].add(bo);
              }
            });
            (successParams['reportShopPartnerBOList'] as List).removeAt(0);
            // return;
            CustomAlert(title: '提示', content: '是否确认提交？').show(
              confirmClick: () {
                CustomLoading().show();
                if (imgAssets != null && imgAssets.length > 0) {
                  ReportUploadViewModel().upLoadReportImages(
                    imgAssets,
                    callBack: (strImg) {
                      String imageStr = '';
                      strImg.forEach((element) {
                        imageStr += element + ',';
                      });
                      imageStr = imageStr.substring(0, imageStr.length - 1);
                      successParams['images'] = imageStr;
                      ReportSuccessViewModel()
                          .reportSuccessRequest(successParams, (success) {
                        CustomLoading().hide();
                        if (success) {
                          successBack();
                        }
                      });
                    },
                  );
                } else {
                  ReportSuccessViewModel().reportSuccessRequest(successParams,
                      (success) {
                    CustomLoading().hide();
                    if (success) {
                      successBack();
                    }
                  });
                }
              },
            );
          },
        ),
        SizedBox(
          height: 40,
        )
      ],
    );
  }

  void successBack() {
    CustomLoading().hide();
    ShowToast.normal('恭喜，提交成功');
    Future.delayed(Duration(seconds: 2)).then((value) {
      _eventBus.emit(NOTIFY_REPORT_LIST_REFRASH);
      Navigator.pop(context);
    });
  }

  // 姓名电话
  Widget getTitle() {
    print(widget.data);
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

  Widget getImageContent() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        getTitleRow('成交资料'),
        SizedBox(
          height: 15,
        ),
        Container(
          margin: EdgeInsets.only(left: outMargin, bottom: 10),
          width: SizeConfig.screenWidth - outMargin * 2,
          child: Text(
            '1、甲方公司的带看/转介确认单 2、商品房认购协议书 3、客户的交款凭据',
            style: jm_text_gray_style13,
          ),
        ),
        Padding(
          padding: EdgeInsets.only(left: outMargin),
          child: CustomGridImageV(
            // imageUrls: imgAssets,
            imageCount: imageCount,
            imageAssets: imgAssets,
            width: SizeConfig.screenWidth - outMargin * 2,
            needButton: true,
            addImages: (images) {
              setState(() {
                imgAssets.addAll(images);
                if (imgAssets.length >= imageCount) {
                  imgAssets.removeRange(imageCount, imgAssets.length);
                }
              });
            },
            deleteImage: (images) {
              if (mounted) {
                setState(() {
                  imgAssets.remove(images);
                });
              }
            },
            imageClick: (index) {
              Navigator.of(context).push(PageRouteBuilder(
                pageBuilder: (context, animation, secondaryAnimation) {
                  return ScaleTransition(
                      scale: animation,
                      alignment: Alignment.center,
                      child: CustomImagePage(
                        imageList: imgAssets ?? [],
                        index: index,
                        count: imgAssets?.length,
                      ));
                },
              ));
            },
          ),
        ),
      ],
    );
  }

  Widget getTitleRow(String title) {
    return Row(
      children: [
        SizedBox(
          width: outMargin,
        ),
        // Container(
        //   width: widthScale * 2.5,
        //   height: widthScale * 2.5,
        //   decoration: BoxDecoration(
        //       color: Color(0xff6ad09c),
        //       borderRadius: BorderRadius.circular(widthScale * 1.25)),
        // ),
        // SizedBox(
        //   width: widthScale * 1.5,
        // ),
        Text(
          title,
          style: jm_text_black_bold_style17,
        ),
      ],
    );
  }

  List<Widget> getCommissionList() {
    List<Widget> list = [];
    int i = 0;
    reportShopPartnerBOList.forEach((e) {
      list.add(getCommissionInput(e, i));
      i++;
    });
    return list;
  }

  Widget getCommissionInput(Map data, int index) {
    double lableWidth = widthScale * 25;
    double inputHeight = 40;
    String ratioStr = ((reportShopPartnerBOList[index])['ratio']).toString();

    return Row(
      children: [
        SizedBox(
          width: outMargin,
          height: inputHeight,
        ),
        Container(
          width: lableWidth,
          child: Text(
            data['userName'] ?? '',
            style: jm_text_black_style14,
          ),
        ),
        // JMline(width: 0.5, height: inputHeight),
        Container(
            constraints: BoxConstraints(
              maxHeight: inputHeight,
              maxWidth: widthScale * 15,
              minHeight: inputHeight * 0.75,
              minWidth: widthScale * 15,
            ),
            child: CupertinoTextField(
              textAlign: TextAlign.center,
              keyboardType: TextInputType.number,
              style: jm_text_black_style14,
              // padding: EdgeInsets.only(left: widthScale * 6),
              controller: TextEditingController.fromValue(TextEditingValue(
                  text: ratioStr ?? '',
                  selection: TextSelection.fromPosition(TextPosition(
                      affinity: TextAffinity.downstream,
                      offset: ratioStr.length ?? 0)))),
              decoration: BoxDecoration(color: jm_line_color),
              enabled: index == 0 ? false : true,
              // textAlign: TextAlign.start,
              textAlignVertical: TextAlignVertical.center,
              onChanged: (value) {
                if (value != '' && !isNumeric(value)) {
                  ShowToast.normal('请输入正确的比例');
                  setState(() {
                    (reportShopPartnerBOList[index])['ratio'] = 0;
                  });
                } else {
                  setState(() {
                    int intValue = value == ''
                        ? 0
                        : (int.parse(value) > 100 ? 100 : int.parse(value));
                    int total = 100;
                    int have = 0;
                    List list = reportShopPartnerBOList;
                    for (var i = 0; i < list.length; i++) {
                      if (i != 0 && i != index) {
                        int ratio = (list[i])['ratio'];
                        have += ratio;
                      }
                    }
                    int other = total - have;
                    (list[index])['ratio'] =
                        intValue > other ? other : intValue;
                    have = 0;
                    for (var i = 0; i < list.length; i++) {
                      if (i != 0) {
                        int ratio = (list[i])['ratio'];
                        have += ratio;
                      }
                    }
                    other = total - have;
                    (list[0])['ratio'] = other;
                  });
                }
              },
            )),
        SizedBox(
          width: widthScale * 2,
        ),
        Text(
          '%',
          style: jm_text_black_style15,
        ),
        index != 0
            ? IconButton(
                splashColor: Colors.transparent,
                icon: Icon(
                  Icons.cancel,
                  size: 18,
                  color: jm_text_gray,
                ),
                onPressed: () {
                  setState(() {
                    if ((reportShopPartnerBOList[index])['ratio'] > 0) {
                      (reportShopPartnerBOList[0])['ratio'] +=
                          (reportShopPartnerBOList[index])['ratio'];
                    }
                    reportShopPartnerBOList.removeAt(index);
                  });
                })
            : NoneV()
      ],
    );
  }

  bool isNumeric(String s) {
    if (s == null) {
      return false;
    }
    return int.parse(s, onError: (e) => null) != null;
  }
}
