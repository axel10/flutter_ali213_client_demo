import 'package:flutter/material.dart';
import 'package:scoped_model/scoped_model.dart';
import 'package:youxia/pages/search/type/ComplexSearchResult.dart';
import 'package:youxia/pages/search/type/SearchHotWord.dart';
import 'package:youxia/pages/search/type/GuideSubjectResultItem.dart';

class SearchModel extends Model {
  //包含攻略搜索热词以及新闻搜索热词
  SearchHotWord hotWords;
  List<GuideSubjectResultItem> guideSubjectResultList = [];
  ComplexSearchResult complexSearchResult;

  void setGuideSubjectResultList(List<GuideSubjectResultItem> result) {
    this.guideSubjectResultList = result;
    notifyListeners();
  }

  void addNewsSearchResult(List<NewsSearchResultItem> list){
    complexSearchResult.news.addAll(list);
    notifyListeners();
  }

  void addGuideSearchResult(List<GuideSearchResultItem> list){
    complexSearchResult.gl.addAll(list);
    notifyListeners();
  }

  void addGameSearchResult(List<GameSearchResultItem> list){
    complexSearchResult.game.addAll(list);
    notifyListeners();
  }

  void setComplexSearchResult(ComplexSearchResult result) {
    this.complexSearchResult = result;
    notifyListeners();
  }

  void setHotWords(SearchHotWord hotWords) {
    this.hotWords = hotWords;
    notifyListeners();
  }

  static SearchModel of(BuildContext context) =>
      ScopedModel.of<SearchModel>(context);
}
