import 'dart:convert' show json;

import 'package:youxia/pages/guide/types/GuideDetail.dart';
import 'package:youxia/pages/main/types/newsDetailItem.dart';

class GuideArticleRecommendItem {

  String addtime;
  String className;
  String id;
  String pic;
  String title;

  GuideArticleRecommendItem.fromParams({this.addtime, this.className, this.id, this.pic, this.title});

  factory GuideArticleRecommendItem(jsonStr) => jsonStr == null ? null : jsonStr is String ? new GuideArticleRecommendItem.fromJson(json.decode(jsonStr)) : new GuideArticleRecommendItem.fromJson(jsonStr);
  GuideArticleRecommendItem.fromJson(jsonRes) {
  addtime = jsonRes['addtime'];
  className = jsonRes['class'];
  id = jsonRes['id'];
  pic = jsonRes['pic'];
  title = jsonRes['title'];
  }

}



class GuideArticle {
  List<int> arr;
  List<String> fenzhang;
  GuideArticleData data;
  GuideArticle.fromParams({this.arr, this.fenzhang, this.data});

  factory GuideArticle(jsonStr) => jsonStr == null
      ? null
      : jsonStr is String
          ? new GuideArticle.fromJson(json.decode(jsonStr))
          : new GuideArticle.fromJson(jsonStr);

  GuideArticle.fromJson(jsonRes) {
    arr = jsonRes['arr'] == null ? null : [];

    for (var arrItem in arr == null ? [] : jsonRes['arr']) {
      arr.add(arrItem);
    }

    fenzhang = jsonRes['fenzhang'] == null ? null : [];

    for (var fenzhangItem in fenzhang == null ? [] : jsonRes['fenzhang']) {
      fenzhang.add(fenzhangItem);
    }

    data = jsonRes['data'] == null
        ? null
        : new GuideArticleData.fromJson(jsonRes['data']);
  }

  @override
  String toString() {
    return '{"arr": $arr,"fenzhang": $fenzhang,"data": $data}';
  }
}

class GuideArticleData {
  int cheight;
  int num;
  String addtime;
  String className;
  String content;
  String id;
  String keyword;
  String title;
  List<GuideTag> HotTag;
  List<GuideArticleRecommendItem> related;
  GameInfo odayinfo;

  GuideArticleData.fromParams(
      {this.cheight,
      this.num,
      this.addtime,
      this.className,
      this.content,
      this.id,
      this.keyword,
      this.title,
      this.HotTag,
      this.related,
      this.odayinfo});

  GuideArticleData.fromJson(jsonRes) {
    cheight = jsonRes['cheight'];
    num = jsonRes['num'];
    addtime = jsonRes['addtime'];
    className = jsonRes['class'];
    content = jsonRes['content'];
    id = jsonRes['id'];
    keyword = jsonRes['keyword'];
    title = jsonRes['title'];
    HotTag = jsonRes['HotTag'] == null ? null : [];

    for (var HotTagItem in HotTag == null ? [] : jsonRes['HotTag']) {
      HotTag.add(HotTagItem == null ? null : new GuideTag.fromJson(HotTagItem));
    }

    related = jsonRes['related'] == null ? null : [];

    for (var relatedItem in related == null ? [] : jsonRes['related']) {
      related.add(relatedItem == null
          ? null
          : new GuideArticleRecommendItem.fromJson(relatedItem));
    }

    odayinfo = jsonRes['odayinfo'] == null
        ? null
        : new GameInfo.fromJson(jsonRes['odayinfo']);
  }
}
