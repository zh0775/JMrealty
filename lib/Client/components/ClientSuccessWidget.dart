import 'package:JMrealty/const/Default.dart';
import 'package:JMrealty/utils/sizeConfig.dart';
import 'package:flutter/material.dart';

class ClientSuccessWidget extends StatelessWidget {
  final Map successData;
  const ClientSuccessWidget({this.successData});
  @override
  Widget build(BuildContext context) {
    SizeConfig().init(context);
    double widthScale = SizeConfig.blockSizeHorizontal;
    double margin = widthScale * 4;
    double lineHeight = 22;
    return Container(
      child: Column(
        children: [...successInfo(widthScale, margin, lineHeight)],
      ),
    );
  }

  Widget getInfoRow(String title, String value,
      {double widthScale, double margin, double lineHeight}) {
    return Row(
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
        Text(
          value,
          style: TextStyle(fontSize: 14, color: jm_text_black),
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
          Icon(
            Icons.thumb_up_alt,
            size: 20,
            color: jm_appTheme,
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
        height: 5,
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
      getInfoRow('成交面积·平方', successData['houseArea'] ?? '',
          widthScale: widthScale, lineHeight: lineHeight, margin: margin),
      SizedBox(
        height: 5,
      ),
      getInfoRow('成交总价·万', (successData['dealTotal']).toString() ?? '',
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
      ...getCommissionRow(widthScale, margin)
    ];
  }

  List<Widget> getCommissionRow(double widthScale, double margin) {
    double commLine = 20;
    List<Widget> widgetList = [];
    if (successData['reportShopPartnerVO'] != null &&
        successData['reportShopPartnerVO'] is List) {
      widgetList.add(
        Row(
          children: [
            Icon(
              Icons.thumb_up_alt,
              size: 20,
              color: jm_appTheme,
            ),
            SizedBox(
              width: widthScale * 1,
            ),
            Text(
              '佣金明细',
              style: TextStyle(fontSize: 18, color: jm_text_black),
            )
          ],
        ),
      );
      List commissionList = successData['reportShopPartnerVO'];
      for (var i = 0; i < commissionList.length; i++) {
        Map commissionData = commissionList[i];
        widgetList.add(Column(
          children: [
            SizedBox(
              height: 10,
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
                  style: jm_text_black_style14,
                ),
              ),
              Text(
                commissionData['userPhone'] != null
                    ? ('手机号：' + commissionData['userPhone'])
                    : '',
                style: jm_text_black_style14,
              ),
            ]),
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
                    style: jm_text_black_style14,
                  ),
                ),
                Text(
                  commissionData['ratio'] != null
                      ? ((commissionData['ratio']).toString() + '%')
                      : '',
                  style: jm_text_black_style14,
                ),
                SizedBox(
                  width: widthScale * 4,
                ),
                Text(
                  commissionData['userCommission'] != null
                      ? ((commissionData['userCommission']).toString() + '元')
                      : '',
                  style: jm_text_black_style14,
                )
              ],
            ),
          ],
        ));
      }
    }

    return widgetList;
  }
}
