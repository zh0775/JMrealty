import 'package:JMrealty/const/Default.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

typedef void SelectedChange(int index, String data);

class BottomSelect {
  SelectedChange selectedChange;
  List pickerChildren;
  int defaultSelect;
  BottomSelect({
    @required this.selectedChange,
    @required this.pickerChildren,
    this.defaultSelect = 0,
  });


  void didClickSelectedGender(context) {
    showCupertinoModalPopup(
        context: context,
        builder: (BuildContext context) {
          return Container(
            height: 250,
            child: Column(
              children: <Widget>[
                Container(
                  color: Colors.white,
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: <Widget>[
                      FlatButton(
                        color: Colors.white,
                        onPressed: () {
                          Navigator.pop(context);
                        },
                        child: Text("取消"),
                      ),
                      FlatButton(
                        color: Colors.white,
                        onPressed: () {
                          if (selectedChange != null && pickerChildren.length > 0) {
                            selectedChange(defaultSelect, (pickerChildren[defaultSelect])['title']);
                          }
                          Navigator.pop(context);
                        },
                        child: Text("确定"),
                      ),
                    ],
                  ),
                ),
                Expanded(
                  child: DefaultTextStyle(
                    style: TextStyle(
                      color: Colors.black,
                      fontSize: 22,
                    ),
                    child: _buildGenderPicker(),
                  ),
                ),
              ],
            ),
          );
        });
  }

  Widget _buildGenderPicker() {
    return CupertinoPicker(
      backgroundColor: Colors.white,
      itemExtent: 40,
      onSelectedItemChanged: (value) {
        defaultSelect = value;
      },
      children: pickerChildren.map((data) {
        return Text(data['title']);
      }).toList(),
    );
  }
}
