import 'package:flutter/material.dart';
import 'package:youxia/pages/main/newsDetail/components/ArticleSectionTitle.dart';
import 'package:youxia/pages/main/newsDetail/components/commentItem.dart';
import 'package:youxia/pages/main/types/newsCommentData.dart';
import 'package:youxia/utils/utils.dart';

class CommentSection extends StatefulWidget {
  final List<Comment> comments;
  CommentSection(this.comments, {Key key}) : super(key: key);
  @override
  CommentSectionState createState() {
    return CommentSectionState();
  }
}

class CommentSectionState extends State<CommentSection> {
  @override
  Widget build(BuildContext context) {
    return widget.comments.length > 0
        ? Column(
      children: <Widget>[
        ArticleSectionTitleWidget('最新评论'),
        Column(
          children: widget.comments.map((o) {
            return CommentItem(
              content: o.content.main,
              headImgUrl: o.avatar,
              label: o.ip_address,
              likeCount: int.parse(o.ding),
              dislikeCount: int.parse(o.cai),
              time: Utils.getCurrentTimeStringByAddTime(
                  int.parse(o.addtime)),
              username: o.username,
            );
          }).toList(),
        )
      ],
    )
        : Utils.getEmptyContainer();
  }
}
