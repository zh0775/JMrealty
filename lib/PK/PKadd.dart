import 'package:JMrealty/PK/viewModel/PKviewModel.dart';
import 'package:JMrealty/components/CustomAppBar.dart';
import 'package:JMrealty/const/Default.dart';
import 'package:JMrealty/utils/sizeConfig.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class PKadd extends StatefulWidget {
  @override
  _PKaddState createState() => _PKaddState();
}

class _PKaddState extends State<PKadd> {
  double widthScale;
  double margin;
  double selfWidth;
  double outMargin;
  double lineHeight;
  @override
  void initState() {
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
    margin = widthScale * 6;
    outMargin = widthScale * 4;
    selfWidth = SizeConfig.screenWidth - margin * 2;
    lineHeight = 40;
    return SingleChildScrollView(
      child: Column(
        children: [
          Row(children: [
            SizedBox(width: margin,height: 40,),
            Text('PK赛信息',style: jm_text_black_bold_style18,),
          ],),
          JMline(width: selfWidth, height: 0.5)
        ],
      ),
    );
  }

  showDatePick (DateTime dateTime) async {
    dateTime = await  showDatePicker(context: context, initialDate: DateTime.now(), firstDate: DateTime(2018, 1), lastDate: DateTime(2022, 1),
      builder: (BuildContext context, Widget child){
        return Theme();
    });
    setState(() {
    });
  }
}
