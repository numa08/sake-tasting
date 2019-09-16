import 'package:equatable/equatable.dart';
import 'package:json_annotation/json_annotation.dart';

part 'tasting_note_image.g.dart';

abstract class TastingNoteImage extends Equatable {
  const TastingNoteImage([List props = const <dynamic>[]]) : super(props);
  factory TastingNoteImage.fromJSON(Map<String, dynamic> json) =>
      _$_SQLiteTastingNoteImageFromJson(json);
  factory TastingNoteImage.create(
          {String imageID, String name, String tastingNoteID}) =>
      _SQLiteTastingNoteImage(imageID, tastingNoteID, name);
  String get imageID;
  String get tastingNoteID;
  String get name;
  Map<String, dynamic> toJSON();
}

@JsonSerializable()
class _SQLiteTastingNoteImage extends TastingNoteImage {
  _SQLiteTastingNoteImage(this.imageID, this.tastingNoteID, this.name)
      : super(<dynamic>[imageID, tastingNoteID, name]);

  @override
  @JsonKey(name: 'id')
  final String imageID;

  @override
  @JsonKey(name: 'tasting_note_id')
  final String tastingNoteID;

  @override
  final String name;

  @override
  Map<String, dynamic> toJSON() => _$_SQLiteTastingNoteImageToJson(this);
}
