import 'dart:convert';

import 'package:youxia/pages/login/type/LoginResponse.dart';
import 'package:youxia/type/UpdateTokenResponse.dart';
import 'package:youxia/type/UserInfo.dart';
import 'package:youxia/utils/config.dart';
import 'package:youxia/utils/request.dart';
import 'package:youxia/utils/utils.dart';
import 'package:crypto/crypto.dart';

class UserService {
  static Future<LoginResponse> login({String username, String password}) async {
    var time = Utils.getTimeToken();
    var privateKey = r"BGg)K6ng4?&x9sCIuO%C2%{@TJ?fnFJ,bZKy/[/EWnw9UsC$@1";

    String signature = md5
        .convert(utf8.encode('username-$username-time-$time-passwd-$password'
            '-from-feedearn-action-login$privateKey'))
        .toString();
    var qs = '?action=login'
        '&username=$username&passwd=$password&from=feedearn&time=$time'
        '&signature=$signature';
    var result = await Request.get('http://i.ali213.net/api.html$qs');
    return LoginResponse(result);
  }

  /// 更新token
  static Future<UpdateTokenResponse> updateToken({String oldToken}) async {
    return UpdateTokenResponse(await Request.get(
        'https://api3.ali213.net/feedearn/checktoken?token=$oldToken'));
  }

  ///通过存储在本地的token获得用户信息。
  static Future<UserInfo> getUserInfo() async {
    var token = await Utils.getLocalStorage(Config.USER_TOKEN_KEY);
    if(token==null){
      return null;
    }
    return UserInfo(
        await Request.get('https://api3.ali213.net/feedearn/userinfo?token=$token'));
  }
}
