import 'package:JMrealty/Report/viewmodel/SmartReportViewModel.dart';
import 'package:JMrealty/components/CustomAlert.dart';
import 'package:JMrealty/components/CustomAppBar.dart';
import 'package:JMrealty/components/CustomLoading.dart';
import 'package:JMrealty/components/CustomSubmitButton.dart';
import 'package:JMrealty/const/Default.dart';
import 'package:JMrealty/utils/sizeConfig.dart';
import 'package:JMrealty/utils/toast.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class SmartReport extends StatefulWidget {
  @override
  _SmartReportState createState() => _SmartReportState();
}

class _SmartReportState extends State<SmartReport> {
  SmartReportViewModel smartVM = SmartReportViewModel();
  String str = '''''';
  double widthScale;
  double margin;
  @override
  Widget build(BuildContext context) {
    SizeConfig().init(context);
    widthScale = SizeConfig.blockSizeHorizontal;
    margin = widthScale * 5;
    return GestureDetector(
      onTap: () => FocusScope.of(context).requestFocus(FocusNode()),
      child: Scaffold(
        backgroundColor: Colors.white,
        appBar: CustomAppbar(
          shadowColor: Colors.transparent,
          title: '智能报备',
        ),
        body: SingleChildScrollView(
          physics: ClampingScrollPhysics(),
          child: Align(
            child: Container(
              margin: EdgeInsets.only(top: margin),
              decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(widthScale * 3)),
              constraints: BoxConstraints(
                minWidth: SizeConfig.screenWidth - margin * 2,
                maxWidth: SizeConfig.screenWidth - margin * 2,
              ),
              child: Column(
                children: [
                  Align(
                    child: Container(
                      constraints: BoxConstraints(
                          minWidth: SizeConfig.screenWidth - margin * 2,
                          maxWidth: SizeConfig.screenWidth - margin * 2,
                          minHeight: SizeConfig.blockSizeVertical * 85 - 90,
                          maxHeight: SizeConfig.blockSizeVertical * 85 - 90),
                      // margin: EdgeInsets.only(top: margin),
                      child: CupertinoTextField(
                        maxLines: null,
                        decoration: BoxDecoration(
                            color: jm_bg_gray_color,
                            borderRadius:
                                BorderRadius.circular(widthScale * 1.5)),
                        placeholder: '智能识别，请粘贴文本',
                        textAlignVertical: TextAlignVertical.top,
                        keyboardType: TextInputType.multiline,
                        padding: EdgeInsets.all(10),
                        controller:
                            TextEditingController.fromValue(TextEditingValue(
                          text: str ?? '',
                          selection: TextSelection.fromPosition(TextPosition(
                              affinity: TextAffinity.downstream,
                              offset: str.length ?? 0)),
                        )),
                        onChanged: (value) {
                          str = '''$value''';
                        },
                      ),
                    ),
                  ),
                  SizedBox(
                    height: 30,
                  ),
                  CustomSubmitButton(
                    // margin: margin,
                    height: 45,
                    title: '识别',
                    buttonClick: () {
                      if (str == null || str.length == 0) {
                        ShowToast.normal('请输入报备内容');
                        return;
                      }

                      FocusScope.of(context).requestFocus(FocusNode());
                      CustomAlert(title: '提示', content: '是否确认提交？').show(
                          confirmClick: () {
                        CustomLoading().show();

                        smartVM.smartReportRequest(str, (success) {
                          CustomLoading().hide();
                          if (success) {
                            ShowToast.normal('提交成功');
                            Future.delayed(Duration(seconds: 1), () {
                              Navigator.pop(context);
                            });
                          }
                        });
                      });
                    },
                  ),
                  SizedBox(
                      // height: 20,
                      ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
