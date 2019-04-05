import 'package:flutter/material.dart';
import 'package:youxia/utils/config.dart';

class SectionContentTitle extends StatelessWidget {
  final String title;

  SectionContentTitle(
      {@required this.title,
      this.more,
      this.margin,});

  final void Function() more;
  final EdgeInsets margin;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: <Widget>[
        Container(
          margin: margin,
          padding: EdgeInsets.symmetric(
              horizontal: Config.horizontalPadding, vertical: 5),
          decoration: BoxDecoration(
              border: Border(
                  bottom: BorderSide(
                      width: 1, color: Color.fromARGB(255, 240, 240, 240)))),
          //栏目标题
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: <Widget>[
              Row(
                children: <Widget>[
                  //红色小块
                  Container(
                    margin: EdgeInsets.only(right: 15),
                    width: 3,
                    height: 20,
                    color: Colors.red,
                  ),
                  //标题
                  Text(
                    title,
                    style: TextStyle(fontSize: 18),
                  )
                ],
              ),
              more == null
                  ? Container(
                      height: 0,
                    )
                  : InkWell(
                      child: Text(
                        '更多>>',
                        style: TextStyle(color: Colors.grey),
                      ),
                      onTap: more,
                    )
            ],
          ),
        ),
      ],
    );
  }
}
