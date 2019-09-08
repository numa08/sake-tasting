// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'sake_entity_impl.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

SakeEntityImpl _$SakeEntityImplFromJson(Map<String, dynamic> json) {
  return SakeEntityImpl(
    flavorComplexityOther: json['flavor_complexity_other'] as String,
    tasteSoundness: json['taste_soundness'] as String,
    aromaComplexityOther: json['aroma_complexity_other'] as String,
    aromaExample: json['aroma_example'] as String,
    aromaOther: json['aroma_other'] as String,
    attackOther: json['attack_other'] as String,
    breweriesID: json['breweries_id'] as String,
    createdAtUTC: json['created_at_utc'] as int,
    flavorExample: json['flavor_example'] as String,
    flavorSoundness: json['flavor_soundness'] as String,
    flavorStrengthOther: json['flavor_strength_other'] as String,
    hueOther: json['hue_other'] as String,
    id: json['id'] as String,
    individuality: json['individuality'] as String,
    mainFlavor: json['main_flavor'] as String,
    name: json['name'] as String,
    notice: json['notice'] as String,
    reverberationElement: json['reverberation_element'] as String,
    reverberationOther: json['reverberation_other'] as String,
    sweetnessOther: json['sweetness_other'] as String,
    tasteExample: json['taste_example'] as String,
    texture: json['texture'] as String,
    typeNotice: json['type_notice'] as String,
    updatedAtUTC: json['updated_at_utc'] as int,
    viscosityOther: json['viscosity_other'] as String,
    visualSoundness: json['visual_soundness'] as String,
  );
}

Map<String, dynamic> _$SakeEntityImplToJson(SakeEntityImpl instance) =>
    <String, dynamic>{
      'aroma_complexity_other': instance.aromaComplexityOther,
      'aroma_example': instance.aromaExample,
      'aroma_other': instance.aromaOther,
      'attack_other': instance.attackOther,
      'breweries_id': instance.breweriesID,
      'created_at_utc': instance.createdAtUTC,
      'flavor_example': instance.flavorExample,
      'flavor_soundness': instance.flavorSoundness,
      'flavor_strength_other': instance.flavorStrengthOther,
      'hue_other': instance.hueOther,
      'id': instance.id,
      'individuality': instance.individuality,
      'main_flavor': instance.mainFlavor,
      'name': instance.name,
      'notice': instance.notice,
      'reverberation_element': instance.reverberationElement,
      'reverberation_other': instance.reverberationOther,
      'sweetness_other': instance.sweetnessOther,
      'taste_example': instance.tasteExample,
      'texture': instance.texture,
      'type_notice': instance.typeNotice,
      'updated_at_utc': instance.updatedAtUTC,
      'viscosity_other': instance.viscosityOther,
      'visual_soundness': instance.visualSoundness,
      'flavor_complexity_other': instance.flavorComplexityOther,
      'taste_soundness': instance.tasteSoundness,
    };
