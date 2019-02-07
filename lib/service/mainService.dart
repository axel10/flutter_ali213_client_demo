import 'package:youxia/pages/main/types/category.dart';
import 'package:youxia/pages/main/types/newsCommentData.dart';
import 'package:youxia/pages/main/types/newsDetailItem.dart';
import 'package:youxia/type/Result.dart';
import 'package:youxia/utils/request.dart';
import 'package:youxia/pages/main/types/newsItem.dart';
import 'dart:convert';

class MainService {
  static Future<NewsData> getNewsData(
      {int pageNo = 10, String eid = '', String nid = '1'}) async {
    return NewsData(await Request.get(
        'https://api3.ali213.net/feedearn/indexdatabynavtest?num=$pageNo&nid=$nid&eid=${eid.isEmpty ? '' : eid}'));
  }

  static Future<NewsDetailItem> getNewsDetail(String id) async {
    return NewsDetailItem(
        await Request.get('http://3g.ali213.net/app/news/newsdetail/$id'));
  }

  static Future<CommentData> getComments(String id) async {
    return CommentData(await Request.get(
        'https://api3.ali213.net/feedearn/getcomment?appid=1&conid=$id'));
  }

  static Future<Result> like(String id) async {
    return Result(await Request.get(
        'https://api3.ali213.net/feedearn/newsding?token=&id=$id'));
  }

  static Future<List<Category>> getCategorys() async {
//    return Categorys(
//        await Request.get('https://api3.ali213.net/feedearn/navigation')).list;
    return (json.decode(await Request.get('https://api3.ali213.net/feedearn/navigation')) as List).map((o){
      return Category.fromJson(o);
    }).toList();
  }
}
