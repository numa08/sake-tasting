// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'tasting_note_image.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_SQLiteTastingNoteImage _$_SQLiteTastingNoteImageFromJson(
    Map<String, dynamic> json) {
  return _SQLiteTastingNoteImage(
    json['id'] as String,
    json['tasting_note_id'] as String,
    json['name'] as String,
  );
}

Map<String, dynamic> _$_SQLiteTastingNoteImageToJson(
        _SQLiteTastingNoteImage instance) =>
    <String, dynamic>{
      'id': instance.imageID,
      'tasting_note_id': instance.tastingNoteID,
      'name': instance.name,
    };
