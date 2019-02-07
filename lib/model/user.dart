import 'package:flutter/material.dart';
import 'package:scoped_model/scoped_model.dart';
import 'package:youxia/pages/login/type/LoginResponse.dart';
import 'package:youxia/type/UserInfo.dart';

class UserModel extends Model {
  String token;
  String avatar;
  LoginUserInfo loginUserInfo;
  UserInfo userInfo;

  void setAvatar(String avatar){
    this.avatar = avatar;
    notifyListeners();
  }

  void setLoginUserInfo(LoginUserInfo userInfo){
    this.loginUserInfo = userInfo;
    notifyListeners();
  }

  void setUserInfo(UserInfo userInfo){
    this.userInfo = userInfo;
    notifyListeners();
  }

  void setToken(String token){
    this.token = token;
    notifyListeners();
  }

  static UserModel of(BuildContext context) =>
      ScopedModel.of<UserModel>(context);
}
