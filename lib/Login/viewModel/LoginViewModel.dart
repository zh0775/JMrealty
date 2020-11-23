import 'package:JMrealty/Login/model/PostListModel.dart';
import 'package:JMrealty/base/base_viewmodel.dart';
import 'package:JMrealty/components/TreeNode.dart';
import 'package:JMrealty/const/Default.dart';
import 'package:JMrealty/services/Urls.dart';
import 'package:JMrealty/services/http.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';

class LoginViewModel extends BaseViewModel {
  List<Map<String,dynamic>> postDataList = [];
  List<Map<String,dynamic>> depDataList = [];
  List<TreeNode> depTreeDataList = [];
  PostListModel postListModel;
  bool sendCodeSuccess;
  loadPhoneCode(String phonenumber) {
    state = BaseState.LOADING;
    notifyListeners();
    Http().post(
      Urls.phoneCode,
      {'phonenumber': phonenumber},
      success: (json) {
        state = BaseState.CONTENT;
        notifyListeners();
      },
      fail: (reason, code) {
        state = BaseState.FAIL;
        notifyListeners();
        Fluttertoast.showToast(
            msg: reason,
            toastLength: Toast.LENGTH_SHORT,
            gravity: ToastGravity.BOTTOM,
            timeInSecForIosWeb: 1,
            backgroundColor: jm_appTheme,
            textColor: Colors.white,
            fontSize: 16.0);
      },
      after: () {},
    );
  }

  loadRegistPostSelectList() {
    state = BaseState.LOADING;
    notifyListeners();
    Http().get(
      Urls.registerPostList,
      {},
      success: (json) {
        compute(decodePostListToMapList,json).then((value) {
          postDataList = value;
          state = BaseState.CONTENT;
          notifyListeners();
        });

      },
      fail: (reason, code) {
        state = BaseState.FAIL;
        notifyListeners();
      },
      after: () {},
    );
  }
  static PostListModel decodePostList (dynamic json) {
    return PostListModel.fromJson(json);
  }
  static List<Map<String ,dynamic>> decodePostListToMapList (dynamic json) {
    List<Map<String ,dynamic>> dataList = [];
    json['data'].forEach((value){
      Map<String, dynamic> postModel = {'title':value['postName'],'value':value['postId']};
      dataList.add(postModel);
    });
    return dataList;
  }
  loadRegistDeptSelectList() {
    state = BaseState.LOADING;
    notifyListeners();
    Http().get(
      Urls.registerDeptList,
      {},
      success: (json) {
        compute(decodeDepListToList, json).then((value) {
          depTreeDataList = value;
          state = BaseState.CONTENT;
          notifyListeners();
        });
      },
      fail: (reason, code) {
        state = BaseState.FAIL;
        notifyListeners();
      },
      after: () {},
    );
  }

  static List<TreeNode> decodeDepListToList (dynamic json) {
    List<TreeNode> dataList = [];
    json['data'].forEach((value){
      TreeNode treeNode0 = TreeNode(id: value['id'],
      label: value['label'],
      expand: true,
      selected: false,
      treeLevel: 0,
      children: []);
      dataList.add(treeNode0);
      if (value['children'] != null && value['children'].length > 0){
        value['children'].forEach((value1) {
          TreeNode treeNode1 = TreeNode(id: value1['id'],
              label: value1['label'],
              expand: false,
              selected: false,
              treeLevel: 1,
              children: []);
          treeNode0.children.add(treeNode1);
          if (value1['children'] != null && value1['children'].length > 0){
            value1['children'].forEach((value2) {
              TreeNode treeNode2 = TreeNode(id: value2['id'],
                  label: value2['label'],
                  expand: false,
                  selected: false,
                  treeLevel: 2,
                  children: []);
              treeNode1.children.add(treeNode2);
              if (value2['children'] != null && value2['children'].length > 0) {
                value2['children'].forEach((value3) {
                  TreeNode treeNode3 = TreeNode(id: value3['id'],
                      label: value3['label'],
                      expand: false,
                      selected: false,
                      treeLevel: 3,
                      children: []);
                  treeNode2.children.add(treeNode3);
                  if (value3['children'] != null && value3['children'].length > 0) {
                    value3['children'].forEach((value4) {
                      TreeNode treeNode4 = TreeNode(id: value4['id'],
                          label: value4['label'],
                          expand: false,
                          selected: false,
                          treeLevel: 4,
                          children: []);
                      treeNode3.children.add(treeNode4);
                      if (value4['children'] != null && value4['children'].length > 0) {
                        value4['children'].forEach((value5) {
                          TreeNode treeNode5 = TreeNode(id: value5['id'],
                              label: value5['label'],
                              expand: false,
                              selected: false,
                              treeLevel: 5,
                              children: []);
                          treeNode4.children.add(treeNode5);
                          if (value5['children'] != null && value5['children'].length > 0) {
                            value5['children'].forEach((value6) {
                              TreeNode treeNode6 = TreeNode(id: value6['id'],
                                  label: value6['label'],
                                  expand: false,
                                  selected: false,
                                  treeLevel: 6,
                                  children: []);
                              treeNode5.children.add(treeNode6);
                              if (value6['children'] != null && value6['children'].length > 0) {
                                value6['children'].forEach((value7) {
                                  TreeNode treeNode7 = TreeNode(id: value7['id'],
                                      label: value7['label'],
                                      expand: false,
                                      selected: false,
                                      treeLevel: 7,
                                      children: []);
                                  treeNode6.children.add(treeNode7);
                                  if (value7['children'] != null && value7['children'].length > 0) {
                                    value7['children'].forEach((value8) {
                                      TreeNode treeNode8 = TreeNode(id: value8['id'],
                                          label: value8['label'],
                                          expand: false,
                                          selected: false,
                                          treeLevel: 8,
                                          children: []);
                                      treeNode7.children.add(treeNode8);
                                      if (value8['children'] != null && value8['children'].length > 0) {
                                        value8['children'].forEach((value9) {
                                          TreeNode treeNode9 = TreeNode(id: value9['id'],
                                              label: value9['label'],
                                              expand: false,
                                              selected: false,
                                              treeLevel: 9,
                                              children: []);
                                          treeNode8.children.add(treeNode9);
                                        });
                                      }
                                    });
                                  }
                                });
                              }
                            });
                          }
                        });
                      }
                    });
                  }
                });
              }
            });
          }
        });
      }
    });
    return dataList;
  }
}
