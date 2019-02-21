import 'package:flutter/material.dart';
import 'package:youxia/type/ArticleCollectionItem.dart';
import 'package:youxia/utils/utils.dart';

double contentPadding = 10;
double normalContentHeight = 90;
double imagesContentHeight = 130;
TextStyle itemFooterStyle = TextStyle(color: Colors.grey, fontSize: 12);
TextStyle itemTitleStyle = TextStyle(fontSize: 18);

class ArticleCollectionItemWidget extends StatelessWidget {
  final ArticleCollectionItem item;

  const ArticleCollectionItemWidget({Key key,@required this.item}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return new Container(
      padding: EdgeInsets.fromLTRB(
          contentPadding, contentPadding, contentPadding, 0),
      decoration: BoxDecoration(
        border:
            BorderDirectional(bottom: BorderSide(color: Colors.grey, width: 1)),
      ),
      child: new Row(
        children: <Widget>[
          new Expanded(
            child: new Container(
              height: normalContentHeight,
              padding: EdgeInsets.fromLTRB(0, 0, 0, contentPadding),

              child: new Row(
                children: <Widget>[
                  new Expanded(
                    child: new Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      mainAxisSize: MainAxisSize.max,
                      children: <Widget>[
                        new Container(
                          child: Text(
                            item.title,
                            style: itemTitleStyle,
                            maxLines: 2,
                            overflow: TextOverflow.ellipsis,
                          ),
                        ),
                        new Row(
                          // 左下角时间
                          children: <Widget>[
                            Text(
                              item.time,
                              style: itemFooterStyle,
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
                  new Container(
                    width: 120,
                    height: normalContentHeight,
                    child: Utils.getCacheImage(
                      imageUrl: item.cover,
                      fit: BoxFit.cover,
                    ),
                  )
                ],
              ),
            ),
          )
        ],
      ),
    );
  }
}
