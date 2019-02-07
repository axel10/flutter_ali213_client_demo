import 'package:flutter/material.dart';
import 'package:scoped_model/scoped_model.dart';
import 'package:youxia/pages/main/types/category.dart';
import 'package:youxia/pages/main/types/newsItem.dart';

class CategoryData {
  List<NewsItem> newsList;
  List<Flash> flashList;

  CategoryData(this.newsList,this.flashList);
}


/*List<Category> categorys = [
  Category('1', '推荐'),
  Category('2', '单机'),
  Category('3', '手游'),
  Category('4', '评测'),
  Category('6', '杂谈'),
  Category('26', '视频'),
  Category('27', 'VR'),
];*/

class NewsModel extends Model {
  Map<String, CategoryData> categoryData = new Map();
  List<Category> categorys=[];

//  String currentKey=categorys[0].key;

  void addItems(String key, List<NewsItem> items) {
    categoryData[key].newsList.addAll(items);
    notifyListeners();
  }

  void setCategorys(List<Category> categorys) {
    this.categorys = categorys;
    notifyListeners();
  }

  void setItems(String key, List<NewsItem> newsList,List<Flash> flashList) {
    categoryData[key] = CategoryData(newsList, flashList);
    notifyListeners();
  }

  static NewsModel of(BuildContext context) =>
      ScopedModel.of<NewsModel>(context);
}
