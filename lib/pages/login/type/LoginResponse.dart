import 'dart:convert' show json;

class LoginResponse {

  int status;
  String msg;
  LoginResponseData data;

  LoginResponse.fromParams({this.status, this.msg, this.data});

  factory LoginResponse(jsonStr) => jsonStr == null ? null : jsonStr is String ? new LoginResponse.fromJson(json.decode(jsonStr)) : new LoginResponse.fromJson(jsonStr);

  LoginResponse.fromJson(jsonRes) {
    status = jsonRes['status'];
    msg = jsonRes['msg'];
    data = jsonRes['data'] == false ? null : new LoginResponseData.fromJson(jsonRes['data']);
  }

  @override
  String toString() {
    return '{"status": $status,"msg": ${msg != null?'${json.encode(msg)}':'null'},"data": $data}';
  }
}

class LoginResponseData {

  String script;
  String token;
  LoginUserInfo userinfo;

  LoginResponseData.fromParams({this.script, this.token, this.userinfo});

  LoginResponseData.fromJson(jsonRes) {
    script = jsonRes['script'];
    token = jsonRes['token'];
    userinfo = jsonRes['userinfo'] == null ? null : new LoginUserInfo.fromJson(jsonRes['userinfo']);
  }

  @override
  String toString() {
    return '{"script": ${script != null?'${json.encode(script)}':'null'},"token": ${token != null?'${json.encode(token)}':'null'},"userinfo": $userinfo}';
  }
}

class LoginUserInfo {

  int gender;
  bool renamable;
  String avatar;
  String birth;
  String email;
  String mobile;
  String nickname;
  String uid;
  String username;

  LoginUserInfo.fromParams({this.gender, this.renamable, this.avatar, this.birth, this.email, this.mobile, this.nickname, this.uid, this.username});

  LoginUserInfo.fromJson(jsonRes) {
    gender = jsonRes['gender'];
    renamable = jsonRes['renamable'];
    avatar = jsonRes['avatar'];
    birth = jsonRes['birth'];
    email = jsonRes['email'];
    mobile = jsonRes['mobile'];
    nickname = jsonRes['nickname'];
    uid = jsonRes['uid'];
    username = jsonRes['username'];
  }

  @override
  String toString() {
    return '{"gender": $gender,"renamable": $renamable,"avatar": ${avatar != null?'${json.encode(avatar)}':'null'},"birth": ${birth != null?'${json.encode(birth)}':'null'},"email": ${email != null?'${json.encode(email)}':'null'},"mobile": ${mobile != null?'${json.encode(mobile)}':'null'},"nickname": ${nickname != null?'${json.encode(nickname)}':'null'},"uid": ${uid != null?'${json.encode(uid)}':'null'},"username": ${username != null?'${json.encode(username)}':'null'}}';
  }
}

