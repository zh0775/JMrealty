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
  // 获取首页轮播图
  static const String getHomeBanner = '/comps/chart/findRotationList';
  // 获取通知公告列表
  static const String getHomeNotice = '/system/notice/listInfo';
  // app首页【成交喜报】列表
  static const String getGladNotice = '/comps/notice/getNoticeList';
  // 日期范围查询代办事项
  static const String getHomeWaitToDo = '/comps/todo/findByTime';
  // 获取首页菜单
  static const String getHomeMenus = '/system/user/findMenuByUserId';

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
  // 退单
  static const String reportChargeBack = '/customer/status/chargeback';
  // 签约
  static const String reportSignUp = '/customer/status/signUp';
  // 带看
  static const String reportTakelook = '/customer/status/takelook';

  //业绩规划
  // 查询业绩规则列表
  static const String targetRuleList = '/customer/targetRule/list';
  // 修改业绩规则
  static const String targetRuleChange = '/customer/targetRule/edit';
  // 新增业绩规则
  static const String addTargetRule = '/customer/targetRule/add';
  // 删除业绩规则信息
  static String deleteTargetRule(String id) => '/customer/targetRule/$id';

  // 删除业绩规则信息
  static const String deleteTargetRuleById = '/customer/targetRule';

  //PK赛
  // 查询pk赛列表
  static const String pkList = '/comps/race/searchList';
  // 新增pk赛
  static const String addPk = '/comps/race/add';
  // 查询pk赛详情
  static const String pkDetail = '/comps/race/searchList';
  // 查询pk赛详情
  static const String pkTarget = '/system/dict/type/typeId';
  // 查询pk赛详情
  static const String pkMedel = '/comps/medal/findByFuzzySearch';
  // pk赛指标
  static const String pkType = '/system/dict/type/typeId';

  //项目
  // 项目列表
  static const String projectList = '/customer/project/findListByArea';

  //我的任务
  // 我发布的任务列表
  static const String tasksPublishedList = '/comps/task/myPublishedTasks';
  // 我接收的任务列表
  static const String tasksAcceptList = '/comps/task/taskListTome';
  // 新增任务
  static const String tasksAdd = '/comps/task/add';
  // /system/dict/type/typeId?dictId=114
  // 新增任务 下拉 任务类型
  static const String tasksType = '/system/dict/type/typeId?dictId=122';
  // 新增任务 下拉 任务紧急
  static const String tasksUrgency = '/system/dict/type/typeId?dictId=123';

  //消息
  // 消息列表
  static const String messageList = '/comps/notice/selectNoticeList';
  // 消息列表已读
  static const String messageRead = '/comps/notice/readAdd';
  // 消息类型列表
  static const String messageTypeList = '/comps/notice/selectNoticeMessageList';

  // 强制提醒
  static const String findOvertime = '/customer/progress/findOvertime';

  //我的
  // 个人信息 // findUserInfo
  // 员工当前月的目标业绩及完成业绩
  static const String monthTarget = '/comps/employee/find';
  // 修改头像，签名，背景图
  static const String changeUserInfo = '/system/user/updateInfo';
  // 根据员工id 查找等级规则，去设置目标
  static const String queryEmployeeTarget = '/comps/employee/query';
  // 员工设置目标
  static const String employeeSetTarget = '/comps/employee/setTarget';
}
