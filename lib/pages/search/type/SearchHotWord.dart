import 'dart:convert' show json;

class SearchHotWord {

  List<Word> gl;
  List<Word> news;
  List<Word> sygl;

  SearchHotWord.fromParams({this.gl, this.news, this.sygl});

  factory SearchHotWord(jsonStr) => jsonStr == null ? null : jsonStr is String ? new SearchHotWord.fromJson(json.decode(jsonStr)) : new SearchHotWord.fromJson(jsonStr);

  SearchHotWord.fromJson(jsonRes) {
    gl = jsonRes['gl'] == null ? null : [];

    for (var glItem in gl == null ? [] : jsonRes['gl']){
      gl.add(glItem == null ? null : new Word.fromJson(glItem));
    }

    news = jsonRes['news'] == null ? null : [];

    for (var newsItem in news == null ? [] : jsonRes['news']){
      news.add(newsItem == null ? null : new Word.fromJson(newsItem));
    }

    sygl = jsonRes['sygl'] == null ? null : [];

    for (var syglItem in sygl == null ? [] : jsonRes['sygl']){
      sygl.add(syglItem == null ? null : new Word.fromJson(syglItem));
    }
  }

  @override
  String toString() {
    return '{"gl": $gl,"news": $news,"sygl": $sygl}';
  }
}

class Word {

  String title;

  Word.fromParams({this.title});

  Word.fromJson(jsonRes) {
    title = jsonRes['title'];
  }

  @override
  String toString() {
    return '{"title": ${title != null?'${json.encode(title)}':'null'}}';
  }
}