import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:scoped_model/scoped_model.dart';
import 'package:youxia/pages/search/components/complexSearchResultTab.dart';
import 'package:youxia/pages/search/components/searchBasicWidget.dart';
import 'package:youxia/pages/search/model/search.dart';
import 'package:youxia/pages/search/type/ComplexSearchResult.dart';
import 'package:youxia/service/mainService.dart';
import 'package:youxia/utils/config.dart';
import 'package:youxia/utils/utils.dart';

class ComplexSearchPage extends StatefulWidget {
  const ComplexSearchPage({Key key}) : super(key: key);

  @override
  State<StatefulWidget> createState() {
    return ComplexSearchPageState();
  }
}

class ComplexSearchPageState extends State<ComplexSearchPage>
    with TickerProviderStateMixin {
  TabController _tabController;
  List<String> _searchHistoryList = [];
  SearchModel _searchModel;
  TextEditingController _searchInputController;

  @override
  void initState() {
    super.initState();
    _searchInputController = new TextEditingController();
    _tabController = new TabController(length: 2, vsync: this);
    _tabController.addListener(() {
      setState(() {
        SearchModel.of(context).setComplexSearchResult(null);
        _searchInputController.clear();
      });
    });
    _searchHistoryList =
        (json.decode(Utils.getLocalStorage(Config.NEWS_SEARCH_HISTORY) ?? '[]')
                as List)
            .cast<String>();

    _searchModel = SearchModel.of(context);
  }

  @override
  void dispose() {
    _searchModel.setComplexSearchResult(null);
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return ScopedModelDescendant(
      builder: (BuildContext context, Widget child, SearchModel model) =>
          SearchBasicWidget(
            handleTabChange: () {
              model.setComplexSearchResult(null);
            },
            historyKey: Config.NEWS_SEARCH_HISTORY,
            hotWords: model.hotWords.news,
            clearSearchHistory: _clearSearchHistory,
            handleSearchInputTap: () {
              model.setComplexSearchResult(null);
            },
            checkResultIsEmpty: _checkComplexResultIsEmpty,
            resultWidget: ComplexSearchResultTab(),
            handleSearchSubmit: _handleSearchSubmit,
            handleDispose: () {
              model.setComplexSearchResult(null);
            },
          ),
    );
  }

  void _handleSearchSubmit(String word) async {
    _searchInputController.text = word;
    var model = SearchModel.of(context);

    ComplexSearchResult result =
        await MainService.getComplexSearchResult(word: word);
    model.setComplexSearchResult(result);

    if (result.news.length == 0 &&
        result.gl.length == 0 &&
        result.game.length == 0) {
      Utils.showShortToast('未找到相关内容');
    } else {
      //添加近期搜索关键词

      if (!_searchHistoryList.contains(word)) {
        setState(() {
          _searchHistoryList.add(word);
        });
      }
      Utils.setLocalStorage(
          Config.NEWS_SEARCH_HISTORY, json.encode(_searchHistoryList));
    }
  }

  void _clearSearchHistory() {
    setState(() {
      _searchHistoryList = [];
    });
    Utils.setLocalStorage(Config.NEWS_SEARCH_HISTORY, null);
    Utils.showShortToast('已清空搜索历史');
  }

  bool _checkComplexResultIsEmpty() {
    var complexResult = _searchModel.complexSearchResult;
    return complexResult == null ||
        (complexResult.news.length == 0 &&
            complexResult.game.length == 0 &&
            complexResult.gl.length == 0);
  }
}
