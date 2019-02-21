import 'package:json_annotation/json_annotation.dart';

part 'GuideCollectionItem.g.dart';

@JsonSerializable(nullable: false)
class GuideListItem {
  String title;
  String time;
  String ID;

  GuideListItem({this.title, this.time, this.ID});

  factory GuideListItem.fromJson(json) =>
      _$GuideCollectionItemFromJson(json);

  Map<String, dynamic> toJson() => _$GuideCollectionItemToJson(this);
}
