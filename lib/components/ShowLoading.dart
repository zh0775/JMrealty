import 'package:JMrealty/const/Default.dart';
import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';

class ShowLoading extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Stack(
      children: <Widget>[
        Padding(
          padding: EdgeInsets.fromLTRB(0.0, 0.0, 0.0, 35.0),
          child: Center(
            child: SpinKitFadingCircle(
              color: jm_appTheme,
              size: 60.0,
            ),
          ),
        ),
        // new Padding(
        //   padding: new EdgeInsets.fromLTRB(0.0, 35.0, 0.0, 0.0),
        //   child: new Center(
        //     child: new Text(""),
        //   ),
        // ),
      ],
    );
  }
}
