import 'package:json_annotation/json_annotation.dart';

part 'GuideCollectionItem.g.dart';

@JsonSerializable(nullable: false)
class GuideCollectionItem {
  String title;
  String time;
  String ID;

  GuideCollectionItem({this.title, this.time, this.ID});

  factory GuideCollectionItem.fromJson(json) =>
      _$GuideCollectionItemFromJson(json);

  Map<String, dynamic> toJson() => _$GuideCollectionItemToJson(this);
}
