import 'dart:convert' show json;

class NewsData {
  int status;
  List<Flash> flash;
  List<NewsItem> list;
  NewsData.fromParams({this.status, this.flash, this.list});

  factory NewsData(jsonStr) => jsonStr == null ? null : jsonStr is String ? new NewsData.fromJson(json.decode(jsonStr)) : new NewsData.fromJson(jsonStr);

  NewsData.fromJson(jsonRes) {
    status = jsonRes['status'];
    flash = jsonRes['flash'] == null ? null : [];

    for (var flashItem in flash == null ? [] : jsonRes['flash']){
      flash.add(flashItem == null ? null : new Flash.fromJson(flashItem));
    }

    list = jsonRes['list'] == null ? null : [];

    for (var listItem in list == null ? [] : jsonRes['list']){
      list.add(listItem == null ? null : new NewsItem.fromJson(listItem));
    }
  }

  @override
  String toString() {
    return '{"status": $status,"flash": $flash,"list": $list}';
  }
}

class NewsItem {

  String commentnum;
  String id;
  String mid;
  String modelid;
  String name;
  String nid;
  String pic;
  String pic1;
  String pic2;
  String pic3;
  String sid;
  String time;
  String title;
  NewsItem.fromParams({this.commentnum, this.id, this.mid, this.modelid, this.name, this.nid, this.pic, this.sid, this.time, this.title});
  NewsItem.fromJson(jsonRes) {
    commentnum = jsonRes['commentnum'];
    id = jsonRes['id'];
    mid = jsonRes['mid'];
    modelid = jsonRes['modelid'];
    name = jsonRes['name'];
    nid = jsonRes['nid'];
    pic = jsonRes['pic'];
    pic1 = jsonRes['pic1'];
    pic2 = jsonRes['pic2'];
    pic3 = jsonRes['pic3'];
    sid = jsonRes['sid'];
    time = jsonRes['time'];
    title = jsonRes['title'];
  }

  @override
  String toString() {
    return '{"commentnum": ${commentnum != null?'${json.encode(commentnum)}':'null'},"id": ${id != null?'${json.encode(id)}':'null'},"mid": ${mid != null?'${json.encode(mid)}':'null'},"modelid": ${modelid != null?'${json.encode(modelid)}':'null'},"name": ${name != null?'${json.encode(name)}':'null'},"nid": ${nid != null?'${json.encode(nid)}':'null'},"pic": ${pic != null?'${json.encode(pic)}':'null'},"sid": ${sid != null?'${json.encode(sid)}':'null'},"time": ${time != null?'${json.encode(time)}':'null'},"title": ${title != null?'${json.encode(title)}':'null'}}';
  }
}

class Flash {

  String id;
  String mid;
  String modelid;
  String name;
  String nid;
  String pic;
  String title;
  String type;
  String url;

  Flash.fromParams({this.id, this.mid, this.modelid, this.name, this.nid, this.pic, this.title, this.type, this.url});

  Flash.fromJson(jsonRes) {
    id = jsonRes['id'];
    mid = jsonRes['mid'];
    modelid = jsonRes['modelid'];
    name = jsonRes['name'];
    nid = jsonRes['nid'];
    pic = jsonRes['pic'];
    title = jsonRes['title'];
    type = jsonRes['type'];
    url = jsonRes['url'];
  }

  @override
  String toString() {
    return '{"id": ${id != null?'${json.encode(id)}':'null'},"mid": ${mid != null?'${json.encode(mid)}':'null'},"modelid": ${modelid != null?'${json.encode(modelid)}':'null'},"name": ${name != null?'${json.encode(name)}':'null'},"nid": ${nid != null?'${json.encode(nid)}':'null'},"pic": ${pic != null?'${json.encode(pic)}':'null'},"title": ${title != null?'${json.encode(title)}':'null'},"type": ${type != null?'${json.encode(type)}':'null'},"url": ${url != null?'${json.encode(url)}':'null'}}';
  }
}

