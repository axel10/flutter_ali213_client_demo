import 'package:flutter/material.dart';
import 'package:scoped_model/scoped_model.dart';
import 'package:youxia/pages/main/types/newsCommentData.dart';
import 'package:youxia/pages/main/types/newsDetailItem.dart';

class NewsDetailModel extends Model {
  NewsDetailItem item;
  List<Comment> comments=[];

  void setItem(NewsDetailItem item){
    this.item = item;
    notifyListeners();
  }

  static NewsDetailModel of(BuildContext context) =>
      ScopedModel.of<NewsDetailModel>(context);

  void setComments(List<Comment> data) {
    this.comments = data;
    notifyListeners();
  }

  void clearData(){
    this.comments = [];
    this.item = null;
    notifyListeners();
  }
}