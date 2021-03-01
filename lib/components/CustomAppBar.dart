import 'package:JMrealty/const/Default.dart';
import 'package:flutter/material.dart';

class CustomAppbar extends StatelessWidget implements PreferredSizeWidget {
  final String title;
  final void Function() backClick;
  final PreferredSizeWidget bottom;
  final Widget flexibleSpace;
  final List<Widget> actions;
  final Color shadowColor;
  @override
  // final Size preferredSize;
  const CustomAppbar(
      {this.title = '',
      this.backClick,
      this.flexibleSpace,
      this.actions = const [],
      this.shadowColor,
      // this.preferredSize = const Size.fromHeight(kToolbarHeight+ bottom.preferredSize),
      this.bottom});
  @override
  Widget build(BuildContext context) {
    return AppBar(
        shadowColor: shadowColor,
        flexibleSpace: flexibleSpace != null
            ? flexibleSpace
            : Container(
                decoration: BoxDecoration(
                    image: DecorationImage(
                        fit: BoxFit.fill,
                        image:
                            AssetImage('assets/images/icon/bg_appbar_01.png'))),
              ),
        centerTitle: true,
        backgroundColor: jm_appTheme,
        automaticallyImplyLeading: false,
        bottom: bottom,
        actions: actions,
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
              if (Navigator.canPop(context)) {
                Navigator.pop(context);
              }
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
