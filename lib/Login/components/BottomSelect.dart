import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

typedef void SelectedChange(int index, String data);

class BottomSelect {
  SelectedChange selectedChange;
  List pickerChildren;
  int defaultSelect = 0;
  BottomSelect({
    @required this.selectedChange,
    @required this.pickerChildren,
    this.defaultSelect,
  });

  void didClickSelectedGender(context) {
    showCupertinoModalPopup(
        context: context,
        builder: (BuildContext context) {
          return Container(
            height: 250,
            child: Column(
              children: <Widget>[
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: <Widget>[
                    FlatButton(
                      color: Colors.white,
                      onPressed: () {
                        Navigator.pop(context);
                      },
                      child: Text("Cancle"),
                    ),
                    FlatButton(
                      color: Colors.white,
                      onPressed: () {
                        Navigator.pop(context);
                      },
                      child: Text("OK"),
                    ),
                  ],
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
      itemExtent: 40,
      onSelectedItemChanged: (value) {
        selectedChange(value, (pickerChildren[value])['title']);
      },
      children: pickerChildren.map((data) {
        return Text(data['title']);
      }).toList(),
    );
  }
}
