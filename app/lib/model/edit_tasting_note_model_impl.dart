import 'dart:io';

import 'package:app/data/database/database.dart';
import 'package:app/model/model.dart';
import 'package:async/async.dart';
import 'package:path/path.dart';
import 'package:path_provider/path_provider.dart';
import 'package:rxdart/rxdart.dart';
import 'package:uuid/uuid.dart';

class EditTastingNoteModelImpl implements EditTastingNoteModel {
  EditTastingNoteModelImpl(this._database);

  static final Uuid _uuid = Uuid();

  final TastingNoteDatabase _database;
  final _editingTargetSubject = BehaviorSubject<TastingNote>.seeded(null);
  final _saveResultSubject = PublishSubject<Result<TastingNote>>();
  final _tastingNoteImagesSubject =
      BehaviorSubject<List<TastingNoteImage>>.seeded(<TastingNoteImage>[]);
  @override
  Observable<TastingNote> get editingTarget => _editingTargetSubject;
  @override
  Observable<TastingNote> get onSaveSuccess =>
      _saveResultSubject.where((t) => t.isValue).map((t) => t.asValue.value);
  @override
  Observable<List<TastingNoteImage>> get images => _tastingNoteImagesSubject;

  @override
  Observable<bool> get canSave =>
      Observable.combineLatest2<TastingNote, List<TastingNoteImage>, bool>(
          _editingTargetSubject, _tastingNoteImagesSubject,
          (TastingNote note, List<TastingNoteImage> images) {
        return note != null &&
            note.id != null &&
            note.sake != null &&
            note.sake.name != null &&
            note.sake.name.isNotEmpty &&
            note.brewery != null &&
            note.brewery.name != null &&
            note.brewery.name.isNotEmpty &&
            note.createdAt != null &&
            images.isNotEmpty;
      });

  @override
  Future<void> save() async {
    final dataPath = await getApplicationDocumentsDirectory();
    final images = _tastingNoteImagesSubject.value;

    try {
      final newImages = images.map((i) {
        final newPath = join(dataPath.path, basename(i.image.path));
        final newFile = i.image.copySync(newPath);
        return TastingNoteImage(id: i.id, image: newFile);
      }).toList();
      final value = _editingTargetSubject.value.copyTo(images: newImages);
      await _database.save(value.toSakeEntity(), value.toBreweryEntity(),
          value.toTastingNoteImageEntities(), value.toTastingNoteEntity());
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
  void setSakeName(String sakeName) {
    final value = _editingTargetSubject.value;
    final newValue = value.copyTo(sake: value.sake.copyTo(name: sakeName));
    _editingTargetSubject.add(newValue);
  }

  @override
  void addImage(File image) {
    final newImage = TastingNoteImage(
        id: TastingNoteImageID(value: _uuid.v4()), image: image);
    final value = _tastingNoteImagesSubject.value..add(newImage);
    _tastingNoteImagesSubject.add(value);
  }

  @override
  Future<File> deleteImage(int index) async {
    final value = _tastingNoteImagesSubject.value;
    final image = value.removeAt(index);
    _tastingNoteImagesSubject.add(value);
    return image.image;
  }

  @override
  Future<void> startEditing() async {
    _editingTargetSubject.add(TastingNote(
        id: TastingNoteID(value: _uuid.v4()),
        sake: Sake(id: SakeID(value: _uuid.v4())),
        brewery: Brewery(id: BreweryID(value: _uuid.v4())),
        flavorTypes: const <FlavorType>[],
        stringField: const {},
        doubleField: const {},
        createdAt: DateTime.now()));
    _tastingNoteImagesSubject.add([]);
  }

  @override
  Future<void> close() async {
    await _tastingNoteImagesSubject.close();
    await _saveResultSubject.close();
    await _editingTargetSubject.close();
  }

  @override
  void setStringField(StringValueField field, String value) {
    final target = _editingTargetSubject.value;
    final fields = Map.of(target.stringField);
    fields[field] = value;
    final newTarget = target.copyTo(stringField: fields);
    _editingTargetSubject.add(newTarget);
  }

  @override
  void setDoubleField(DoubleValueField field, double value) {
    final target = _editingTargetSubject.value;
    final fields = Map.of(target.doubleField);
    fields[field] = value;
    final newTarget = target.copyTo(doubleField: fields);
    _editingTargetSubject.add(newTarget);
  }

  @override
  void setFlavorType(List<FlavorType> flavorTypes) {
    final target = _editingTargetSubject.value;
    final newTarget = target.copyTo(flavorTypes: flavorTypes);
    _editingTargetSubject.add(newTarget);
  }
}
