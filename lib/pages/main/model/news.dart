import 'package:flutter/material.dart';
import 'package:scoped_model/scoped_model.dart';
import 'package:youxia/pages/main/types/newsItem.dart';

class NewsModel extends Model {
  static Map<String, List<NewsItem>> data = new Map();

  static void AddItems(String key, List<NewsItem> items) {
    if(!data.containsKey(key)){
      data[key] = new List<NewsItem>();
    }
    data[key].addAll(items);
  }

  static void SetItems(String key, List<NewsItem> items) {
    if(!data.containsKey(key)){
      data[key] = new List<NewsItem>();
    }
    data[key] = items;
  }

  static NewsModel of(BuildContext context)=>ScopedModel.of<NewsModel>(context);

}
