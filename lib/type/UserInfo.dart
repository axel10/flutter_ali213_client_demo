import 'dart:convert' show json;

class UserInfo {

  int available;
  int coins;
  int follower;
  int history;
  int money;
  int total;
  int unavailable;
  String birth;
  String historycoins;
  String mobile;
  String nickname;
  String qqstatus;
  String sharecode;
  String username;
  String validfollowersnum;

  UserInfo.fromParams({this.available, this.coins, this.follower, this.history, this.money, this.total, this.unavailable, this.birth, this.historycoins, this.mobile, this.nickname, this.qqstatus, this.sharecode, this.username, this.validfollowersnum});

  factory UserInfo(jsonStr) => jsonStr == null ? null : jsonStr is String ? new UserInfo.fromJson(json.decode(jsonStr)) : new UserInfo.fromJson(jsonStr);

  UserInfo.fromJson(jsonRes) {
    available = jsonRes['available'];
    coins = jsonRes['coins'];
    follower = jsonRes['follower'];
    history = jsonRes['history'];
    money = jsonRes['money'];
    total = jsonRes['total'];
    unavailable = jsonRes['unavailable'];
    birth = jsonRes['birth'];
    historycoins = jsonRes['historycoins'];
    mobile = jsonRes['mobile'];
    nickname = jsonRes['nickname'];
    qqstatus = jsonRes['qqstatus'];
    sharecode = jsonRes['sharecode'];
    username = jsonRes['username'];
    validfollowersnum = jsonRes['validfollowersnum'];
  }

  @override
  String toString() {
    return '{"available": $available,"coins": $coins,"follower": $follower,"history": $history,"money": $money,"total": $total,"unavailable": $unavailable,"birth": ${birth != null?'${json.encode(birth)}':'null'},"historycoins": ${historycoins != null?'${json.encode(historycoins)}':'null'},"mobile": ${mobile != null?'${json.encode(mobile)}':'null'},"nickname": ${nickname != null?'${json.encode(nickname)}':'null'},"qqstatus": ${qqstatus != null?'${json.encode(qqstatus)}':'null'},"sharecode": ${sharecode != null?'${json.encode(sharecode)}':'null'},"username": ${username != null?'${json.encode(username)}':'null'},"validfollowersnum": ${validfollowersnum != null?'${json.encode(validfollowersnum)}':'null'}}';
  }
}

