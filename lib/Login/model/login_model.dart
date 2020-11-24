import 'package:JMrealty/base/base_model.dart';

class LoginModel extends BaseModel {}

class RegistModel {
  int deptId; // 部门ID
  String nickName; // 姓名
  int sex; // 性别
  String avatar; // 头像地址
  String phonenumber; // 手机号
  int position; // 岗位ID
  String code; // 验证码
}
