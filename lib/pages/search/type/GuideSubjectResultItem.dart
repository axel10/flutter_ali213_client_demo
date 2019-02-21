import 'dart:convert' show json;

class GuideSubjectResultItem {

  String addtime;
  String glzoid;
  String img;
  String keyword;
  String title;

  GuideSubjectResultItem.fromParams({this.addtime, this.glzoid, this.img, this.keyword, this.title});

  factory GuideSubjectResultItem(jsonStr) => jsonStr == null ? null : jsonStr is String ? new GuideSubjectResultItem.fromJson(json.decode(jsonStr)) : new GuideSubjectResultItem.fromJson(jsonStr);

  GuideSubjectResultItem.fromJson(jsonRes) {
    addtime = jsonRes['addtime'];
    glzoid = jsonRes['glzoid'];
    img = jsonRes['img'];
    keyword = jsonRes['keyword'];
    title = jsonRes['title'];
  }

  @override
  String toString() {
    return '{"addtime": ${addtime != null?'${json.encode(addtime)}':'null'},"glzoid": ${glzoid != null?'${json.encode(glzoid)}':'null'},"img": ${img != null?'${json.encode(img)}':'null'},"keyword": ${keyword != null?'${json.encode(keyword)}':'null'},"title": ${title != null?'${json.encode(title)}':'null'}}';
  }
}

