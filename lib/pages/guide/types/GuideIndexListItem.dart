import 'dart:convert' show json;

class GuideIndexListItem {
  String addtime;
  String id;
  String img;
  String title;

  GuideIndexListItem.fromParams({this.addtime, this.id, this.img, this.title});

  factory GuideIndexListItem(jsonStr) => jsonStr == null ? null : jsonStr is String ? new GuideIndexListItem.fromJson(json.decode(jsonStr)) : new GuideIndexListItem.fromJson(jsonStr);

  GuideIndexListItem.fromJson(jsonRes) {
    addtime = jsonRes['addtime'];
    id = jsonRes['id'];
    img = jsonRes['img'];
    title = jsonRes['title'];
  }

  @override
  String toString() {
    return '{"addtime": ${addtime != null?'${json.encode(addtime)}':'null'},"id": ${id != null?'${json.encode(id)}':'null'},"img": ${img != null?'${json.encode(img)}':'null'},"title": ${title != null?'${json.encode(title)}':'null'}}';
  }
}

