import 'dart:convert' show json;

class NewsDetailItem {
  Object buyinfo;
  Object shareinfo;
  int cheight;
  int num;
  bool pingceArea;
  bool vrpingce;
  String Content;
  String GuideRead;
  String ID;
  String Keyword;
  String Title;
  String addtime;
  String className;
  String cover;
  String dzan;
  String resource;
  String shareurl;
  String xgword;
  String zlname;
  List<RecommendArticleListItem> xgwz;
  GameInfo odayinfo;

  NewsDetailItem.fromParams(
      {this.buyinfo,
      this.shareinfo,
      this.cheight,
      this.num,
      this.pingceArea,
      this.vrpingce,
      this.Content,
      this.GuideRead,
      this.ID,
      this.Keyword,
      this.Title,
      this.addtime,
      this.className,
      this.cover,
      this.dzan,
      this.resource,
      this.shareurl,
      this.xgword,
      this.zlname,
      this.xgwz,
      this.odayinfo});

  factory NewsDetailItem(jsonStr) => jsonStr == null
      ? null
      : jsonStr is String
          ? new NewsDetailItem.fromJson(json.decode(jsonStr))
          : new NewsDetailItem.fromJson(jsonStr);

  NewsDetailItem.fromJson(jsonRes) {
    buyinfo = jsonRes['buyinfo'];
    shareinfo = jsonRes['shareinfo'];
    cheight = jsonRes['cheight'];
    num = jsonRes['num'];
    pingceArea = jsonRes['pingceArea'];
    vrpingce = jsonRes['vrpingce'];
    Content = jsonRes['Content'];
    GuideRead = jsonRes['GuideRead'];
    ID = jsonRes['ID'];
    Keyword = jsonRes['Keyword'];
    Title = jsonRes['Title'];
    addtime = jsonRes['addtime'];
    className = jsonRes['class'];
    cover = jsonRes['cover'];
    dzan = jsonRes['dzan'];
    resource = jsonRes['resource'];
    shareurl = jsonRes['shareurl'];
    xgword = jsonRes['xgword'];
    zlname = jsonRes['zlname'];
    xgwz = jsonRes['xgwz'] == null ? null : [];

    for (var xgwzItem in xgwz == null ? [] : jsonRes['xgwz']) {
      xgwz.add(xgwzItem == null ? null : new RecommendArticleListItem.fromJson(xgwzItem));
    }

    odayinfo = jsonRes['odayinfo'] == null
        ? null
        : new GameInfo.fromJson(jsonRes['odayinfo']);
  }
}

class GameInfo {
  double pf;
  String id;
  String img;
  String pt;
  String title;
  String tjpct;
  String url;

  GameInfo.fromParams(
      {this.pf, this.id, this.img, this.pt, this.title, this.tjpct, this.url});

  GameInfo.fromJson(jsonRes) {
    pf = jsonRes['pf']!=null?jsonRes['pf']+.0:0.0;
    id = jsonRes['id'];
    img = jsonRes['img'];
    pt = jsonRes['pt'];
    title = jsonRes['title'];
    tjpct = jsonRes['tjpct'];
    url = jsonRes['url'];
  }
}

class RecommendArticleListItem {
  String addtime;
  String className;
  String id;
  String img;
  String time;
  String title;
  String url;

  RecommendArticleListItem.fromParams(
      {this.addtime,
      this.className,
      this.id,
      this.img,
      this.time,
      this.title,
      this.url});

  RecommendArticleListItem.fromJson(jsonRes) {
    addtime = jsonRes['addtime'];
    className = jsonRes['class'];
    id = jsonRes['id'];
    img = jsonRes['img'];
    time = jsonRes['time'];
    title = jsonRes['title'];
    url = jsonRes['url'];
  }
}
