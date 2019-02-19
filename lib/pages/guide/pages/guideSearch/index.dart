import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:scoped_model/scoped_model.dart';
import 'package:youxia/pages/guide/components/ImgListItem.dart';
import 'package:youxia/pages/guide/components/searchInput2.dart';
import 'package:youxia/pages/guide/pages/guideDetail/index.dart';
import 'package:youxia/pages/guide/pages/guideSearch/model/search.dart';
import 'package:youxia/pages/guide/pages/guideSearch/type/SearchHotWord.dart';
import 'package:youxia/pages/guide/pages/guideSearch/type/SearchResultItem.dart';
import 'package:youxia/service/mainService.dart';
import 'package:youxia/type/types.dart';
import 'package:youxia/utils/config.dart';
import 'package:youxia/utils/utils.dart';


class GuideSearchPage extends StatefulWidget {
  final EnterPosition enterPosition;

  const GuideSearchPage({Key key, @required this.enterPosition})
      : super(key: key);

  @override
  State<StatefulWidget> createState() {
    return GuideSearchPageState();
  }
}

class GuideSearchPageState extends State<GuideSearchPage>
    with TickerProviderStateMixin {
  TabController _tabController;

  List<SearchResultItem> _resultList = [];
  List<String> _recentSearchWordList = [];

  TextEditingController _searchInputController;

  @override
  void initState() {
    super.initState();
    _searchInputController = new TextEditingController();
    _tabController = new TabController(length: 2, vsync: this);
    _tabController.addListener(() {
      setState(() {
        _searchInputController.clear();
        _resultList = [];
      });
    });

    _recentSearchWordList =
        (json.decode(Utils.getLocalStorage(Config.SEARCH_WORD) ?? '[]') as List)
            .cast<String>();
  }

  @override
  Widget build(BuildContext context) {
    Widget createTab(String title) {
      return Tab(
        child: Text(
          title,
//          style: TextStyle(color: Colors.black),
        ),
      );
    }

    Widget createHotWordTag(String title) {
      return InkWell(
        onTap: () {
          _handleSearchSubmit(title);
        },
        child: Container(
          padding: EdgeInsets.symmetric(vertical: 8, horizontal: 12),
          color: MyColors.backgroundGray,
          child: Text(
            title,
            style: TextStyle(fontSize: 16),
          ),
        ),
      );
    }

    return ScopedModelDescendant(
      builder: (BuildContext context, Widget child, SearchModel model) {
        List<Word> words = [];

        switch (widget.enterPosition) {
          case EnterPosition.news:
            words = model.hotWords.news;
            break;
          case EnterPosition.guide:
            words = model.hotWords.gl;
            break;
        }

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
                            onTap: (){
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
              Expanded(
                child: _resultList.length == 0
                    ? TabBarView(controller: _tabController, children: [
                        // 搜索结果列表
                        ListView(
                          shrinkWrap: true,
                          children: <Widget>[
                            Row(
                              children: <Widget>[
                                Expanded(
                                  child: Container(
                                    padding: EdgeInsets.symmetric(
                                        horizontal: Config.horizontalPadding,
                                        vertical: 10),
                                    child: Wrap(
                                      spacing: 10,
                                      runSpacing: 10,
                                      children: words.map((word) {
                                        return createHotWordTag(word.title);
                                      }).toList(),
                                    ),
                                  ),
                                )
                              ],
                            )
                          ],
                        ),

                        // 近期搜索列表
                        ListView(
                          shrinkWrap: true,
                          children: [
                            Container(
                              padding: EdgeInsets.symmetric(horizontal: 26),
                              child: Column(
                                children: [
                                  Column(
                                    children: _recentSearchWordList.map((item) {
                                      return Container(
                                        padding:
                                            EdgeInsets.symmetric(vertical: 14),
                                        child: Row(
                                          children: <Widget>[
                                            Text(
                                              item,
                                              style:
                                                  TextStyle(color: Colors.grey),
                                            )
                                          ],
                                        ),
                                      );
                                    }).toList(),
                                  ),
                                  _recentSearchWordList.length > 0
                                      ? InkWell(
                                          child: Container(
                                            padding: EdgeInsets.symmetric(
                                                vertical: 10),
                                            child: Center(
                                              child: Text('清除搜索历史'),
                                            ),
                                            decoration: BoxDecoration(
                                                color: MyColors.backgroundGray,
                                                borderRadius:
                                                    BorderRadius.circular(4)),
                                          ),
                                          onTap: _clearSearchHistory,
                                        )
                                      : Utils.getEmptyContainer()
                                ],
                              ),
                            ),
                          ],
                        )
                      ])
                    : GridView.count(
                        padding: EdgeInsets.symmetric(
                            horizontal: Config.horizontalPadding),
                        childAspectRatio: 1 / 1.5,
                        crossAxisCount: 3,
                        mainAxisSpacing: 0,
                        crossAxisSpacing: 10,
                        children: _resultList.map((item) {
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
                      ),
              ),
            ],
          )),
        );
      },
    );
  }

  void _handleSearchSubmit(String word) async {
    _searchInputController.text = word;
//    var word = _searchInputController.text;
    var list = await MainService.getSearchResultList(word: word);
    if (list.length == 0) {
      Utils.showShortToast('未找到相关内容');
    } else {
      setState(() {
        _resultList = list;
      });

      //添加近期搜索关键词
/*      List<String> recentSearchWords =
          (json.decode(Utils.getLocalStorage(Config.SEARCH_WORD) ?? '[]')
                  as List)
              .cast<String>();
      recentSearchWords.add(word);*/
      setState(() {
        _recentSearchWordList.add(word);
      });
      Utils.setLocalStorage(
          Config.SEARCH_WORD, json.encode(_recentSearchWordList));
    }
  }

  void _clearSearchHistory() {
    setState(() {
      _recentSearchWordList = [];
    });
    Utils.setLocalStorage(Config.SEARCH_WORD, null);
    Utils.showShortToast('已清空搜索历史');
  }
}
