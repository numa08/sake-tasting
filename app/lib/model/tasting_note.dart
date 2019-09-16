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
      this.createdAt})
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

  TastingNote copyTo(
          {Sake sake,
          Brewery brewery,
          String comment,
          List<TastingNoteImage> images}) =>
      TastingNote(
          id: id,
          sake: sake ?? this.sake,
          brewery: brewery ?? this.brewery,
          comment: comment ?? this.comment,
          images: images ?? this.images,
          createdAt: createdAt);

  e.TastingNote toTastingNoteEntity() => e.TastingNote.crate(
      tastingNoteID: id.value,
      comment: comment,
      sakeID: sake.id.value,
      createdAtUTC: createdAt.toUtc().millisecondsSinceEpoch);

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
