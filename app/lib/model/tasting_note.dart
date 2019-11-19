import 'dart:io';

import 'package:app/data/database/entitiy/entity.dart' as e;
import 'package:app/model/model.dart';
import 'package:equatable/equatable.dart';
import 'package:path/path.dart';

class TastingNoteID extends Equatable {
  TastingNoteID({this.value}) : super(<dynamic>[value]);

  final String value;
}

class ValueComment extends Equatable {
  ValueComment(this.value, this.comment) : super(<dynamic>[value, comment]);

  final double value;
  final String comment;
}

class Appearance extends Equatable {
  Appearance({this.soundness, this.hue, this.viscosity})
      : super(<dynamic>[soundness, viscosity]);
  final String soundness;
  final ValueComment hue;
  final ValueComment viscosity;

  Appearance copyTo(
          {String soundness, ValueComment hue, ValueComment viscosity}) =>
      Appearance(
          soundness: soundness ?? this.soundness,
          hue: hue ?? this.hue,
          viscosity: viscosity ?? this.viscosity);
}

class Fragrance extends Equatable {
  Fragrance(
      {this.soundness,
      this.strength,
      this.example,
      this.mainly,
      this.complexity})
      : super(<dynamic>[soundness, strength, example, mainly]);
  final String soundness;
  final ValueComment strength;
  final String example;
  final String mainly;
  final ValueComment complexity;

  Fragrance copyTo(
          {String soundness,
          ValueComment strength,
          String example,
          String mainly,
          ValueComment complexity}) =>
      Fragrance(
          soundness: soundness ?? this.soundness,
          strength: strength ?? this.strength,
          example: example ?? this.example,
          mainly: mainly ?? this.mainly,
          complexity: complexity ?? this.complexity);
}

class Taste extends Equatable {
  Taste(
      {this.soundness,
      this.attack,
      this.texture,
      this.example,
      this.sweetness,
      this.afterFlavorStrength,
      this.afterFlavorExample,
      this.reverberationStrength,
      this.reverberationExample,
      this.complexity})
      : super(<dynamic>[
          soundness,
          attack,
          texture,
          example,
          sweetness,
          afterFlavorStrength,
          afterFlavorExample,
          reverberationStrength,
          reverberationExample,
          complexity
        ]);

  final String soundness;
  final ValueComment attack;
  final String texture;
  final String example;
  final ValueComment sweetness;
  final ValueComment afterFlavorStrength;
  final String afterFlavorExample;
  final ValueComment reverberationStrength;
  final String reverberationExample;
  final ValueComment complexity;

  Taste copyTo({
    String soundness,
    ValueComment attack,
    String texture,
    String example,
    ValueComment sweetness,
    ValueComment afterFlavorStrength,
    String afterFlavorExample,
    ValueComment reverberationStrength,
    String reverberationExample,
    ValueComment complexity,
  }) =>
      Taste(
          soundness: soundness ?? this.soundness,
          attack: attack ?? this.attack,
          texture: texture ?? this.texture,
          example: example ?? this.example,
          sweetness: sweetness ?? this.sweetness,
          afterFlavorStrength: afterFlavorStrength ?? this.afterFlavorStrength,
          afterFlavorExample: afterFlavorExample ?? this.afterFlavorExample,
          reverberationStrength:
              reverberationStrength ?? this.reverberationStrength,
          reverberationExample:
              reverberationExample ?? this.reverberationExample,
          complexity: complexity ?? this.complexity);
}

class Individuality extends Equatable {
  Individuality(
      {this.individuality,
      this.notice,
      this.flavorTypes,
      this.flavorTypeComment})
      : super(<dynamic>[individuality, notice, flavorTypes, flavorTypeComment]);
  final String individuality;
  final String notice;
  final List<FlavorType> flavorTypes;
  final String flavorTypeComment;

  Individuality copyTo({
    String individuality,
    String notice,
    List<FlavorType> flavorTypes,
    String flavorTypeComment,
  }) =>
      Individuality(
          individuality: individuality ?? this.individuality,
          notice: notice ?? this.notice,
          flavorTypes: flavorTypes ?? this.flavorTypes,
          flavorTypeComment: flavorTypeComment ?? this.flavorTypeComment);
}

enum StringValueField {
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
  flavorTypeComment
}

enum DoubleValueField {
  afterFlavorStrength,
  appearanceHue,
  appearanceViscosity,
  fragranceComplexity,
  fragranceStrength,
  reverberationStrength,
  tasteAttack,
  tasteComplexity,
  tasteSweetness
}

bool isNullableStringValueField(StringValueField field) {
  switch (field) {
    case StringValueField.appearanceSoundness:
    case StringValueField.fragranceSoundness:
    case StringValueField.fragranceExample:
    case StringValueField.fragranceMainly:
    case StringValueField.tasteSoundness:
    case StringValueField.tasteTexture:
    case StringValueField.tasteExample:
    case StringValueField.afterFlavorExample:
    case StringValueField.reverberationExample:
    case StringValueField.individuality:
      return false;
    default:
      return true;
  }
}

class TastingNote extends Equatable {
  TastingNote(
      {this.id,
      this.sake,
      this.brewery,
      this.images,
      this.createdAt,
      this.appearance,
      this.fragrance,
      this.taste,
      this.individuality})
      : super(<dynamic>[id]);
  factory TastingNote.create(e.TastingNote ne, e.Sake se, e.Brewery be,
      List<e.TastingNoteImage> ies, String dataDirectoryPath) {
    final brewery = Brewery(name: be.name, id: BreweryID(value: be.breweryID));
    final sake = Sake(name: se.name, id: SakeID(value: se.sakeID));
    final images = ies
        .map((ie) => TastingNoteImage(
            id: TastingNoteImageID(value: ie.imageID),
            image: File(join(dataDirectoryPath, ie.name))))
        .toList();
    final flavorTypes =
        ne.flavorType.split(',').map((s) => FlavorType.fromName(s)).toList();
    final createdAt = DateTime.fromMillisecondsSinceEpoch(ne.createdAtUTC);
    final tastingNote = TastingNote(
        id: TastingNoteID(value: ne.tastingNoteID),
        sake: sake,
        brewery: brewery,
        images: images,
        createdAt: createdAt,
        appearance: Appearance(
            soundness: ne.appearanceSoundness,
            hue: ValueComment(ne.appearanceHue, ne.appearanceHueComment),
            viscosity: ValueComment(
                ne.appearanceViscosity, ne.appearanceViscosityComment)),
        fragrance: Fragrance(
            soundness: ne.fragranceSoundness,
            strength:
                ValueComment(ne.fragranceStrength, ne.fragranceStrengthComment),
            example: ne.fragranceExample,
            mainly: ne.fragranceMainly,
            complexity: ValueComment(
                ne.fragranceComplexity, ne.fragranceComplexityComment)),
        taste: Taste(
            soundness: ne.tasteSoundness,
            attack: ValueComment(ne.tasteAttack, ne.tasteAttackComment),
            texture: ne.tasteTexture,
            example: ne.tasteExample,
            sweetness:
                ValueComment(ne.tasteSweetness, ne.tasteSweetnessComment),
            afterFlavorStrength: ValueComment(
                ne.afterFlavorStrength, ne.afterFlavorStrengthComment),
            afterFlavorExample: ne.afterFlavorExample,
            reverberationStrength: ValueComment(
                ne.reverberationStrength, ne.reverberationStrengthComment),
            reverberationExample: ne.reverberationExample,
            complexity:
                ValueComment(ne.tasteComplexity, ne.tasteComplexityComment)),
        individuality: Individuality(
            individuality: ne.individuality,
            notice: ne.noticeComment,
            flavorTypes: flavorTypes,
            flavorTypeComment: ne.flavorTypeComment));
    return tastingNote;
  }
  final TastingNoteID id;
  final Sake sake;
  final Brewery brewery;
  final List<TastingNoteImage> images;
  final DateTime createdAt;
  final Appearance appearance;
  final Fragrance fragrance;
  final Taste taste;
  final Individuality individuality;

  TastingNote copyTo({
    Sake sake,
    Brewery brewery,
    List<TastingNoteImage> images,
    Appearance appearance,
    Fragrance fragrance,
    Taste taste,
    Individuality individuality,
  }) =>
      TastingNote(
          id: id,
          sake: sake ?? this.sake,
          brewery: brewery ?? this.brewery,
          images: images ?? this.images,
          createdAt: createdAt,
          appearance: appearance ?? this.appearance,
          fragrance: fragrance ?? this.fragrance,
          taste: taste ?? this.taste,
          individuality: individuality ?? this.individuality);

  e.TastingNote toTastingNoteEntity() => e.TastingNote.crate(
      tastingNoteID: id.value,
      sakeID: sake.id.value,
      createdAtUTC: createdAt.toUtc().millisecondsSinceEpoch,
      appearanceSoundness: appearance?.soundness,
      appearanceHueComment: appearance?.hue?.comment,
      appearanceViscosityComment: appearance?.viscosity?.comment,
      fragranceSoundness: fragrance?.soundness,
      fragranceStrengthComment: fragrance?.strength?.comment,
      fragranceExample: fragrance?.example,
      fragranceMainly: fragrance?.mainly,
      fragranceComplexityComment: fragrance?.complexity?.comment,
      tasteSoundness: taste?.soundness,
      tasteAttackComment: taste?.attack?.comment,
      tasteTexture: taste?.texture,
      tasteExample: taste?.example,
      tasteSweetnessComment: taste?.sweetness?.comment,
      afterFlavorStrengthComment: taste?.afterFlavorStrength?.comment,
      afterFlavorExample: taste?.afterFlavorExample,
      reverberationStrengthComment: taste?.reverberationStrength?.comment,
      reverberationExample: taste?.reverberationExample,
      tasteComplexityComment: taste?.complexity?.comment,
      individuality: individuality?.individuality,
      noticeComment: individuality?.notice,
      flavorTypeComment: individuality?.flavorTypeComment,
      flavorType: individuality?.flavorTypes?.map((t) => t.name)?.join(','),
      afterFlavorStrength: taste?.afterFlavorStrength?.value,
      appearanceHue: appearance?.hue?.value,
      appearanceViscosity: appearance?.viscosity?.value,
      fragranceComplexity: fragrance?.complexity?.value,
      fragranceStrength: fragrance?.strength?.value,
      reverberationStrength: taste?.reverberationStrength?.value,
      tasteAttack: taste?.attack?.value,
      tasteComplexity: taste?.complexity?.value,
      tasteSweetness: taste?.sweetness?.value);

  e.Sake toSakeEntity() => e.Sake.create(
      sakeID: sake.id.value, breweryID: brewery.id.value, name: sake.name);

  e.Brewery toBreweryEntity() =>
      e.Brewery.create(breweryID: brewery.id.value, name: brewery.name);

  List<e.TastingNoteImage> toTastingNoteImageEntities() => images
      .map((i) => e.TastingNoteImage.create(
          imageID: i.id.value,
          name: basename(i.image.path),
          tastingNoteID: id.value))
      .toList();

  bool get isDraft => false;
}
