// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'GuideCollectionItem.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

GuideCollectionItem _$GuideCollectionItemFromJson(Map<String, dynamic> json) {
  return GuideCollectionItem(
      title: json['title'] as String,
      time: json['time'] as String,
      ID: json['ID'] as String);
}

Map<String, dynamic> _$GuideCollectionItemToJson(
        GuideCollectionItem instance) =>
    <String, dynamic>{
      'title': instance.title,
      'time': instance.time,
      'ID': instance.ID
    };
