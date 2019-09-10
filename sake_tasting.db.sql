BEGIN TRANSACTION;
CREATE TABLE IF NOT EXISTS "tasting_note" (
	"id"	TEXT NOT NULL,
	"comment"	TEXT NOT NULL,
	"sake_id"	TEXT NOT NULL,
	"created_at_utc"	INTEGER NOT NULL,
	PRIMARY KEY("id"),
	FOREIGN KEY("sake_id") REFERENCES "sake"("id")
);
CREATE TABLE IF NOT EXISTS "tasting_image" (
	"id"	TEXT NOT NULL,
	"url"	TEXT NOT NULL,
	"tasting_note_id"	TEXT NOT NULL,
	PRIMARY KEY("id"),
	FOREIGN KEY("tasting_note_id") REFERENCES "tasting_note"("id")
);
CREATE TABLE IF NOT EXISTS "sake" (
	"id"	TEXT NOT NULL,
	"name"	TEXT NOT NULL,
	"brewery_id"	TEXT NOT NULL,
	PRIMARY KEY("id"),
	FOREIGN KEY("brewery_id") REFERENCES "brewery"("id")
);
CREATE TABLE IF NOT EXISTS "brewery" (
	"id"	TEXT NOT NULL,
	"name"	TEXT NOT NULL,
	PRIMARY KEY("id")
);
COMMIT;
