import 'package:JMrealty/const/Default.dart';
import 'package:flutter/material.dart';

class CustomAppbar extends StatelessWidget implements PreferredSizeWidget {
  final String title;
  final void Function() backClick;
  @override
  final Size preferredSize;
  const CustomAppbar(
      {this.title = '',
      this.backClick,
      this.preferredSize = const Size.fromHeight(kToolbarHeight)});
  @override
  Widget build(BuildContext context) {
    return AppBar(
        centerTitle: true,
        backgroundColor: jm_appTheme,
        automaticallyImplyLeading: false,
        title: Text(
          title,
          style: TextStyle(color: Colors.white, fontSize: 18),
        ),
        leading: IconButton(
          icon: Icon(
            Icons.navigate_before,
            size: 40,
            color: Colors.white,
          ),
          onPressed: () {
            if (backClick != null) {
              backClick();
            } else {
              Navigator.pop(context);
            }
          },
        ));
  }
}
