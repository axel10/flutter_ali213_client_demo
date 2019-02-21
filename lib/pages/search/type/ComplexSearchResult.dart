import 'dart:convert' show json;

class ComplexSearchResult {
  List<GameSearchResultItem> game;
  List<GuideSearchResultItem> gl;
  List<NewsSearchResultItem> news;

  ComplexSearchResult.fromParams({this.game, this.gl, this.news});

  factory ComplexSearchResult(jsonStr) => jsonStr == null
      ? null
      : jsonStr is String
          ? new ComplexSearchResult.fromJson(json.decode(jsonStr))
          : new ComplexSearchResult.fromJson(jsonStr);

  ComplexSearchResult.fromJson(jsonRes) {
    game = jsonRes['game'] == null ? null : [];

    for (var gameItem in game == null ? [] : jsonRes['game']) {
      game.add(gameItem == null
          ? null
          : new GameSearchResultItem.fromJson(gameItem));
    }

    gl = jsonRes['gl'] == null ? null : [];

    for (var glItem in gl == null ? [] : jsonRes['gl']) {
      gl.add(
          glItem == null ? null : new GuideSearchResultItem.fromJson(glItem));
    }

    news = jsonRes['news'] == null ? null : [];

    for (var newsItem in news == null ? [] : jsonRes['news']) {
      news.add(newsItem == null
          ? null
          : new NewsSearchResultItem.fromJson(newsItem));
    }
  }

  @override
  String toString() {
    return '{"game": $game,"gl": $gl,"news": $news}';
  }
}

class NewsSearchResultItem {
  int addtime;
  int cid;
  String id;
  String img;
  String nums;
  String title;

  NewsSearchResultItem.fromParams(
      {this.addtime, this.cid, this.id, this.img, this.nums, this.title});

  NewsSearchResultItem.fromJson(jsonRes) {
    addtime = jsonRes['addtime'];
    cid = jsonRes['cid'];
    id = jsonRes['id'].toString();
    img = jsonRes['img'];
    nums = jsonRes['nums'].toString();
    title = jsonRes['title'];
  }

  @override
  String toString() {
    return '{"addtime": $addtime,"cid": $cid,"id": $id,"img": ${img != null ? '${json.encode(img)}' : 'null'},"nums": ${nums != null ? '${json.encode(nums)}' : 'null'},"title": ${title != null ? '${json.encode(title)}' : 'null'}}';
  }
}

class GuideSearchResultItem {
  int addtime;
  int cid;
  int id;
  String content;
  String title;

  GuideSearchResultItem.fromParams(
      {this.addtime, this.cid, this.id, this.content, this.title});

  GuideSearchResultItem.fromJson(jsonRes) {
    addtime = jsonRes['addtime'];
    cid = jsonRes['cid'];
    id = jsonRes['id'];
    content = jsonRes['content'];
    title = jsonRes['title'];
  }

  @override
  String toString() {
    return '{"addtime": $addtime,"cid": $cid,"id": $id,"content": ${content != null ? '${json.encode(content)}' : 'null'},"title": ${title != null ? '${json.encode(title)}' : 'null'}}';
  }
}

class GameSearchResultItem {
  int addtime;
  int id;
  double pf;
  String className;
  String img;
  String title;
  String type;

  GameSearchResultItem.fromParams(
      {this.addtime,
      this.id,
      this.pf,
      this.className,
      this.img,
      this.title,
      this.type});

  GameSearchResultItem.fromJson(jsonRes) {
    addtime = jsonRes['addtime'];
    id = jsonRes['id'];
    pf = double.parse(jsonRes['pf'].toString());
    className = jsonRes['class'];
    img = jsonRes['img'];
    title = jsonRes['title'];
    type = jsonRes['type'];
  }
}
