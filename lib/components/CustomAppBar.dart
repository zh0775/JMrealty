import 'package:JMrealty/const/Default.dart';
import 'package:flutter/material.dart';

class CustomAppbar extends StatelessWidget implements PreferredSizeWidget {
  final String title;
  final void Function() backClick;
  final PreferredSizeWidget bottom;
  @override
  // final Size preferredSize;
  const CustomAppbar(
      {this.title = '',
      this.backClick,
      // this.preferredSize = const Size.fromHeight(kToolbarHeight+ bottom.preferredSize),
      this.bottom});
  @override
  Widget build(BuildContext context) {
    return AppBar(
        centerTitle: true,
        backgroundColor: jm_appTheme,
        automaticallyImplyLeading: false,
        bottom: bottom,
        title: Text(
          title,
          style: TextStyle(color: Colors.white, fontSize: 18),
        ),
        leading: IconButton(
          icon: jm_naviBack_icon,
          onPressed: () {
            if (backClick != null) {
              backClick();
            } else {
              Navigator.pop(context);
            }
          },
        ));
  }

  @override
  Size get preferredSize {
    Size toolHeight = Size.fromHeight(
        Size.fromHeight(kToolbarHeight).height + (bottom != null ? 50 : 0));

    return toolHeight;
  }
}
