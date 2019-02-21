import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:scoped_model/scoped_model.dart';
import 'package:youxia/pages/guide/components/searchInput.dart';
import 'package:youxia/pages/search/components/SearchHistory.dart';
import 'package:youxia/pages/search/components/searchHotWords.dart';
import 'package:youxia/pages/search/model/search.dart';
import 'package:youxia/pages/search/type/SearchHotWord.dart';
import 'package:youxia/utils/config.dart';
import 'package:youxia/utils/utils.dart';

class SearchBasicWidget extends StatefulWidget {
  final Widget resultWidget;

  final List<Word> hotWords;

  final String historyKey;

  const SearchBasicWidget(
      {Key key,
      @required this.handleSearchSubmit,
      @required this.checkResultIsEmpty,
      @required this.resultWidget,
      @required this.clearSearchHistory,
      @required this.hotWords,
      @required this.historyKey,
      @required this.handleTabChange,
      @required this.handleSearchInputTap,
      @required this.handleDispose})
      : super(key: key);

  @override
  State<StatefulWidget> createState() {
    return SearchBasicWidgetState();
  }

  final void Function(String text) handleSearchSubmit;

  final bool Function() checkResultIsEmpty;

  final void Function() clearSearchHistory;

  final void Function() handleTabChange;

  final void Function() handleSearchInputTap;

  final void Function() handleDispose;
}

class SearchBasicWidgetState extends State<SearchBasicWidget>
    with TickerProviderStateMixin {
  TabController _tabController;
  List<String> _searchHistoryList = [];
  TextEditingController _searchInputController;

  _handleSearchSubmit(String word){
//    var word = _searchInputController.text;
    widget.handleSearchSubmit(word);
    if (!_searchHistoryList.contains(word)) {
      setState(() {
        _searchHistoryList.add(word);
      });
    }
    _searchInputController.text = word;
    Utils.setLocalStorage(
        Config.NEWS_SEARCH_HISTORY, json.encode(_searchHistoryList));
  }

  @override
  void initState() {
    super.initState();
    _searchInputController = new TextEditingController();
    _tabController = new TabController(length: 2, vsync: this);
    _tabController.addListener(() {
      widget.handleTabChange();
    });
    _searchHistoryList =
        (json.decode(Utils.getLocalStorage(widget.historyKey) ?? '[]') as List)
            .cast<String>();
  }

  @override
  void dispose() {
    widget.handleDispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    Widget createTab(String title) {
      return Tab(
        child: Text(
          title,
        ),
      );
    }

    return ScopedModelDescendant(
      builder: (BuildContext context, Widget child, SearchModel model) {
        return Scaffold(
          body: SafeArea(
              child: Column(
            children: <Widget>[
              // 顶部搜索栏
              Row(
                children: <Widget>[
                  Expanded(
                    child: Container(
                      padding: EdgeInsets.symmetric(
                          horizontal: Config.horizontalPadding, vertical: 10),
                      child: Row(
                        children: <Widget>[
                          Expanded(
                              //灰色输入框
                              child: SearchInputWidget(
                            onTap: () {
                              widget.handleSearchInputTap();
                            },
                            controller: _searchInputController,
                            hintText: '请输入搜索内容',
                            color: MyColors.backgroundGray,
                            cleanIcon: Icon(Icons.clear),
                            rightArea: IconButton(
                                icon: Icon(Icons.search),
                                onPressed: () {
                                  _handleSearchSubmit(
                                      _searchInputController.text);
                                }),
                          )),
                          InkWell(
                            onTap: () {
                              Navigator.of(context).pop();
                            },
                            child: Container(
                              padding: EdgeInsets.symmetric(horizontal: 10),
                              child: Text(
                                '取消',
                                style: TextStyle(color: Colors.red),
                              ),
                            ),
                          )
                        ],
                      ),
                    ),
                  )
                ],
              ),
              // tabBar
              // 热词搜索以及搜索历史tabbar
              Row(
                children: <Widget>[
                  Expanded(
                    child: TabBar(
                        labelStyle: TextStyle(color: Colors.red, fontSize: 18),
                        unselectedLabelStyle: TextStyle(fontSize: 16),
                        indicatorColor: Colors.transparent,
                        labelColor: Colors.red,
                        controller: _tabController,
                        tabs: [
                          createTab('热词搜索'),
                          createTab('搜索历史'),
                        ]),
                  )
                ],
              ),
              //主体
              Expanded(
                  child: widget.checkResultIsEmpty()
                      ? (TabBarView(controller: _tabController, children: [
                          //热词列表
                          SearchHotWords(
                            handleSearchSubmit: _handleSearchSubmit,
                            hotWords: widget.hotWords,
                          ),
                          // 近期搜索列表
                          SearchHistory(
                            clearSearchHistory: widget.clearSearchHistory,
                            searchHistoryList: _searchHistoryList,
                            handleSearchSubmit: _handleSearchSubmit,
                          )
                        ]))
                      : widget.resultWidget)
            ],
          )),
        );
      },
    );
  }
}
