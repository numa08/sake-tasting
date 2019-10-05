import 'package:equatable/equatable.dart';
import 'package:json_annotation/json_annotation.dart';

part 'tasting_note.g.dart';

abstract class TastingNote extends Equatable {
  const TastingNote([List props = const <dynamic>[]]) : super(props);
  factory TastingNote.fromJSON(Map<String, dynamic> json) =>
      _$_SQLiteTastingNoteFromJson(json);
  factory TastingNote.crate(
          {String tastingNoteID,
          String sakeID,
          String appearanceSoundness,
          String appearanceHueComment,
          String appearanceViscosityComment,
          String fragranceSoundness,
          String fragranceStrengthComment,
          String fragranceExample,
          String fragranceMainly,
          String fragranceComplexityComment,
          String tasteSoundness,
          String tasteAttackComment,
          String tasteTexture,
          String tasteExample,
          String tasteSweetnessComment,
          String afterFlavorStrengthComment,
          String afterFlavorExample,
          String reverberationStrengthComment,
          String reverberationExample,
          String tasteComplexityComment,
          String individuality,
          String noticeComment,
          String flavorTypeComment,
          int createdAtUTC,
          double afterFlavorStrength,
          double appearanceHue,
          double appearanceViscosity,
          double fragranceComplexity,
          double fragranceStrength,
          double reverberationStrength,
          double tasteAttack,
          double tasteComplexity,
          double tasteSweetness}) =>
      _SQLiteTastingNote(
          tastingNoteID,
          sakeID,
          createdAtUTC,
          appearanceSoundness,
          appearanceHueComment,
          appearanceViscosityComment,
          fragranceSoundness,
          fragranceStrengthComment,
          fragranceExample,
          fragranceMainly,
          fragranceComplexityComment,
          tasteSoundness,
          tasteAttackComment,
          tasteTexture,
          tasteExample,
          tasteSweetnessComment,
          afterFlavorStrengthComment,
          afterFlavorExample,
          reverberationStrengthComment,
          reverberationExample,
          tasteComplexityComment,
          individuality,
          noticeComment,
          flavorTypeComment,
          afterFlavorStrength,
          appearanceHue,
          appearanceViscosity,
          fragranceComplexity,
          fragranceStrength,
          reverberationStrength,
          tasteAttack,
          tasteComplexity,
          tasteSweetness);
  String get tastingNoteID;
  String get sakeID;
  String get appearanceSoundness;
  String get appearanceHueComment;
  String get appearanceViscosityComment;
  String get fragranceSoundness;
  String get fragranceStrengthComment;
  String get fragranceExample;
  String get fragranceMainly;
  String get fragranceComplexityComment;
  String get tasteSoundness;
  String get tasteAttackComment;
  String get tasteTexture;
  String get tasteExample;
  String get tasteSweetnessComment;
  String get afterFlavorStrengthComment;
  String get afterFlavorExample;
  String get reverberationStrengthComment;
  String get reverberationExample;
  String get tasteComplexityComment;
  String get individuality;
  String get noticeComment;
  String get flavorTypeComment;
  double get appearanceHue;
  double get appearanceViscosity;
  double get fragranceStrength;
  double get fragranceComplexity;
  double get tasteAttack;
  double get tasteSweetness;
  double get afterFlavorStrength;
  double get reverberationStrength;
  double get tasteComplexity;
  int get createdAtUTC;
  Map<String, dynamic> toJSON();
}

@JsonSerializable(fieldRename: FieldRename.snake)
class _SQLiteTastingNote extends TastingNote {
  _SQLiteTastingNote(
      this.tastingNoteID,
      this.sakeID,
      this.createdAtUTC,
      this.appearanceSoundness,
      this.appearanceHueComment,
      this.appearanceViscosityComment,
      this.fragranceSoundness,
      this.fragranceStrengthComment,
      this.fragranceExample,
      this.fragranceMainly,
      this.fragranceComplexityComment,
      this.tasteSoundness,
      this.tasteAttackComment,
      this.tasteTexture,
      this.tasteExample,
      this.tasteSweetnessComment,
      this.afterFlavorStrengthComment,
      this.afterFlavorExample,
      this.reverberationStrengthComment,
      this.reverberationExample,
      this.tasteComplexityComment,
      this.individuality,
      this.noticeComment,
      this.flavorTypeComment,
      this.afterFlavorStrength,
      this.appearanceHue,
      this.appearanceViscosity,
      this.fragranceComplexity,
      this.fragranceStrength,
      this.reverberationStrength,
      this.tasteAttack,
      this.tasteComplexity,
      this.tasteSweetness)
      : super(<dynamic>[tastingNoteID, sakeID, createdAtUTC]);
  @override
  @JsonKey(name: 'id')
  final String tastingNoteID;
  @override
  @JsonKey(name: 'sake_id')
  final String sakeID;
  @override
  @JsonKey(name: 'created_at_utc')
  final int createdAtUTC;
  @override
  final String appearanceSoundness;
  @override
  final String appearanceHueComment;
  @override
  final String appearanceViscosityComment;
  @override
  final String fragranceSoundness;
  @override
  final String fragranceStrengthComment;
  @override
  final String fragranceExample;
  @override
  final String fragranceMainly;
  @override
  final String fragranceComplexityComment;
  @override
  final String tasteSoundness;
  @override
  final String tasteAttackComment;
  @override
  final String tasteTexture;
  @override
  final String tasteExample;
  @override
  final String tasteSweetnessComment;
  @override
  final String afterFlavorStrengthComment;
  @override
  final String afterFlavorExample;
  @override
  final String reverberationStrengthComment;
  @override
  final String reverberationExample;
  @override
  final String tasteComplexityComment;
  @override
  final String individuality;
  @override
  final String noticeComment;
  @override
  final String flavorTypeComment;
  @override
  final double afterFlavorStrength;
  @override
  final double appearanceHue;
  @override
  final double appearanceViscosity;
  @override
  final double fragranceComplexity;
  @override
  final double fragranceStrength;
  @override
  final double reverberationStrength;
  @override
  final double tasteAttack;
  @override
  final double tasteComplexity;
  @override
  final double tasteSweetness;

  @override
  Map<String, dynamic> toJSON() => _$_SQLiteTastingNoteToJson(this);
}
