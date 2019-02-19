import 'package:flutter/material.dart';

class ShareIconItem {
  final Widget img;
  final void Function() onTap;
  final String title;

  ShareIconItem({this.img, this.onTap, this.title});
}
