import 'package:JMrealty/services/Urls.dart';
import 'package:JMrealty/services/http.dart';

class ReportChangeStatusViewModel {
  signUpRequest(Map params, Function(bool success) success) {
    Http().post(
      Urls.reportSignUp,
      params,
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
      },
      fail: (reason, code) {
        if (success != null) {
          success(false);
        }
      },
    );
  }

  reportReceive(Map params, Function(bool success) success) {
    Http().post(
      Urls.reportReceive,
      params,
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
      },
      fail: (reason, code) {
        if (success != null) {
          success(false);
        }
      },
    );
  }

  takelookRequest(Map params, Function(bool success) success) {
    Http().post(
      Urls.reportTakelook,
      params,
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
      },
      fail: (reason, code) {
        if (success != null) {
          success(false);
        }
      },
    );
  }

  chargebackRequest(Map params, Function(bool success) success) {
    Http().post(
      Urls.reportChargeBack,
      params,
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
      },
      fail: (reason, code) {
        if (success != null) {
          success(false);
        }
      },
    );
  }
}
