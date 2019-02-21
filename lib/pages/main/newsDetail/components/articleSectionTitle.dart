import 'package:flutter/material.dart';

class ArticleSectionTitleWidget extends StatelessWidget {
  final String title;

  ArticleSectionTitleWidget(this.title);

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
      children: <Widget>[
        Container(
          width: 70,
          height: 1,
          color: Colors.black,
          margin: EdgeInsets.symmetric(horizontal: 20),
        ),
        Text(
          title,
          style: TextStyle(fontWeight: FontWeight.w700, fontSize: 16),
        ),
        Container(
            width: 70,
            height: 1,
            color: Colors.black,
            margin: EdgeInsets.symmetric(horizontal: 20)),
      ],
    );
  }
}
