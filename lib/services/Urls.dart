class Urls {
  // 用户基础模块
  // 获取手机验证码
  static const String phoneCode = '/comps/code/createCode';
  // 图片上传
  static const String imgUpload = '/comps/upload';
  // 注册下拉筛选部门列表
  static const String registerDeptList = '/system/dept/treeselect';
  // 注册职业选择列表
  static const String registerPostList = '/system/post/selectlist';
  // APP启动页图片获取
  static const String appStartImg = '/comps/homepage/default';
  // 用户注册接口
  static const String userRegister = '/system/user/register';
  // 登录接口
  static const String userLogin = '/auth/app/login';

  // 客户
  // 新增接口下拉数据接口
  static const String allTypeByCostomer = '/system/dict/type/allTypeByCostomer';
  // 项目模糊搜索接口
  static const String fuzzySearch = '/customer/project/fuzzySearch';
  // 客户新增接口
  static const String addClient = '/customer/customer/insert';
  // 获取客户列表
  static const String clientList = '/customer/customer/keys';
  // 查询字典数据
  static const String searchDic = '/system/dict/type/typeId';
  // 客户详情
  static const String findClientById = '/customer/findById';
  // 获取下次跟进的时间
  static const String findExpectTime = '/customer/findExpectTime';
  // 新增跟进
  static const String addFlow = '/customer/progress/insert';
  // 跟进token获取用户信息
  static const String findUserInfo = '/system/user/findUserInfo';
}
