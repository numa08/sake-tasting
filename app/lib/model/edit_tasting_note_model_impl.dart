import 'package:app/data/database/database.dart';
import 'package:app/model/model.dart';
import 'package:async/async.dart';
import 'package:rxdart/rxdart.dart';
import 'package:uuid/uuid.dart';

class EditTastingNoteModelImpl implements EditTastingNoteModel {
  EditTastingNoteModelImpl(this._database);

  final TastingNoteDatabase _database;
  final _editingTargetSubject = BehaviorSubject<TastingNote>.seeded(null);
  final _saveResultSubject = PublishSubject<Result<TastingNote>>();
  @override
  Observable<TastingNote> get editingTarget => _editingTargetSubject;
  @override
  Observable<TastingNote> get onSaveSuccess =>
      _saveResultSubject.where((t) => t.isValue).map((t) => t.asValue.value);

  @override
  Observable<bool> get canSave => _editingTargetSubject.map((note) {
        return note != null &&
            note.id != null &&
            note.sake != null &&
            note.sake.name != null &&
            note.brewery != null &&
            note.brewery.name != null &&
            note.comment != null &&
            note.createdAt != null;
      });

  @override
  Future<void> save() async {
    final value = _editingTargetSubject.value;
    try {
      await _database.saveBrewery(value.toBreweryEntity());
      await _database.saveSake(value.toSakeEntity());
      await _database.saveTastingNote(value.toTastingNoteEntity());
      _saveResultSubject.add(Result.value(value));
    } on Exception catch (e) {
      _saveResultSubject.add(Result.error(e));
    }
  }

  @override
  Observable<Result<TastingNote>> saveResult(TastingNoteID id) =>
      _saveResultSubject.where((t) => t.isValue && t.asValue.value.id == id);

  @override
  void setBreweryName(String breweryName) {
    final value = _editingTargetSubject.value;
    final newValue =
        value.copyTo(brewery: value.brewery.copyTo(name: breweryName));
    _editingTargetSubject.add(newValue);
  }

  @override
  void setComment(String comment) {
    final value = _editingTargetSubject.value;
    final newValue = value.copyTo(comment: comment);
    _editingTargetSubject.add(newValue);
  }

  @override
  void setSakeName(String sakeName) {
    final value = _editingTargetSubject.value;
    final newValue = value.copyTo(sake: value.sake.copyTo(name: sakeName));
    _editingTargetSubject.add(newValue);
  }

  @override
  Future<void> startEditing() async {
    final uuid = Uuid();
    _editingTargetSubject.add(TastingNote(
        id: TastingNoteID(value: uuid.v4()),
        sake: Sake(id: SakeID(value: uuid.v4())),
        brewery: Brewery(id: BreweryID(value: uuid.v4())),
        createdAt: DateTime.now()));
  }

  @override
  Future<void> close() async {
    await _saveResultSubject.close();
    await _editingTargetSubject.close();
  }
}
