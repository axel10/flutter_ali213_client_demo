import 'dart:async';
import 'package:scoped_model/scoped_model.dart';
import 'package:youxia/components/loadMore.dart';
import 'package:youxia/model/ui.dart';
import 'package:youxia/pages/main/components/ArticleListItemWidget.dart';
import 'package:youxia/pages/main/components/mainSwiper.dart';
import 'package:flutter/material.dart';
import 'package:youxia/pages/main/model/news.dart';
import 'package:youxia/service/mainService.dart';
import 'package:youxia/utils/utils.dart';

class NewsTab extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    // TODO: implement createState
    return NewsTabState(_key);
  }

  ///栏目id
  final String _key;

  NewsTab(this._key);
}

class NewsTabState extends State<NewsTab> {

  String currentKey;

  String _key;

  NewsTabState(this._key);

  Future<Null> _handleRefresh() async {
    var newsModel = NewsModel.of(context);
    final Completer<void> completer = Completer<Null>();
/*    MainService.getNewsData(nid: _key).then((d) {
      newsModel.setItems(_key, d.list, d.flash);
    });*/
    var data = await MainService.getNewsData(nid: _key);
    newsModel.setItems(_key, data.list, data.flash);

    completer.complete();
    return null;
  }

  ScrollController _scrollController;

  bool loading = false;

  void fetchData() {
    if (loading) return;
    loading = true;
    var model = NewsModel.of(context);
    var currentList = model.categoryData[_key];
    if (currentList != null) {
      MainService.getNewsData(nid: _key, eid: currentList.newsList.last.id)
          .then((items) {
        model.addItems(_key, items.list);
        loading = false;
      });
    }
  }

  @override
  void initState() {
    super.initState();
    var newsModel = NewsModel.of(context);

    //获取初始数据
    if (newsModel.categoryData[_key] == null) {
      MainService.getNewsData(nid: _key).then((d) {
        newsModel.setItems(_key, d.list, d.flash);
      });
    }

    _scrollController = new ScrollController();
    Utils.addInfinityLoadListener(
        _scrollController, fetchData, LoadMore.height);

    _scrollController.addListener(() {
      var model = UIModel.of(context);
      // 如果有滚动
      if (_scrollController.hasClients &&
          _scrollController.position.pixels != 0) {
        // 收起appbar
        model.foldIndexAppbar();
      } else {
        // 展开appbar
        model.expandIndexAppbar();
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return ScopedModelDescendant(
      builder: (context, child, NewsModel model) {
//        var categoryData = model.categoryData[key];
        return RefreshIndicator(
            onRefresh: _handleRefresh,
            child: new ListView(
              controller: _scrollController,
              physics: const AlwaysScrollableScrollPhysics(),
              children: <Widget>[
                // 如果是视频则没有轮播图
                _key == '26'
                    ? Container(
                        height: 0,
                      )
                    : MainSwiper(_key),
                Container(
                  child: Column(
                      children: (model.categoryData[_key] == null
                              ? []
                              : model.categoryData[_key].newsList)
                          .map((item) {
                    return new ArticleListItemWidget(item);
                  }).toList()),
                ),
                LoadMore()
              ],
            ));
      },
    );
  }
}
