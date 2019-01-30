import 'package:flutter/material.dart';

class LoadMore extends StatelessWidget {

  static double _height = 50;
  static get height{
    return _height;
  }

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: <Widget>[
        Container(
          height: height,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[Text('正在加载')],
          ),
        )
      ],
    );
  }
}
