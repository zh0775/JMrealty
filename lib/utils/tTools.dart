import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

/// 手机号正则表达式->true匹配
bool isMobilePhoneNumber(String value) {
  RegExp mobile = new RegExp(r"(0|86|17951)?(1[0-9][0-9])[0-9]{8}");

  return mobile.hasMatch(value);
}

///验证网页URl
bool isUrl(String value) {
  RegExp url = new RegExp(r"^((https|http|ftp|rtsp|mms)?:\/\/)[^\s]+");

  return url.hasMatch(value);
}

///校验身份证
bool isIdCard(String value) {
  RegExp identity = new RegExp(r"\d{17}[\d|x]|\d{15}");

  return identity.hasMatch(value);
}

///正浮点数
bool isMoney(String value) {
  RegExp identity = new RegExp(
      r"^(([0-9]+\.[0-9]*[1-9][0-9]*)|([0-9]*[1-9][0-9]*\.[0-9]+)|([0-9]*[1-9][0-9]*))$");
  return identity.hasMatch(value);
}

///校验中文
bool isChinese(String value) {
  RegExp identity = new RegExp(r"[\u4e00-\u9fa5]");

  return identity.hasMatch(value);
}

///校验支付宝名称
bool isAliPayName(String value) {
  RegExp identity = new RegExp(r"[\u4e00-\u9fa5_a-zA-Z]");

  return identity.hasMatch(value);
}

/// 字符串不为空
bool strNoEmpty(String value) {
  if (value == null) return false;

  return value.trim().isNotEmpty;
}

/// 字符串不为空
bool mapNoEmpty(Map value) {
  if (value == null) return false;
  return value.isNotEmpty;
}

///判断List是否为空
bool listNoEmpty(List list) {
  if (list == null) return false;

  if (list.length == 0) return false;

  return true;
}

/// 判断是否网络
bool isNetWorkImg(String img) {
  return img.startsWith('http') || img.startsWith('https');
}

/// 判断是否资源图片
bool isAssetsImg(String img) {
  return img.startsWith('asset') || img.startsWith('assets');
}

double getMemoryImageCashe() {
  return PaintingBinding.instance.imageCache.maximumSize / 1000;
}

void clearMemoryImageCache() {
  PaintingBinding.instance.imageCache.clear();
}

String stringAsFixed(value, num) {
  double v = double.parse(value.toString());
  String str = ((v * 100).floor() / 100).toStringAsFixed(2);
  return str;
}

String hiddenPhone(String phone) {
  String result = '';

  if (phone != null && phone.length >= 11) {
    String sub = phone.substring(0, 3);
    String end = phone.substring(8, 11);
    result = '$sub****$end';
  }

  return result;
}

///去除后面的0
String stringDisposeWithDouble(v, [fix = 2]) {
  double b = double.parse(v.toString());
  String vStr = b.toStringAsFixed(fix);
  int len = vStr.length;
  for (int i = 0; i < len; i++) {
    if (vStr.contains('.') && vStr.endsWith('0')) {
      vStr = vStr.substring(0, vStr.length - 1);
    } else {
      break;
    }
  }

  if (vStr.endsWith('.')) {
    vStr = vStr.substring(0, vStr.length - 1);
  }

  return vStr;
}

///去除小数点
String removeDot(v) {
  String vStr = v.toString().replaceAll('.', '');

  return vStr;
}

class DateTimeForMater {
  static String full = "yyyy-MM-dd HH:mm:ss";

  static String formatDateV(DateTime dateTime, {bool isUtc, String format}) {
    if (dateTime == null) return "";
    format = format ?? full;
    if (format.contains("yy")) {
      String year = dateTime.year.toString();
      if (format.contains("yyyy")) {
        format = format.replaceAll("yyyy", year);
      } else {
        format = format.replaceAll(
            "yy", year.substring(year.length - 2, year.length));
      }
    }

    format = _comFormat(dateTime.month, format, 'M', 'MM');
    format = _comFormat(dateTime.day, format, 'd', 'dd');
    format = _comFormat(dateTime.hour, format, 'H', 'HH');
    format = _comFormat(dateTime.minute, format, 'm', 'mm');
    format = _comFormat(dateTime.second, format, 's', 'ss');
    format = _comFormat(dateTime.millisecond, format, 'S', 'SSS');

    return format;
  }

  static String _comFormat(
      int value, String format, String single, String full) {
    if (format.contains(single)) {
      if (format.contains(full)) {
        format =
            format.replaceAll(full, value < 10 ? '0$value' : value.toString());
      } else {
        format = format.replaceAll(single, value.toString());
      }
    }
    return format;
  }
}

String formatTimeStampToString(timestamp, [format]) {
  assert(timestamp != null);

  int time = 0;

  if (timestamp is int) {
    time = timestamp;
  } else {
    time = int.parse(timestamp.toString());
  }

  if (format == null) {
    format = 'yyyy-MM-dd HH:mm:ss';
  }

  DateFormat dateFormat = new DateFormat(format);

  var date = new DateTime.fromMillisecondsSinceEpoch(time * 1000);

  return dateFormat.format(date);
}

String timeHandle(int time) {
  double createTimeDouble = strNoEmpty('$time') ? time / 1000 : 0;
  int createTime = int.parse('${stringDisposeWithDouble(createTimeDouble)}');
  return '${formatTimeStampToString(createTime) ?? '未知'}';
}