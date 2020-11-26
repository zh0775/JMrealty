import 'package:JMrealty/Client/model/ClientModel.dart';
import 'package:JMrealty/const/Default.dart';
import 'package:JMrealty/utils/sizeConfig.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:JMrealty/Client/viewModel/ClientViewModel.dart';

typedef void SelectedForRowAtIndex(ClientStatus status, int index, ClientModel model);

class WaitFollowUpCell extends StatefulWidget {
  final ClientModel model;
  final int index;
  final ClientStatus status;
  final SelectedForRowAtIndex selectedForRowAtIndex;
  WaitFollowUpCell({this.model,this.selectedForRowAtIndex,this.index,this.status});
  @override
  _WaitFollowUpCellState createState() => _WaitFollowUpCellState();
}

class _WaitFollowUpCellState extends State<WaitFollowUpCell> {
  @override
  Widget build(BuildContext context) {
    SizeConfig().init(context);
    double lineHeight = 35;
    double cellHeight = 200;
    double cellWidth = SizeConfig.screenWidth;
    ClientModel model = widget.model;

    String level = '';
    String name = '';
    String sex = '';
    String houseType = '';
    String roomCount = '';
    String houseSize = '';
    String housePrice = '';
    String newFollowTime = '';
    String clientIntention = '';
    String clientPhoneNum = '';

    Color levelColor = Colors.transparent;
    if(model.level != null) {
      switch (model.level) {
        case 1:
          level = 'A级';
          levelColor = Color.fromRGBO(233,193,112, 1);
          break;
        case 2:
          level = 'B级';
          levelColor = Color.fromRGBO(91,93,106, 1);
          break;
        case 3:
          level = 'C级';
          levelColor = Color.fromRGBO(40,143,255, 1);
          break;
      }
    }
    if (model.name != null) {
      name = model.name;
    }
    if (model.sex != null) {
      if (model.sex == 1) {
        sex = '先生';
      } else if (model.sex == 2) {
        sex = '女士';
      }
    }
    if (model.houseType != null) {
      houseType = model.houseType;
    }
    if (model.roomCount != null) {
      roomCount = model.roomCount;
    }
    if (model.houseSize != null) {
      houseSize = model.houseSize;
    }
    if (model.housePrice != null) {
      housePrice = model.housePrice;
    }
    if (model.newFollowTime != null) {
      newFollowTime = model.newFollowTime;
    }
    if (model.clientIntention != null) {
      clientIntention = model.clientIntention;
    }
    if (model.clientPhoneNum != null) {
      clientPhoneNum = model.clientPhoneNum;
    }

    return GestureDetector(
      onTap: () {
        if (widget.selectedForRowAtIndex != null) {
          widget.selectedForRowAtIndex(widget.status,widget.index,widget.model);
        }
      },
      child: Container(
        width: cellWidth,
        height: cellHeight,
        decoration: BoxDecoration(
            border: Border(
          bottom: BorderSide(color: jm_line_color, width: 0.5),
        )),
        child: Column(
          children: [
            Container(
              height: lineHeight,
              width: cellWidth,
              margin: EdgeInsets.only(left: SizeConfig.blockSizeHorizontal * 4, top: 10),
              child: Row(children: [
                // 客户级别
                Container(width: SizeConfig.blockSizeHorizontal * 10,height: lineHeight - 10,
                decoration: BoxDecoration(
                  color: levelColor,
                  borderRadius: BorderRadius.only(
                    topRight: Radius.circular((lineHeight - 10)/2),
                    bottomLeft: Radius.circular((lineHeight - 10)/2),
                    bottomRight: Radius.circular((lineHeight - 10)/2),
                  )
                ),
                  child: Center(
                    child: Text(level,style: TextStyle(
                      color: Colors.white,
                      fontSize: 13
                    ),),
                  ),
                ),
                // 客户姓名
                frameText(name,width: SizeConfig.blockSizeHorizontal * 17,height: lineHeight - 10,fontSize: 16,textColor: Colors.black),
                // 客户性别
                Container(
                  decoration: BoxDecoration(
                    color: Color.fromRGBO(243,249,255, 1),
                    borderRadius: BorderRadius.circular((lineHeight - 10) / 2)
                  ),
                  child: frameText(sex,width: SizeConfig.blockSizeHorizontal * 12,height: lineHeight - 10,fontSize: 13,textColor: Colors.black),
                ),
                SizedBox(width: SizeConfig.blockSizeHorizontal * 2),
                // 是否新房
                Container(
                  decoration: BoxDecoration(
                      color: Color.fromRGBO(243,249,255, 1),
                      borderRadius: BorderRadius.circular((lineHeight - 10) / 2)
                  ),
                  child: frameText(houseType,width: SizeConfig.blockSizeHorizontal * 12,height: lineHeight - 10,fontSize: 13,textColor: Colors.black),
                ),
                SizedBox(width: SizeConfig.blockSizeHorizontal * 18,),
                // 联系电话
                GestureDetector(
                  onTap: () {
                    // callPhone(clientPhoneNum);
                  },
                  child:Row(children: [
                    frameText('联系电话',width: SizeConfig.blockSizeHorizontal * 16,height: lineHeight - 10,fontSize: 15,textColor: Colors.black),
                    Image.asset('assets/images/icon_client_phone.png',height: SizeConfig.blockSizeHorizontal*6,width: SizeConfig.blockSizeHorizontal*6,)
                  ],),
                )
              ],),
            ),
            Container(
              height: lineHeight,
              width: cellWidth,
              child: Row(children: [
                SizedBox(width: SizeConfig.blockSizeHorizontal * 14,),
                // 房间数量
                frameText(roomCount, height: lineHeight - 10, width: SizeConfig.blockSizeHorizontal * 10, textColor: Color.fromRGBO(98,103,125, 1), fontSize: 14),
                Container(width: 1, height: lineHeight - 28, color: Color.fromRGBO(98,103,125, 1),),
                // frameText(roomCount, height: lineHeight - 10, width: SizeConfig.blockSizeHorizontal * 10, textColor: Color.fromRGBO(98,103,125, 1), fontSize: 14),
                SizedBox(width: SizeConfig.blockSizeHorizontal * 2,),
                // 房子大小
                Text(houseSize,style: TextStyle(color: Color.fromRGBO(98,103,125, 1),fontSize: 14),),
                SizedBox(width: SizeConfig.blockSizeHorizontal * 2,),
                Container(width: 1, height: lineHeight - 28, color: Color.fromRGBO(98,103,125, 1),),
                SizedBox(width: SizeConfig.blockSizeHorizontal * 2,),
                // 房子价格
                Text(housePrice,style: TextStyle(color: Color.fromRGBO(98,103,125, 1),fontSize: 14),),
              ],),
            ),
            Container(
              height: lineHeight - 15,
              width: cellWidth,
              margin: EdgeInsets.only(bottom: 8),
              child: Row(children: [
                SizedBox(width: SizeConfig.blockSizeHorizontal * 16,),
                // 最新跟进进展信息
                Text(newFollowTime,style: TextStyle(color: Color.fromRGBO(172,176,187, 1),fontSize: 14))
              ],),
            ),
            Container(
              height: lineHeight,
              width: cellWidth,
              child: Row(children: [
                // 客户意向
                Container(
                  margin: EdgeInsets.only(left: SizeConfig.blockSizeHorizontal * 16),
                  padding: EdgeInsets.only(left: SizeConfig.blockSizeHorizontal * 3),
                  height: lineHeight,
                  width: SizeConfig.blockSizeHorizontal * 80,
                  decoration: BoxDecoration(
                    color: Color.fromRGBO(247,248,251, 1),
                    borderRadius: BorderRadius.circular(8)
                  ),
                  child: Align(
                    alignment: Alignment.centerLeft,
                    child: Text(clientIntention,style: TextStyle(color: Color.fromRGBO(55,58,73, 1),fontSize: 15)),),
                  )
              ],),
            ),
            Container(
              margin: EdgeInsets.only(top: 13),
              height: lineHeight - 5,
              width: cellWidth,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  Container(
                      width: SizeConfig.blockSizeHorizontal * 20,
                      height: lineHeight - 5,
                      child: RawMaterialButton(
                        highlightElevation:0,
                        elevation: 0,
                        fillColor: Colors.white,
                        shape: RoundedRectangleBorder(
                          side: BorderSide(width: 0.5, color: Color.fromRGBO(87,93,116, 1)),
                          borderRadius: BorderRadius.circular(6),
                        ),
                        onPressed: (){},
                        child:Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Icon(Icons.create,size: 15,color: Color.fromRGBO(87,93,116, 1),),
                            SizedBox(width: 6,),
                            Text('写跟进',style: TextStyle(fontSize: 14,color: Color.fromRGBO(87,93,116, 1)),)
                          ],
                        ) ,)
                  ),
                  SizedBox(width: SizeConfig.blockSizeHorizontal * 3,),
                  Container(
                    width: SizeConfig.blockSizeHorizontal * 16,
                    height: lineHeight - 5,
                    child: RawMaterialButton(
                        highlightElevation:0,
                        elevation: 0,
                        fillColor: Color.fromRGBO(230,184,92, 1),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(6),
                        ),
                        onPressed: (){},
                        child:Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Icon(Icons.assignment,size: 15,color: Colors.white,),
                            SizedBox(width: 6,),
                            Text('报备',style: TextStyle(fontSize: 14,color: Colors.white),)
                          ],
                        ) ,)
                  ),
                  SizedBox(width: SizeConfig.blockSizeHorizontal * 4,)
              ],),
            )
          ],
        ),
      ),
    );
  }

  Widget frameText(text,{
    @required double height,
    @required double width,
    @required Color textColor,
    @required double fontSize }) {
    return Container(
      width: width,
      height: height,
      child: Center(
        child: Text(text, style: TextStyle(
          color: textColor,
          fontSize: fontSize
        ),),
      ),
    );
  }
}
