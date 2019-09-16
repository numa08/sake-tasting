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
    json['appearance_soundness'] as String,
    json['appearance_hue_comment'] as String,
    json['appearance_viscosity_comment'] as String,
    json['fragrance_soundness'] as String,
    json['fragrance_strength_comment'] as String,
    json['fragrance_example'] as String,
    json['fragrance_mainly'] as String,
    json['fragrance_complexity_comment'] as String,
    json['taste_soundness'] as String,
    json['taste_attack_comment'] as String,
    json['taste_texture'] as String,
    json['taste_example'] as String,
    json['taste_sweetness_comment'] as String,
    json['after_flavor_strength_comment'] as String,
    json['after_flavor_example'] as String,
    json['reverberation_strength_comment'] as String,
    json['reverberation_example'] as String,
    json['taste_complexity_comment'] as String,
    json['individuality'] as String,
    json['notice_comment'] as String,
    json['flavor_type_comment'] as String,
  );
}

Map<String, dynamic> _$_SQLiteTastingNoteToJson(_SQLiteTastingNote instance) =>
    <String, dynamic>{
      'id': instance.tastingNoteID,
      'comment': instance.comment,
      'sake_id': instance.sakeID,
      'created_at_utc': instance.createdAtUTC,
      'appearance_soundness': instance.appearanceSoundness,
      'appearance_hue_comment': instance.appearanceHueComment,
      'appearance_viscosity_comment': instance.appearanceViscosityComment,
      'fragrance_soundness': instance.fragranceSoundness,
      'fragrance_strength_comment': instance.fragranceStrengthComment,
      'fragrance_example': instance.fragranceExample,
      'fragrance_mainly': instance.fragranceMainly,
      'fragrance_complexity_comment': instance.fragranceComplexityComment,
      'taste_soundness': instance.tasteSoundness,
      'taste_attack_comment': instance.tasteAttackComment,
      'taste_texture': instance.tasteTexture,
      'taste_example': instance.tasteExample,
      'taste_sweetness_comment': instance.tasteSweetnessComment,
      'after_flavor_strength_comment': instance.afterFlavorStrengthComment,
      'after_flavor_example': instance.afterFlavorExample,
      'reverberation_strength_comment': instance.reverberationStrengthComment,
      'reverberation_example': instance.reverberationExample,
      'taste_complexity_comment': instance.tasteComplexityComment,
      'individuality': instance.individuality,
      'notice_comment': instance.noticeComment,
      'flavor_type_comment': instance.flavorTypeComment,
    };
