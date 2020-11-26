import 'dart:math';

import 'package:JMrealty/Client/model/ClientModel.dart';
import 'package:JMrealty/base/base_viewmodel.dart';
import 'package:JMrealty/services/http.dart';

enum ClientStatus {
  wait, // 待跟进
  already, // 已带看
  order, // 已预约
  deal, // 已成交
  water // 水客
}

class ClientViewModel extends BaseViewModel {
  // ClientModel clientModel;
  List<ClientModel> clientList = [];
  loadClientListFromStatus(ClientStatus status) {
    int count = Random().nextInt(15) + 1;
    print('count === $count');
    for (var i = 0; i < count; i++) {
      ClientModel clientModel = ClientModel();
      clientModel.level = 2;
      clientModel.sex = 1;
      clientModel.name = '杨酱紫';
      clientModel.houseType = '新房';
      clientModel.roomCount = '3室';
      clientModel.houseSize = '80m - 100m';
      clientModel.housePrice = '100万-180万';
      clientModel.newFollowTime = '最新跟进 2020.12.12';
      clientModel.clientIntention = '客户已确定意向，准备签约';
      clientModel.clientPhoneNum = '15300088668';
      clientList.add(clientModel);
    }
    notifyListeners();
  }

  @override
  void dispose() {
    clientList = [];
    super.dispose();
  }
}
