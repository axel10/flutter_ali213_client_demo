import 'package:flutter/material.dart';
import 'package:youxia/pages/main/detail/index.dart';
import 'package:youxia/pages/user/collection/components/articleCollectionItemWidget.dart';
import 'package:youxia/pages/user/collection/components/guideCollectionItemWidget.dart';
import 'package:youxia/type/ArticleCollectionItem.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:youxia/type/GuideCollectionItem.dart';
import 'dart:convert';
import 'package:youxia/utils/config.dart';
import 'package:youxia/utils/utils.dart';

class ArticleCollection extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    // TODO: implement createState
    return ArticleCollectionState();
  }
}

class ArticleCollectionState extends State<ArticleCollection>
    with TickerProviderStateMixin {
  TabController _tabController;

  List<ArticleCollectionItem> newsList = [];
  List<GuideCollectionItem> guideList = [];

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    _tabController = new TabController(length: 2, vsync: this);

    SharedPreferences.getInstance().then((prefs) {
      setState(() {
        newsList =
            (json.decode(prefs.getString(NEWS_COLLECTION_LIST_KEY) ?? '[]')
                    as List)
                .map((o) => ArticleCollectionItem.fromJson(o))
                .toList();
        guideList =
            (json.decode(prefs.getString(GUIDE_COLLECTION_LIST_KEY) ?? '[]')
                    as List)
                .map((o) => GuideCollectionItem.fromJson(o))
                .toList();
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return new Scaffold(
      appBar: Utils.createYXAppBar(title: '我的收藏', actions: <Widget>[
        new InkWell(
          onTap: clearCollection,
          child: Text(
            '清空',
            style: TextStyle(color: Colors.black),
          ),
        )
      ]),
      body: new Column(
        children: <Widget>[
          new TabBar(
            isScrollable: true,
            controller: _tabController,
            tabs: <Widget>[
              Tab(
                child: Text(
                  '新闻',
                  style: TextStyle(color: Colors.black),
                ),
              ),
              Tab(
                child: Text(
                  '攻略',
                  style: TextStyle(color: Colors.black),
                ),
              ),
            ],
          ),
          new Container(
              child: new Expanded(
                  child: new TabBarView(controller: _tabController, children: [
            new ListView(
              shrinkWrap: true,
              // 新闻收藏列表
              children: [
                new Container(
                  child: new Column(
                    children: newsList.map((item) {
                      return Utils.navigateTo(
                          context: context,
                          child: new ArticleCollectionItemWidget(
                            item: item,
                          ),
                        route: MaterialPageRoute(builder: (ctx) => new NewsDetail(item.ID))
                      );
                    }).toList(),
                  ),
                )
              ],
            ),
            new ListView(
              shrinkWrap: true,
              // 攻略收藏列表
              children: guideList.map((item) {
                return Utils.navigateTo(
                    context: context,
                    child: new GuideCollectionItemWidget(
                      item: item,
                    ),
                    route: MaterialPageRoute(builder: (ctx) => new NewsDetail(item.ID))
                );
              }).toList(),
            ),
          ])))
        ],
      ),
    );
  }

  void clearCollection() async {
    if (await showDialog(
        context: context,
        builder: (ctx) {
          return SimpleDialog(
            title: Text('是否要清空所有收藏？'),
            children: <Widget>[
              new Row(
                mainAxisAlignment: MainAxisAlignment.end,
                children: <Widget>[
                  new SimpleDialogOption(
                    onPressed: () {
                      Navigator.pop(context, true);
                    },
                    child: Text('是'),
                  ),
                  new SimpleDialogOption(
                    onPressed: () {
                      Navigator.pop(context, false);
                    },
                    child: Text('否'),
                  )
                ],
              )
            ],
          );
        })) {
      var prefs = await SharedPreferences.getInstance();
      prefs.setString(NEWS_COLLECTION_LIST_KEY, null);
      prefs.setString(GUIDE_COLLECTION_LIST_KEY, null);
      setState(() {
        guideList = [];
        newsList = [];
      });
    }
  }
}
