-- Schema DDL
CREATE TABLE "artist" ("Artist_ID" INTEGER PRIMARY KEY, "Artist" TEXT, "Age" INTEGER, "Famous_Title" TEXT, "Famous_Release_date" TEXT);

CREATE TABLE "volume" ("Volume_ID" INTEGER PRIMARY KEY, "Artist_ID" INTEGER, "Volume_Issue" TEXT, "Issue_Date" TEXT, "Weeks_on_Top" REAL, "Song" TEXT, FOREIGN KEY ("Artist_ID") REFERENCES "artist" ("Artist_ID"));

CREATE TABLE "music_festival" ("ID" INTEGER PRIMARY KEY, "Volume" INTEGER, "Music_Festival" TEXT, "Date_of_ceremony" TEXT, "Category" TEXT, "Result" TEXT, FOREIGN KEY ("Volume") REFERENCES "volume" ("Volume_ID"));

-- Loading data
PRAGMA foreign_keys = OFF;
INSERT INTO "artist" ("artist_id", "artist", "age", "famous_title", "famous_release_date") VALUES (1102, 'product', 1103, 'Designer, jewellery', 'structure');
INSERT INTO "artist" ("artist_id", "artist", "age", "famous_title", "famous_release_date") VALUES (1107, 'I', 1108, 'Therapist, occupational', 'management');
INSERT INTO "volume" ("volume_id", "artist_id", "volume_issue", "issue_date", "weeks_on_top", "song") VALUES (1104, 1102, 'response', 'knowledge', 1105.5, 'pick');
INSERT INTO "volume" ("volume_id", "artist_id", "volume_issue", "issue_date", "weeks_on_top", "song") VALUES (1109, 1107, 'newspaper', 'enter', 1110.5, 'on');
INSERT INTO "music_festival" ("id", "volume", "music_festival", "date_of_ceremony", "category", "result") VALUES (1106, 1104, 'attack', 'image', 'Best Song', 'Awarded');
INSERT INTO "music_festival" ("id", "volume", "music_festival", "date_of_ceremony", "category", "result") VALUES (1111, 1109, 'traditional', 'activity', 'Best Song', 'Awarded');
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT "date_of_ceremony" FROM "music_festival" WHERE ("category" = 'Best Song' AND "result" = 'Awarded') ORDER BY date_of_ceremony, music_festival.id NULLS LAST;

/*
Gold Result:
('activity',)
('image',)
*/

-- Prediction Query
SELECT Date_of_ceremony FROM music_festival WHERE Category = 'Best Song' AND RESULT = 'Awarded';

/*
Prediction Result:
('image',)
('activity',)
*/