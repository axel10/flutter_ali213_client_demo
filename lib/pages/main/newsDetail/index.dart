import 'package:flutter/material.dart';
import 'package:scoped_model/scoped_model.dart';
import 'package:youxia/pages/main/newsDetail/components/articleBottomBar.dart';
import 'package:youxia/pages/main/newsDetail/components/collectionIconButton.dart';
import 'package:youxia/pages/main/newsDetail/components/commentButton.dart';
import 'package:youxia/pages/main/newsDetail/components/commentSection.dart';
import 'package:youxia/pages/main/newsDetail/components/recommendSection.dart';
import 'package:youxia/pages/main/model/detail.dart';
import 'package:youxia/service/mainService.dart';
import 'package:youxia/utils/config.dart';
import 'package:youxia/utils/utils.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'dart:convert';
import 'package:flutter_html/flutter_html.dart';

class NewsDetailPage extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return NewsDetailPageState(id);
  }

  final String id;

  NewsDetailPage(this.id);
}

class NewsDetailPageState extends State<NewsDetailPage> {
  bool _isLiked = false;
  final _commentListKey = GlobalKey<CommentSectionState>();

//  bool _isCollected = false;
  NewsDetailPageState(this.id);

  String id;

  @override
  void initState() {
    super.initState();

    var model = NewsDetailModel.of(context);
    model.clearData();

    // 获取文章信息
    MainService.getNewsDetail(id).then((d) {
      var model = NewsDetailModel.of(context);
      model.setItem(d);
      var item = model.item;

      SharedPreferences.getInstance().then((prefs) {
        // 获取点赞信息
        var likeDictStr = prefs.getString(Config.LIKE_DICT) ?? '{}';
        Map dict = json.decode(likeDictStr);
        setState(() {
          this._isLiked = dict.containsKey(item.ID);
        });
      });
    });
    // 获取评论信息
    MainService.getComments(id, appid: Config.NEWS_APP_ID).then((o) {
      var model = NewsDetailModel.of(context);
      model.setComments(o.data);
    });
  }

  @override
  Widget build(BuildContext context) {
    return ScopedModelDescendant(
        builder: (context, child, NewsDetailModel model) {
          var item = model.item;
          var comments = model.comments ??= [];

          // 如果数据还没准备好则返回空scaffold
          if (item == null) {
            return Scaffold();
          }
          // 获取title
          var title = new Text(
            item.Title,
            style: TextStyle(fontSize: 20, fontWeight: FontWeight.w700),
          );
          // 获取文章信息
          var articleInfo = new Container(
              child: Row(
                children: <Widget>[
                  Container(
                    child: Text(
                      '${item.addtime} 来源：${item.resource}',
                      style: TextStyle(color: Colors.grey, fontSize: 10),
                    ),
                  ),
                ],
              ));

         item.Content = item.Content.replaceAllMapped(
              new RegExp(r'<img[\s\S].*?data-original="(.*?)"[\s\S].*?/>'),
                  (m) => """
                  <img src="${m[1]}"></img>
                  """);

          /*List<Widget> htmlToWidget(String html) {
        if (html == null || html.isEmpty) {
          return [
            Container(
              height: 0,
            )
          ];
        }

        var reg = new RegExp(r'<(p|span)[\s\S]*?>([\s\S\w]*?)<\/(p|span)>');

        String distHtml = '';
        var matches = reg.allMatches(html);
        for (var o in matches) {
          distHtml += o.group(2).replaceAllMapped(
              new RegExp(r'<img[\s\S].*?data-original="(.*?)"[\s\S].*?/>'),
              (m) => "#%${m[1]}#%");
        }

        distHtml =
            distHtml.replaceAll(new RegExp(r'<script>[\s\S]*?</script>'), '');
        distHtml = distHtml.replaceAll(new RegExp(r'<span[\s\S]*?>'), '');
        distHtml = distHtml.replaceAll(new RegExp(r'</span>'), '');
        distHtml = distHtml.replaceAll(new RegExp(r'<a[\s\S]*?>'), '');
        distHtml = distHtml.replaceAll(new RegExp(r'</a>'), '');
        distHtml = distHtml.replaceAll(new RegExp(r'<iframe[\s\S]*?>'), '');
        distHtml = distHtml.replaceAll(new RegExp(r'<\/iframe>'), '');

        distHtml = distHtml.replaceAll(new RegExp(r'<b[\s\S]*?>'), '');
        distHtml = distHtml.replaceAll(new RegExp(r'<\/b>'), '');
        distHtml = distHtml.replaceAll(new RegExp(r'<font[\s\S]*?>'), '');
        distHtml = distHtml.replaceAll(new RegExp(r'<\/font>'), '');
        distHtml = distHtml.replaceAll(new RegExp(r'<strong[\s\S]*?>'), '');
        distHtml = distHtml.replaceAll(new RegExp(r'<\/strong>'), '');
        distHtml = distHtml.replaceAll(new RegExp(r'<!--[\s\S]*?>'), '');

        distHtml = distHtml.replaceAll(new RegExp(r'&ldquo;'), '“');
        distHtml = distHtml.replaceAll(new RegExp(r'&rdquo;'), '”');

        var strArr = distHtml.split('#%');

        return strArr.map((str) {
          if (str.startsWith('http')) {
            return new Container(
              child: Image.network(
                str,
                fit: BoxFit.cover,
              ),
            );
          }
          return Text(str);
        }).toList();
      }*/

          //转换富文本
//      var contentWidget = htmlToWidget(item.Content);
          var contentWidget = Html(data: item.Content,);

          return Scaffold(
            appBar: Utils.createYXAppBar(),
            body: Stack(
              alignment: AlignmentDirectional.topStart,
              children: <Widget>[
                new Column(
                  children: <Widget>[
                    Expanded(
                      child: new ListView(
                        padding: EdgeInsets.all(10),
                        shrinkWrap: true,
                        children: <Widget>[
                          title,
                          articleInfo,
                          // 文章主体
                          contentWidget,
                          // 点赞按钮
                          new Padding(
                            key: _commentListKey,
                            padding: EdgeInsets.symmetric(vertical: 20),
                            child: new Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: <Widget>[
                                new InkWell(
                                  onTap: like,
                                  child: new Container(
                                    height: 40,
                                    width: 100,
                                    decoration: BoxDecoration(
                                        border:
                                        Border.all(width: 1, color: Colors.red),
                                        borderRadius: BorderRadius.circular(
                                            20)),
                                    child: new Row(
                                      mainAxisAlignment:
                                      MainAxisAlignment.spaceEvenly,
                                      children: <Widget>[
                                        Icon(
                                          this._isLiked
                                              ? Icons.favorite
                                              : Icons.favorite_border,
                                          color: Colors.red,
                                        ),
                                        Text(
//                                item.dzan + '人喜欢',
                                          this._isLiked ? '您已点赞' : '点赞',
                                          style: TextStyle(color: Colors.red),
                                        )
                                      ],
                                    ),
                                  ),
                                )
                              ],
                            ),
                          ),
                          new Column(
                            crossAxisAlignment: CrossAxisAlignment.center,
                            children: <Widget>[
                              //推荐文章列表
                              RecommendSection(item.xgwz),
                              //评论列表
                              CommentSection(
                                comments,
                              ),
                            ],
                          )
                        ],
                      ),
                    ),
                    // 底部评论栏
                    ArticleBottomBarWidget(
                      commentListKey: _commentListKey,
                      scaffoldContext: context,
                      iconSlot: [
                        CollectionIconButton(
                          cover: item.cover,
                          addtime: item.addtime,
                          className: item.className,
                          id: id,
                          title: item.Title,
                        ),
                        CommentIconButton(
                          appId: Config.NEWS_APP_ID,
                          commentCount: comments.length,
                          onTap: () {
                            Utils.showCommentInput(
                                context: context,
                                appId: Config.NEWS_APP_ID,
                                articleId: id,
                                articleTitle: item.Title)
                                .then((_) {
                              MainService.getComments(
                                  id, appid: Config.NEWS_APP_ID)
                                  .then((o) {
                                var model = NewsDetailModel.of(context);
                                model.setComments(o.data);
                              });
                            });
                          },
                        )
                      ],
                      leftArea: InkWell(
                        onTap: () {
                          Utils.showCommentInput(
                              context: context,
                              appId: Config.NEWS_APP_ID,
                              articleId: item.ID,
                              articleTitle: item.Title);
                        },
                        child: new Container(
                          padding:
                          EdgeInsets.symmetric(horizontal: 10, vertical: 8),
                          child: Row(
                            children: <Widget>[
                              Text(
                                '写评论',
                                style: TextStyle(color: Colors.grey),
                              )
                            ],
                          ),
                          decoration: BoxDecoration(
                            color: Colors.white,
                            borderRadius: BorderRadius.circular(3),
                            border: Border.all(width: 1, color: Colors.grey),
                          ),
                        ),
                      ),
                      articleId: item.ID,
                      appId: Config.NEWS_APP_ID,
                    )
                  ],
                ),
              ],
            ),
          );
        });
  }

  like() {
    if (this._isLiked) {
      Fluttertoast.showToast(
          msg: '您已点赞',
          toastLength: Toast.LENGTH_SHORT,
          gravity: ToastGravity.BOTTOM);
      return;
    }

    var model = NewsDetailModel.of(context);
    MainService.like(model.item.ID).then((result) async {
      if (result.status == 1) {
        Fluttertoast.showToast(
            msg: '点赞成功！',
            toastLength: Toast.LENGTH_SHORT,
            gravity: ToastGravity.BOTTOM);

        var prefs = await SharedPreferences.getInstance();
        var dict = prefs.getString(Config.LIKE_DICT) ?? '{}';
        Map map = json.decode(dict);
        map[model.item.ID] = '1';
        prefs.setString(Config.LIKE_DICT, json.encode(map));
        this.setState(() {
          this._isLiked = true;
        });
      }
    });
  }


}
