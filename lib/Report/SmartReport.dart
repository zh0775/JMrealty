import 'package:JMrealty/Report/viewmodel/SmartReportViewModel.dart';
import 'package:JMrealty/components/CustomAppBar.dart';
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
  String str = '';
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
        backgroundColor: jm_appTheme,
        appBar: CustomAppbar(
          title: '智能报备',
        ),
        body: SingleChildScrollView(
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
                          minWidth: SizeConfig.screenWidth - margin * 4,
                          maxWidth: SizeConfig.screenWidth - margin * 4,
                          minHeight: SizeConfig.blockSizeVertical * 50),
                      margin: EdgeInsets.only(top: margin),
                      child: CupertinoTextField(
                        placeholder: '智能识别，请粘贴文本',
                        textAlignVertical: TextAlignVertical.top,
                        controller:
                            TextEditingController.fromValue(TextEditingValue(
                          text: str ?? '',
                          selection: TextSelection.fromPosition(TextPosition(
                              affinity: TextAffinity.downstream,
                              offset: str.length ?? 0)),
                        )),
                        onChanged: (value) {
                          str = value;
                        },
                      ),
                    ),
                  ),
                  SizedBox(
                    height: 20,
                  ),
                  CustomSubmitButton(
                    margin: margin * 2,
                    height: 50,
                    title: '识别',
                    buttonClick: () {
                      FocusScope.of(context).requestFocus(FocusNode());
                      if (str != null && str.length > 0) {
                        smartVM.smartReportRequest(str, (success) {
                          if (success) {
                            ShowToast.normal('报备成功');
                            Future.delayed(Duration(seconds: 1), () {
                              Navigator.pop(context);
                            });
                          }
                        });
                      }
                    },
                  ),
                  SizedBox(
                    height: 20,
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
