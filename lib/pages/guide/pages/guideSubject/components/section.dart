

import 'package:flutter/material.dart';

class Section extends StatelessWidget{
  final Widget child;
  const Section({Key key,@required this.child}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Container(
      color: Colors.white,
      padding: EdgeInsets.symmetric(
        vertical: 8,
      ),
      margin: EdgeInsets.only(top: 10),
      child: child,
    );
  }
}