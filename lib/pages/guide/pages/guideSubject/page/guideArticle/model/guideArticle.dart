import 'package:flutter/material.dart';
import 'package:scoped_model/scoped_model.dart';

class GuideArticleModel extends Model {
  int page = 1;

  static GuideArticleModel of(BuildContext context) =>
      ScopedModel.of<GuideArticleModel>(context);

  void setPage(int page) {
    this.page = page;
    notifyListeners();
  }
}
