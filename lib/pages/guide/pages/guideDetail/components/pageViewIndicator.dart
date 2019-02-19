import 'package:flutter/material.dart';

class PageViewIndicator extends StatelessWidget {
  final double pageViewIndicatorPosition;
  final int pageCount;
  final double width;

  const PageViewIndicator({Key key, this.pageCount, this.width, this.pageViewIndicatorPosition}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: <Widget>[
        Container(
          height: 2,
          color: Color.fromARGB(255, 230, 230, 230),
        ),
        Container(
          margin: EdgeInsets.only(left: pageViewIndicatorPosition),
          color: Colors.red,
          height: 2,
          width: width/pageCount
        )
      ],
    );
  }

}