import 'package:flutter/material.dart';

class CommentIconButton extends StatelessWidget {
  final String appId;
  final void Function() onTap;
  final int commentCount;

  const CommentIconButton({Key key, this.appId, this.onTap, this.commentCount})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Stack(
      overflow: Overflow.visible,
      alignment: AlignmentDirectional.topEnd,
      children: <Widget>[
        InkWell(
          child: Icon(
            Icons.message,
            size: 20,
          ),
          onTap: onTap,
        ),
        Positioned(
          right: -5,
          top: -5,
          child: new Container(
            padding: EdgeInsets.all(3),
            decoration: BoxDecoration(
                color: Colors.red,
                borderRadius: BorderRadius.circular(5)),
            child: Text(
              commentCount.toString(),
              style: TextStyle(color: Colors.white, fontSize: 8),
            ),
          ),
        )
      ],
    );
  }
}