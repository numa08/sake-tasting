import 'dart:io';

import 'package:app/data/database/entitiy/entity.dart' as e;
import 'package:app/model/model.dart';
import 'package:equatable/equatable.dart';
import 'package:path/path.dart';

class TastingNoteID extends Equatable {
  TastingNoteID({this.value}) : super(<dynamic>[value]);

  final String value;
}

class TastingNote extends Equatable {
  TastingNote(
      {this.id,
      this.sake,
      this.brewery,
      this.comment,
      this.images,
      this.createdAt,
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
      this.flavorTypeComment})
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
    final createdAt = DateTime.fromMillisecondsSinceEpoch(ne.createdAtUTC);
    final tastingNote = TastingNote(
        id: TastingNoteID(value: ne.tastingNoteID),
        sake: sake,
        brewery: brewery,
        comment: ne.comment,
        images: images,
        createdAt: createdAt);
    return tastingNote;
  }
  final TastingNoteID id;
  final Sake sake;
  final Brewery brewery;
  final String comment;
  final List<TastingNoteImage> images;
  final DateTime createdAt;

  final String appearanceSoundness;
  final String appearanceHueComment;
  final String appearanceViscosityComment;
  final String fragranceSoundness;
  final String fragranceStrengthComment;
  final String fragranceExample;
  final String fragranceMainly;
  final String fragranceComplexityComment;
  final String tasteSoundness;
  final String tasteAttackComment;
  final String tasteTexture;
  final String tasteExample;
  final String tasteSweetnessComment;
  final String afterFlavorStrengthComment;
  final String afterFlavorExample;
  final String reverberationStrengthComment;
  final String reverberationExample;
  final String tasteComplexityComment;
  final String individuality;
  final String noticeComment;
  final String flavorTypeComment;

  TastingNote copyTo({
    Sake sake,
    Brewery brewery,
    String comment,
    List<TastingNoteImage> images,
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
  }) =>
      TastingNote(
        id: id,
        sake: sake ?? this.sake,
        brewery: brewery ?? this.brewery,
        comment: comment ?? this.comment,
        images: images ?? this.images,
        createdAt: createdAt,
        appearanceSoundness: appearanceSoundness ?? this.appearanceSoundness,
        appearanceHueComment: appearanceHueComment ?? this.appearanceHueComment,
        appearanceViscosityComment:
            appearanceViscosityComment ?? this.appearanceViscosityComment,
        fragranceSoundness: fragranceSoundness ?? this.fragranceSoundness,
        fragranceStrengthComment:
            fragranceStrengthComment ?? this.fragranceStrengthComment,
        fragranceExample: fragranceExample ?? this.fragranceExample,
        fragranceMainly: fragranceMainly ?? this.fragranceMainly,
        fragranceComplexityComment:
            fragranceComplexityComment ?? this.fragranceComplexityComment,
        tasteSoundness: tasteSoundness ?? this.tasteSoundness,
        tasteAttackComment: tasteAttackComment ?? this.tasteAttackComment,
        tasteTexture: tasteTexture ?? this.tasteTexture,
        tasteExample: tasteExample ?? this.tasteExample,
        tasteSweetnessComment:
            tasteSweetnessComment ?? this.tasteSweetnessComment,
        afterFlavorStrengthComment:
            afterFlavorStrengthComment ?? this.afterFlavorStrengthComment,
        afterFlavorExample: afterFlavorExample ?? this.afterFlavorExample,
        reverberationStrengthComment:
            reverberationStrengthComment ?? this.reverberationStrengthComment,
        reverberationExample: reverberationExample ?? this.reverberationExample,
        tasteComplexityComment:
            tasteComplexityComment ?? this.tasteComplexityComment,
        individuality: individuality ?? this.individuality,
        noticeComment: noticeComment ?? this.noticeComment,
        flavorTypeComment: flavorTypeComment ?? this.flavorTypeComment,
      );

  e.TastingNote toTastingNoteEntity() => e.TastingNote.crate(
      tastingNoteID: id.value,
      comment: comment,
      sakeID: sake.id.value,
      createdAtUTC: createdAt.toUtc().millisecondsSinceEpoch,
      appearanceSoundness: appearanceSoundness,
      appearanceHueComment: appearanceHueComment,
      appearanceViscosityComment: appearanceViscosityComment,
      fragranceSoundness: fragranceSoundness,
      fragranceStrengthComment: fragranceStrengthComment,
      fragranceExample: fragranceExample,
      fragranceMainly: fragranceMainly,
      fragranceComplexityComment: fragranceComplexityComment,
      tasteSoundness: tasteSoundness,
      tasteAttackComment: tasteAttackComment,
      tasteTexture: tasteTexture,
      tasteExample: tasteExample,
      tasteSweetnessComment: tasteSweetnessComment,
      afterFlavorStrengthComment: afterFlavorStrengthComment,
      afterFlavorExample: afterFlavorExample,
      reverberationStrengthComment: reverberationStrengthComment,
      reverberationExample: reverberationExample,
      tasteComplexityComment: tasteComplexityComment,
      individuality: individuality,
      noticeComment: noticeComment,
      flavorTypeComment: flavorTypeComment);

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
}
