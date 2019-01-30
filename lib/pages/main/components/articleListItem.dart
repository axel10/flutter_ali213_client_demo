import 'package:flutter/material.dart';
import 'package:youxia/pages/main/types/newsItem.dart';

TextStyle itemFooterStyle = TextStyle(color: Colors.grey, fontSize: 12);
TextStyle itemTitleStyle = TextStyle(fontSize: 18);

double normalContentHeight = 90;
double imagesContentHeight = 130;
double contentPadding = 10;

enum ArticleListItemType { normal, images, ad }

class ArticleListItem extends StatelessWidget {
  NewsItem item;

  ArticleListItem(NewsItem item) {
    this.item = item;
  }

  @override
  Widget build(BuildContext context) {
    if (item.pic1 != null &&
        item.pic2 != null &&
        item.pic3 != null &&
        item.pic1.isNotEmpty &&
        item.pic2.isNotEmpty &&
        item.pic3.isNotEmpty) {
      return new Container(
          padding: EdgeInsets.fromLTRB(
              contentPadding, contentPadding, contentPadding, 0),
          child: new Row(children: <Widget>[
            new Expanded(
                child: new Container(
              height: imagesContentHeight,
              decoration: BoxDecoration(
                  border:
                      Border(bottom: BorderSide(width: 1, color: Colors.grey))),
              child: Column(
                children: <Widget>[
                  Text(
                    item.title,
                    style: itemTitleStyle,
                    maxLines: 2,
                  ),
                  Container(
                    padding: EdgeInsets.fromLTRB(0, 10, 0, 0),
                    child: new Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: <Widget>[
                        new Container(
                          width: 110,
                          height: 70,
                          child: Image.network(
                            item.pic1,
                            fit: BoxFit.cover,
                          ),
                        ),
                        new Container(
                          width: 110,
                          height: 70,
                          child: Image.network(
                            item.pic2,
                            fit: BoxFit.cover,
                          ),
                        ),
                        new Container(
                          width: 110,
                          height: 70,
                          child: Image.network(
                            item.pic3,
                            fit: BoxFit.cover,
                          ),
                        ),
                      ],
                    ),
                  )
                ],
              ),
            ))
          ]));
    }

    if (item.pic != null || item.pic1.isNotEmpty) {
      var picUrl = item.pic ??= item.pic1;

      return new Container(
        padding: EdgeInsets.fromLTRB(
            contentPadding, contentPadding, contentPadding, 0),
        child: new Row(
          children: <Widget>[
            Expanded(
              child: Container(
                height: normalContentHeight,
                padding: EdgeInsets.fromLTRB(0, 0, 0, contentPadding),
                decoration: BoxDecoration(
                    border: Border(
                        bottom: BorderSide(color: Colors.grey, width: 1))),
                child: new Row(
                  children: <Widget>[
                    new Expanded(
                      child: new Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        mainAxisSize: MainAxisSize.max,
                        children: <Widget>[
                          Container(
                            child: Text(
                              item.title,
                              style: itemTitleStyle,
                              maxLines: 2,
                              overflow: TextOverflow.ellipsis,
                            ),
                          ),
                          new Row(
                            children: <Widget>[
                              Text(
                                '2小时前',
                                style: itemFooterStyle,
                              ),
                              Container(
                                child: Row(
                                  children: <Widget>[
                                    new Icon(
                                      Icons.message,
                                      color: Colors.grey,
                                      size: 12,
                                    ),
                                    new Text(
                                      item.commentnum ??= '0',
                                      style: itemFooterStyle,
                                    )
                                  ],
                                ),
                              )
                            ],
                          ),
                        ],
                      ),
                    ),
                    new Container(
                      width: 120,
                      height: normalContentHeight,
                      child: Image.network(
                        picUrl,
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
}
