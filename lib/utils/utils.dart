import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:youxia/model/user.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:youxia/type/UserInfo.dart';

class Utils {
  /// 获取当前时间字符串
  static String getCurrentTimeStringByAddTime(int millSecond, {String format}) {
    var targetTime = getCurrentTimeByAddTime(millSecond).toUtc();
    if (format != null) {
      return DateFormat(format).format(targetTime);
    }
    var utcNow = DateTime.now().toUtc();
    var dif = utcNow.difference(targetTime);
    return (dif.inMinutes < 60
        ? dif.inMinutes <= 1 ? '1分钟前' : dif.inMinutes.toString() + '分钟前'
        : dif.inHours < 24
            ? dif.inHours.toString() + '小时前'
            : DateFormat('yyyy-MM-dd').format(targetTime));
  }

  static DateTime getCurrentTimeByAddTime(int millSecond) {
    var oTime = DateTime.utc(1970);
//    var oTime = DateTime.utc(1970,1,1);
    return oTime.add(Duration(seconds: millSecond));
  }

  /// 获取现在到utc 1970-01-01的秒数
  static int getTimeToken() {
    var oTime = DateTime.utc(1970);
    return DateTime.now().toUtc().difference(oTime).inSeconds;
//    return oTime.difference().inSeconds;
  }

  /// 传入widget，添加点击后导航到相应页面的InkWall，返回包装后的widget
  static Widget navigateTo(
      {@required BuildContext context,
      @required Widget child,
      @required Route route,
      Function callback}) {
    return InkWell(
      child: child,
      onTap: () {
//        Navigator.push(context, MaterialPageRoute(builder: builder));
        Navigator.push(context, route).then(callback);
      },
    );
  }

  static Widget createYXAppBar({String title = '', List<Widget> actions}) {
    return new PreferredSize(
        child: new AppBar(
          actions: actions,
          iconTheme: IconThemeData(color: Colors.black),
          title: Text(title),
          backgroundColor: Colors.white,
          elevation: 0.0,
          bottom: PreferredSize(
              child: Container(
                height: 1,
                color: Colors.grey,
              ),
              preferredSize: Size.fromHeight(1.0)),
        ),
        preferredSize: Size.fromHeight(50));
  }

  static UserInfo getDefaultUser() {
    return new UserInfo.fromParams(
        nickname: '未登录',username: '未登录');
  }

  static void setLocalStorage(String key, String value) async {
    var prefs = await SharedPreferences.getInstance();
    prefs.setString(key, value);
  }

  static Future<String> getLocalStorage(String key) async {
    var prefs = await SharedPreferences.getInstance();
    return prefs.getString(key);
  }

  static bool checkIsLogin(BuildContext context) {
    var model = UserModel.of(context);
    return model.token != null;
  }
}
