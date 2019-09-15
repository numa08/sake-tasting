import 'dart:core';

import 'package:app/data/database/database.dart';
import 'package:app/model/model.dart';
import 'package:rxdart/rxdart.dart';

import 'tasting_note_model_impl.dart';

abstract class TastingNoteModel {
  factory TastingNoteModel(TastingNoteDatabase database) =>
      TastingNoteModelImpl(database);
  Observable<List<TastingNote>> get allTastingNotes;
  Observable<TastingNote> tastingNoteByID(TastingNoteID id);
  Future<void> fetchAll();
  Future<void> close();
}
