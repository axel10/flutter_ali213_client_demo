import 'dart:convert' show json;

class CommentData {

  int status;
  String msg;
  List<Comment> data;

  CommentData.fromParams({this.status, this.msg, this.data});

  factory CommentData(jsonStr) => jsonStr == null ? null : jsonStr is String ? new CommentData.fromJson(json.decode(jsonStr)) : new CommentData.fromJson(jsonStr);

  CommentData.fromJson(jsonRes) {
    status = jsonRes['status'];
    msg = jsonRes['msg'];
    data = jsonRes['data'] == null || jsonRes['data'] == false ? null : [];

    for (var dataItem in data == null ? [] : jsonRes['data']){
      data.add(dataItem == null ? null : new Comment.fromJson(dataItem));
    }
  }

  @override
  String toString() {
    return '{"status": $status,"msg": ${msg != null?'${json.encode(msg)}':'null'},"data": $data}';
  }
}

class Comment {

  Object xbhf;
  String addtime;
  String avatar;
  String cai;
  String changyanuserid;
  String comment;
  String ding;
  String hf_id;
  String id;
  String ip;
  String ip_address;
  String parentid;
  String platform;
  String username;
  CommentContent content;

  Comment.fromParams({this.xbhf, this.addtime, this.avatar, this.cai, this.changyanuserid, this.comment, this.ding, this.hf_id, this.id, this.ip, this.ip_address, this.parentid, this.platform, this.username, this.content});

  Comment.fromJson(jsonRes) {
    xbhf = jsonRes['xbhf'];
    addtime = jsonRes['addtime'];
    avatar = jsonRes['avatar'];
    cai = jsonRes['cai'];
    changyanuserid = jsonRes['changyanuserid'];
    comment = jsonRes['comment'];
    ding = jsonRes['ding'];
    hf_id = jsonRes['hf_id'];
    id = jsonRes['id'];
    ip = jsonRes['ip'];
    ip_address = jsonRes['ip_address'];
    parentid = jsonRes['parentid'];
    platform = jsonRes['platform'];
    username = jsonRes['username'];
    content = jsonRes['content'] == null ? null : new CommentContent.fromJson(jsonRes['content']);
  }

  @override
  String toString() {
    return '{"xbhf": $xbhf,"addtime": ${addtime != null?'${json.encode(addtime)}':'null'},"avatar": ${avatar != null?'${json.encode(avatar)}':'null'},"cai": ${cai != null?'${json.encode(cai)}':'null'},"changyanuserid": ${changyanuserid != null?'${json.encode(changyanuserid)}':'null'},"comment": ${comment != null?'${json.encode(comment)}':'null'},"ding": ${ding != null?'${json.encode(ding)}':'null'},"hf_id": ${hf_id != null?'${json.encode(hf_id)}':'null'},"id": ${id != null?'${json.encode(id)}':'null'},"ip": ${ip != null?'${json.encode(ip)}':'null'},"ip_address": ${ip_address != null?'${json.encode(ip_address)}':'null'},"parentid": ${parentid != null?'${json.encode(parentid)}':'null'},"platform": ${platform != null?'${json.encode(platform)}':'null'},"username": ${username != null?'${json.encode(username)}':'null'},"content": $content}';
  }
}

class CommentContent {

  String main;
  List<dynamic> hf;

  CommentContent.fromParams({this.main, this.hf});

  CommentContent.fromJson(jsonRes) {
    main = jsonRes['main'];
    hf = jsonRes['hf'] == null ? null : [];

    for (var hfItem in hf == null ? [] : jsonRes['hf']){
      hf.add(hfItem);
    }
  }

  @override
  String toString() {
    return '{"main": ${main != null?'${json.encode(main)}':'null'},"hf": $hf}';
  }
}

