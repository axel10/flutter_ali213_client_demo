import 'package:flutter/material.dart';
import 'package:youxia/pages/guide/pages/guideDetail/page/guideArticle/index.dart';
import 'package:youxia/pages/main/newsDetail/index.dart';
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
    return ArticleCollectionState();
  }
}

class ArticleCollectionState extends State<ArticleCollection>
    with TickerProviderStateMixin {
  TabController _tabController;

  List<ArticleCollectionItem> newsList = [];
  List<GuideListItem> guideList = [];

  @override
  void initState() {
    super.initState();
    _tabController = new TabController(length: 2, vsync: this);

    SharedPreferences.getInstance().then((prefs) {
      setState(() {
        newsList = (json.decode(
                    prefs.getString(Config.NEWS_COLLECTION_LIST_KEY) ?? '[]')
                as List)
            .map((o) => ArticleCollectionItem.fromJson(o))
            .toList();
        guideList = (json.decode(
                    prefs.getString(Config.GUIDE_COLLECTION_LIST_KEY) ?? '[]')
                as List)
            .map((o) => GuideListItem.fromJson(o))
            .toList();
      });
    });
  }

  Widget checkDataLength({List list, Widget child}) {
    if (list.length > 0) {
      return child;
    } else {
      return Column(
        children: <Widget>[
          Expanded(
            child: Container(
              child: Center(
                child: Text('还没有收藏任何文章'),
              ),
            ),
          )
        ],
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return new Scaffold(
      appBar: Utils.createYXAppBar(title: '我的收藏', actions: <Widget>[
        new InkWell(
          onTap: clearCollection,
          child: Container(
            padding: EdgeInsets.symmetric(vertical: 12,horizontal: 10),
            child: Text(
              '清空',
              style: TextStyle(color: Colors.black),
            ),
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
            checkDataLength(
                list: newsList,
                child: new ListView(
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
                              route: MaterialPageRoute(
                                  builder: (ctx) =>
                                      new NewsDetailPage(item.ID)));
                        }).toList(),
                      ),
                    )
                  ],
                )),
            checkDataLength(
                list: guideList,
                child: new ListView(
                  shrinkWrap: true,
                  // 攻略收藏列表
                  children: guideList.map((item) {
                    return Utils.navigateTo(
                        context: context,
                        child: new GuideCollectionItemWidget(
                          item: item,
                        ),
                        route: MaterialPageRoute(
                            builder: (ctx) => new GuideArticlePage(
                                  articleId: item.ID,
                                )));
                  }).toList(),
                )),
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
                      Navigator.pop(ctx, true);
                    },
                    child: Text('是'),
                  ),
                  new SimpleDialogOption(
                    onPressed: () {
                      Navigator.pop(ctx, false);
                    },
                    child: Text('否'),
                  )
                ],
              )
            ],
          );
        })) {
      var prefs = await SharedPreferences.getInstance();
      prefs.setString(Config.NEWS_COLLECTION_LIST_KEY, null);
      prefs.setString(Config.GUIDE_COLLECTION_LIST_KEY, null);
      setState(() {
        guideList = [];
        newsList = [];
      });
    }
  }
}
