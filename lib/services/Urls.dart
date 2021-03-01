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
  // 忘记密码接口
  static const String userForgetPwd = '/system/user/forget';

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
  // 日期范围查询待办事项
  static const String getHomeWaitToDo = '/comps/todo/findByTime';
  // 待办事项-根据时间段查询待办事项情况
  static const String allTodoHandler = '/comps/todo/allTodoHandler';

  // 获取首页菜单
  static const String getHomeMenus = '/system/user/findMenuByUserId';
  // 查询部门是省，市，区 所有信息集合
  static const String getDepCityList =
      '/system/deptDetail/deptDetailIsCtiyList';

  // 客户
  // 新增接口下拉数据接口
  static const String allTypeByCostomer = '/system/dict/type/allTypeByCostomer';
  // 项目模糊搜索接口
  static const String fuzzySearch = '/customer/project/fuzzySearch';
  // 客户新增接口
  static const String addClient = '/customer/customer/insert';
  // 修改客户信息
  static const String editClient = '/customer/customer/edit';
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
  // 员工把客户放入客户池
  static const String customToPoll = '/customer/customer/increaseCustomerPool';

  // 获取当天待跟进的客户数量
  static const String countProgress = '/customer/progress/countProgress';
  // 获取待接收的报备数量
  static const String selectReportCountByStatus =
      'customer/report/selectReportCountByStatus';

  // 强制提醒获取接口
  static const String findOvertime = '/customer/progress/findOvertime';
  // 报备
  // 项目名称模糊查询
  static const String projectFuzzySearch = '/customer/project/fuzzySearch';
  // 报备列表项目筛选

  static const String reportListProjectFilter =
      '/customer/project/findListByRole';
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
  // 接收
  static const String reportReceive = 'customer/status/receive';
  // 已成交
  static const String reportSuccess = '/customer/shop/subscription';
  // 退单
  static const String reportChargeBack = '/customer/status/chargeback';
  // 失效
  static const String reportInvalid = '/customer/status/invalid';
  // 签约
  static const String reportSignUp = '/customer/status/signUp';
  // 争议
  static const String reportDispute = '/customer/status/dispute';
  // 结佣
  static const String reportMakingCommission =
      '/customer/status/makingCommission';
  // 预约和成交确认接口
  static const String waitForConfirmation =
      '/customer/status/waitForConfirmation';

  // 预约
  static const String reportAppointment = '/customer/status/makeAppointment';
  // 带看
  static const String reportTakelook = '/customer/status/takelook';
  // 复制
  static const String reportCopy = '/customer/report/copyReport';
  // 智能报备
  static const String smartReport = '/customer/report/intelligenceReport';
  // 跟进项目ID查询联系人列表（不分页）
  static const String projectContact =
      '/customer/projectContact/findByProjectId';

  //业绩规划
  // 查询业绩规则列表
  static const String targetRuleList = '/comps/targetRule/list';
  // 修改业绩规则
  static const String targetRuleChange = '/comps/targetRule/edit';
  // 新增业绩规则
  static const String addTargetRule = '/comps/targetRule/add';
  // 删除业绩规则信息
  static String deleteTargetRule(String id) => '/comps/targetRule/$id';

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
  // PK赛 获取奖章信息
  static const String getMedal = '/comps/race/getMedal';

  //项目
  // 项目列表
  static const String projectList = '/customer/project/findListByArea';
  // 获取本部门所属的省市区
  static const String findDeptDetailIsListByDeptIp =
      '/system/deptDetail/findDeptDetailIsListByDeptIp';
  // 获取本部门所属的省市区
  static const String deptDetailIsCtiyList =
      '/system/deptDetail/deptDetailIsCtiyList';
  // app 获取市级下的所有区域
  static const String areaByToken = '/system/area/AreaByToken';
  // 查询省市级地区列表
  static const String getAreaList = '/system/area/list';

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
  // 修改任务状态
  static const String changeTaskStatus = '/comps/task/taskStatus';

  //消息
  // 消息列表
  static const String messageList = '/comps/notice/selectNoticeList';
  // 消息列表已读
  static const String messageRead = '/comps/notice/readAdd';
  // 消息类型列表
  static const String messageTypeList = '/comps/notice/selectNoticeMessageList';

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
  // 修改签名
  static const String updateSign = '/system/user/updateSign';
  // 奖章列表
  static const String medalList = '/comps/detail/findByUserId';

  // 退出登录
  static const String logout = '/auth/logout';
  // 离职
  static const String dimission = '/system/user/quit';
}
