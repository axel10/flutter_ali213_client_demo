import 'package:flutter/material.dart';
import 'package:youxia/pages/guide/pages/guideDetail/components/TagsSection2.dart';
import 'package:youxia/pages/guide/pages/guideDetail/components/guideArticleList.dart';
import 'package:youxia/pages/guide/pages/guideDetail/components/sectionContent.dart';
import 'package:youxia/pages/guide/pages/guideDetail/type/GuideTagArticleList.dart';
import 'package:youxia/pages/guide/types/GuideDetail.dart';
import 'package:youxia/service/mainService.dart';
import 'package:youxia/utils/utils.dart';

///由标签控制的文章列表
class ArticleListPage extends StatefulWidget {
  ///标签id
  final String id;

  ///攻略专辑id
  final String oid;

  const ArticleListPage({Key key, @required this.id, @required this.oid})
      : super(key: key);

  @override
  State<StatefulWidget> createState() {
    return ArticleListPageState();
  }
}

class ArticleListPageState extends State<ArticleListPage> {
  GuideTagArticleListData _data;
  bool _loading = false;
  ScrollController _scrollController;
  int _pageNo = 2;

  ///当前选中的标签id
  String _currentId;

  @override
  void initState() {
    super.initState();
    _currentId = widget.id;
    MainService.getGuideTagArticleListData(oid: widget.oid, id: widget.id)
        .then((data) {
      setState(() {
        _data = data;
      });
    });

    void addNewGl(List<GuideArticleListItem> list) {
      setState(() {
        _data.NewGl.addAll(list);
      });
    }

    _scrollController = ScrollController();
    Utils.addInfinityLoadListener(_scrollController, () {
      if (!_loading) {
        MainService.getNewGuideArticleList(id: widget.oid, pageNo: _pageNo)
            .then((data) {
          setState(() {
            _pageNo += 1;
            addNewGl(data);
          });
        });
      }
    }, 20);
  }

  @override
  Widget build(BuildContext context) {
    if (_data != null) {
      return Scaffold(
        appBar: Utils.createYXAppBar(),
        body: ListView(
          controller: _scrollController,
          children: <Widget>[
            SectionContentTitle(title: '热门标签'),
            TagsSectionWidget(
                tags: _data.HotTag,
                currentId: _currentId,
                onTagTap: handleTagTap),
            Utils.createSectionGap(),
            SectionContentTitle(title: '热门攻略'),
            GuideArticleListWidget(
              list: _data.HotGl,
            ),
            Utils.createSectionGap(),
            SectionContentTitle(title: '最新攻略'),
            GuideArticleListWidget(
              list: _data.NewGl,
            ),
          ],
        ),
      );
    } else {
      return Scaffold();
    }
  }

  void handleTagTap(GuideTag tag) {
    setState(() {
      this._currentId = tag.id;
      MainService.getGuideTagArticleListData(id: _currentId, oid: widget.oid)
          .then((data) {
       setState(() {
         _data = data;
         _pageNo = 2;
       });
      });
    });
  }
}
