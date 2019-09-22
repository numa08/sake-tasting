BEGIN TRANSACTION;
CREATE TABLE IF NOT EXISTS "tasting_note" (
	"id"	TEXT NOT NULL,
	"sake_id"	TEXT NOT NULL,
	"created_at_utc"	INTEGER NOT NULL,
	"appearance_soundness"	TEXT NOT NULL,
	"appearance_hue_comment"	TEXT,
	"appearance_viscosity_comment"	TEXT,
	"fragrance_soundness"	TEXT,
	"fragrance_strength_comment"	TEXT,
	"fragrance_example"	TEXT,
	"fragrance_mainly"	TEXT,
	"fragrance_complexity_comment"	TEXT,
	"taste_soundness"	TEXT,
	"taste_atack_comment"	TEXT,
	"taste_texture"	TEXT,
	"taste_example"	TEXT,
	"taste_sweetness_comment"	TEXT,
	"after_flavor_strength_comment"	TEXT,
	"after_flavor_example"	TEXT,
	"reverberation_strength_comment"	TEXT,
	"reverberation_example"	TEXT,
	"taste_complexity_comment"	TEXT,
	"indivisuality"	TEXT,
	"notice_comment"	TEXT,
	"flavor_type_comment"	TEXT,
	"appearance_hue"	INTEGER DEFAULT 5 CHECK(appearance_hue>=0 AND appearance_hue<=10),
	"appearance_viscosity"	INTEGER DEFAULT 5 CHECK(appearance_viscosity>=0 AND appearance_viscosity<=10),
	"fragrance_strength"	INTEGER DEFAULT 5 CHECK(fragrance_strength>=0 AND fragrance_strength<=10),
	"fragrance_complexity"	INTEGER DEFAULT 5 CHECK(fragrance_complexity>=0 AND fragrance_complexity<=10),
	"taste_attack"	INTEGER DEFAULT 5 CHECK(taste_attack>=0 AND taste_attack<=10),
	"taste_sweetness"	INTEGER DEFAULT 5 CHECK(taste_sweetness>=0 AND taste_sweetness<=10),
	"after_flavor_strength"	INTEGER DEFAULT 5 CHECK(after_flavor_strength>=0 AND after_flavor_strength<=10),
	"reverberation_strength"	INTEGER DEFAULT 5 CHECK(reverberation_strength>=0 AND reverberation_strength<=10),
	"taste_complexity"	INTEGER DEFAULT 5 CHECK(taste_complexity>=0 AND taste_complexity<=10),
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
