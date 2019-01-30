import 'dart:async';

import 'package:youxia/components/loadMore.dart';
import 'package:youxia/pages/main/components/articleListItem.dart';
import 'package:youxia/pages/main/components/mainSwiper.dart';
import 'package:flutter/material.dart';
import 'package:youxia/pages/main/types/newsItem.dart';
import 'package:youxia/service/mainService.dart';

class NewsTab extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    // TODO: implement createState
    return NewsTabState();
  }
}

class NewsTabState extends State<NewsTab> {
  final GlobalKey<RefreshIndicatorState> _refreshIndicatorKey =
      GlobalKey<RefreshIndicatorState>();
  final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();

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

  void initState() {
    _scrollController = new ScrollController();
    _scrollController.addListener(() {
      if (_scrollController.position.pixels >
          _scrollController.position.maxScrollExtent-LoadMore.height) {
        print('done');
      }
    });
    MainService.getNewsData().then((d) {
      setState(() {
        newsItems.addAll(d.list);
      });
    });
  }

  List<NewsItem> newsItems = [];

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return RefreshIndicator(
        key: _refreshIndicatorKey,
        onRefresh: _handleRefresh,
        child: new ListView(
          controller: _scrollController,
          physics: const AlwaysScrollableScrollPhysics(),
          children: <Widget>[
            MainSwiper(),
            Container(
              child: Column(
                  children: newsItems.map((item) {
                return new ArticleListItem(item);
              }).toList()),
            ),
            LoadMore()
          ],
        ));
  }
}
