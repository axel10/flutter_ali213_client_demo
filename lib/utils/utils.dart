import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:intl/intl.dart';
import 'package:youxia/model/user.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:youxia/pages/guide/types/GuideDetail.dart';
import 'package:youxia/pages/login/type/LoginResponse.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:youxia/pages/main/detail/components/commentInput.dart';

class Utils {
  static SharedPreferences _prefs;

  static Future init() async {
    // 获取本地存储管理对象实例
    _prefs = await SharedPreferences.getInstance();
  }

  static SharedPreferences get prefs {
    if (_prefs == null) {
      throw ('未调用Utils.init方法，无法获取SharedPreferences实例');
    }
    return _prefs;
  }

  /// 通过获取当前时间字符串
  static String getCurrentTimeStringByAddTime(addtime, {String format}) {
    int distAddtime = int.parse(addtime.toString());
    var targetTime = getCurrentTimeByAddTime(distAddtime).toUtc();
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

  ///将addtime转换为当前时间
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

  static LoginUserInfo getDefaultLoginUserInfo() {
    return new LoginUserInfo.fromParams(nickname: '未登录', username: '未登录');
  }

  static void setLocalStorage(String key, String value) {
    var prefs = Utils.prefs;
    prefs.setString(key, value);
  }

  static String getLocalStorage(String key) {
//    var prefs = await SharedPreferences.getInstance();
    var prefs = Utils.prefs;
    return prefs.getString(key);
  }

  static bool checkIsLogin(BuildContext context) {
    var model = UserModel.of(context);
    return model.token != null;
  }

  static void showShortToast(String msg) {
    Fluttertoast.showToast(
        msg: msg,
        toastLength: Toast.LENGTH_SHORT,
        gravity: ToastGravity.BOTTOM);
  }

  static void showErrorToast() {
    Fluttertoast.showToast(
        msg: '似乎除了点什么问题...',
        toastLength: Toast.LENGTH_SHORT,
        gravity: ToastGravity.BOTTOM);
  }

  static List<Widget> htmlToWidget(String html) {
    if (html == null || html.isEmpty) {
      return [
        Container(
          height: 0,
        )
      ];
    }

    var reg = new RegExp(r'<(p|span)[\s\S]*?>([\s\S\w]*?)<\/(p|span)>');

    String distHtml = '';
    var matches = reg.allMatches(html);
    for (var o in matches) {
      distHtml += o.group(2).replaceAllMapped(
          new RegExp(r'<img[\s\S].*?data-original="(.*?)"[\s\S].*?/>'),
          (m) => "#%${m[1]}#%");
    }

    distHtml =
        distHtml.replaceAll(new RegExp(r'<script>[\s\S]*?</script>'), '');
    distHtml = distHtml.replaceAll(new RegExp(r'<span[\s\S]*?>'), '');
    distHtml = distHtml.replaceAll(new RegExp(r'</span>'), '');
    distHtml = distHtml.replaceAll(new RegExp(r'<a[\s\S]*?>'), '');
    distHtml = distHtml.replaceAll(new RegExp(r'</a>'), '');
    distHtml = distHtml.replaceAll(new RegExp(r'<iframe[\s\S]*?>'), '');
    distHtml = distHtml.replaceAll(new RegExp(r'<\/iframe>'), '');

    distHtml = distHtml.replaceAll(new RegExp(r'<b[\s\S]*?>'), '');
    distHtml = distHtml.replaceAll(new RegExp(r'<\/b>'), '');
    distHtml = distHtml.replaceAll(new RegExp(r'<font[\s\S]*?>'), '');
    distHtml = distHtml.replaceAll(new RegExp(r'<\/font>'), '');
    distHtml = distHtml.replaceAll(new RegExp(r'<strong[\s\S]*?>'), '');
    distHtml = distHtml.replaceAll(new RegExp(r'<\/strong>'), '');
    distHtml = distHtml.replaceAll(new RegExp(r'<!--[\s\S]*?>'), '');

    distHtml = distHtml.replaceAll(new RegExp(r'&ldquo;'), '“');
    distHtml = distHtml.replaceAll(new RegExp(r'&rdquo;'), '”');

    var strArr = distHtml.split('#%');

    return strArr.map((str) {
      if (str.startsWith('http')) {
        return new Container(
          child: Image.network(
            str,
            fit: BoxFit.cover,
          ),
        );
      }
      return Text(str);
    }).toList();
  }

  static CachedNetworkImage getCacheImage(
      {String imageUrl, BoxFit fit, double width, double height}) {
    return CachedNetworkImage(
      imageUrl: imageUrl,
      fit: fit,
      fadeInDuration: Duration(milliseconds: 300),
      width: width,
      height: height,
    );
  }

  static addInfinityLoadListener(ScrollController scrollController,
      void Function() callback, double offset) {
    scrollController.addListener(() {
      if (scrollController.hasClients &&
          scrollController.position.pixels >
              scrollController.position.maxScrollExtent - offset) {
        callback();
      }
    });
  }

  static Container getEmptyContainer() {
    return Container(
      height: 0,
    );
  }

  static Widget showIfExist(bool exp, Widget child) {
    if (exp) {
      return child;
    } else {
      return Utils.getEmptyContainer();
    }
  }

  static double getScreenWidth(BuildContext context) {
    return MediaQuery.of(context).size.width;
  }

  /// 将数据类型转换为GuideArticleListItem。要求列表item有id和title属性
  static List<GuideArticleListItem> castToGuideArticleListItem(
      List list, String articleId) {
    return list.map((item) {
      GuideArticleListItem.fromParams(
          id: articleId != null ? '${articleId}_${item.id}' : '$item.id',
          title: item.title);
    }).toList();
  }

  static Widget createSectionGap() {
    return Container(
      color: MyColors.backgroundGray,
      height: 10,
    );
  }

  static getRouter({WidgetBuilder builder}) {
    return MaterialPageRoute(builder: builder);
  }

  static List<List<T>> groupData<T>(List list, int count) {
    List<List<T>> res = [];
    var listLen = list.length;
    for (var i = 0; i < listLen / count.ceil(); ++i) {
      var end = i * count + count;
      var pageData =
          list.getRange(i * count, (end) >= listLen ? listLen : end).toList();
      res.add(pageData);
    }
    return res;
  }

  static Future showCommentInput(
      {@required BuildContext context,
      @required String appId,
      @required String articleId,
      @required String articleTitle}) async {
    return showDialog(
        context: context,
        barrierDismissible: true,
        builder: (ctx) {
          return CommentInput(
            id: articleId,
            title: articleTitle,
            appId: appId,
          );
        });
  }
}

class MyColors {
  static Color alphaGray = Color.fromARGB(80, 0, 0, 0);
  static Color backgroundGray = Color.fromARGB(255, 240, 240, 240);
}
