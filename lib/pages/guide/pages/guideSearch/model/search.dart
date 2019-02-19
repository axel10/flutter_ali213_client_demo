import 'package:flutter/material.dart';
import 'package:scoped_model/scoped_model.dart';
import 'package:youxia/pages/guide/pages/guideSearch/type/SearchHotWord.dart';

class SearchModel extends Model {
  SearchHotWord hotWords;

  void setHotWords(SearchHotWord hotWords) {
    this.hotWords = hotWords;
    notifyListeners();
  }

  static SearchModel of(BuildContext context) =>
      ScopedModel.of<SearchModel>(context);
}
