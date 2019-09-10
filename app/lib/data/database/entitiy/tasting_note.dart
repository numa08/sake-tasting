import 'package:equatable/equatable.dart';
import 'package:json_annotation/json_annotation.dart';

part 'tasting_note.g.dart';

abstract class TastingNote extends Equatable {
  const TastingNote([List props = const <dynamic>[]]) : super(props);
  factory TastingNote.fromJSON(Map<String, dynamic> json) =>
      _$_SQLiteTastingNoteFromJson(json);
  String get tastingNoteID;
  String get comment;
  String get sakeID;
  int get createdAtUTC;
  Map<String, dynamic> toJSON();
}

@JsonSerializable()
class _SQLiteTastingNote extends TastingNote {
  _SQLiteTastingNote(
      this.tastingNoteID, this.comment, this.sakeID, this.createdAtUTC)
      : super(<dynamic>[tastingNoteID, comment, sakeID, createdAtUTC]);
  @override
  @JsonKey(name: 'id')
  final String tastingNoteID;
  @override
  final String comment;
  @override
  final String sakeID;
  @override
  @JsonKey(name: 'created_at_utc')
  final int createdAtUTC;

  @override
  Map<String, dynamic> toJSON() => _$_SQLiteTastingNoteToJson(this);
}
