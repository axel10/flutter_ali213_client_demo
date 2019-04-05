import 'package:flutter/material.dart';
import 'package:youxia/pages/guide/pages/guideSubject/page/guideArticle/index.dart';
import 'package:youxia/pages/guide/types/GuideDetail.dart';
import 'package:youxia/utils/config.dart';
import 'package:youxia/utils/utils.dart';
import 'package:youxia/pages/guide/pages/guideSubject/components/guidePageViewIndicatorWidget.dart';

///具体游戏攻略列表页攻略列表滑动控件
class GuidePageListComponent extends StatefulWidget {
  final List<GuideArticleListItem> imgTextList;
  final List<GuideArticleListItem> videoList;
  final String articleId;

  GuidePageListComponent(this.imgTextList, this.videoList, this.articleId);

  @override
  State<StatefulWidget> createState() {
    return GuidePageListComponentState(imgTextList, videoList, articleId);
  }
}

enum GuideSwitchBtnType { imageText, video }

class GuidePageListComponentState extends State<GuidePageListComponent> {
  PageController _pageViewController;

  final String articleId;

  @override
  void initState() {
    super.initState();
    _pageViewController = new PageController();
  }

  // 存储imgList和videoList数据
  Map<GuideSwitchBtnType, List<List<GuideArticleListItem>>> _guideArticleMap =
      new Map();

  GuidePageListComponentState(List<GuideArticleListItem> _imgTextList,
      List<GuideArticleListItem> _videoList, this.articleId) {
    _guideArticleMap[GuideSwitchBtnType.imageText] =
        Utils.groupData<GuideArticleListItem>(_imgTextList, 10);
    _guideArticleMap[GuideSwitchBtnType.video] =
        Utils.groupData<GuideArticleListItem>(_videoList, 10);
  }

  GuideSwitchBtnType _currentGuideBtnType = GuideSwitchBtnType.imageText;

  @override
  Widget build(BuildContext context) {
    Widget createGuideSelectBtn({GuideSwitchBtnType key}) {
      var title;
      switch (key) {
        case GuideSwitchBtnType.imageText:
          title = '图文流程';
          break;
        case GuideSwitchBtnType.video:
          title = '视频攻略';
      }

      return Flexible(
        flex: 1,
        child: InkWell(
          child: Container(
            color:
                _currentGuideBtnType == key ? Colors.red : Colors.transparent,
            padding: EdgeInsets.symmetric(vertical: 8),
            child: Center(
                child: Text(
              title,
              style: TextStyle(
                  color: _currentGuideBtnType == key
                      ? Colors.white
                      : Colors.black),
            )),
          ),
          onTap: () {
            this.setState(() {
              _currentGuideBtnType = key;
              _pageViewController.jumpTo(0);
            });
          },
        ),
      );
    }

    ///创建文章列表的每一页
    Widget createArticleListItemWidget(List<GuideArticleListItem> list) {
      List<GuideArticleListItem> allArticle = [];
      _guideArticleMap[_currentGuideBtnType].forEach((item) {
        allArticle.addAll(item);
      });

      return Column(
        mainAxisSize: MainAxisSize.min,
        children: list.map((item) {
          return Container(
            padding: EdgeInsets.symmetric(
                horizontal: Config.horizontalPadding, vertical: 12),
            child: Row(
              children: <Widget>[
                InkWell(
                  child: Text(item.title),
                  onTap: () {
                    Navigator.of(context)
                        .push( Utils.getRouter(builder: (ctx) {
                      return GuideArticlePage(
                        articleId: item.id.runtimeType == String
                            ? item.id
                            : '${articleId}_${item.id}',
                      );
                    }));
                  },
                )
              ],
            ),
          );
        }).toList(),
      );
    }

    return Container(
      padding: EdgeInsets.symmetric(horizontal: Config.horizontalPadding),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: <Widget>[
          // 两个切换按钮
          Container(
            height: 40,
            decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(5),
                border: Border.all(width: 1, color: Colors.red)),
            child: Row(
              children: <Widget>[
                createGuideSelectBtn(key: GuideSwitchBtnType.imageText),
                createGuideSelectBtn(key: GuideSwitchBtnType.video),
              ],
            ),
          ),
          // 文章列表
          GuidePageViewIndicatorWidget(
            children:  _guideArticleMap[_currentGuideBtnType].map((list) {
              return createArticleListItemWidget(list);
            }).toList(),
            height: 460,
            pageCount: _guideArticleMap[_currentGuideBtnType].length,
            pageViewController: _pageViewController,
          ),
        ],
      ),
    );
  }
}
