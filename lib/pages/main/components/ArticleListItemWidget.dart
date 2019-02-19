import 'package:flutter/material.dart';
import 'package:youxia/pages/main/detail/index.dart';
import 'package:youxia/pages/main/types/newsItem.dart';
import 'package:youxia/utils/utils.dart';

TextStyle itemFooterStyle = TextStyle(color: Colors.grey, fontSize: 12);
TextStyle itemTitleStyle = TextStyle(fontSize: 18);

double normalContentHeight = 90;
double imagesContentHeight = 130;
double contentPadding = 10;

enum ArticleListItemType { normal, images, ad }

class ArticleListItemWidget extends StatelessWidget {
  final NewsItem item;
  ArticleListItemWidget(this.item);

  @override
  Widget build(BuildContext context) {
    Widget result;
    if (item.pic1 != null &&
        item.pic2 != null &&
        item.pic3 != null &&
        item.pic1.isNotEmpty &&
        item.pic2.isNotEmpty &&
        item.pic3.isNotEmpty &&
        item.pic1.startsWith('http') &&
        item.pic2.startsWith('http') &&
        item.pic3.startsWith('http')) {

      // 底部三张图片的item
      result = new Container(
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
                          // 底部三张图片
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: <Widget>[
                            new Container(
                              width: 110,
                              height: 70,
                              child: Utils.getCacheImage(
                                imageUrl: item.pic1,
                                fit: BoxFit.cover,
                              ),
                            ),
                            new Container(
                              width: 110,
                              height: 70,
                              child: Utils.getCacheImage(
                                imageUrl: item.pic2,
                                fit: BoxFit.cover,
                              ),
                            ),
                            new Container(
                              width: 110,
                              height: 70,
                              child: Utils.getCacheImage(
                                imageUrl: item.pic3,
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
    } else if (item.pic != null ||
        (item.pic1.isNotEmpty && item.pic1.startsWith('http'))) {
      var picUrl = item.pic ??= item.pic1;

      result = new Container(
        padding: EdgeInsets.fromLTRB(
            contentPadding, contentPadding, contentPadding, 0),
        child: new Row(
          children: <Widget>[
            new Expanded(
              child: new Container(
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
                          new Container(
                            child: Text(
                              item.title,
                              style: itemTitleStyle,
                              maxLines: 2,
                              overflow: TextOverflow.ellipsis,
                            ),
                          ),
                          new Row(
                            children: <Widget>[
                              //时间
                              Text(
                                Utils.getCurrentTimeStringByAddTime(item.time),
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
                      child: Utils.getCacheImage(
                        imageUrl: picUrl,
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
    } else {
      result = Container(
        height: 0,
      );
    }


//    return result;

    return InkWell(
      onTap: () {
        Navigator.push(context, MaterialPageRoute(builder: (ctx) {
          return new NewsDetailPage(item.sid);
        }));
      },
      child: result,
    );
  }
}
