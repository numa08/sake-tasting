import 'package:app/data/database/database.dart';
import 'package:app/model/model.dart';
import 'package:rxdart/rxdart.dart';

class TastingNoteModelImpl implements TastingNoteModel {
  TastingNoteModelImpl(this._database);

  final TastingNoteDatabase _database;
  final _allTastingNotesSubject = BehaviorSubject.seeded(<TastingNote>[]);

  @override
  Observable<List<TastingNote>> get allTastingNotes => _allTastingNotesSubject;

  @override
  Observable<TastingNote> tastingNoteByID(TastingNoteID id) =>
      allTastingNotes.map((l) => l.firstWhere((t) => t.id == id));

  @override
  Future<void> fetchAll() async {
    final entityList = await _database.allTastingNotes();
    final noteListTask = entityList.map((e) async {
      final sakeEntity = await _database.findSakeByID(e.sakeID);
      final breweryEntity =
          await _database.findBreweryByID(sakeEntity.breweryID);
      return TastingNote.create(e, sakeEntity, breweryEntity);
    });
    final noteList = (await Future.wait(noteListTask)).toList();
    _allTastingNotesSubject.add(noteList);
  }

  @override
  Future<void> close() async {
    await _allTastingNotesSubject.close();
    await _database.close();
  }
}
