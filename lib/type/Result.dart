import 'dart:convert' show json;

/// 一般响应，包含状态码和消息
class Result {

  int status;
  String msg;

  Result.fromParams({this.status, this.msg});

  factory Result(jsonStr) => jsonStr == null ? null : jsonStr is String ? new Result.fromJson(json.decode(jsonStr)) : new Result.fromJson(jsonStr);

  Result.fromJson(jsonRes) {
    status = jsonRes['status'];
    msg = jsonRes['msg'];
  }

  @override
  String toString() {
    return '{"status": $status,"msg": ${msg != null?'${json.encode(msg)}':'null'}}';
  }
}

