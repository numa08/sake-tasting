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
  TastingNote({
    this.id,
    this.sake,
    this.brewery,
    this.images,
    this.createdAt,
    this.stringField,
  }) : super(<dynamic>[id]);
  factory TastingNote.create(e.TastingNote ne, e.Sake se, e.Brewery be,
      List<e.TastingNoteImage> ies, String dataDirectoryPath) {
    final brewery = Brewery(name: be.name, id: BreweryID(value: be.breweryID));
    final sake = Sake(name: se.name, id: SakeID(value: se.sakeID));
    final images = ies
        .map((ie) => TastingNoteImage(
            id: TastingNoteImageID(value: ie.imageID),
            image: File(join(dataDirectoryPath, ie.name))))
        .toList();
    final createdAt = DateTime.fromMillisecondsSinceEpoch(ne.createdAtUTC);
    final tastingNote = TastingNote(
        id: TastingNoteID(value: ne.tastingNoteID),
        sake: sake,
        brewery: brewery,
        images: images,
        createdAt: createdAt);
    return tastingNote;
  }
  final TastingNoteID id;
  final Sake sake;
  final Brewery brewery;
  final List<TastingNoteImage> images;
  final DateTime createdAt;
  final Map<StringValueField, String> stringField;

  TastingNote copyTo({
    Sake sake,
    Brewery brewery,
    List<TastingNoteImage> images,
    Map<StringValueField, String> stringField,
  }) =>
      TastingNote(
        id: id,
        sake: sake ?? this.sake,
        brewery: brewery ?? this.brewery,
        images: images ?? this.images,
        createdAt: createdAt,
        stringField: stringField ?? this.stringField,
      );

  e.TastingNote toTastingNoteEntity() => e.TastingNote.crate(
        tastingNoteID: id.value,
        sakeID: sake.id.value,
        createdAtUTC: createdAt.toUtc().millisecondsSinceEpoch,
        appearanceSoundness: stringField[StringValueField.appearanceSoundness],
        appearanceHueComment:
            stringField[StringValueField.appearanceHueComment],
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
        reverberationExample:
            stringField[StringValueField.reverberationExample],
        tasteComplexityComment:
            stringField[StringValueField.tasteComplexityComment],
        individuality: stringField[StringValueField.individuality],
        noticeComment: stringField[StringValueField.noticeComment],
        flavorTypeComment: stringField[StringValueField.flavorTypeComment],
      );

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
