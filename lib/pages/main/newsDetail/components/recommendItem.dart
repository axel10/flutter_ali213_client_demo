import 'package:flutter/material.dart';

class RecommendItem extends StatelessWidget {
  final String title;
  final String time;
  final String imgUrl;

  RecommendItem(
      {@required this.title, @required this.time, @required this.imgUrl});

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return new Container(
      height: 100,
      child: new Row(
        crossAxisAlignment: CrossAxisAlignment.center,
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: <Widget>[
          new Expanded(
            child: new Container(
              padding: EdgeInsets.fromLTRB(0, 10, 20, 10),
              child: new Column(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisSize: MainAxisSize.max,
                children: <Widget>[
                  Container(
                    padding: EdgeInsets.only(top: 10),
                    child: Text(title),
                  ),
                  Text(
                    time,
                    style: TextStyle(fontSize: 12, color: Colors.grey),
                  )
                ],
              ),
            ),
          ),
          new ClipRRect(
            borderRadius: BorderRadius.circular(8.0),
            child: Image.network(
              imgUrl,
              fit: BoxFit.cover,
              width: 130,
              height: 80,
            ),
          ),
/*          new Container(
            width: 130,
            height: 80,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(6),
            ),
            child: Image.network(
              'http://imgs.ali213.net/news/2019/01/24/2019012491819302.jpg',
              fit: BoxFit.cover,
            ),
          )*/
        ],
      ),
    );
  }
}
