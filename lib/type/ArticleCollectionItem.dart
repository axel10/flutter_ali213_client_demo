import 'package:json_annotation/json_annotation.dart';

part 'ArticleCollectionItem.g.dart';

@JsonSerializable(nullable: false)
class ArticleCollectionItem {
  String title;
  String ID;
  String time;
  String cover;

  factory ArticleCollectionItem.fromJson(json)=>
      _$ArticleCollectionItemFromJson(json);

  Map<String, dynamic> toJson() => _$ArticleCollectionItemToJson(this);

  ArticleCollectionItem({this.title, this.ID, this.time, this.cover});
}