import 'package:flutter/material.dart';
import 'package:youxia/pages/guide/pages/guideDetail/components/TagsSection2.dart';
import 'package:youxia/pages/guide/pages/guideDetail/components/sectionContent.dart';
import 'package:youxia/pages/guide/pages/guideDetail/page/guideArticle/type/GuideArticle.dart';
import 'package:youxia/pages/main/newsDetail/components/articleBottomBar.dart';
import 'package:youxia/pages/main/newsDetail/components/collectionIconButton.dart';
import 'package:youxia/pages/main/newsDetail/components/commentButton.dart';
import 'package:youxia/pages/main/newsDetail/components/commentSection.dart';
import 'package:youxia/pages/main/newsDetail/components/recommendItem.dart';
import 'package:youxia/pages/main/types/newsCommentData.dart';
import 'package:youxia/service/mainService.dart';
import 'package:youxia/utils/config.dart';
import 'package:youxia/utils/utils.dart';

///传入的[articleId]形式为 文章id+_+页id
class GuideArticlePage extends StatefulWidget {
  final String articleId;

  const GuideArticlePage({Key key, @required this.articleId}) : super(key: key);

  @override
  State<StatefulWidget> createState() {
    String distId =
        articleId.contains('_') ? articleId.split('_')[0] : articleId;
    int page = articleId.contains('_') ? int.parse(articleId.split('_')[1]) : 1;
    return GuideArticlePageState(distId, page);
  }
}

class GuideArticlePageState extends State<GuideArticlePage> {
  final String articleId;
  int _page = 1;
  GuideArticle _data;
  List<Comment> _comments = [];

  GuideArticlePageState(this.articleId, this._page);

/*  void showCommentInput() {
    showDialog(
        context: context,
        barrierDismissible: true,
        builder: (ctx) {
          return CommentInput(
            id: articleId,
            title: _data.data.title,
          );
        });
  }*/

  @override
  void initState() {
    super.initState();
    //获取评论数据
    MainService.getComments(articleId.split('_')[0], appid: '5')
        .then((comments) {
      setState(() {
        _comments = comments.data ?? [];
      });
    });
    //获取文章数据
    jumpPage(_page);
  }

  void jumpPage(int page) {
    MainService.getGuideArticle(articleId: '${articleId}_$page').then((data) {
      setState(() {
        this._data = data;
        this._page = page;
      });
    });
  }

  GlobalKey<ScaffoldState> _scaffoldKey = new GlobalKey();

  @override
  Widget build(BuildContext context) {
    if (_data != null) {
      var articleData = _data.data;
      return Scaffold(
        key: _scaffoldKey,
        drawer: Drawer(
          child: ListView(
            children: _data.fenzhang.map((item) {
              return Row(
                children: <Widget>[
                  InkWell(
                    child: Padding(
                      padding: EdgeInsets.symmetric(
                          horizontal: Config.horizontalPadding, vertical: 8),
                      child: Text(
                        item,
                        overflow: TextOverflow.ellipsis,
                      ),
                    ),
                    onTap: () {
                      jumpPage(_data.fenzhang.indexOf(item) + 1);
                      Navigator.of(context).pop();
                    },
                  )
                ],
              );
            }).toList(),
          ),
        ),
        appBar: Utils.createYXAppBar(),
        body: Column(
          children: <Widget>[
            Expanded(
              child: ListView(
                shrinkWrap: true,
                children: <Widget>[
                  //标题
                  Padding(
                    padding: EdgeInsets.symmetric(
                        horizontal: Config.horizontalPadding, vertical: 10),
                    child: Text(
                      articleData.title,
                      style:
                          TextStyle(fontWeight: FontWeight.w700, fontSize: 18),
                    ),
                  ),
                  //文章主体
                  Container(
                    padding: EdgeInsets.symmetric(
                        horizontal: Config.horizontalPadding),
                    child: Column(
                      children: Utils.htmlToWidget(articleData.content),
                    ),
                  ),
                  //热门标签
                  Utils.showIfExist(
                      articleData.HotTag != null &&
                          articleData.HotTag.length > 0,
                      Column(
                        children: <Widget>[
                          SectionContentTitle(
                            margin: EdgeInsets.symmetric(
                                horizontal: Config.horizontalPadding),
                            title: '热门标签',
                          ),
                          TagsSectionWidget(
                            tags: articleData.HotTag,
                          )
                        ],
                      )),
                  Container(
                    height: 10,
                    color: MyColors.backgroundGray,
                  ),
                  // 相关推荐
                  articleData.related.length > 0
                      ? Container(
                          padding: EdgeInsets.symmetric(
                            horizontal: Config.horizontalPadding,
                          ),
                          child: Column(
                            children: <Widget>[
                              Column(
                                children: articleData.related.map((o) {
                                  return RecommendItem(
                                    title: o.title,
                                    time: o.addtime,
                                    imgUrl: o.pic,
                                  );
                                }).toList(),
                              )
                            ],
                          ),
                        )
                      : Utils.getEmptyContainer(),
                  // 最新评论
                  Container(
                    padding: EdgeInsets.symmetric(
                        horizontal: Config.horizontalPadding),
                    child: CommentSection(_comments),
                  ),
                ],
              ),
            ),
            //底部栏
            ArticleBottomBarWidget(
              appId: Config.GUIDE_APP_ID,
              articleId: articleId,
              scaffoldContext: context,
              iconSlot: [
                CollectionIconButton(
                  cover: articleData.odayinfo.img,
                  addtime: articleData.addtime,
                  className: articleData.className,
                  id: articleId,
                  title: articleData.title,
                ),
                CommentIconButton(
                  appId: Config.GUIDE_APP_ID,
                  commentCount: _comments.length,
                  onTap: () {
                    Utils.showCommentInput(
                        context: context,
                        appId: Config.GUIDE_APP_ID,
                        articleId: articleId,
                        articleTitle: articleData.title)
                        .then((_) {
                      MainService.getComments(articleId.split('_')[0], appid: Config.GUIDE_APP_ID)
                          .then((comments) {
                        setState(() {
                          _comments = comments.data ?? [];
                        });
                      });
                    });
                  },
                )
              ],
              leftArea: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                mainAxisSize: MainAxisSize.max,
                children: <Widget>[
//                  Icon(Icons.chevron_left),
                  IconButton(
                    icon: Icon(Icons.chevron_left),
                    onPressed: () {
                      jumpPage(_page - 1);
                    },
                  ),
                  Expanded(
                    child: InkWell(
                      child: Container(
                        padding:
                            EdgeInsets.symmetric(horizontal: 10, vertical: 8),
                        child: Center(
                          child: Text(
                            '${_data.fenzhang.length}/$_page',
                            style: TextStyle(color: Colors.grey),
                          ),
                        ),
                        decoration: BoxDecoration(
                          color: Colors.white,
                          borderRadius: BorderRadius.circular(3),
                          border: Border.all(width: 1, color: Colors.grey),
                        ),
                      ),
                      onTap: () {
//                          Scaffold.of(context).openDrawer();
                        _scaffoldKey.currentState.openDrawer();
                      },
                    ),
                  ),
                  IconButton(
                    icon: Icon(Icons.chevron_right),
                    onPressed: () {
                      jumpPage(_page + 1);
                    },
                  ),
                ],
              ),
            )
          ],
        ),
      );
    } else {
      return Scaffold();
    }
  }
}
