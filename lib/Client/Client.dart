import 'package:flutter/material.dart';
import 'package:JMrealty/const/Default.dart';

class Client extends StatefulWidget {
  @override
  _ClientState createState() => _ClientState();
}

class _ClientState extends State<Client> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: jm_appTheme,
        // centerTitle: true,
        title: Text(
          '客户',
          style: TextStyle(color: Colors.white, fontSize: 20),
        ),
        actions: [
          IconButton(
              icon: Icon(
                Icons.add_circle_outline,
                color: Colors.white,
                size: 30,
              ),
              onPressed: () {})
        ],
      ),
      backgroundColor: Colors.white,
      body: null,
    );
  }
}
