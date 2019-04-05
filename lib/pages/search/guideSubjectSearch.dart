import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:scoped_model/scoped_model.dart';
import 'package:youxia/pages/guide/components/ImgListItem.dart';
import 'package:youxia/pages/guide/pages/guideSubject/index.dart';
import 'package:youxia/pages/search/components/searchBasicWidget.dart';
import 'package:youxia/pages/search/model/search.dart';
import 'package:youxia/service/mainService.dart';
import 'package:youxia/utils/config.dart';
import 'package:youxia/utils/utils.dart';

class GuideSearchPage extends StatefulWidget {
  const GuideSearchPage({Key key}) : super(key: key);

  @override
  State<StatefulWidget> createState() {
    return GuideSearchPageState();
  }
}

class GuideSearchPageState extends State<GuideSearchPage>
    with TickerProviderStateMixin {
  TabController _tabController;
  List<String> _searchHistoryList = [];

  TextEditingController _searchInputController;

  @override
  void initState() {
    super.initState();
    _searchInputController = new TextEditingController();
    _tabController = new TabController(length: 2, vsync: this);
    var model = SearchModel.of(context);
    _tabController.addListener(() {
      setState(() {
        _searchInputController.clear();
        //清空攻略专题列表
        model.setGuideSubjectResultList([]);
      });
    });
    _searchHistoryList = (json.decode(
                Utils.getLocalStorage(Config.GUIDE_SEARCH_HISTORY_WORD) ?? '[]')
            as List)
        .cast<String>();
  }

  @override
  Widget build(BuildContext context) {
/*    Widget createTab(String title) {
      return Tab(
        child: Text(
          title,
        ),
      );
    }

    return ScopedModelDescendant(
      builder: (BuildContext context, Widget child, SearchModel model) {
        List<Word> hotWords = model.hotWords.gl;
        var guideSubjectList = model.guideSubjectResultList;
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
                              model.setGuideSubjectResultList([]);
                              model.setComplexSearchResult(null);
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
                  child: (guideSubjectList.length == 0
                      ? TabBarView(controller: _tabController, children: [
                          //热词列表
                          SearchHotWords(
                            handleSearchSubmit: _handleSearchSubmit,
                            hotWords: hotWords,
                          ),
                          // 近期搜索列表
                          SearchHistory(
                            clearSearchHistory: _clearSearchHistory,
                            searchHistoryList: _searchHistoryList,
                          )
                        ])
                      // 搜索结果列表
                      : GridView.count(
                          padding: EdgeInsets.symmetric(
                              horizontal: Config.horizontalPadding),
                          childAspectRatio: 1 / 1.5,
                          crossAxisCount: 3,
                          mainAxisSpacing: 0,
                          crossAxisSpacing: 10,
                          children: guideSubjectList.map((item) {
                            return ImgListItem(
                              title: item.title,
                              imgUrl: item.img,
                              id: item.glzoid,
                              onTap: (id) {
                                Navigator.of(context)
                                    .push(MaterialPageRoute(builder: (ctx) {
                                  return GuideDetailPage(id);
                                }));
                              },
                            );
                          }).toList(),
                        )))
            ],
          )),
        );
      },
    );*/

    return ScopedModelDescendant(
      builder: (BuildContext context, Widget child, SearchModel model) =>
          SearchBasicWidget(
            historyKey: Config.GUIDE_SEARCH_HISTORY_WORD,
            handleDispose: () {
              model.setGuideSubjectResultList([]);
            },
            handleTabChange: () {
              model.setGuideSubjectResultList([]);
            },
            clearSearchHistory: _clearSearchHistory,
            handleSearchInputTap: () {
              model.setGuideSubjectResultList([]);
            },
            checkResultIsEmpty: () {
              return model.guideSubjectResultList == null ||
                  model.guideSubjectResultList.length == 0;
            },
            resultWidget: GridView.count(
              padding: EdgeInsets.symmetric(
                  horizontal: Config.horizontalPadding),
              childAspectRatio: 1 / 1.5,
              crossAxisCount: 3,
              mainAxisSpacing: 0,
              crossAxisSpacing: 10,
              children: model.guideSubjectResultList.map((item) {
                return ImgListItem(
                  title: item.title,
                  imgUrl: item.img,
                  id: item.glzoid,
                  onTap: (id) {
                    Navigator.of(context)
                        .push( Utils.getRouter(builder: (ctx) {
                      return GuideSubjectPage(id);
                    }));
                  },
                );
              }).toList(),
            ),
            handleSearchSubmit: _handleSearchSubmit,
            hotWords: model.hotWords.gl,
          ),
    );
  }

  void _handleSearchSubmit(String word) async {
    _searchInputController.text = word;
    var model = SearchModel.of(context);

    var list = await MainService.getGuideSubjectSearchResultList(word: word);
    if (list.length == 0) {
      Utils.showShortToast('未找到相关内容');
    } else {
      model.setGuideSubjectResultList(list);
      //添加近期搜索关键词

      if (!_searchHistoryList.contains(word)) {
        setState(() {
          _searchHistoryList.add(word);
        });
      }

      Utils.setLocalStorage(
          Config.GUIDE_SEARCH_HISTORY_WORD, json.encode(_searchHistoryList));
    }
  }

  void _clearSearchHistory() {
    setState(() {
      _searchHistoryList = [];
    });
    Utils.setLocalStorage(Config.GUIDE_SEARCH_HISTORY_WORD, null);
    Utils.showShortToast('已清空搜索历史');
  }
}
