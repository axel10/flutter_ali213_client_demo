import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:youxia/service/mainService.dart';
import 'package:youxia/utils/config.dart';
import 'package:youxia/utils/utils.dart';

class CommentInput extends StatefulWidget {
  final String title;
  final String id;
  final String appId;

  const CommentInput({Key key, @required this.title, @required this.id, @required this.appId})
      : super(key: key);

  @override
  State<StatefulWidget> createState() {
    return CommentInputState();
  }
}

class CommentInputState extends State<CommentInput> {
  String _comment = '';

  bool sending = false;

  @override
  void initState() {
    print(widget.appId);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.transparent,
      body: Container(
        child: Column(
          children: <Widget>[
            Expanded(
              child: InkWell(
                onTap: () {
                  Navigator.pop(context);
                },
                child: Container(
                  decoration: BoxDecoration(color: Color.fromARGB(50, 0, 0, 0)),
                ),
              ),
            ),
            Container(
              color: Colors.white,
//        height: 60,
              padding: EdgeInsets.symmetric(vertical: 8, horizontal: 12),
              child: Row(
                children: <Widget>[
                  Expanded(
                    child: Container(
                      decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(4),
                          border: Border.all(width: 1, color: Colors.grey)),
                      child: TextField(
                        autofocus: true,
                        decoration: InputDecoration(hintText: '输入你的评论'),
                        onChanged: (str) {
                          setState(() {
                            _comment = str;
                          });
                        },
                      ),
                    ),
                  ),
                  Container(
                    margin: EdgeInsets.only(left: 10),
                    child: InkWell(
                      child: Text(
                        '发布',
                        style: TextStyle(color: Colors.grey),
                      ),
                      onTap: submitCommit,
                    ),
                  ),
                ],
              ),
            )
          ],
        ),
      ),
    );
  }

  void submitCommit() async {
    if (sending) {
      return;
    }
    if (_comment.length <= 6) {
      Utils.showShortToast('评论字数不能小于6个字');
      return;
    }
    var token = (await SharedPreferences.getInstance())
        .getString(Config.USER_TOKEN_KEY);
    if (token == null) {
      Utils.showShortToast('用户未登录');
      return;
    }
    setState(() {
      sending = true;
    });
    Utils.showShortToast('正在发送...');

    var res = await MainService.sendComment(
        comment: _comment,
        articleTitle: widget.title,
        articleId: widget.id,
        appId: widget.appId,
        token: token);

    if (res.status == 1) {
      Utils.showShortToast('评论发表成功');
      Navigator.pop(context);
    }
  }
}
