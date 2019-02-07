import 'package:flutter/material.dart';

class YXButton extends StatelessWidget {
  final Widget child;
  final EdgeInsets padding;
  final Color borderColor;
  final Color color;
  final Function onTap;

  YXButton({
    @required this.child,
    @required this.padding,
    this.borderColor = Colors.grey,
    this.onTap,
    this.color,
  });

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return new InkWell(
      onTap: onTap,
      child: Container(
        padding: padding,
        decoration: BoxDecoration(
            color: color,
            border: Border.all(width: 1, color: borderColor),
            borderRadius: BorderRadius.circular(100)),
        child: child,
      ),
    );
  }
}
