import 'dart:convert';

import 'package:JMrealty/Home/viewModel/HomeViewModel.dart';
import 'package:JMrealty/Login/model/PostListModel.dart';
import 'package:JMrealty/Login/model/login_model.dart';
import 'package:JMrealty/base/base_viewmodel.dart';
import 'package:JMrealty/components/CustomLoading.dart';
import 'package:JMrealty/components/TreeNode.dart';
import 'package:JMrealty/services/Urls.dart';
import 'package:JMrealty/services/http.dart';
import 'package:JMrealty/utils/notify_default.dart';
import 'package:JMrealty/utils/toast.dart';
import 'package:JMrealty/utils/user_default.dart';
import 'package:flutter/foundation.dart';

class LoginViewModel extends BaseViewModel {
  List<Map<String, dynamic>> postDataList = [];
  List<Map<String, dynamic>> depDataList = [];
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
        if (json['code'] == 200) {
          ShowToast.normal('验证码已发送');
          state = BaseState.CONTENT;
        } else {
          if (json['msg'] != null && (json['msg'] as String).length > 0) {
            ShowToast.normal(json['msg']);
          }
          state = BaseState.FAIL;
        }
        notifyListeners();
      },
      fail: (reason, code) {
        state = BaseState.FAIL;
        notifyListeners();
        ShowToast.normal(reason);
      },
      after: () {
        CustomLoading().hide();
      },
    );
  }

  loadRegistPostSelectList({Function(bool success, List postList) success}) {
    state = BaseState.LOADING;
    notifyListeners();
    Http().get(
      Urls.registerPostList,
      {},
      success: (json) {
        if (json['code'] == 200) {
          compute(decodePostListToMapList, json).then((value) {
            postDataList = value;
            if (success != null) {
              success(true, postDataList);
            }
            state = BaseState.CONTENT;
            notifyListeners();
          });
        } else {
          if (success != null) {
            success(false, null);
          }
          state = BaseState.FAIL;
          notifyListeners();
        }
      },
      fail: (reason, code) {
        if (success != null) {
          success(false, null);
        }
        state = BaseState.FAIL;
        notifyListeners();
      },
      after: () {},
    );
  }

  static PostListModel decodePostList(dynamic json) {
    return PostListModel.fromJson(json);
  }

  static List<Map<String, dynamic>> decodePostListToMapList(dynamic json) {
    List<Map<String, dynamic>> dataList = [];
    json['data'].forEach((value) {
      Map<String, dynamic> postModel = {
        'title': value['postName'],
        'value': value['postId']
      };
      dataList.add(postModel);
    });
    return dataList;
  }

  List<TreeNode> treeNodes = [];
  loadRegistDeptSelectList({Function(List<TreeNode> value) success}) {
    state = BaseState.LOADING;
    notifyListeners();
    Http().get(
      Urls.registerDeptList,
      {},
      success: (json) {
        if (json['code'] == 200) {
          treeNodes = [];
          // treeNodeFormat
          treeNodeFormat(0, treeNodes, json['data'] ?? []);
          if (success != null) {
            success(treeNodes);
          }
          state = BaseState.CONTENT;
          notifyListeners();
          // compute(
          //   decodeDepListToList,
          //   json,
          // ).then((value) {
          //   depTreeDataList = value;
          //   if (success != null) {
          //     success(depTreeDataList);
          //   }
          //   state = BaseState.CONTENT;
          //   notifyListeners();
          // });
        } else {
          if (success != null) {
            success(null);
          }
          state = BaseState.FAIL;
          notifyListeners();
        }
      },
      fail: (reason, code) {
        if (success != null) {
          success(null);
        }
        state = BaseState.FAIL;
        notifyListeners();
      },
      after: () {},
    );
  }

  treeNodeFormat(int level, List nodelist, List jsonList) {
    jsonList.forEach((e) {
      TreeNode node = TreeNode(
          id: e['id'],
          label: e['label'],
          expand: true,
          selected: false,
          treeLevel: level,
          children: []);
      nodelist.add(node);
      if (e['children'] != null && e['children'].length > 0) {
        treeNodeFormat((level + 1), node.children, e['children']);
      }
    });
  }

  static List<TreeNode> decodeDepListToList(dynamic json) {
    print('json ==== ${json.runtimeType}');
    List<TreeNode> dataList = [];
    List datas = json['data'];
    if (datas == null) {
      return dataList;
    }
    datas.forEach((value) {
      TreeNode treeNode0 = TreeNode(
          id: value['id'],
          label: value['label'],
          expand: true,
          selected: false,
          treeLevel: 0,
          children: []);
      dataList.add(treeNode0);
      if (value['children'] != null && value['children'].length > 0) {
        value['children'].forEach((value1) {
          TreeNode treeNode1 = TreeNode(
              id: value1['id'],
              label: value1['label'],
              expand: false,
              selected: false,
              treeLevel: 1,
              children: []);
          treeNode0.children.add(treeNode1);
          if (value1['children'] != null && value1['children'].length > 0) {
            value1['children'].forEach((value2) {
              TreeNode treeNode2 = TreeNode(
                  id: value2['id'],
                  label: value2['label'],
                  expand: false,
                  selected: false,
                  treeLevel: 2,
                  children: []);
              treeNode1.children.add(treeNode2);
              if (value2['children'] != null && value2['children'].length > 0) {
                value2['children'].forEach((value3) {
                  TreeNode treeNode3 = TreeNode(
                      id: value3['id'],
                      label: value3['label'],
                      expand: false,
                      selected: false,
                      treeLevel: 3,
                      children: []);
                  treeNode2.children.add(treeNode3);
                  if (value3['children'] != null &&
                      value3['children'].length > 0) {
                    value3['children'].forEach((value4) {
                      TreeNode treeNode4 = TreeNode(
                          id: value4['id'],
                          label: value4['label'],
                          expand: false,
                          selected: false,
                          treeLevel: 4,
                          children: []);
                      treeNode3.children.add(treeNode4);
                      if (value4['children'] != null &&
                          value4['children'].length > 0) {
                        value4['children'].forEach((value5) {
                          TreeNode treeNode5 = TreeNode(
                              id: value5['id'],
                              label: value5['label'],
                              expand: false,
                              selected: false,
                              treeLevel: 5,
                              children: []);
                          treeNode4.children.add(treeNode5);
                          if (value5['children'] != null &&
                              value5['children'].length > 0) {
                            value5['children'].forEach((value6) {
                              TreeNode treeNode6 = TreeNode(
                                  id: value6['id'],
                                  label: value6['label'],
                                  expand: false,
                                  selected: false,
                                  treeLevel: 6,
                                  children: []);
                              treeNode5.children.add(treeNode6);
                              if (value6['children'] != null &&
                                  value6['children'].length > 0) {
                                value6['children'].forEach((value7) {
                                  TreeNode treeNode7 = TreeNode(
                                      id: value7['id'],
                                      label: value7['label'],
                                      expand: false,
                                      selected: false,
                                      treeLevel: 7,
                                      children: []);
                                  treeNode6.children.add(treeNode7);
                                  if (value7['children'] != null &&
                                      value7['children'].length > 0) {
                                    value7['children'].forEach((value8) {
                                      TreeNode treeNode8 = TreeNode(
                                          id: value8['id'],
                                          label: value8['label'],
                                          expand: false,
                                          selected: false,
                                          treeLevel: 8,
                                          children: []);
                                      treeNode7.children.add(treeNode8);
                                      if (value8['children'] != null &&
                                          value8['children'].length > 0) {
                                        value8['children'].forEach((value9) {
                                          TreeNode treeNode9 = TreeNode(
                                              id: value9['id'],
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

  requestRegist(RegistModel model) {
    state = BaseState.LOADING;
    notifyListeners();
    Http().post(
      Urls.userRegister,
      {},
      success: (json) {
        compute(decodeDepListToList, json).then((value) {
          state = BaseState.CONTENT;
          notifyListeners();
        });
      },
      fail: (reason, code) {
        state = BaseState.FAIL;
      },
      after: () {},
    );
  }

  requestLogin(String phone, String code, void Function(bool success) success) {
    state = BaseState.LOADING;
    notifyListeners();
    Http().post(
      Urls.userLogin,
      // {'phonenumber': phone, 'code': code},
      {'phonenumber': phone, 'password': code},
      success: (json) {
        Map<String, dynamic> data = json['data'];
        if (json['code'] == 200 && data[ACCESS_TOKEN] != null) {
          state = BaseState.CONTENT;
          UserDefault.saveStr(ACCESS_TOKEN, data[ACCESS_TOKEN])
              .then((bool value) {
            if (value) {
              success(true);
              HomeViewModel().loadUserInfo();
            }
          });
        } else {
          state = BaseState.FAIL;
          success(false);
          if (json['msg'] != null && (json['msg'] as String).length > 0) {
            ShowToast.normal(json['msg']);
          }
        }
        notifyListeners();
      },
      fail: (reason, code) {
        // print('reason ==== $reason --- code === $code');
        state = BaseState.FAIL;
        notifyListeners();
        success(false);
      },
      after: () {},
    );
  }

  userForgetPwd(Map params, Function(bool success) success) {
    Http().post(
      Urls.userForgetPwd,
      Map<String, dynamic>.from(params),
      success: (json) {
        if (json['code'] == 200) {
          if (success != null) {
            success(true);
          }
        } else {
          if (success != null) {
            success(false);
          }
        }
        if (json['msg'] != null && (json['msg'] as String).length > 0) {
          ShowToast.normal(json['msg']);
        } else if (json['data'] != null &&
            json['data'] is String &&
            (json['data'] as String).length > 0) {
          ShowToast.normal(json['data']);
        }
      },
      fail: (reason, code) {
        if (success != null) {
          success(false);
        }
      },
    );
  }
}
