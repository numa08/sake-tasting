import 'package:app/data/database/entitiy/entity.dart';
import 'package:app/data/database/entitiy/tasting_note_image.dart';
import 'package:app/data/database/sqlite_database_impl.dart';

abstract class TastingNoteDatabase {
  factory TastingNoteDatabase(String path) => SQLiteDatabaseImpl(path);
  Future<List<TastingNote>> allTastingNotes();
  Future<List<Sake>> allSake();
  Future<List<Brewery>> allBreweries();
  Future<Sake> findSakeByID(String id);
  Future<Brewery> findBreweryByID(String id);
  Future<List<TastingNoteImage>> findImage(String tastingNoteID);
  Future<void> save(Sake sake, Brewery brewery, List<TastingNoteImage> image,
      TastingNote tastingNote);
  Future<void> close();
}
