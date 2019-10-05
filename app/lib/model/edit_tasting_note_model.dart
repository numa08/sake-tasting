import 'dart:io';

import 'package:app/data/database/database.dart';
import 'package:app/model/model.dart';
import 'package:async/async.dart';
import 'package:rxdart/rxdart.dart';

import 'edit_tasting_note_model_impl.dart';

abstract class EditTastingNoteModel {
  factory EditTastingNoteModel(TastingNoteDatabase database) =>
      EditTastingNoteModelImpl(database);
  Observable<TastingNote> get editingTarget;
  Observable<bool> get canSave;
  Observable<TastingNote> get onSaveSuccess;
  Observable<List<TastingNoteImage>> get images;
  Observable<Result<TastingNote>> saveResult(TastingNoteID id);
  Future<void> startEditing();
  Future<void> save();
  Future<void> close();
  void setSakeName(String sakeName);
  void setBreweryName(String breweryName);
  void addImage(File image);
  Future<File> deleteImage(int index);
  void setStringField(StringValueField field, String value);
  void setDoubleField(DoubleValueField field, double value);
}
