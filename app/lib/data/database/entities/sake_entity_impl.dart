import 'package:app/data/database/entities/sake_entity.dart';
import 'package:json_annotation/json_annotation.dart';

part 'sake_entity_impl.g.dart';

@JsonSerializable(fieldRename: FieldRename.snake)
class SakeEntityImpl extends SakeEntity {
  SakeEntityImpl(
      {this.flavorComplexityOther,
      this.tasteSoundness,
      this.aromaComplexityOther,
      this.aromaExample,
      this.aromaOther,
      this.attackOther,
      this.breweriesID,
      this.createdAtUTC,
      this.flavorExample,
      this.flavorSoundness,
      this.flavorStrengthOther,
      this.hueOther,
      this.id,
      this.individuality,
      this.mainFlavor,
      this.name,
      this.notice,
      this.reverberationElement,
      this.reverberationOther,
      this.sweetnessOther,
      this.tasteExample,
      this.texture,
      this.typeNotice,
      this.updatedAtUTC,
      this.viscosityOther,
      this.visualSoundness})
      : super(<dynamic>[
          id,
          name,
          breweriesID,
          visualSoundness,
          hueOther,
          viscosityOther,
          flavorSoundness,
          flavorStrengthOther,
          flavorExample,
          mainFlavor,
          flavorComplexityOther,
          tasteSoundness,
          sweetnessOther,
          aromaOther,
          aromaExample,
          reverberationOther,
          reverberationElement,
          aromaComplexityOther,
          individuality,
          notice,
          typeNotice,
          createdAtUTC,
          updatedAtUTC
        ]);

  @override
  final String aromaComplexityOther;
  @override
  final String aromaExample;
  @override
  final String aromaOther;
  @override
  final String attackOther;
  @override
  @JsonKey(name: 'breweries_id')
  final String breweriesID;
  @override
  @JsonKey(name: 'created_at_utc')
  final int createdAtUTC;
  @override
  final String flavorExample;
  @override
  final String flavorSoundness;
  @override
  final String flavorStrengthOther;
  @override
  final String hueOther;
  @override
  final String id;
  @override
  final String individuality;
  @override
  final String mainFlavor;
  @override
  final String name;
  @override
  final String notice;
  @override
  final String reverberationElement;
  @override
  final String reverberationOther;
  @override
  final String sweetnessOther;
  @override
  final String tasteExample;
  @override
  final String texture;
  @override
  final String typeNotice;
  @override
  @JsonKey(name: 'updated_at_utc')
  final int updatedAtUTC;
  @override
  final String viscosityOther;
  @override
  final String visualSoundness;
  @override
  final String flavorComplexityOther;
  @override
  final String tasteSoundness;

  @override
  Map<String, dynamic> toJson() {
    return _$SakeEntityImplToJson(this);
  }
}
