import 'package:flutter/material.dart';

class CommentItem extends StatelessWidget {
  final String headImgUrl;
  final String label;
  final String content;
  final String time;
  final String username;
  final int likeCount;
  final int dislikeCount;

  CommentItem(
      {@required this.headImgUrl,
      @required this.label,
      @required this.content,
      @required this.time,
      @required this.likeCount,
      @required this.username,
      @required this.dislikeCount});

  @override
  Widget build(BuildContext context) {
    var headerSize = 40.0;
    Widget createLikeIcon(IconData icon, int count, bool isActive) => new Row(
          children: <Widget>[
            Icon(
              icon,
              size: 12,
              color: Colors.grey,
            ),
            Text(
              count.toString(),
              style: TextStyle(fontSize: 12, color: Colors.grey),
            )
          ],
        );
    return new Container(
      padding: EdgeInsets.symmetric(vertical: 10),
      child: new Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          new ClipRRect(
            borderRadius: BorderRadius.circular(headerSize/2),
            child: new Image.network(
              headImgUrl,
              fit: BoxFit.cover,
              width: headerSize,
              height: headerSize,
            ),
          ),
          Expanded(
            // 右侧主体
            child: new Container(
              padding: EdgeInsets.only(left: 15),
              child: new Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  new Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: <Widget>[
                      new Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        // 用户名与来源
                        children: <Widget>[
                          Text(
                            username,
                            style: TextStyle(fontSize: 14),
                          ),
                          Text(label),
                        ],
                      ),
                      new Container(
                        // 回复小图标
                        child: Row(
                          children: <Widget>[
                            Icon(
                              Icons.message,
                              size: 12,
                              color: Colors.grey,
                            ),
                            Text(
                              '回复',
                              style:
                                  TextStyle(color: Colors.grey, fontSize: 12),
                            )
                          ],
                        ),
                      ),
                    ],
                  ),
                  new Container(
                    // 内容
                    padding: EdgeInsets.symmetric(vertical: 10),
                    child: Text(
                      content,
                      style: TextStyle(fontSize: 16),
                    ),
                  ),
                  new Row(
                    // 时间以及点赞数
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: <Widget>[
                      Text(time,
                          style: TextStyle(color: Colors.grey, fontSize: 12)),
                      Container(
                        child: Row(
                          children: <Widget>[
                            createLikeIcon(Icons.mood, likeCount, false),
                            Container(
                              margin: EdgeInsets.fromLTRB(10, 0, 0, 0),
                              child: createLikeIcon(
                                  Icons.mood_bad, dislikeCount, false),
                            ),
                          ],
                        ),
                      )
                    ],
                  )
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
