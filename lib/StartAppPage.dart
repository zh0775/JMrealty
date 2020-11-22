import 'package:JMrealty/base/appstart_viewmodel.dart';
import 'package:JMrealty/base/provider_widget.dart';
import 'package:JMrealty/const/Routes.dart';
import 'package:flutter/material.dart';

class StartAppPage extends StatefulWidget {
  @override
  _StartAppPageState createState() => _StartAppPageState();
}

class _StartAppPageState extends State<StartAppPage> {
  @override
  void initState() {
    Future.delayed(Duration(seconds: 3), () {
      Navigator.of(context).pushNamed(Routes.main_page);
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return ProviderWidget<AppStartViewModel>(
      model: AppStartViewModel(),
      onReady: (model) {
        model.load();
      },
      builder: (context, model, child) {
        return Container(
          color: Colors.pink,
        );
      },
    );
  }
}
