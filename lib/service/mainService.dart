import 'package:youxia/pages/guide/pages/guideDetail/page/guideArticle/type/GuideArticle.dart';
import 'package:youxia/pages/guide/pages/guideDetail/type/GuideTagArticleList.dart';
import 'package:youxia/pages/guide/pages/guideSearch/type/SearchResultItem.dart';
import 'package:youxia/pages/guide/types/GuideDetail.dart';
import 'package:youxia/pages/guide/types/GuideIndexListItem.dart';
import 'package:youxia/pages/main/types/category.dart';
import 'package:youxia/pages/main/types/newsCommentData.dart';
import 'package:youxia/pages/main/types/newsDetailItem.dart';
import 'package:youxia/type/Result.dart';
import 'package:youxia/pages/guide/pages/guideSearch/type/SearchHotWord.dart';
import 'package:youxia/utils/config.dart';
import 'package:youxia/utils/request.dart';
import 'package:youxia/pages/main/types/newsItem.dart';
import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:get_ip/get_ip.dart';
import 'package:youxia/utils/utils.dart';

class MainService {
  /// [eid] 结尾数据id
  /// [nid] 栏目id
  static Future<NewsData> getNewsData(
      {int pageSize = 10, String eid = '', String nid = '1'}) async {
    try {
      var response = await Request.get(
          'https://api3.ali213.net/feedearn/indexdatabynavtest?num=$pageSize&nid=$nid&eid=${eid.isEmpty ? '' : eid}');
      Utils.setLocalStorage(Config.NEWS_CACHE_KEY + '_$nid', response);
      return NewsData(response);
    } catch (e) {
      if (eid.isNotEmpty) {
        return NewsData.fromParams(status: 0, flash: [], list: []);
      }
      var cacheStr = Utils.getLocalStorage(Config.NEWS_CACHE_KEY + '_$nid');
      if (cacheStr == null) {
        return NewsData.fromParams(status: 0, flash: [], list: []);
      }
      return NewsData(cacheStr);
    }
  }

  ///获得新闻详情
  static Future<NewsDetailItem> getNewsDetail(String id) async {
    return NewsDetailItem(
        await Request.get('http://3g.ali213.net/app/news/newsdetail/$id'));
  }

  ///获得评论列表
  ///[appid] 新闻为1，攻略为5
  static Future<CommentData> getComments(String id,
      {@required String appid}) async {
    return CommentData(await Request.get(
        'https://api3.ali213.net/feedearn/getcomment?appid=1&conid=$id&appid=$appid'));
  }

  ///喜欢新闻
  static Future<Result> like(String id) async {
    return Result(await Request.get(
        'https://api3.ali213.net/feedearn/newsding?token=&id=$id'));
  }

  ///获取首页栏目数据
  static Future<List<Category>> getCategorys() async {
    try {
      var res =
          await Request.get('https://api3.ali213.net/feedearn/navigation');
      Utils.setLocalStorage(Config.CATEGORY_CACHE_KEY, res);
      return (json.decode(res) as List).map((o) {
        return Category.fromJson(o);
      }).toList();
    } catch (e) {
      Utils.showErrorToast();
      print(Utils.getLocalStorage(Config.CATEGORY_CACHE_KEY));
      var res = Utils.getLocalStorage(Config.CATEGORY_CACHE_KEY) ?? '[]';
      return (json.decode(res) as List).map((o) {
        return Category.fromJson(o);
      }).toList();
    }
  }

  ///发送评论
  static Future<Result> sendComment(
      {@required String comment,
      @required String articleTitle,
      @required String articleId,
      @required String token,
      @required String appId}) async {
    var ip = await GetIp.ipAddress;

    return Result(
        await Request.get('https://api3.ali213.net/feedearn/fabucomment?'
            'token=$token&appid=$appId&conid=$articleId&'
            'title=$articleTitle&content=$comment&ip=$ip'));
  }

  ///获取攻略首页条目数据
  static Future<List<GuideIndexListItem>> getGuides(
      {int orderBy = 0, String addtime = '', int length = 12}) async {
    return (json.decode(await Request.get(
                'http://3g.ali213.net/app/gl/getapppczjindex?type=$orderBy&addtime=$addtime&length=$length'))
            as List)
        .map((item) => GuideIndexListItem.fromJson(item))
        .toList();
  }

  ///获取攻略详情列表
  static Future<GuideDetail> getGuideDetail(String id) async {
    return GuideDetail(await Request.get(
        'http://3g.ali213.net/app/gl/appglzjpcdetail?id=$id'));
  }

  ///获取最新攻略列表
  ///[id]:标签id
  ///[oid]:攻略专栏id
  static Future<List<GuideArticleListItem>> getNewGuideArticleList(
      {int pageNo = 2, @required String id}) async {
    return (json.decode(await Request.get(
                'http://3g.ali213.net/app/gl/appglzjpcdetail?id=$id&page=$pageNo'))
            as List)
        .map((item) => GuideArticleListItem.fromJson(item))
        .toList();
  }

  ///根据攻略文章id获得攻略文章
  static Future<GuideArticle> getGuideArticle(
      {@required String articleId}) async {
    return GuideArticle(await Request.get(
        'http://3g.ali213.net/app/gl/apppcglhtml?id=$articleId'));
  }

  ///获取根据标签页获得攻略列表页面数据
  ///[id]:标签id
  ///[oid]:攻略专栏id
  static Future<GuideTagArticleListData> getGuideTagArticleListData(
      {@required String oid, @required String id}) async {
    return GuideTagArticleListData(
        await Request.get('http://3g.ali213.net/app/gl/tag?oid=$oid&id=$id'));
  }

  ///获取根据标签页获得攻略列表页面数据
  ///[id]:标签id
  ///[oid]:攻略专栏id
  static Future<List<GuideArticleListItem>> getGuideTagArticleList(
      {@required String oid, @required String id, int page = 2}) async {
    return (json.decode(await Request.get(
                'http://3g.ali213.net/app/gl/tag?oid=$oid&id=$id&page=$page'))
            as List)
        .cast<GuideArticleListItem>();
  }

  ///获取根据标签页获得攻略列表页面数据
  ///[id]:标签id
  ///[oid]:攻略专栏id
  static Future<SearchHotWord> getSearchHotWord() async {
    return SearchHotWord(
        await Request.get('http://3g.ali213.net/app/gl/gethotword'));
  }

  static Future<List<SearchResultItem>> getSearchResultList(
      {@required String word, int length = 12}) async {
    var encodedWord = Uri.encodeFull(word);
    return (json.decode(await Request.get(
                'http://3g.ali213.net/app/gl/appglzjpcsearch?keyword=$encodedWord&addtime=&length=$length'))
            as List)
        .map((item) {
      return SearchResultItem.fromJson(item);
    }).toList();
  }
}
