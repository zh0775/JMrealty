import 'package:JMrealty/const/Default.dart';
import 'package:flutter/material.dart';

class AddClientVC extends StatefulWidget {
  @override
  _AddClientVCState createState() => _AddClientVCState();
}

class _AddClientVCState extends State<AddClientVC> {
  double lineHeight = 40;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        backgroundColor: jm_appTheme,
        automaticallyImplyLeading: false,
        leading: IconButton(icon: Icon(Icons.navigate_before,size: 40,color: Colors.white,),onPressed: (){
          Navigator.pop(context);
        },),
        title: Text(
          '录入客源',
          style: TextStyle(color: Colors.white, fontSize: 20),
          ),
        ),
      body: ListView(
        children: [
          Container()
        ],
      ),
    );
  }
}
