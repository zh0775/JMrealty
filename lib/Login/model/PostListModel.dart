import 'package:JMrealty/base/base_model.dart';

class PostListModel extends BaseModel {
  List<PostData> data;

  PostListModel({this.data});

  PostListModel.fromJson(Map<String, dynamic> json) {
    if (json['data'] != null) {
      data = new List<PostData>();
      json['data'].forEach((v) { data.add(PostData.fromJson(v)); });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    if (this.data != null) {
      data['data'] = this.data.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class PostData {
  Null searchValue;
  String createBy;
  String createTime;
  Null updateBy;
  Null updateTime;
  String remark;
  Params params;
  int postId;
  String postCode;
  String postName;
  String postSort;
  String status;
  bool flag;

  PostData({this.searchValue, this.createBy, this.createTime, this.updateBy, this.updateTime, this.remark, this.params, this.postId, this.postCode, this.postName, this.postSort, this.status, this.flag});

  PostData.fromJson(Map<String, dynamic> json) {
    searchValue = json['searchValue'];
    createBy = json['createBy'];
    createTime = json['createTime'];
    updateBy = json['updateBy'];
    updateTime = json['updateTime'];
    remark = json['remark'];
    params = json['params'] != null ? new Params.fromJson(json['params']) : null;
    postId = json['postId'];
    postCode = json['postCode'];
    postName = json['postName'];
    postSort = json['postSort'];
    status = json['status'];
    flag = json['flag'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['searchValue'] = this.searchValue;
    data['createBy'] = this.createBy;
    data['createTime'] = this.createTime;
    data['updateBy'] = this.updateBy;
    data['updateTime'] = this.updateTime;
    data['remark'] = this.remark;
    if (this.params != null) {
      data['params'] = this.params.toJson();
    }
    data['postId'] = this.postId;
    data['postCode'] = this.postCode;
    data['postName'] = this.postName;
    data['postSort'] = this.postSort;
    data['status'] = this.status;
    data['flag'] = this.flag;
    return data;
  }
}

class Params {
  Params();

Params.fromJson(Map<String, dynamic> json) {}

Map<String, dynamic> toJson() {
  final Map<String, dynamic> data = new Map<String, dynamic>();
  return data;
}
}