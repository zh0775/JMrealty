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
  // 获取当前用户信息
  static const String getUserInfo = '/system/user/findUserInfo';

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
  static const String findClientById = '/customer/customer/findById';
  // 获取下次跟进的时间
  static const String findExpectTime = '/customer/customer/findExpectTime';
  // 新增跟进
  static const String addFollow = '/customer/progress/insert';
  // 跟进token获取用户信息
  static const String findUserInfo = '/system/user/findUserInfo';
  // 获取客户池信息
  static const String findCustomerPoolInfo =
      '/customer/customer/findCustomerPoolInfo';
  // 从客户池添加客户到我的客户列表
  static const String takeCustomerInPool = '/customer/customer/customerPool';

  // 报备
  // 项目名称模糊查询
  static const String projectFuzzySearch = '/customer/project/fuzzySearch';
  // 根据名字模糊搜索客户经理
  static const String agentFuzzySearch = '/system/user/vagueUserName';
  // 模糊搜索客户
  static const String clientFuzzySearch = '/customer/customer/search';
  // 新增报备
  static const String addReport = '/customer/report/insert';
  // 报备记录列表
  static const String reportRecordList = '/customer/report/Keys';
  // 报备详情
  static const String reportDetail = '/customer/report/findDetailsById';
  // 上传带看单
  static const String reportUploadRecord = '/customer/status/upload';
  // 已成交
  static const String reportSuccess = '/customer/shop/subscription';

  //业绩规划
  // 查询业绩规则列表
  static const String targetRuleList = '/customer/targetRule/list';
  // 修改业绩规则
  static const String targetRuleChange = '/customer/targetRule/edit';
  // 新增业绩规则
  static const String addTargetRule = '/customer/targetRule/add';
  // 删除业绩规则信息
  static String deleteTargetRule(String id) => '/customer/targetRule/$id';
}
