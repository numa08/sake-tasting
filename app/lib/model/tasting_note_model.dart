import 'dart:core';

import 'package:app/model/model.dart';
import 'package:rxdart/rxdart.dart';

abstract class TastingNoteModel {
  Observable<List<TastingNote>> get allTastingNotes;
  Observable<TastingNote> tastingNoteByID(TastingNoteID id);
  Future<void> fetchAll();
  Future<void> close();
}
