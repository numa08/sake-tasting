import 'package:app/data/database/database.dart';
import 'package:app/data/database/entities/brewery_entity.dart';
import 'package:app/data/database/entities/sake_entity.dart';
import 'package:app/data/entities/sake.dart';
import 'package:rxdart/rxdart.dart';
import 'package:sqflite/sqflite.dart';

class TastingSQLiteDB implements TastingDB {
  TastingSQLiteDB(String dbPath) : _dbManager = _DatabaseManager(dbPath);
  final _DatabaseManager _dbManager;
  final PublishSubject<List<Sake>> _allSubject = PublishSubject();
  final PublishSubject<Sake> _insertResultSubject = PublishSubject();

  @override
  Future<void> close() async {
    await _allSubject.close();
    await _insertResultSubject.close();
    await (await _dbManager.database).close();
  }

  @override
  Future<void> insertBrewery(BreweryEntity entity) async {
    assert(entity != null);
    final database = await _dbManager.database;
    final saved = await database.query('brewery',
        columns: ['id'], where: 'id = ?', whereArgs: <dynamic>[entity.id]);
    if (saved.isNotEmpty) {
      return;
    }
    await database.insert('brewery', entity.toJson());
  }

  @override
  Future<void> insertSake(SakeEntity entity) async {
    assert(entity != null);
    final database = await _dbManager.database;
    final saved = await database.query('sake',
        columns: ['id'], where: 'id = ?', whereArgs: <dynamic>[entity.id]);
    if (saved.isNotEmpty) {
      return;
    }
    await database.insert('sake', entity.toJson());
  }
}

class _DatabaseManager {
  _DatabaseManager(this.dbPath);
  Database _database;
  final String dbPath;

  Future<Database> get database async =>
      _database ??
      await openDatabase(dbPath, onCreate: (db, version) async {
        await db.execute('''
        CREATE TABLE IF NOT EXISTS "brewery" (
	"id"	TEXT NOT NULL,
	"name"	TEXT NOT NULL,
	PRIMARY KEY("id")
);''');
        await db.execute('''
        CREATE TABLE IF NOT EXISTS "sake" (
	"id"	TEXT NOT NULL,
	"name"	TEXT NOT NULL,
	"breweries_id"	TEXT NOT NULL,
	"visual_soundness"	TEXT NOT NULL,
	"hue_other"	TEXT DEFAULT NULL,
	"viscosity_other"	TEXT DEFAULT NULL,
	"flavor_soundness"	TEXT NOT NULL,
	"flavor_strength_other"	TEXT DEFAULT NULL,
	"flavor_example"	TEXT NOT NULL,
	"main_flavor"	TEXT NOT NULL,
	"flavor_complexity_other"	TEXT DEFAULT NULL,
	"taste_soundness"	TEXT NOT NULL,
	"attack_other"	TEXT DEFAULT NULL,
	"texture"	TEXT NOT NULL,
	"taste_example"	TEXT NOT NULL,
	"sweetness_other"	TEXT DEFAULT NULL,
	"aroma_other"	TEXT DEFAULT NULL,
	"aroma_example"	TEXT NOT NULL,
	"reverberation_other"	TEXT DEFAULT NULL,
	"reverberation_element"	TEXT NOT NULL,
	"aroma_complexity_other"	TEXT DEFAULT NULL,
	"individuality"	TEXT NOT NULL,
	"notice"	TEXT DEFAULT NULL,
	"type_notice"	TEXT DEFAULT NULL,
	"created_at_utc"	INTEGER NOT NULL,
	"updated_at_utc"	INTEGER NOT NULL,
	PRIMARY KEY("id"),
	FOREIGN KEY("breweries_id") REFERENCES "brewery"("id")
);''');
        await db.execute('''
        CREATE TABLE IF NOT EXISTS "type" (
	"id"	TEXT NOT NULL,
	"value"	INTEGER NOT NULL CHECK(value>=0 AND value<=3),
	"sake_id"	TEXT,
	PRIMARY KEY("id"),
	FOREIGN KEY("sake_id") REFERENCES "sake"("id")
);''');
        await db.execute('''
        CREATE TABLE IF NOT EXISTS "aroma_complexity" (
	"id"	TEXT NOT NULL,
	"value"	INTEGER NOT NULL CHECK(value>=0 AND value<=6),
	"sake_id"	TEXT,
	PRIMARY KEY("id"),
	FOREIGN KEY("sake_id") REFERENCES "sake"("id")
);''');
        await db.execute('''
        CREATE TABLE IF NOT EXISTS "reverberation" (
	"id"	TEXT NOT NULL,
	"value"	INTEGER NOT NULL CHECK(value>=0 AND value<=6),
	"sake_id"	TEXT,
	PRIMARY KEY("id"),
	FOREIGN KEY("sake_id") REFERENCES "sake"("id")
);''');
        await db.execute('''
        CREATE TABLE IF NOT EXISTS "aroma" (
	"id"	TEXT NOT NULL,
	"value"	INTEGER NOT NULL CHECK(value>=0 AND value<=6),
	"sake_id"	TEXT,
	PRIMARY KEY("id"),
	FOREIGN KEY("sake_id") REFERENCES "sake"("id")
);''');
        await db.execute('''
        CREATE TABLE IF NOT EXISTS "sweetness" (
	"id"	TEXT NOT NULL,
	"value"	INTEGER NOT NULL CHECK(value>=0 AND value<=6),
	"sake_id"	TEXT,
	PRIMARY KEY("id"),
	FOREIGN KEY("sake_id") REFERENCES "sake"("id")
);''');
        await db.execute('''
        CREATE TABLE IF NOT EXISTS "attack" (
	"id"	TEXT NOT NULL,
	"value"	INTEGER NOT NULL CHECK(value>=0 AND value<=6),
	"sake_id"	TEXT NOT NULL,
	PRIMARY KEY("id")
);
''');
        await db.execute('''
        CREATE TABLE IF NOT EXISTS "flavor_complexity" (
	"id"	TEXT NOT NULL,
	"value"	INTEGER NOT NULL CHECK(value>=0 AND value<=6),
	"sake_id"	TEXT NOT NULL,
	PRIMARY KEY("id"),
	FOREIGN KEY("sake_id") REFERENCES "sake"("id")
);''');
        await db.execute('''
        CREATE TABLE IF NOT EXISTS "flavor_strength" (
	"id"	TEXT NOT NULL,
	"value"	INTEGER NOT NULL CHECK(value>=0 AND value<=6),
	"sake_id"	TEXT NOT NULL,
	PRIMARY KEY("id"),
	FOREIGN KEY("sake_id") REFERENCES "sake"("id")
);''');
        await db.execute('''
        CREATE TABLE IF NOT EXISTS "viscosity" (
	"id"	TEXT NOT NULL,
	"value"	INTEGER NOT NULL CHECK(value>=0 AND value<=6),
	"sake_id"	TEXT NOT NULL,
	PRIMARY KEY("id"),
	FOREIGN KEY("sake_id") REFERENCES "sake"("id")
);''');
        await db.execute('''
        CREATE TABLE IF NOT EXISTS "hue" (
	"id"	TEXT NOT NULL,
	"value"	INTEGER NOT NULL CHECK(value>=0 AND value<=6),
	"sale_id"	TEXT NOT NULL,
	PRIMARY KEY("id"),
	FOREIGN KEY("sale_id") REFERENCES "sake"("id")
);''');
        await db.execute('''
        CREATE TABLE IF NOT EXISTS "image" (
	"id"	TEXT NOT NULL,
	"url"	TEXT NOT NULL,
	"sake_id"	TEXT NOT NULL,
	FOREIGN KEY("sake_id") REFERENCES "sake"("id")
);''');
      }, version: 1);
}
