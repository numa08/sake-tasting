// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'sake.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_SQLiteSake _$_SQLiteSakeFromJson(Map<String, dynamic> json) {
  return _SQLiteSake(
    json['brewery_id'] as String,
    json['id'] as String,
    json['name'] as String,
  );
}

Map<String, dynamic> _$_SQLiteSakeToJson(_SQLiteSake instance) =>
    <String, dynamic>{
      'brewery_id': instance.breweryID,
      'id': instance.sakeID,
      'name': instance.name,
    };
