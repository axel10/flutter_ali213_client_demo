import 'dart:convert' show json;

class UpdateTokenResponse {

  int status;
  String token;

  UpdateTokenResponse.fromParams({this.status, this.token});

  factory UpdateTokenResponse(jsonStr) => jsonStr == null ? null : jsonStr is String ? new UpdateTokenResponse.fromJson(json.decode(jsonStr)) : new UpdateTokenResponse.fromJson(jsonStr);

  UpdateTokenResponse.fromJson(jsonRes) {
    status = jsonRes['status'];
    token = jsonRes['token'];
  }

  @override
  String toString() {
    return '{"status": $status,"token": ${token != null?'${json.encode(token)}':'null'}}';
  }
}

