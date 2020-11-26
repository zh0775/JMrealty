import 'package:JMrealty/Client/components/WaitFollowUpCell.dart';
import 'package:JMrealty/Client/model/ClientModel.dart';
import 'package:JMrealty/Client/viewModel/ClientViewModel.dart';
import 'package:JMrealty/base/provider_widget.dart';
import 'package:JMrealty/const/Default.dart';
import 'package:JMrealty/utils/sizeConfig.dart';
import 'package:flutter/material.dart';

class Client extends StatefulWidget {
  @override
  _ClientState createState() => _ClientState();
}

class _ClientState extends State<Client> {
  SelectedForRowAtIndex selectedForRowAtIndex = (ClientStatus status, int index, ClientModel model) {
    print('status === $status --- index === $index --- model === $model');
  };
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
            ClientList(status: ClientStatus.wait, selectedForRowAtIndex: selectedForRowAtIndex,),
            ClientList(status: ClientStatus.already, selectedForRowAtIndex: selectedForRowAtIndex),
            ClientList(status: ClientStatus.order, selectedForRowAtIndex: selectedForRowAtIndex),
            ClientList(status: ClientStatus.deal, selectedForRowAtIndex: selectedForRowAtIndex),
            ClientList(status: ClientStatus.water, selectedForRowAtIndex: selectedForRowAtIndex),
          ],
        ),
      ),
    );
  }
}


class ClientList extends StatefulWidget {
  final ClientStatus status;
  final SelectedForRowAtIndex selectedForRowAtIndex;
  ClientList({@required this.status,this.selectedForRowAtIndex});
  @override
  _ClientListState createState() => _ClientListState();
}

class _ClientListState extends State<ClientList> {
  @override
  Widget build(BuildContext context) {
    return  ProviderWidget<ClientViewModel>(
        model: ClientViewModel(),
        onReady: (model) {
          model.loadClientListFromStatus(widget.status);
        },
        builder: (ctx, model, child) {
          return ListView.builder(
            itemCount: model.clientList.length,
            itemBuilder: (context, index) {
              return WaitFollowUpCell(
                model: model.clientList[index],
                status: widget.status,
                index: index,
                selectedForRowAtIndex: widget.selectedForRowAtIndex,
              );
            },
          );
        });
  }
  @override
  void dispose() {
    super.dispose();
  }
}
