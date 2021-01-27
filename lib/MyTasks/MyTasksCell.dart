import 'package:JMrealty/MyTasks/viewModel/MyTasksViewModel.dart';
import 'package:JMrealty/base/image_loader.dart';
import 'package:JMrealty/components/CustomAlert.dart';
import 'package:JMrealty/components/NoneV.dart';
import 'package:JMrealty/const/Default.dart';
import 'package:JMrealty/utils/sizeConfig.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class MyTasksCell extends StatefulWidget {
  final Map data;
  final int status;
  final Function() needRefreshList;
  const MyTasksCell({this.data, this.status = 1, this.needRefreshList});
  @override
  _MyTasksCellState createState() => _MyTasksCellState();
}

class _MyTasksCellState extends State<MyTasksCell> {
  MyTasksViewModel taskVM = MyTasksViewModel();
  DateFormat dateFormat = DateFormat('yyyy-MM-dd HH:mm:ss');
  // double cellHeight = 340;
  double widthScale;
  double outMargin;
  double insideMargin;
  double labelSpace = 3;
  double axisSpace = 14;
  @override
  Widget build(BuildContext context) {
    widthScale = SizeConfig.blockSizeHorizontal;
    outMargin = widthScale * 4;
    insideMargin = widthScale * 6;
    return Container(
        width: SizeConfig.screenWidth,
        decoration: BoxDecoration(
            color: Colors.white,
            border:
                Border(bottom: BorderSide(width: 0.5, color: jm_line_color))),
        child: Row(
          children: [
            SizedBox(
              width: insideMargin,
            ),
            Column(
              // mainAxisAlignment: MainAxisAlignment.center,
              // crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Padding(
                  padding: EdgeInsets.only(bottom: 25),
                  child: ClipRRect(
                    borderRadius: BorderRadius.circular(widthScale * 13 / 2),
                    child: Container(
                        width: widthScale * 13,
                        height: widthScale * 13,
                        child: widget.data['avatar'] != null &&
                                widget.data['avatar'] != ''
                            ? ImageLoader(widget.data['avatar'])
                            : Container(
                                width: 0.0,
                                height: 0.0,
                              )),
                  ),
                ),
                // SizedBox(
                //   height: labelSpace,
                // ),
                // Text(
                //   widget.data['userName'] ?? '',
                //   style: jm_text_black_style14,
                // )
              ],
            ),
            SizedBox(
              width: outMargin,
            ),
            Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                SizedBox(
                  height: axisSpace,
                ),
                Container(
                  width: SizeConfig.screenWidth -
                      widthScale * 13 -
                      insideMargin * 2 -
                      widthScale * 2,
                  child: Row(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      SizedBox(
                          width: SizeConfig.screenWidth -
                              widthScale * 13 -
                              insideMargin * 2 -
                              widthScale * 20,
                          child: Text(
                            widget.data['name'] ?? '',
                            style: jm_text_black_bold_style15,
                            maxLines: 100,
                          )),
                      RawMaterialButton(
                        materialTapTargetSize: MaterialTapTargetSize.shrinkWrap,
                        constraints: BoxConstraints(minWidth: 0),
                        onPressed: () {
                          callPhone(widget.data['phonenumber']);
                        },
                        child: Row(
                          children: [
                            Text(widget.data['userName'] ?? ''),
                            SizedBox(
                              width: widthScale * 1.5,
                            ),
                            Image.asset(
                              'assets/images/icon_client_phone.png',
                              height: SizeConfig.blockSizeHorizontal * 5,
                              width: SizeConfig.blockSizeHorizontal * 5,
                            )
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
                SizedBox(
                  height: labelSpace + 2,
                ),
                SizedBox(
                  width: SizeConfig.screenWidth -
                      widthScale * 13 -
                      insideMargin * 2,
                  child: Text(
                    widget.data['taskExplain'] ?? '',
                    style: jm_text_black_style14,
                    maxLines: 100,
                  ),
                ),
                // SizedBox(
                //   height: labelSpace,
                // ),
                // Text(
                //   '',
                // widget.data['startTime'] != null
                //     ? (widget.data['startTime'] + ' - ')
                //     : '',
                //   style: jm_text_black_style14,
                // ),
                // SizedBox(
                //   height: labelSpace,
                // ),
                SizedBox(
                  height: 3,
                ),
                Text(
                  '开始时间：' + widget.data['startTime'] ?? '',
                  style: jm_text_gray_style14,
                ),
                SizedBox(
                  height: 3,
                ),
                Text(
                  '结束时间：' + widget.data['expireTime'] ?? '',
                  style: jm_text_gray_style14,
                ),
                SizedBox(
                  height: 5,
                ),
                SizedBox(
                  width: SizeConfig.screenWidth -
                      widthScale * 13 -
                      insideMargin * 2 -
                      widthScale * 2,
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Container(
                        height: 25,
                        decoration: BoxDecoration(
                            color: Color.fromRGBO(243, 249, 255, 1),
                            borderRadius: BorderRadius.circular(25 / 2)),
                        child: Padding(
                          padding:
                              EdgeInsets.symmetric(horizontal: widthScale * 3),
                          child: Center(
                            child: Text(getTaskType(widget.data['type']),
                                style: jm_text_black_style14),
                          ),
                        ),
                      ),
                      (dateFormat
                                      .parse(widget.data['expireTime'])
                                      .isAfter(DateTime.now()) &&
                                  dateFormat
                                      .parse(widget.data['startTime'])
                                      .isBefore(DateTime.now()) &&
                                  widget.status == 1) ||
                              widget.status == 4
                          ? RawMaterialButton(
                              materialTapTargetSize:
                                  MaterialTapTargetSize.shrinkWrap,
                              elevation: 1.0,
                              // hoverElevation: 1.0,
                              highlightElevation: 1.0,
                              onPressed: () {
                                if (widget.needRefreshList != null) {
                                  CustomAlert(title: '', content: '是否添加到已完成')
                                      .show(
                                    confirmClick: () {
                                      taskVM.taskCompleteRequest({
                                        'id': widget.data['id'],
                                        'status': 3
                                      }, (success) {
                                        if (success) {
                                          widget.needRefreshList();
                                        }
                                      });
                                    },
                                  );
                                }
                              },
                              constraints:
                                  BoxConstraints(minHeight: 0, minWidth: 0),
                              fillColor: jm_appTheme,
                              shape: RoundedRectangleBorder(
                                  borderRadius:
                                      BorderRadius.circular(widthScale * 2)),
                              child: Padding(
                                padding: EdgeInsets.symmetric(
                                    vertical: widthScale * 1,
                                    horizontal: widthScale * 2),
                                child: Text(
                                  '完成',
                                  style: TextStyle(
                                      color: Colors.white, fontSize: 13),
                                ),
                              ),
                            )
                          : NoneV(),
                    ],
                  ),
                ),
                SizedBox(
                  height: axisSpace,
                ),
              ],
            ),
          ],
        ));
  }

  String getTaskType(int taskType) {
    if (taskType == null) {
      return '';
    }
    switch (taskType) {
      case 0:
        return '业绩任务';
        break;
      case 1:
        return '招聘任务';
        break;
      case 2:
        return '培训任务';
        break;
      default:
    }
  }
}
