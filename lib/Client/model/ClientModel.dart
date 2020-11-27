import 'package:JMrealty/base/base_model.dart';

class ClientModel extends BaseModel {
  ClientModel({
    this.level,
    this.name,
    this.intentionProductType,
    this.roomCount,
    this.intentionArea,
    this.intentionPrice,
    this.newFollowTime,
    this.clientIntention,
    this.clientPhoneNum,
    this.customersOccupation,
    this.housePurpose,
    this.houseCount,
    this.floorIntention,
    this.sensitive,
    this.desireGrade,
    this.customersOfSource,
    this.decisionMaker
  });
  int level; // 客户等级
  String name; // 客户姓名
  Sex sex; // 客户性别
  IntentionProductType intentionProductType; // 房间类型 新房、二手房
  String roomCount; // 房间数量 二房、三房
  IntentionArea intentionArea; // 意向房子面积
  IntentionPrice intentionPrice; // 房子价格
  String newFollowTime; // 客户最新跟进信息
  String clientIntention; // 客户意向
  String clientPhoneNum; // 客户手机号码
  CustomersOccupation customersOccupation; // 客户职业
  String housePurpose; // 房子用途
  String houseCount; // 几次置业
  String floorIntention; // 意向楼层
  Sensitive sensitive; // 是否脱敏
  DesireGrade desireGrade; // 意愿等级
  CustomersOfSource customersOfSource; // 客户来源
  DecisionMaker decisionMaker; // 决策人
}

class ClientSelectListModel {
  ClientSelectListModel({
    this.sexList,
    this.sensitiveList,
    this.desireGradeList,
    this.intentionAreaList,
    this.intentionProductTypeList,
    this.intentionPriceList,
    this.decisionMakerList,
    this.customersOfSourceList,
    this.customersOccupationList
  });
  List<Sex> sexList; //性别
  List<Sensitive> sensitiveList; //是否脱敏
  List<DesireGrade> desireGradeList; //意愿等级
  List<IntentionArea> intentionAreaList; //面积
  List<IntentionProductType> intentionProductTypeList; //意向产品类型
  List<IntentionPrice> intentionPriceList; //客户意向价格
  List<DecisionMaker> decisionMakerList; // 决策人
  List<CustomersOfSource> customersOfSourceList; // 客户来源
  List<CustomersOccupation> customersOccupationList; // 客户职业

}

//性别
class Sex {
  Sex({this.id, this.value});
  int id;
  String value;
}
//是否脱敏
class Sensitive {
  Sensitive({this.id, this.value});
  int id;
  String value;
}
//意愿等级
class DesireGrade {
  DesireGrade({this.id, this.value});
  int id;
  String value;
}
//面积
class IntentionArea {
  IntentionArea({this.id, this.value});
  int id;
  String value;
}
//意向产品类型
class IntentionProductType {
  IntentionProductType({this.id, this.value});
  int id;
  String value;
}
//客户意向价格
class IntentionPrice {
  IntentionPrice({this.id, this.value});
  int id;
  String value;
}
// 决策人
class DecisionMaker {
  DecisionMaker({this.id, this.value});
  int id;
  String value;
}
// 客户来源
class CustomersOfSource {
  CustomersOfSource({this.id, this.value});
  int id;
  String value;
}
// 客户职业
class CustomersOccupation {
  CustomersOccupation({this.id, this.value});
  int id;
  String value;
}


