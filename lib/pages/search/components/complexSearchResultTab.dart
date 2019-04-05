import 'package:flutter/material.dart';
import 'package:scoped_model/scoped_model.dart';
import 'package:youxia/pages/guide/pages/guideSubject/page/guideArticle/index.dart';
import 'package:youxia/pages/search/model/search.dart';
import 'package:youxia/pages/main/components/ArticleListItemWidget.dart';
import 'package:youxia/pages/main/types/newsItem.dart';
import 'package:youxia/pages/search/type/ComplexSearchResult.dart';
import 'package:youxia/service/mainService.dart';
import 'package:youxia/utils/config.dart';
import 'package:youxia/utils/icons.dart';
import 'package:youxia/utils/utils.dart';

class ComplexSearchResultTab extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return ComplexSearchResultTabState();
  }
}

class Category {
  final int offset;
  final void Function() fetchData;

  Category(this.offset, this.fetchData);
}

class ComplexSearchResultTabState extends State<ComplexSearchResultTab>
    with TickerProviderStateMixin {
  TabController _tabController;
  ScrollController _scrollController;
  TextEditingController _searchEditingController;

  @override
  void initState() {
    super.initState();

    var model = SearchModel.of(context);
    //对应每一栏的滚动加载偏移
    _searchEditingController = TextEditingController();
    var category = [
      Category(30, () {
        MainService.getNewsSearchResultList(word: _searchEditingController.text)
            .then((list) {
          model.addNewsSearchResult(list);
        });
      }),
      Category(30, () {
        MainService.getGuideSearchResultList(
                word: _searchEditingController.text)
            .then((list) {
          model.addGuideSearchResult(list);
        });
      }),
      Category(30, () {
        MainService.getGameSearchResultList(word: _searchEditingController.text)
            .then((list) {
          model.addGameSearchResult(list);
        });
      })
    ];
    _tabController = TabController(length: 4, vsync: this);
    _scrollController = ScrollController();
    _scrollController.addListener(() {
      if (_scrollController.hasClients &&
          _scrollController.position.pixels >
              _scrollController.position.maxScrollExtent -
                  category[_tabController.index].offset) {
        category[_tabController.index].fetchData();
      }
    });
  }

  @override
  void dispose() {
    super.dispose();
    _tabController.dispose();
  }

  @override
  Widget build(BuildContext context) {
    Widget createTypeIcon(IconData icon) {
      return Container(
        margin: EdgeInsets.only(right: 10),
        child: Icon(
          icon,
          size: 16,
        ),
      );
    }

    Widget createTab(String title) => Tab(
          child: Text(title),
        );
    return ScopedModelDescendant(
      builder: (BuildContext context, Widget child, SearchModel model) {
        var result = model.complexSearchResult;

        Widget createGuideItem(GuideSearchResultItem guide) => InkWell(
          onTap: (){
            Navigator.of(context).push(Utils.getRouter(builder: (BuildContext context) {
              return GuideArticlePage(articleId: guide.id.toString(),);
            }));
          },
          child: Row(
            children: <Widget>[
              Expanded(
                child: Container(
                  padding: EdgeInsets.symmetric(
                      horizontal: Config.horizontalPadding, vertical: 10),
                  decoration: BoxDecoration(
                      border: Border(
                          bottom: BorderSide(
                              width: 1, color: MyColors.backgroundGray))),
                  child: Column(
                    children: <Widget>[
                      Text(
                        guide.title,
                      ),
                      Text(
                        guide.content,
                        style: TextStyle(fontSize: 12, color: Colors.grey),
                      )
                    ],
                  ),
                ),
              )
            ],
          ),
        );

        Widget createGameItem(GameSearchResultItem game) => Container(
              height: 100,
              child: Row(
                children: <Widget>[
                  AspectRatio(
                    aspectRatio: 1 / 1.5,
                    child: Utils.getCacheImage(imageUrl: game.img),
                  ),
                  Expanded(
                    child: Container(
                      padding: EdgeInsets.only(left: 15),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: <Widget>[
                          //标题
                          Row(
                            children: <Widget>[
                              Expanded(
                                child: Text(
                                  game.title,
                                  overflow: TextOverflow.ellipsis,
                                ),
                              )
                            ],
                          ),
                          Padding(
                            padding: EdgeInsets.only(top: 10),
                            child: Text(game.className),
                          ),
                          Padding(
                            padding: EdgeInsets.only(top: 10),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.start,
                              children: game.type
                                  .split(',')
                                  .map((String type) {
                                    switch (type) {
                                      case 'pc':
                                        return createTypeIcon(YXIcons.windows);
                                      case 'xboxone':
                                      case 'xbox360':
                                        return createTypeIcon(YXIcons.xbox);
                                      case 'ps4':
                                      case 'ps3':
                                        return createTypeIcon(
                                            YXIcons.playstation);
                                      case '3ds':
                                        return createTypeIcon(
                                            YXIcons.btn_game_DS);
                                      case 'switch':
                                        return createTypeIcon(YXIcons.NS__);
                                    }
                                  })
                                  .toList()
                                  .cast<Widget>(),
                            ),
                          )
                        ],
                      ),
                    ),
                  )
                ],
              ),
            );

        // 综合栏目section
        Widget createComplexSection(String title,
            void Function() moreTapCallback, List<Widget> children) {
          var dist = children.where((item) => item != null);
          if (dist.length == 0) {
            return Utils.getEmptyContainer();
          }

          List<Widget> childrenTemp = [
            Container(
              padding: EdgeInsets.symmetric(vertical: 10),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: <Widget>[
                  Text(
                    title,
                    style: TextStyle(fontWeight: FontWeight.w700),
                  ),
                  InkWell(
                    child: Text('更多'),
                    onTap: moreTapCallback,
                  )
                ],
              ),
            )
          ];
          childrenTemp.addAll(dist);
          childrenTemp.add(Row(
            children: <Widget>[
              Expanded(
                child: Container(
                  height: 1,
                  color: MyColors.backgroundGray,
                ),
              )
            ],
          ));
          return Padding(
            padding: EdgeInsets.symmetric(
                vertical: 20, horizontal: Config.horizontalPadding),
            child: Column(
              children: childrenTemp,
            ),
          );
        }

        return result != null
            ? Material(
                child: Column(
                  children: <Widget>[
                    Row(
                      children: <Widget>[
                        Expanded(
                          child: TabBar(
                              controller: _tabController,
                              labelColor: Colors.black,
                              tabs: [
                                createTab('综合'),
                                createTab('资讯'),
                                createTab('攻略'),
                                createTab('游戏'),
                              ]),
                        )
                      ],
                    ),
                    Expanded(
                      child: TabBarView(controller: _tabController, children: [
                        //综合
                        ListView(
                          children: <Widget>[
                            createComplexSection('游戏', () {
                              _tabController.animateTo(3);
                            },
                                result.game.getRange(0, 3).map((game) {
                                  return createGameItem(game);
                                }).toList()),
                            createComplexSection('资讯', () {
                              _tabController.animateTo(1);
                            },
                                result.news.getRange(0, 3).map((news) {
                                  return ArticleListItemWidget(
                                      NewsItem.fromParams(
                                          sid: news.id,
                                          title: news.title,
                                          id: news.id,
                                          pic: news.img,
                                          time: news.addtime.toString()));
                                }).toList()),
                            createComplexSection('攻略', () {
                              _tabController.animateTo(2);
                            },
                                result.gl.getRange(0, 3).map((guide) {
                                  return createGuideItem(guide);
                                }).toList()),
                          ],
                        ),
                        //新闻
                        ListView(
//                          padding: EdgeInsets.symmetric(horizontal: Config.horizontalPadding),
                          children: result.news.map((news) {
                            return ArticleListItemWidget(NewsItem.fromParams(
                                title: news.title,
                                id: news.id,
                                pic: news.img,
                                time: news.addtime.toString()));
                          }).toList(),
                        ),
                        //攻略
                        ListView(
                          children: result.gl
                              .map((guide) => createGuideItem(guide))
                              .toList(),
                        ),
                        //游戏
                        ListView(
                          padding: EdgeInsets.symmetric(
                              horizontal: Config.horizontalPadding),
                          children: result.game
                              .map((game) => createGameItem(game))
                              .toList(),
                        ),
                      ]),
                    )
                  ],
                ),
              )
            : Utils.getEmptyContainer();
      },
    );
  }
}

class ComplexSection {
  final title;
  final void Function() moreTapCallback;
  final List<Widget> children;

  ComplexSection(
      {@required this.title,
      @required this.moreTapCallback,
      @required this.children});
}
