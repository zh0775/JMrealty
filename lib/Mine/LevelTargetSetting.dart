import 'package:JMrealty/Mine/components/CityDropDown.dart';
import 'package:JMrealty/Mine/components/LevelTargetCell.dart';
import 'package:JMrealty/Mine/viewModel/LevelTargetViewModel.dart';
import 'package:JMrealty/components/CustomAppBar.dart';
import 'package:JMrealty/components/CustomLoading.dart';
import 'package:JMrealty/const/Default.dart';
import 'package:JMrealty/utils/sizeConfig.dart';
import 'package:JMrealty/utils/toast.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class LevelTargetSetting extends StatefulWidget {
  final int deptId;
  const LevelTargetSetting({this.deptId});
  @override
  _LevelTargetSettingState createState() => _LevelTargetSettingState();
}

class _LevelTargetSettingState extends State<LevelTargetSetting> {
  LevelTargetViewModel levelTargetVM = LevelTargetViewModel();
  double topHeight = 300;
  double widthScale;
  double margin;
  double selfWidth;

  Function(int deleteIndex) deleteItem = (int deleteIndex) {};

  List citys = [];
  int cityValue = 0;
  List itemsData = [];
  bool isEdit = false;
  Map newItem;
  @override
  void initState() {
    cityValue = widget.deptId ?? 0;
    newItem = {'count': '', 'month': '', 'price': ''};
    CustomLoading().show();
    levelTargetVM.getDepCityList((success, cityList) {
      CustomLoading().hide();
      if (success) {
        setState(() {
          citys = cityList;
        });
        if (citys != null && citys.length > 0) {
          cityValue = (citys[0])['deptId'];
          loadTargetList();
        }
      }
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    // print('newItem === $newItem');
    SizeConfig().init(context);
    widthScale = SizeConfig.blockSizeHorizontal;
    margin = widthScale * 6;
    selfWidth = SizeConfig.screenWidth - margin * 2;
    return GestureDetector(
      onTap: () => FocusScope.of(context).requestFocus(FocusNode()),
      child: Scaffold(
          appBar: CustomAppbar(
            shadowColor: Colors.transparent,
            title: '规则设置',
          ),
          body: SingleChildScrollView(
            child: Container(
              width: SizeConfig.screenWidth,
              height: SizeConfig.screenHeight - kToolbarHeight - 40,
              child: Column(
                children: [
                  SizedBox(
                    height: 20,
                  ),
                  CityDropDown(
                    border: BorderSide(width: 0.5, color: jm_line_color),
                    defalultValue: true,
                    titleKey: 'deptName',
                    valueKey: 'deptId',
                    dataList: citys ?? [],
                    valueChange: (value, data) {
                      cityValue = value;
                      loadTargetList();
                    },
                  ),
                  SizedBox(
                    height: 10,
                  ),
                  Expanded(
                    child: ListView.builder(
                      itemCount: (itemsData != null ? itemsData.length : 0) + 1,
                      itemBuilder: (context, index) {
                        if (index == itemsData.length) {
                          return LevelTargetCell(
                            isEmpty: true,
                            index: index,
                            addItemClick: (item) {
                              addTargetSetting(item);
                            },
                          );
                        } else {
                          return LevelTargetCell(
                            data: itemsData[index] ?? {},
                            index: index,
                            isEmpty: false,
                            deleteItemClick: (item) {
                              deleteTarget(item);
                            },
                          );
                        }
                      },
                    ),
                  ),
                  // ...getTargetCell(),
                  // SizedBox(
                  //   height: 30,
                  // ),
                ],
              ),
            ),
          )),
    );
  }

  void deleteTarget(Map item) {
    CustomLoading().show();
    levelTargetVM.deleteTarget(item['id'], (bool success) {
      CustomLoading().hide();
      if (success) {}
      ShowToast.normal('删除成功');
      loadTargetList();
    });
    // setState(() {
    //   itemsData.remove(item);
    // });
  }

  void addTargetSetting(Map item) {
    CustomLoading().show();
    levelTargetVM.addTargetSetting(
        Map<String, dynamic>.from({'organizationId': cityValue, ...item}),
        (bool success) {
      CustomLoading().hide();
      if (success) {}
      ShowToast.normal('新增成功');
      loadTargetList();
    });
  }

  void loadTargetList() {
    CustomLoading().show();
    levelTargetVM.loadTarget(cityValue, (success, targetList) {
      CustomLoading().hide();
      if (success && mounted) {
        setState(() {
          itemsData = targetList;
        });
      }
    });
  }
}
