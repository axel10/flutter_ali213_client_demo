import 'package:flutter/material.dart';
import 'package:scoped_model/scoped_model.dart';
import 'package:youxia/pages/main/detail/components/commentItem.dart';
import 'package:youxia/pages/main/detail/components/recommendItem.dart';
import 'package:youxia/pages/main/model/detail.dart';
import 'package:youxia/service/mainService.dart';
import 'package:youxia/type/ArticleCollectionItem.dart';
import 'package:youxia/type/GuideCollectionItem.dart';
import 'package:youxia/utils/config.dart';
import 'package:youxia/utils/utils.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'dart:convert';

class NewsDetail extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    // TODO: implement createState
    return NewsDetailState(id);
  }

  final String id;

  NewsDetail(this.id);
}

class NewsDetailState extends State<NewsDetail> {
  bool _isLiked = false;

  bool _isCollected = false;

  NewsDetailState(this.id);

  String id;

  List<Widget> htmlToWidget(String html) {
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
  }

  @override
  void initState() {
    // TODO: implement initState
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
        var likeDictStr = prefs.getString(LIKE_DICT) ?? '{}';
        Map dict = json.decode(likeDictStr);
        setState(() {
          this._isLiked = dict.containsKey(item.ID);
        });
        // 获取收藏信息
        String key = item.className == '游戏攻略'
            ? GUIDE_COLLECTION_LIST_KEY
            : NEWS_COLLECTION_LIST_KEY;
        List collectionList = json.decode(prefs.getString(key) ?? '[]');
        setState(() {
          this._isCollected = collectionList.any((o) => o['ID']== item.ID);
        });
      });
    });

    // 获取评论信息
    MainService.getComments(id).then((o) {
      var model = NewsDetailModel.of(context);
      model.setComments(o.data);
    });
  }

  @override
  Widget build(BuildContext context) {
    Widget createSectionTitle(String text) => Row(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: <Widget>[
            Container(
              width: 70,
              height: 1,
              color: Colors.black,
              margin: EdgeInsets.symmetric(horizontal: 20),
            ),
            Text(
              text,
              style: TextStyle(fontWeight: FontWeight.w700, fontSize: 16),
            ),
            Container(
                width: 70,
                height: 1,
                color: Colors.black,
                margin: EdgeInsets.symmetric(horizontal: 20)),
          ],
        );

    return ScopedModelDescendant(
        builder: (context, child, NewsDetailModel model) {
      var item = model.item;
      var comments = model.comments ??= [];
      if (item == null) {
        return Scaffold();
      }
      var title = new Text(
        item.Title,
        style: TextStyle(fontSize: 20, fontWeight: FontWeight.w700),
      );
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

      var contentWidget = htmlToWidget(item.Content);

      List<Widget> recommendWidgets = item.xgwz.map((o) {
        return RecommendItem(
          title: o.title,
          time: o.time,
          imgUrl: o.img,
        );
      }).toList();

      List<Widget> commentWidgets = comments.map((o) {
        return CommentItem(
          content: o.content.main,
          headImgUrl: o.avatar,
          label: o.ip_address,
          likeCount: int.parse(o.ding),
          dislikeCount: int.parse(o.cai),
//          time: DateFormat('yyyy-MM-dd').format(DateTime.fromMillisecondsSinceEpoch(int.parse(o.addtime))),
          time: Utils.getCurrentTimeStringByAddTime(int.parse(o.addtime)),
          username: o.username,
        );
      }).toList();

      return Scaffold(
        appBar: Utils.createYXAppBar()
            /*new PreferredSize(
            child: new AppBar(
              iconTheme: IconThemeData(color: Colors.black),
              backgroundColor: Colors.white,
              elevation: 0.0,
              bottom: PreferredSize(
                  child: Container(
                    height: 1,
                    color: Colors.grey,
                  ),
                  preferredSize: Size.fromHeight(1.0)),
            ),
            preferredSize: Size.fromHeight(50)),*/
            ,
        body: new Column(
          children: <Widget>[
            Expanded(
              child: new ListView(
                padding: EdgeInsets.all(10),
                shrinkWrap: true,
                children: <Widget>[
                  title,
                  articleInfo,
                  // 文章主体
                  Column(
                    children: contentWidget.toList(),
                  ),
                  // 点赞按钮
                  new Container(
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
                                border: Border.all(width: 1, color: Colors.red),
                                borderRadius: BorderRadius.circular(20)),
                            child: new Row(
                              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
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
                      recommendWidgets.length > 0
                          ? createSectionTitle('相关推荐')
                          : Container(
                              height: 0,
                            ),
                      Column(
                        children: recommendWidgets,
                      ),
                      commentWidgets.length > 0
                          ? createSectionTitle('最新评论')
                          : Container(
                              height: 0,
                            ),
                      Column(
                        children: commentWidgets,
                      )
                    ],
                  )
                ],
              ),
            ),
            // 底部评论栏
            new Container(
              padding: EdgeInsets.symmetric(vertical: 6, horizontal: 10),
              child: new Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: <Widget>[
                  new Expanded(
                    // 评论输入框
                    child: new Container(
                      height: 16,
                      padding: EdgeInsets.only(left: 10),
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
                  // 收藏按钮
                  new IconButton(
                      icon: _isCollected
                          ? Icon(Icons.star)
                          : Icon(Icons.star_border),
                      onPressed: toggleCollection),
                  // 评论数图标
                  Stack(
                    overflow: Overflow.visible,
                    alignment: AlignmentDirectional.topEnd,
                    children: <Widget>[
                      Icon(
                        Icons.message,
                        size: 20,
                      ),
                      Positioned(
                        right: -5,
                        top: -5,
                        child: new Container(
//                            height: 10,
//                            width: 10,
                          padding: EdgeInsets.all(3),
                          decoration: BoxDecoration(
                              color: Colors.red,
                              borderRadius: BorderRadius.circular(5)),
                          child: Text(
                            comments.length.toString(),
                            style: TextStyle(color: Colors.white, fontSize: 8),
                          ),
                        ),
                      )
                    ],
                  )
                ],
              ),
            )
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
        var dict = prefs.getString(LIKE_DICT) ?? '{}';
        Map map = json.decode(dict);
        map[model.item.ID] = '1';
        prefs.setString(LIKE_DICT, json.encode(map));
        this.setState(() {
          this._isLiked = true;
        });
      }
    });
  }

  void toggleCollection() async {
    var prefs = await SharedPreferences.getInstance();
    // 数据存放于model中，所以先获取model
    var item = NewsDetailModel.of(context).item;
    // 根据文章的class字段获取类型
    String key = item.className == '游戏攻略'
        ? GUIDE_COLLECTION_LIST_KEY
        : NEWS_COLLECTION_LIST_KEY;
    // 根据类型获取相应列表
    List list = json.decode(prefs.getString(key) ?? '[]');
    // 如果已经收藏则从列表中删去
    if (this._isCollected) {
      list.removeWhere((o) => o['ID'] == item.ID);
      // 设置状态为未收藏
      setState(() {
        _isCollected = false;
      });
    } else {
      // 当前文章未收藏
      // 根据类别向list里添加新的收藏数据
      var newItem = key == GUIDE_COLLECTION_LIST_KEY
          ? new GuideCollectionItem(
              title: item.Title, time: item.addtime, ID: item.ID)
          : new ArticleCollectionItem(
              title: item.Title,
              ID: item.ID,
              time: item.addtime,
              cover: item.cover);
      list.add(newItem);
      // 设置状态为已收藏
      setState(() {
        _isCollected = true;
      });
    }
    // 序列化列表，存入本地存储
    prefs.setString(key, json.encode(list));
  }
}
