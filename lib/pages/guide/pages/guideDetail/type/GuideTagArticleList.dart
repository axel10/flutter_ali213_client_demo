import 'dart:convert' show json;

import 'package:youxia/pages/guide/types/GuideDetail.dart';

class GuideTagArticleListData {

  String id;
  String oid;
  String keyword;
  String name;
  String oname;
  String seo_keyword;
  String seo_title;
  List<dynamic> BjTj;
  List<GuideArticleListItem> HotGl;
  List<GuideTag> HotTag;
  List<GuideArticleListItem> NewGl;

  GuideTagArticleListData.fromParams({this.id, this.oid, this.keyword, this.name, this.oname, this.seo_keyword, this.seo_title, this.BjTj, this.HotGl, this.HotTag, this.NewGl});

  factory GuideTagArticleListData(jsonStr) => jsonStr == null ? null : jsonStr is String ? new GuideTagArticleListData.fromJson(json.decode(jsonStr)) : new GuideTagArticleListData.fromJson(jsonStr);

  GuideTagArticleListData.fromJson(jsonRes) {
    id = jsonRes['id'].toString();
    oid = jsonRes['oid'].toString();
    keyword = jsonRes['keyword'];
    name = jsonRes['name'];
    oname = jsonRes['oname'];
    seo_keyword = jsonRes['seo_keyword'];
    seo_title = jsonRes['seo_title'];
    BjTj = jsonRes['BjTj'] == null ? null : [];

    for (var BjTjItem in BjTj == null ? [] : jsonRes['BjTj']){
      BjTj.add(BjTjItem);
    }

    HotGl = jsonRes['HotGl'] == null ? null : [];

    for (var HotGlItem in HotGl == null ? [] : jsonRes['HotGl']){
      HotGl.add(HotGlItem == null ? null : new GuideArticleListItem.fromJson(HotGlItem));
    }

    HotTag = jsonRes['HotTag'] == null ? null : [];

    for (var HotTagItem in HotTag == null ? [] : jsonRes['HotTag']){
      HotTag.add(HotTagItem == null ? null : new GuideTag.fromJson(HotTagItem));
    }

    NewGl = jsonRes['NewGl'] == null ? null : [];

    for (var NewGlItem in NewGl == null ? [] : jsonRes['NewGl']){
      NewGl.add(NewGlItem == null ? null : new GuideArticleListItem.fromJson(NewGlItem));
    }
  }

  @override
  String toString() {
    return '{"id": ${id != null?'${json.encode(id)}':'null'},"oid": ${oid != null?'${json.encode(oid)}':'null'},"keyword": ${keyword != null?'${json.encode(keyword)}':'null'},"name": ${name != null?'${json.encode(name)}':'null'},"oname": ${oname != null?'${json.encode(oname)}':'null'},"seo_keyword": ${seo_keyword != null?'${json.encode(seo_keyword)}':'null'},"seo_title": ${seo_title != null?'${json.encode(seo_title)}':'null'},"BjTj": $BjTj,"HotGl": $HotGl,"HotTag": $HotTag,"NewGl": $NewGl}';
  }
}


