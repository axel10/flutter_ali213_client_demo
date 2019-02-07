import 'dart:async';
import 'package:scoped_model/scoped_model.dart';
import 'package:youxia/components/loadMore.dart';
import 'package:youxia/pages/main/components/articleListItem.dart';
import 'package:youxia/pages/main/components/mainSwiper.dart';
import 'package:flutter/material.dart';
import 'package:youxia/pages/main/model/news.dart';
import 'package:youxia/service/mainService.dart';

class NewsTab extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    // TODO: implement createState
    return NewsTabState(_key);
  }

  final String _key;

  NewsTab(this._key);
}

class NewsTabState extends State<NewsTab> {
  final GlobalKey<RefreshIndicatorState> _refreshIndicatorKey =
      GlobalKey<RefreshIndicatorState>();
  final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();

  String currentKey;

  String key;

  NewsTabState(this.key);

  Future<void> _handleRefresh() {
    final Completer<void> completer = Completer<void>();
    Timer(const Duration(seconds: 3), () {
      completer.complete();
    });
    return completer.future.then<void>((_) {
      _scaffoldKey.currentState?.showSnackBar(SnackBar(
          content: const Text('Refresh complete'),
          action: SnackBarAction(
              label: 'RETRY',
              onPressed: () {
                _refreshIndicatorKey.currentState.show();
              })));
    });
  }

  ScrollController _scrollController;

  bool loading = false;

  void fetchData() {
    if(loading) return;
    loading = true;
    var model = NewsModel.of(context);
    var currentList = model.categoryData[key];
    if(currentList!=null){
      MainService.getNewsData(nid: key,eid: currentList.newsList.last.id).then((items){
        model.addItems(key, items.list);
        loading = false;
      });
    }
  }

  @override
  void initState() {
    super.initState();
    _scrollController = new ScrollController();
    _scrollController.addListener(() {
      if (_scrollController.hasClients &&
          _scrollController.position.pixels >
              _scrollController.position.maxScrollExtent - LoadMore.height) {
        fetchData();
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
            key: _refreshIndicatorKey,
            onRefresh: _handleRefresh,
            child: new ListView(
              controller: _scrollController,
              physics: const AlwaysScrollableScrollPhysics(),
              children: <Widget>[
                // 如果是视频则没有轮播图
                key=='26'?Container(height: 0,):MainSwiper(key),
                Container(
                  child: Column(
                      children: (model.categoryData[key] == null
                              ? []
                              : model.categoryData[key].newsList)
                          .map((item) {
                    return new ArticleListItem(item);
                  }).toList()),
                ),
                LoadMore()
              ],
            ));
      },
    );
  }
}
