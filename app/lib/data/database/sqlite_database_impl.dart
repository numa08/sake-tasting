import 'package:app/data/database/database.dart';
import 'package:app/data/database/entitiy/brewery.dart';
import 'package:app/data/database/entitiy/entity.dart';
import 'package:app/data/database/entitiy/sake.dart';
import 'package:app/data/database/entitiy/tasting_note.dart';
import 'package:sqflite/sqflite.dart';

class SQLiteDatabaseImpl implements TastingNoteDatabase {
  SQLiteDatabaseImpl(String databasePath)
      : _databaseManager = _DatabaseManager(databasePath);

  final _DatabaseManager _databaseManager;
  @override
  Future<List<Brewery>> allBreweries() async {
    final database = await _databaseManager.database;
    final entity = await database.query('brewery');
    final list = entity.map((e) => Brewery.fromJSON(e));
    return list.toList();
  }

  @override
  Future<List<Sake>> allSake() async {
    final database = await _databaseManager.database;
    final entity = await database.query('sake');
    final list = entity.map((e) => Sake.fromJSON(e));
    return list.toList();
  }

  @override
  Future<List<TastingNote>> allTastingNotes() async {
    final database = await _databaseManager.database;
    final entity = await database.query('tasting_note');
    final list = entity.map((e) => TastingNote.fromJSON(e));
    return list.toList();
  }

  @override
  Future<Brewery> findBreweryByID(String id) async {
    final entity = await _findByID('brewery', id);
    return entity == null ? null : Brewery.fromJSON(entity);
  }

  @override
  Future<Sake> findSakeByID(String id) async {
    final entity = await _findByID('sake', id);
    return entity == null ? null : Sake.fromJSON(entity);
  }

  @override
  Future<List<TastingNoteImage>> findImage(String tastingNoteID) async {
    final database = await _databaseManager.database;
    final entities = await database.query('tasting_note_image',
        where: 'tasting_note_id = ?', whereArgs: <String>[tastingNoteID]);
    return entities.map((e) => TastingNoteImage.fromJSON(e)).toList();
  }

  Future<Map<String, dynamic>> _findByID(String table, String id) async {
    final database = await _databaseManager.database;
    final entity =
        await database.query(table, where: 'id = ?', whereArgs: <String>[id]);
    return entity.isEmpty ? null : entity.first;
  }

  @override
  Future<void> saveTastingNote(TastingNote note) async {
    final database = await _databaseManager.database;
    await database.insert('tasting_note', note.toJSON());
  }

  @override
  Future<void> saveBrewery(Brewery brewery) async {
    final database = await _databaseManager.database;
    await database.insert('brewery', brewery.toJSON());
  }

  @override
  Future<void> saveSake(Sake sake) async {
    final database = await _databaseManager.database;
    await database.insert('sake', sake.toJSON());
  }

  @override
  Future<void> saveImage(TastingNoteImage image) async {
    final database = await _databaseManager.database;
    await database.insert('tasting_note_image', image.toJSON());
  }

  @override
  Future<void> close() async {
    await (await _databaseManager.database).close();
  }
}

class _DatabaseManager {
  _DatabaseManager(this.databasePath);
  final String databasePath;
  Database _database;

  Future<Database> get database async =>
      _database ??
      await openDatabase(databasePath, onCreate: (db, version) async {
        await db.execute('''
        CREATE TABLE IF NOT EXISTS "tasting_note" (
	"id"	TEXT NOT NULL,
	"sake_id"	TEXT NOT NULL,
	"created_at_utc"	INTEGER NOT NULL,
	"appearance_soundness" TEXT,
	"appearance_hue_comment"	TEXT,
	"appearance_viscosity_comment"	TEXT,
	"fragrance_soundness" TEXT,
	"fragrance_strength_comment"	TEXT,
	"fragrance_example"	TEXT,
	"fragrance_mainly" TEXT,
	"fragrance_complexity_comment"	TEXT,
	"taste_soundness" TEXT,
	"taste_attack_comment"	TEXT,
	"taste_texture" TEXT,
	"taste_example" TEXT,
	"taste_sweetness_comment"	TEXT,
	"after_flavor_strength_comment"	TEXT,
	"after_flavor_example" TEXT,
	"reverberation_strength_comment"	TEXT,
	"reverberation_example" TEXT,
	"taste_complexity_comment"	TEXT,
	"individuality" TEXT,
	"notice_comment"	TEXT,
	"flavor_type_comment"	TEXT,
	PRIMARY KEY("id"),
	FOREIGN KEY("sake_id") REFERENCES "sake"("id")
);
''');
        await db.execute('''
CREATE TABLE IF NOT EXISTS "tasting_note_image" (
	"id"	TEXT NOT NULL,
	"name"	TEXT NOT NULL,
	"tasting_note_id"	TEXT NOT NULL,
	PRIMARY KEY("id"),
	FOREIGN KEY("tasting_note_id") REFERENCES "tasting_note"("id")
);
''');
        await db.execute('''
CREATE TABLE IF NOT EXISTS "sake" (
	"id"	TEXT NOT NULL,
	"name"	TEXT NOT NULL,
	"brewery_id"	TEXT NOT NULL,
	PRIMARY KEY("id"),
	FOREIGN KEY("brewery_id") REFERENCES "brewery"("id")
);
''');
        await db.execute('''
CREATE TABLE IF NOT EXISTS "brewery" (
	"id"	TEXT NOT NULL,
	"name"	TEXT NOT NULL,
	PRIMARY KEY("id")
);
''');
      }, version: 1);
}
