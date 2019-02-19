import 'package:flutter/cupertino.dart';
import 'package:scoped_model/scoped_model.dart';
import 'package:youxia/pages/guide/types/GuideDetail.dart';

class GuideDetailModel extends Model {
  GuideDetail data;

  void setGuideDetail(GuideDetail data) {
    this.data = data;
    notifyListeners();
  }

  static GuideDetailModel of(BuildContext context) =>
      ScopedModel.of<GuideDetailModel>(context);

  void addNewGuideItem(List<GuideArticleListItem> list){
    data.newgl.addAll(list);
    notifyListeners();
  }
}
