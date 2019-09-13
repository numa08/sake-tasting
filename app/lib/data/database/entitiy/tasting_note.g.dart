// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'tasting_note.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_SQLiteTastingNote _$_SQLiteTastingNoteFromJson(Map<String, dynamic> json) {
  return _SQLiteTastingNote(
    json['id'] as String,
    json['comment'] as String,
    json['sake_id'] as String,
    json['created_at_utc'] as int,
  );
}

Map<String, dynamic> _$_SQLiteTastingNoteToJson(_SQLiteTastingNote instance) =>
    <String, dynamic>{
      'id': instance.tastingNoteID,
      'comment': instance.comment,
      'sake_id': instance.sakeID,
      'created_at_utc': instance.createdAtUTC,
    };
