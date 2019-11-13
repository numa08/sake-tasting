import 'dart:io';

import 'package:app/data/database/entitiy/entity.dart' as e;
import 'package:app/model/model.dart';
import 'package:equatable/equatable.dart';
import 'package:path/path.dart';

class TastingNoteID extends Equatable {
  TastingNoteID({this.value}) : super(<dynamic>[value]);

  final String value;
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
      this.flavorTypes,
      this.createdAt,
      this.stringField,
      this.doubleField})
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
        flavorTypes: flavorTypes,
        createdAt: createdAt,
        stringField: <StringValueField, String>{
          StringValueField.appearanceSoundness: ne.appearanceSoundness,
          StringValueField.appearanceHueComment: ne.appearanceHueComment,
          StringValueField.appearanceViscosityComment:
              ne.appearanceViscosityComment,
          StringValueField.fragranceSoundness: ne.fragranceSoundness,
          StringValueField.fragranceStrengthComment:
              ne.fragranceStrengthComment,
          StringValueField.fragranceExample: ne.fragranceExample,
          StringValueField.fragranceMainly: ne.fragranceMainly,
          StringValueField.fragranceComplexityComment:
              ne.fragranceComplexityComment,
          StringValueField.tasteSoundness: ne.tasteSoundness,
          StringValueField.tasteAttackComment: ne.tasteAttackComment,
          StringValueField.tasteTexture: ne.tasteTexture,
          StringValueField.tasteExample: ne.tasteExample,
          StringValueField.tasteSweetnessComment: ne.tasteSweetnessComment,
          StringValueField.afterFlavorStrengthComment:
              ne.afterFlavorStrengthComment,
          StringValueField.afterFlavorExample: ne.afterFlavorExample,
          StringValueField.reverberationStrengthComment:
              ne.reverberationStrengthComment,
          StringValueField.reverberationExample: ne.reverberationExample,
          StringValueField.tasteComplexityComment: ne.tasteComplexityComment,
          StringValueField.individuality: ne.individuality,
          StringValueField.noticeComment: ne.noticeComment,
          StringValueField.flavorTypeComment: ne.flavorTypeComment,
        },
        doubleField: {
          DoubleValueField.afterFlavorStrength: ne.afterFlavorStrength,
          DoubleValueField.appearanceHue: ne.appearanceHue,
          DoubleValueField.appearanceViscosity: ne.appearanceViscosity,
          DoubleValueField.fragranceComplexity: ne.fragranceComplexity,
          DoubleValueField.fragranceStrength: ne.fragranceStrength,
          DoubleValueField.reverberationStrength: ne.reverberationStrength,
          DoubleValueField.tasteAttack: ne.tasteAttack,
          DoubleValueField.tasteComplexity: ne.tasteComplexity,
          DoubleValueField.tasteSweetness: ne.tasteSweetness,
        });
    return tastingNote;
  }
  final TastingNoteID id;
  final Sake sake;
  final Brewery brewery;
  final List<TastingNoteImage> images;
  final List<FlavorType> flavorTypes;
  final DateTime createdAt;
  final Map<StringValueField, String> stringField;
  final Map<DoubleValueField, double> doubleField;

  TastingNote copyTo({
    Sake sake,
    Brewery brewery,
    List<TastingNoteImage> images,
    List<FlavorType> flavorTypes,
    Map<StringValueField, String> stringField,
    Map<DoubleValueField, double> doubleField,
  }) =>
      TastingNote(
          id: id,
          sake: sake ?? this.sake,
          brewery: brewery ?? this.brewery,
          images: images ?? this.images,
          flavorTypes: flavorTypes ?? this.flavorTypes,
          createdAt: createdAt,
          stringField: stringField ?? this.stringField,
          doubleField: doubleField ?? this.doubleField);

  e.TastingNote toTastingNoteEntity() => e.TastingNote.crate(
      tastingNoteID: id.value,
      sakeID: sake.id.value,
      createdAtUTC: createdAt.toUtc().millisecondsSinceEpoch,
      appearanceSoundness: stringField[StringValueField.appearanceSoundness],
      appearanceHueComment: stringField[StringValueField.appearanceHueComment],
      appearanceViscosityComment:
          stringField[StringValueField.appearanceViscosityComment],
      fragranceSoundness: stringField[StringValueField.fragranceSoundness],
      fragranceStrengthComment:
          stringField[StringValueField.fragranceStrengthComment],
      fragranceExample: stringField[StringValueField.fragranceExample],
      fragranceMainly: stringField[StringValueField.fragranceMainly],
      fragranceComplexityComment:
          stringField[StringValueField.fragranceComplexityComment],
      tasteSoundness: stringField[StringValueField.tasteSoundness],
      tasteAttackComment: stringField[StringValueField.tasteAttackComment],
      tasteTexture: stringField[StringValueField.tasteTexture],
      tasteExample: stringField[StringValueField.tasteExample],
      tasteSweetnessComment:
          stringField[StringValueField.tasteSweetnessComment],
      afterFlavorStrengthComment:
          stringField[StringValueField.afterFlavorStrengthComment],
      afterFlavorExample: stringField[StringValueField.afterFlavorExample],
      reverberationStrengthComment:
          stringField[StringValueField.reverberationStrengthComment],
      reverberationExample: stringField[StringValueField.reverberationExample],
      tasteComplexityComment:
          stringField[StringValueField.tasteComplexityComment],
      individuality: stringField[StringValueField.individuality],
      noticeComment: stringField[StringValueField.noticeComment],
      flavorTypeComment: stringField[StringValueField.flavorTypeComment],
      flavorType: flavorTypes.map((t) => t.name).join(','),
      afterFlavorStrength: doubleField[DoubleValueField.afterFlavorStrength],
      appearanceHue: doubleField[DoubleValueField.appearanceHue],
      appearanceViscosity: doubleField[DoubleValueField.appearanceViscosity],
      fragranceComplexity: doubleField[DoubleValueField.fragranceComplexity],
      fragranceStrength: doubleField[DoubleValueField.fragranceStrength],
      reverberationStrength:
          doubleField[DoubleValueField.reverberationStrength],
      tasteAttack: doubleField[DoubleValueField.tasteAttack],
      tasteComplexity: doubleField[DoubleValueField.tasteComplexity],
      tasteSweetness: doubleField[DoubleValueField.tasteSweetness]);

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

  bool get isDraft =>
      stringField == null ||
      stringField.values.where((v) => v == null).isNotEmpty;
}
