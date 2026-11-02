-- Schema DDL
CREATE TABLE "artist" ("Artist_ID" INTEGER PRIMARY KEY, "Artist" TEXT, "Age" INTEGER, "Famous_Title" TEXT, "Famous_Release_date" TEXT);

CREATE TABLE "volume" ("Volume_ID" INTEGER PRIMARY KEY, "Artist_ID" INTEGER, "Volume_Issue" TEXT, "Issue_Date" TEXT, "Weeks_on_Top" REAL, "Song" TEXT, FOREIGN KEY ("Artist_ID") REFERENCES "artist" ("Artist_ID"));

CREATE TABLE "music_festival" ("ID" INTEGER PRIMARY KEY, "Volume" INTEGER, "Music_Festival" TEXT, "Date_of_ceremony" TEXT, "Category" TEXT, "Result" TEXT, FOREIGN KEY ("Volume") REFERENCES "volume" ("Volume_ID"));

-- Loading data
PRAGMA foreign_keys = OFF;
INSERT INTO "artist" ("artist_id", "artist", "age", "famous_title", "famous_release_date") VALUES (7, '18', 18, '18', '18');
INSERT INTO "artist" ("artist_id", "artist", "age", "famous_title", "famous_release_date") VALUES (11, '18', 18, '18', '18');
INSERT INTO "volume" ("volume_id", "artist_id", "volume_issue", "issue_date", "weeks_on_top", "song") VALUES (9, NULL, NULL, NULL, 0, '18');
INSERT INTO "volume" ("volume_id", "artist_id", "volume_issue", "issue_date", "weeks_on_top", "song") VALUES (8, 11, '16', '17', 2, '18');
INSERT INTO "music_festival" ("id", "volume", "music_festival", "date_of_ceremony", "category", "result") VALUES (13, 8, '18', '18', '18', '18');
INSERT INTO "music_festival" ("id", "volume", "music_festival", "date_of_ceremony", "category", "result") VALUES (12, 8, '18', '18', '18', '18');
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT song FROM volume WHERE (weeks_on_top <> 1.0) ORDER BY song, volume.volume_id NULLS LAST;

/*
Gold Result:
('18',)
('18',)
*/

-- Prediction Query
SELECT Song FROM volume WHERE Weeks_on_Top > 1;

/*
Prediction Result:
('18',)
*/