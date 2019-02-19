import 'package:flutter/material.dart';
import 'package:scoped_model/scoped_model.dart';

class UIModel extends Model {
  AnimationController _indexAnimationCtl;

  void setIndexScrollController(AnimationController scrollController) {
    this._indexAnimationCtl = scrollController;
    notifyListeners();
  }

  void expandIndexAppbar() {
//    _indexAnimationCtl.animateTo(0, duration: Duration(milliseconds: 200), curve:Curves.easeOut);
    _indexAnimationCtl.reverse();
    notifyListeners();
  }

  void foldIndexAppbar() {
//    _indexAnimationCtl.animateTo(Config.INDEX_APPBAR_HEIGHT+30, duration: Duration(milliseconds: 200), curve:Curves.easeOut);
    _indexAnimationCtl.forward();
    notifyListeners();
  }

  static UIModel of(BuildContext context) => ScopedModel.of<UIModel>(context);
}
