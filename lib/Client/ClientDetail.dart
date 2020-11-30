import 'package:JMrealty/const/Default.dart';
import 'package:flutter/material.dart';

class ClientDetail extends StatefulWidget {
  final Map clientData;
  ClientDetail({@required this.clientData});
  @override
  _ClientDetailState createState() => _ClientDetailState();
}

class _ClientDetailState extends State<ClientDetail> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        backgroundColor: jm_appTheme,
        automaticallyImplyLeading: false,
        leading: IconButton(
          icon: Icon(
            Icons.navigate_before,
            size: 40,
            color: Colors.white,
          ),
          onPressed: () {
            Navigator.pop(context);
          },
        ),
        title: Text(
          '录入客源',
          style: TextStyle(color: Colors.white, fontSize: 18),
        ),
      ),
      body: ListView(),
    );
  }
}
