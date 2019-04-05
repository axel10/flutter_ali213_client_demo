import 'package:flutter/material.dart';
import 'package:youxia/pages/guide/pages/guideSubject/page/guideArticle/index.dart';
import 'package:youxia/pages/guide/types/GuideDetail.dart';
import 'package:youxia/utils/config.dart';
import 'package:youxia/utils/utils.dart';

class GuideArticleListWidget extends StatelessWidget {
  final List<GuideArticleListItem> list;

  const GuideArticleListWidget({Key key, this.list}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Column(
        children: list.map((item) {
          return Row(
            children: <Widget>[
              Expanded(
                child: InkWell(
                  child: Container(
                    padding: EdgeInsets.symmetric(
                        vertical: 8,
                        horizontal: Config.horizontalPadding),
                    child: Text(
                      item.title,
                      overflow: TextOverflow.ellipsis,
                    ),
                  ),
                  onTap: () {
                    Navigator.of(context).push(Utils.getRouter(builder: (ctx){
                      return new GuideArticlePage(articleId: item.id.toString(),);
                    }));
                  },
                ),
              )
            ],
          );
        }).toList());
  }
}