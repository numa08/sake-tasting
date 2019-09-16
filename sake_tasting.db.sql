BEGIN TRANSACTION;
CREATE TABLE IF NOT EXISTS "tasting_note" (
	"id"	TEXT NOT NULL,
	"comment"	TEXT NOT NULL,
	"sake_id"	TEXT NOT NULL,
	"created_at_utc"	INTEGER NOT NULL,
	"appearance_soundness"	TEXT NOT NULL,
	"appearance_hue_comment"	TEXT,
	"appearance_viscosity_comment"	TEXT,
	"fragrance_soundness"	TEXT NOT NULL,
	"fragrance_strength_comment"	TEXT,
	"fragrance_example"	TEXT,
	"fragrance_mainly"	TEXT NOT NULL,
	"fragrance_complexity_comment"	TEXT,
	"taste_soundness"	TEXT NOT NULL,
	"taste_atack_comment"	TEXT,
	"taste_texture"	TEXT NOT NULL,
	"taste_example"	TEXT NOT NULL,
	"taste_sweetness_comment"	TEXT,
	"after_flavor_strength_comment"	TEXT,
	"after_flavor_example"	TEXT NOT NULL,
	"reverberation_strength_comment"	TEXT,
	"reverberation_example"	TEXT NOT NULL,
	"taste_complexity_comment"	TEXT,
	"indivisuality"	TEXT NOT NULL,
	"notice_comment"	TEXT,
	"flavor_type_comment"	TEXT,
	PRIMARY KEY("id"),
	FOREIGN KEY("sake_id") REFERENCES "sake"("id")
);
CREATE TABLE IF NOT EXISTS "tasting_note_image" (
	"id"	TEXT NOT NULL,
	"name"	TEXT NOT NULL,
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
