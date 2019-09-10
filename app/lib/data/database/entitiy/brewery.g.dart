// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'brewery.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_SQLiteBrewery _$_SQLiteBreweryFromJson(Map<String, dynamic> json) {
  return _SQLiteBrewery(
    json['id'] as String,
    json['name'] as String,
  );
}

Map<String, dynamic> _$_SQLiteBreweryToJson(_SQLiteBrewery instance) =>
    <String, dynamic>{
      'id': instance.breweryID,
      'name': instance.name,
    };
