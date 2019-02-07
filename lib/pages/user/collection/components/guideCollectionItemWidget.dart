import 'package:flutter/material.dart';
import 'package:youxia/type/GuideCollectionItem.dart';



class GuideCollectionItemWidget extends StatelessWidget {
  final GuideCollectionItem item;

  const GuideCollectionItemWidget({Key key,@required this.item}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return new Container(
      padding: EdgeInsets.all(10),
      decoration: BoxDecoration(
          border: BorderDirectional(
              bottom: BorderSide(color: Colors.grey, width: 1))),
      child: new Column(
        children: <Widget>[
          Padding(
            padding: EdgeInsets.only(bottom: 5),
            child: Text(
              item.title,
              style: TextStyle(fontSize: 12, color: Colors.grey),
            ),
          ),
        ],
      ),
    );
  }
}
