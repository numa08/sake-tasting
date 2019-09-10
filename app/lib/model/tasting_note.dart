import 'package:app/data/database/entitiy/entity.dart' as e;
import 'package:app/model/model.dart';
import 'package:equatable/equatable.dart';

class TastingNoteID extends Equatable {
  TastingNoteID({this.value}) : super(<dynamic>[value]);

  final String value;
}

class TastingNote extends Equatable {
  TastingNote({this.id, this.sake, this.brewery, this.comment, this.createdAt})
      : super(<dynamic>[id]);
  factory TastingNote.create(e.TastingNote ne, e.Sake se, e.Brewery be) {
    final brewery = Brewery(name: be.name, id: BreweryID(value: be.breweryID));
    final sake = Sake(name: se.name, id: SakeID(value: se.sakeID));
    final createdAt = DateTime.fromMillisecondsSinceEpoch(ne.createdAtUTC);
    final tastingNote = TastingNote(
        id: TastingNoteID(value: ne.tastingNoteID),
        sake: sake,
        brewery: brewery,
        comment: ne.comment,
        createdAt: createdAt);
    return tastingNote;
  }
  final TastingNoteID id;
  final Sake sake;
  final Brewery brewery;
  final String comment;
  final DateTime createdAt;
}
