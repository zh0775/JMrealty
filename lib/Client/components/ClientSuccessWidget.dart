import 'package:JMrealty/const/Default.dart';
import 'package:JMrealty/utils/sizeConfig.dart';
import 'package:flutter/material.dart';

class ClientSuccessWidget extends StatelessWidget {
  final Map successData;
  final double margin;
  const ClientSuccessWidget({this.successData, this.margin});
  @override
  Widget build(BuildContext context) {
    SizeConfig().init(context);
    double widthScale = SizeConfig.blockSizeHorizontal;
    double selfMargin = (margin != null ? margin : widthScale * 4);
    double lineHeight = 22;
    return Container(
      child: Column(
        children: [...successInfo(widthScale, selfMargin, lineHeight)],
      ),
    );
  }

  Widget getInfoRow(String title, String value,
      {double widthScale, double margin, double lineHeight}) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        SizedBox(
          width: margin,
          height: lineHeight,
        ),
        Container(
          width: widthScale * 26,
          child: Text(
            title,
            style: jm_text_gray_style14,
          ),
        ),
        Container(
          width: widthScale * (100 - 26) - margin * 2,
          child: Text(
            value,
            style: TextStyle(fontSize: 14, color: jm_text_black),
            maxLines: 100,
          ),
        )
      ],
    );
  }

  List<Widget> successInfo(
      double widthScale, double margin, double lineHeight) {
    return // 成交信息
        [
      Row(
        children: [
          SizedBox(
            width: margin,
          ),
          Image.asset(
            'assets/images/icon/icon_client_deal.png',
            width: widthScale * 7,
            height: widthScale * 7,
          ),
          SizedBox(
            width: widthScale * 1,
          ),
          Text(
            '成交信息',
            style: TextStyle(fontSize: 18, color: jm_text_black),
          )
        ],
      ),
      SizedBox(
        height: 15,
      ),
      getInfoRow('成交渠道', successData['companyName'] ?? '',
          widthScale: widthScale, lineHeight: lineHeight, margin: margin),
      SizedBox(
        height: 5,
      ),
      getInfoRow('项目名称', successData['projectName'] ?? '',
          widthScale: widthScale, lineHeight: lineHeight, margin: margin),
      SizedBox(
        height: 5,
      ),
      getInfoRow('房号', successData['buildNo'] ?? '',
          widthScale: widthScale, lineHeight: lineHeight, margin: margin),
      SizedBox(
        height: 5,
      ),
      getInfoRow('认购名称', successData['payName'] ?? '',
          widthScale: widthScale, lineHeight: lineHeight, margin: margin),
      SizedBox(
        height: 5,
      ),
      getInfoRow('认购电话', successData['payPhone'] ?? '',
          widthScale: widthScale, lineHeight: lineHeight, margin: margin),
      SizedBox(
        height: 5,
      ),
      getInfoRow('身份证号', successData['idCard'] ?? '',
          widthScale: widthScale, lineHeight: lineHeight, margin: margin),
      SizedBox(
        height: 5,
      ),
      getInfoRow('成交面积', '${successData['houseArea'] ?? ''}  平方米',
          widthScale: widthScale, lineHeight: lineHeight, margin: margin),
      SizedBox(
        height: 5,
      ),
      getInfoRow('成交总价', '${(successData['dealTotal']).toString() ?? ''}  元',
          widthScale: widthScale, lineHeight: lineHeight, margin: margin),
      SizedBox(
        height: 5,
      ),
      getInfoRow('换签时间', successData['visaTime'] ?? '',
          widthScale: widthScale, lineHeight: lineHeight, margin: margin),
      SizedBox(
        height: 5,
      ),
      getInfoRow('认购时间', successData['createTime'] ?? '',
          widthScale: widthScale, lineHeight: lineHeight, margin: margin),
      SizedBox(
        height: 5,
      ),
      getInfoRow('备注', successData['remark'] ?? '',
          widthScale: widthScale, lineHeight: lineHeight, margin: margin),
      SizedBox(
        height: 15,
      ),
      ...getCommissionRow(widthScale, margin)
    ];
  }

  List<Widget> getCommissionRow(double widthScale, double margin) {
    double commLine = 20;
    List<Widget> widgetList = [];
    if (successData['reportShopPartnerVO'] != null &&
        successData['reportShopPartnerVO'] is List) {
      // widgetList.add(

      // );
      List commissionList = successData['reportShopPartnerVO'];
      for (var i = 0; i < commissionList.length; i++) {
        Map relicyRuleInfo = successData['relicyRuleInfo'] != null &&
                successData['relicyRuleInfo'].length > i
            ? (successData['relicyRuleInfo'])[i]
            : {};
        Map commissionData = commissionList[i];
        widgetList.add(Column(
          children: [
            Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                SizedBox(
                  width: margin,
                ),
                Text(
                  '佣金规则',
                  style: jm_text_gray_style15,
                ),
                SizedBox(
                  width: widthScale * 11.5,
                ),
                Container(
                  width: widthScale * 60,
                  child: Text(
                    relicyRuleInfo['remark'] ?? '',
                    style: jm_text_black_style15,
                  ),
                )
              ],
            ),
            SizedBox(
              height: i == 0 ? 15 : 10,
            ),
            Row(children: [
              SizedBox(
                width: margin,
                height: commLine,
              ),
              Container(
                width: widthScale * 26,
                child: Text(
                  commissionData['userName'] ?? '',
                  style: jm_text_black_style15,
                ),
              ),
              Text(
                commissionData['userPhone'] ?? '',
                style: jm_text_black_style15,
              ),
            ]),
            SizedBox(
              height: 3,
            ),
            Row(
              children: [
                SizedBox(
                  width: margin,
                  height: commLine,
                ),
                Container(
                  width: widthScale * 26,
                  child: Text(
                    '佣金比例',
                    style: jm_text_apptheme_style15,
                  ),
                ),
                Text(
                  commissionData['ratio'] != null
                      ? ((commissionData['ratio'] * 100).toString() + '%')
                      : '',
                  style: jm_text_black_style15,
                ),
                SizedBox(
                  width: widthScale * 4,
                ),
                Text(
                  commissionData['userCommission'] != null
                      ? ((commissionData['userCommission']).toString() + '元')
                      : '',
                  style: jm_text_black_style15,
                )
              ],
            ),
            SizedBox(
              height: i == commissionList.length - 1 ? 20 : 0,
            ),
          ],
        ));
      }
    }

    return widgetList;
  }
}
