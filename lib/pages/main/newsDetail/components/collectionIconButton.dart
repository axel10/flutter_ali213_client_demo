import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:youxia/type/ArticleCollectionItem.dart';
import 'package:youxia/type/GuideCollectionItem.dart';
import 'package:youxia/utils/config.dart';
import 'package:youxia/utils/utils.dart';

class CollectionIconButton extends StatefulWidget {
  final String id;
  final String addtime;
  final String cover;
  final String title;
  final String className;

  const CollectionIconButton(
      {Key key,
      @required this.id,
      @required this.addtime,
      @required this.cover,
      @required this.title,
      @required this.className})
      : super(key: key);

  @override
  State<StatefulWidget> createState() {
    return CollectionIconButtonState();
  }
}

class CollectionIconButtonState extends State<CollectionIconButton> {
  bool _isCollected = false;

  void toggleCollection() async {
    // 数据存放于model中，所以先获取model
//    var item = NewsDetailModel.of(context).item;
    // 根据文章的class字段获取类型
    String key = widget.className == '游戏攻略'
        ? Config.GUIDE_COLLECTION_LIST_KEY
        : Config.NEWS_COLLECTION_LIST_KEY;
    // 根据类型获取相应列表
    List list = json.decode(Utils.getLocalStorage(key) ?? '[]');
    // 如果已经收藏则从列表中删去
    if (this._isCollected) {
      list.removeWhere((o) => o['ID'] == widget.id);
      // 设置状态为未收藏
      setState(() {
        _isCollected = false;
      });
    } else {
      // 当前文章未收藏
      // 根据类别向list里添加新的收藏数据
      var newItem = key == Config.GUIDE_COLLECTION_LIST_KEY
          ? new GuideListItem(
              title: widget.title, time: widget.addtime, ID: widget.id)
          : new ArticleCollectionItem(
              title: widget.title,
              ID: widget.id,
              time: widget.addtime,
              cover: widget.cover);
      list.add(newItem);
      // 设置状态为已收藏
      setState(() {
        _isCollected = true;
      });
    }
    // 序列化列表，存入本地存储
    Utils.setLocalStorage(key, json.encode(list));
  }

  @override
  Widget build(BuildContext context) {
    return IconButton(
        icon: _isCollected ? Icon(Icons.star) : Icon(Icons.star_border),
        onPressed: toggleCollection);
  }

  @override
  void initState() {
    super.initState();
    // 获取收藏信息
    String key = widget.className == '游戏攻略'
        ? Config.GUIDE_COLLECTION_LIST_KEY
        : Config.NEWS_COLLECTION_LIST_KEY;
    List collectionList = json.decode(Utils.getLocalStorage(key) ?? '[]');
    setState(() {
      this._isCollected = collectionList.any((o) => o['ID'] == widget.id);
    });
  }
}
