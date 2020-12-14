import 'package:JMrealty/PK/viewModel/PKviewModel.dart';
import 'package:JMrealty/components/CustomAppBar.dart';
import 'package:JMrealty/const/Default.dart';
import 'package:JMrealty/utils/sizeConfig.dart';
import 'package:flutter/material.dart';


class PKdetail extends StatefulWidget {
  final Map pkData;
  const PKdetail({@required this.pkData});
  @override
  _PKdetailState createState() => _PKdetailState();
}

class _PKdetailState extends State<PKdetail> {
  double widthScale;
  double margin;
  double selfWidth;
  double outMargin;
  // PKviewModel pkVM;

  @override
  void initState() {
    // pkVM = PKviewModel();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    SizeConfig().init(context);
    widthScale = SizeConfig.blockSizeHorizontal;
    margin = widthScale * 6;
    outMargin = widthScale * 4;
    selfWidth = SizeConfig.screenWidth - margin * 2;
    return Scaffold(
      backgroundColor: jm_appTheme,
      appBar: CustomAppbar(title: 'PK赛详情',),
      body: SingleChildScrollView(
        child: Align(
          child: Container(
            constraints: BoxConstraints(
              maxWidth: selfWidth,
              minWidth: selfWidth,
              minHeight: SizeConfig.screenHeight * 50,
            ),
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(widthScale * 4),
              color: Colors.white
            ),
            child: Column(children: [
              SizedBox(height: 10,),
              Row(
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                Container(
                  width: widthScale * 16,
                  height: 28,
                  decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(14),
                      color: jm_appTheme,
                      border: Border.all(width: 0.5,color: jm_line_color)
                  ),
                  child: Center(
                    child: Text(jm_getPKStatus(widget.pkData['status'] ?? 0),
                      style: jm_text_black_bold_style15,
                    ),
                  ),
                ),
                SizedBox(width: outMargin,),
              ],),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Row(children: [
                    SizedBox(width: outMargin,),
                    Text(widget.pkData['name']??'',style: jm_text_black_bold_style17,),
                  ],),
                  Row(children: [
                    Text('时间：' + widget.pkData['startTime']??'' + ' 至 ' + widget.pkData['endTime']??'', style: jm_text_black_bold_style17,),
                    SizedBox(width: outMargin,),
                  ],)
                ],
              ),
              SizedBox(height: 10,),
              JMline(width: selfWidth, height: 0.5),
              SizedBox(height: 10,),
              Row(children: [
                SizedBox(height: 10,),
                SizedBox(width: outMargin,),
                Text('PK赛奖励',style: jm_text_gray_style14,),
                SizedBox(width: widthScale * 7,),
                Container(
                  width: widthScale * 55,
                  child: Text(widget.pkData['award']??'',style: jm_text_black_style14,)),
              ],),
              SizedBox(height: 10,),
              Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                SizedBox(width: outMargin,),
                Text('PK赛规则',style: jm_text_gray_style14,),
                SizedBox(width: widthScale * 7,),
                Container(
                  width: widthScale * 55,
                    child: Text(widget.pkData['rule']??'',style: jm_text_black_style14,maxLines: 100,)),
              ],),
              SizedBox(height: 10,),
              JMline(width: selfWidth, height: 0.5),
              ...getCell(),
            ],),
          ),
        ),
      ),
    );
  }

  List<Widget> getCell (){
    List<Widget> cells = [];
    for (var i = 0; i < (widget.pkData['raceRankList']).length ?? 0; i++) {
      Map<String, dynamic> data = (widget.pkData['raceRankList'])[i];
      cells.add(Row(
        children: [
          SizedBox(width: outMargin,height: 40,),
          Text('排名: ' + (data['sort'] != null ? (data['sort']).toString() : ''),style: jm_text_black_style15,),
          SizedBox(width: widthScale * 3,),
          Text(data['bussinesName'] ?? '',style: jm_text_black_style14,),
          // JMline(margin: widthScale * 3 ,width: selfWidth - widthScale * 6, height: 0.5)
        ],
      ));
      cells.add(JMline(margin: outMargin ,width: selfWidth - outMargin * 2, height: 0.5));
    }
    // cells.add(Container(
    //   height: 40,
    //   child: Row(
    //     mainAxisAlignment: MainAxisAlignment.center,
    //     children: [
    //       Text('查看详情'),
    //       Icon(Icons.chevron_right,size: 23,color: jm_line_color,)
    //     ],
    //   ),
    // ));
    return cells;
  }
}
