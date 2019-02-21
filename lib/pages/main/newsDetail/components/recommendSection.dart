import 'package:flutter/material.dart';
import 'package:youxia/pages/main/newsDetail/components/recommendItem.dart';
import 'package:youxia/pages/main/types/newsDetailItem.dart';
import 'package:youxia/utils/utils.dart';

class RecommendSection extends StatelessWidget {
  final List<RecommendArticleListItem> recommends;

  RecommendSection(this.recommends);

  @override
  Widget build(BuildContext context) {
    return recommends.length > 0
        ? Column(
            children: <Widget>[
              Column(
                children: recommends.map((o) {
                  return RecommendItem(
                    title: o.title,
                    time: o.time,
                    imgUrl: o.img,
                  );
                }).toList(),
              )
            ],
          )
        : Utils.getEmptyContainer();
  }
}
