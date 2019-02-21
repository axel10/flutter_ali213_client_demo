import 'package:flutter/material.dart';
import 'package:youxia/type/ShareIconItem.dart';
import 'package:youxia/utils/utils.dart';

class ArticleBottomBarWidget extends StatelessWidget {
  final Widget leftArea;
  final String articleId;
  final BuildContext scaffoldContext;
  final GlobalKey commentListKey;
  final String appId;

  const ArticleBottomBarWidget(
      {Key key,
      @required this.leftArea,
      @required this.articleId,
      @required this.scaffoldContext,
      this.commentListKey,
      @required this.appId,
      @required this.iconSlot})
      : super(key: key);

  final List<Widget> iconSlot;

  List<Widget> createIconMenuList(BuildContext context) {
    var itemWidth = Utils.getScreenWidth(context) / 5 - 30;
    return [
      ShareIconItem(img: Icon(Icons.build), title: '新浪', onTap: () {}),
      ShareIconItem(img: Icon(Icons.build), title: '新浪', onTap: () {}),
      ShareIconItem(img: Icon(Icons.build), title: '新浪', onTap: () {}),
      ShareIconItem(img: Icon(Icons.build), title: '新浪', onTap: () {}),
      ShareIconItem(img: Icon(Icons.build), title: '新浪', onTap: () {}),
      ShareIconItem(img: Icon(Icons.build), title: '新浪', onTap: () {})
    ].map((item) {
      return Container(
        child: Column(
          children: <Widget>[
            ClipRRect(
              borderRadius: BorderRadius.circular(10),
              child: Container(
                width: itemWidth,
                height: itemWidth,
                child: Center(
                  child: item.img,
                ),
                color: Colors.white,
              ),
            ),
            Container(
              margin: EdgeInsets.only(top: 10),
              child: Text(
                item.title,
                style: TextStyle(fontSize: 12),
              ),
            )
          ],
        ),
      );
    }).toList();
  }

  @override
  Widget build(BuildContext context) {
    List<Widget> rowWidgets = [
      Expanded(
        // 评论输入框
        child: leftArea,
      ),
    ];
    rowWidgets.addAll(iconSlot);
    rowWidgets.add(new IconButton(
        icon: Icon(Icons.share),
        onPressed: () {
          showModalBottomSheet(
              context: scaffoldContext,
              builder: (ctx) {
                return Container(
                  color: MyColors.backgroundGray,
                  height: 340,
                  child: Column(
                    children: <Widget>[
                      Expanded(
                        child: Container(
                          padding: EdgeInsets.symmetric(
                              vertical: 30, horizontal: 20),
                          child: GridView.count(
                            crossAxisSpacing: 15,
                            mainAxisSpacing: 15,
                            crossAxisCount: 5,
                            shrinkWrap: true,
                            childAspectRatio: 1 / 1.5,
                            physics: NeverScrollableScrollPhysics(),
                            children: createIconMenuList(context),
                          ),
                        ),
                      ),
                      InkWell(
                        child: Container(
                          color: Colors.white,
                          height: 50,
                          child: Center(
                            child: Text('取消分享'),
                          ),
                        ),
                        onTap: () {
                          Navigator.of(scaffoldContext).pop();
                        },
                      )
                    ],
                  ),
                );
              });
        }));

    return new Container(
      padding: EdgeInsets.symmetric(vertical: 6, horizontal: 10),
      child: new Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: rowWidgets,
      ),
    );
  }
}
