import 'package:flutter/material.dart';
import 'package:scoped_model/scoped_model.dart';
import 'package:youxia/pages/guide/pages/guideDetail/components/TagsSection2.dart';
import 'package:youxia/pages/guide/pages/guideDetail/components/guideArticleList.dart';
import 'package:youxia/pages/guide/pages/guideDetail/components/guideImgItem.dart';
import 'package:youxia/pages/guide/pages/guideDetail/components/guidePageListComponent.dart';
import 'package:youxia/pages/guide/pages/guideDetail/components/section.dart';
import 'package:youxia/pages/guide/pages/guideDetail/components/sectionContent.dart';
import 'package:youxia/pages/guide/pages/guideDetail/model/guideDetail.dart';
import 'package:youxia/pages/guide/pages/guideDetail/page/articleList/index.dart';
import 'package:youxia/pages/guide/pages/guideDetail/page/gallery/index.dart';
import 'package:youxia/pages/guide/pages/guideDetail/page/guideArticle/index.dart';
import 'package:youxia/pages/guide/pages/guideDetail/page/illustration/index.dart';
import 'package:youxia/pages/guide/types/GuideDetail.dart';
import 'package:youxia/service/mainService.dart';
import 'package:youxia/utils/config.dart';
import 'package:youxia/utils/utils.dart';

class GuideDetailPage extends StatefulWidget {
  GuideDetailPage(this._id);

  final String _id;

  @override
  State<StatefulWidget> createState() {
    return GuideDetailPageState(_id);
  }
}

class GuideDetailPageState extends State<GuideDetailPage> {
  final String _id;
  double _imgBlank = 10;
  ScrollController _scrollController;

  GuideDetailPageState(this._id);

  int _pageNo = 2;
  bool _loading = false;

  @override
  void initState() {
    super.initState();
    _scrollController = new ScrollController();
    var model = GuideDetailModel.of(context);
    Utils.addInfinityLoadListener(_scrollController, () {
      if (!_loading) {
        MainService.getNewGuideArticleList(id: _id, pageNo: _pageNo)
            .then((data) {
          setState(() {
            _pageNo += 1;
            model.addNewGuideItem(data);
          });
        });
      }
    }, 20);

    MainService.getGuideDetail(_id).then((data) {
      model.setGuideDetail(data);
    });
  }

  @override
  Widget build(BuildContext context) {
    Widget createHorizontalListView(
        {@required List<Widget> children, @required double height}) {
      return Container(
        height: height,
        child: ListView(
          scrollDirection: Axis.horizontal,
          shrinkWrap: true,
          children: <Widget>[
            Row(
              children: children.toList(),
            )
          ],
        ),
      );
    }

    // 创建底部列表
    Widget createGuideList(
        {@required String title, @required List<GuideArticleListItem> list}) {
      return Section(
          child: Column(
            children: <Widget>[
              SectionContentTitle(
                title: title,
                margin: EdgeInsets.symmetric(
                    vertical: Config.horizontalPadding),
              ),
              GuideArticleListWidget(
                list: list,
              )
            ],
          ));
    }

    Widget createInlineArticleList(int rowCount, GuideSection data) {
      double itemWidth = MediaQuery
          .of(context)
          .size
          .width / rowCount - 5;
      var model = GuideDetailModel.of(context);
      return Column(
        children: <Widget>[
          SectionContentTitle(
            more: () {
              Navigator.of(context).push(Utils.getRouter(builder: (ctx) {
                var tag = model.data.hottagarr
                    .firstWhere((item) => item.title == data.mkname);
                return ArticleListPage(
                  oid: tag.oid,
                  id: tag.id,
                );
              }));
            },
            title: data.mkname,
            margin: EdgeInsets.symmetric(vertical: 10),
          ),
          Row(
            children: <Widget>[
              Expanded(
                child: Wrap(
                  alignment: WrapAlignment.spaceBetween,
                  runSpacing: 10,
                  children: data.mkdata.map((item) {
                    return InkWell(
                      onTap: () {
                        jumpToDetail(item.id);
                      },
                      child: Container(
                        width: itemWidth,
                        height: 30,
                        decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(4),
                            color: Color.fromARGB(255, 240, 240, 240)),
                        child: Center(
                          child: Text(
                            item.title,
                            style: TextStyle(fontSize: 12),
                          ),
                        ),
                      ),
                    );
                  }).toList(),
                ),
              )
            ],
          )
        ],
      );
    }

    return ScopedModelDescendant(
      builder: (BuildContext context, Widget child, GuideDetailModel model) {
        var _data = model.data;
        if (_data != null) {
          return Scaffold(
            appBar: Utils.createYXAppBar(),
            body: Container(
              color: Color.fromARGB(255, 240, 240, 240),
              child: Column(
                children: <Widget>[
                  // 搜索栏
                  Container(
                    // 外部白框
                      color: Colors.white,
                      padding:
                      EdgeInsets.symmetric(horizontal: 12, vertical: 6),
                      //内部输入框
                      child: Container(
                        padding: EdgeInsets.symmetric(horizontal: 10),
                        decoration: BoxDecoration(
                            border: Border.all(width: 1, color: Colors.grey),
                            borderRadius: BorderRadius.circular(20)),
                        child: Row(
                          crossAxisAlignment: CrossAxisAlignment.center,
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: <Widget>[
                            Expanded(
                              child: TextField(
                                decoration: InputDecoration(
                                    hintText: '在。。。攻略内搜索',
                                    border: InputBorder.none,
                                    contentPadding: EdgeInsets.symmetric(
                                        horizontal: 5, vertical: 8)),
                              ),
                            ),
                            Icon(
                              Icons.search,
                              color: Colors.grey,
                              size: 18,
                            )
                          ],
                        ),
                      )),
                  Expanded(
                    child: ListView(
                      controller: _scrollController,
                      shrinkWrap: true,
                      children: <Widget>[
                        Stack(
                          // 顶部图片标题
                          alignment: AlignmentDirectional.bottomStart,
                          children: <Widget>[
                            Utils.getCacheImage(
                                imageUrl: _data.data.bannerpic,
                                fit: BoxFit.cover),
                            Container(
                              color: Color.fromARGB(80, 0, 0, 0),
                              height: 30,
                              child: Center(
                                child: Text(
                                  _data.data.name + ' 攻略专辑',
                                  style: TextStyle(color: Colors.white),
                                ),
                              ),
                            )
                          ],
                        ),
                        _data.yjtwyfyarr != null
                            ? Section(
                          // 编辑推荐 滚动列表
                            child: Row(
                              children: <Widget>[
                                Container(
                                  // 左侧色块
                                  color: Colors.red,
                                  width: 40,
                                  height: 100,
                                  child: Center(
                                    child: Container(
                                      width: 20,
                                      child: Text(
                                        '编辑推荐',
                                        style: TextStyle(color: Colors.white),
                                      ),
                                    ),
                                  ),
                                ),
                                Expanded(
                                  child: Container(
                                    padding: EdgeInsets.only(left: 10),
                                    //横向滚动列表
                                    child: createHorizontalListView(
                                        height: 100,
                                        children:
                                        _data.yjtwyfyarr.map((item) {
                                          return Container(
                                            margin: EdgeInsets.only(
                                                right: _imgBlank),
                                            child: GuideImgItemWidget(
                                              width: 140,
                                              height: 80,
                                              imgUrl: item.pic,
                                              id: item.id,
                                              title: item.title,
                                            ),
                                          );
                                        }).toList()),
                                  ),
                                )
                              ],
                            ))
                            : Utils.getEmptyContainer(),
                        // 攻略文章列表
                        _data.videoGuide != null
                            ? Section(
                            child: GuidePageListComponent(
                                _data.imgTextGuide.list,
                                _data.videoGuide.list,
                                _data.imgTextGuide.id))
                            : Utils.getEmptyContainer(),
                        //热门标签
                        _data.hottagarr != null
                            ? Section(
                            child: Column(
                              children: <Widget>[
                                SectionContentTitle(
                                  margin: EdgeInsets.symmetric(
                                      horizontal: Config.horizontalPadding),
                                  title: '热门标签',
                                ),
                                TagsSectionWidget(
                                  tags: _data.hottagarr,
                                  onTagTap: (tag) {
                                    Navigator.of(context)
                                        .push(Utils.getRouter(builder: (ctx) {
                                      return ArticleListPage(
                                        id: tag.id,
                                        oid: tag.oid,
                                      );
                                    }));
                                  },
                                )
                              ],
                            ))
                            : Utils.getEmptyContainer(),
                        // 画廊
                        _data.gallery != null
                            ? Section(
                            child: Column(
                              children: <Widget>[
                                Column(
                                  children: <Widget>[
                                    SectionContentTitle(
                                      more: () {
                                        Navigator.of(context).push(
                                            MaterialPageRoute(builder: (ctx) {
                                              return GalleryPage(
                                                data: _data.gallery,
                                              );
                                            }));
                                      },
                                      title: _data.gallery.mkname,
                                      margin: EdgeInsets.symmetric(
                                          horizontal:
                                          Config.horizontalPadding),
                                    ),
                                    Container(
                                      height: 80,
                                      child: createHorizontalListView(
                                          height: 120,
                                          children: _data.gallery.allMkdata
                                              .map((item) {
                                            return Container(
                                              margin: EdgeInsets.only(
                                                  right: _imgBlank),
                                              child: GuideImgItemWidget(
                                                id: item.id,
                                                title: item.title,
                                                imgUrl: item.pic,
                                                maskColor: Color.fromARGB(
                                                    80, 0, 0, 0),
                                                width: 100,
                                                height: 70,
                                                onTap: () {
                                                  jumpToDetail(item.id);
                                                },
                                              ),
                                            );
                                          }).toList()),
                                    )
                                  ],
                                ),

                                // 图鉴
                                _data.illustration == null
                                    ? Utils.getEmptyContainer()
                                    : Section(
                                    child: Column(
                                      children: <Widget>[
                                        SectionContentTitle(
                                          more: () {
                                            Navigator.of(context).push(
                                                MaterialPageRoute(
                                                    builder: (ctx) {
                                                      return IllustrationPage(
                                                        data: _data
                                                            .illustration,
                                                      );
                                                    }));
                                          },
                                          title: _data.illustration.mkname,
                                          margin: EdgeInsets.symmetric(
                                              horizontal:
                                              Config.horizontalPadding),
                                        ),
                                        createHorizontalListView(
                                            height: 100,
                                            children: _data
                                                .illustration.mkdata
                                                .map((item) {
                                              return Container(
                                                margin: EdgeInsets.only(
                                                    right: _imgBlank),
                                                child: GuideImgItemWidget(
                                                  id: item.id,
                                                  title: item.title,
                                                  imgUrl: item.pic,
                                                  maskColor: Color.fromARGB(
                                                      80, 0, 0, 0),
                                                  width: 100,
                                                  height: 90,
                                                  onTap: () {
                                                    jumpToDetail(item.id);
                                                  },
                                                ),
                                              );
                                            }).toList())
                                      ],
                                    )),
                              ],
                            ))
                            : Utils.getEmptyContainer(),

                        //inline攻略列表
                        _data.yjwbptarr != null
                            ? Section(
                            child: Column(
                              children: [
                                Column(
                                  children: _data.yjwbptarr.map((section) {
                                    return createInlineArticleList(
                                        3, section);
                                  }).toList(),
                                ),
                                _data.yjwbygdarr == null
                                    ? Utils.getEmptyContainer()
                                    : Column(
                                  children:
                                  _data.yjwbygdarr.map((section) {
                                    return createInlineArticleList(
                                        2, section);
                                  }).toList(),
                                ),
                              ],
                            ))
                            : Utils.getEmptyContainer(),

                        _data.hotgl != null
                            ? createGuideList(title: '热门攻略', list: _data.hotgl)
                            : Utils.getEmptyContainer(),

                        _data.newgl != null
                            ? createGuideList(title: '最新攻略', list: _data.newgl)
                            : Utils.getEmptyContainer(),

/*                        Utils.showIfExist(_data.hotgl != null,
                            createGuideList(title: '最新攻略', list: _data.newgl)),*/
                        //                    createInlineArticleList(3, _data.yjwbptarr)
                      ],
                    ),
                  )
                ],
              ),
            ),
          );
        } else {
          return Scaffold();
        }
      },
    );
  }

  void jumpToDetail(String id) {
    Navigator.of(context).push(Utils.getRouter(builder: (ctx) {
      return GuideArticlePage(articleId: id,);
    }));
  }
}
