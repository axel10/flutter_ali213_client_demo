import 'package:flutter/material.dart';
import 'package:scoped_model/scoped_model.dart';
import 'package:youxia/pages/guide/types/GuideIndexListItem.dart';

class GuideModel extends Model{

  List<GuideIndexListItem> _guideList = [];

  List<GuideIndexListItem> get guideList{
    return _guideList;
  }

  static GuideModel of(BuildContext context) =>
      ScopedModel.of<GuideModel>(context);

  void setGuideList(List<GuideIndexListItem> guideList){
    this._guideList = guideList;
    notifyListeners();
  }

  void addGuideList(List<GuideIndexListItem> guideList){
    _guideList.addAll(guideList);
    notifyListeners();
  }

  String getGuideListLastAddTime(){
    if(_guideList.length>0){
      return _guideList.last.addtime;
    }else{
      return '';
    }
  }
}
