// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'ArticleCollectionItem.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

ArticleCollectionItem _$ArticleCollectionItemFromJson(
    Map<String, dynamic> json) {
  return ArticleCollectionItem(
      title: json['title'] as String,
      ID: json['ID'] as String,
      time: json['time'] as String,
      cover: json['cover'] as String);
}

Map<String, dynamic> _$ArticleCollectionItemToJson(
        ArticleCollectionItem instance) =>
    <String, dynamic>{
      'title': instance.title,
      'ID': instance.ID,
      'time': instance.time,
      'cover': instance.cover
    };
