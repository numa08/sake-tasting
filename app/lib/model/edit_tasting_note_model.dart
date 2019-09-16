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
  void setComment(String comment);
  void addImage(File image);
  Future<File> deleteImage(int index);

  void setAppearanceSoundness(String value);
  void setAppearanceHueComment(String value);
  void setAppearanceViscosityComment(String value);
  void setFragranceSoundness(String value);
  void setFragranceStrengthComment(String value);
  void setFragranceExample(String value);
  void setFragranceMainly(String value);
  void setFragranceComplexityComment(String value);
  void setTasteSoundness(String value);
  void setTasteAttackComment(String value);
  void setTasteTexture(String value);
  void setTasteExample(String value);
  void setTasteSweetnessComment(String value);
  void setAfterFlavorStrengthComment(String value);
  void setAfterFlavorExample(String value);
  void setReverberationStrengthComment(String value);
  void setReverberationExample(String value);
  void setTasteComplexityComment(String value);
  void setIndividuality(String value);
  void setNoticeComment(String value);
  void setFlavorTypeComment(String value);
}
