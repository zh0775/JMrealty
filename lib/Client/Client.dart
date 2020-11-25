import 'package:JMrealty/Client/components/WaitFollowUpCell.dart';
import 'package:JMrealty/const/Default.dart';
import 'package:JMrealty/utils/sizeConfig.dart';
import 'package:flutter/material.dart';

class Client extends StatefulWidget {
  @override
  _ClientState createState() => _ClientState();
}

class _ClientState extends State<Client> {
  @override
  Widget build(BuildContext context) {
    SizeConfig().init(context);
    return DefaultTabController(
      length: 5,
      child: Scaffold(
        appBar: AppBar(
          centerTitle: true,
          backgroundColor: jm_appTheme,
          automaticallyImplyLeading: false,
          title: Text(
            '客户',
            style: TextStyle(color: Colors.white, fontSize: 22),
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
          bottom: TabBar(
            indicatorSize: TabBarIndicatorSize.label,
            indicatorColor: Colors.white,
            indicatorWeight: 2.0,
            indicatorPadding: EdgeInsets.only(bottom: 5),
            tabs: [
              Tab(
                child: Text(
                  '待跟进',
                  style: TextStyle(fontSize: 14, color: Colors.white),
                ),
              ),
              Tab(
                child: Text(
                  '已带看',
                  style: TextStyle(fontSize: 14, color: Colors.white),
                ),
              ),
              Tab(
                child: Text(
                  '已预约',
                  style: TextStyle(fontSize: 14, color: Colors.white),
                ),
              ),
              Tab(
                child: Text(
                  '已成交',
                  style: TextStyle(fontSize: 14, color: Colors.white),
                ),
              ),
              Tab(
                child: Text(
                  '水客',
                  style: TextStyle(fontSize: 14, color: Colors.white),
                ),
              )
            ],
          ),
        ),
        backgroundColor: Colors.white,
        body: TabBarView(
          children: [
            ListView.builder(
              itemCount: 1,
              itemBuilder: (context, index) {
                return WaitFollowUpCell();
              },
            ),
            ListView.builder(
              itemCount: 5,
              itemBuilder: (context, index) {
                return WaitFollowUpCell();
              },
            ),
            ListView.builder(
              itemCount: 5,
              itemBuilder: (context, index) {
                return WaitFollowUpCell();
              },
            ),
            ListView.builder(
              itemCount: 5,
              itemBuilder: (context, index) {
                return WaitFollowUpCell();
              },
            ),
            ListView.builder(
              itemCount: 5,
              itemBuilder: (context, index) {
                return WaitFollowUpCell();
              },
            )
          ],
        ),
      ),
    );
  }
}
