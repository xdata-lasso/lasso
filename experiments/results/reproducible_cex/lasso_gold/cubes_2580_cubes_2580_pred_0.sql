-- Schema DDL
CREATE TABLE "artist" ("Artist_ID" INTEGER PRIMARY KEY, "Artist" TEXT, "Age" INTEGER, "Famous_Title" TEXT, "Famous_Release_date" TEXT);

CREATE TABLE "volume" ("Volume_ID" INTEGER PRIMARY KEY, "Artist_ID" INTEGER, "Volume_Issue" TEXT, "Issue_Date" TEXT, "Weeks_on_Top" REAL, "Song" TEXT, FOREIGN KEY ("Artist_ID") REFERENCES "artist" ("Artist_ID"));

CREATE TABLE "music_festival" ("ID" INTEGER PRIMARY KEY, "Volume" INTEGER, "Music_Festival" TEXT, "Date_of_ceremony" TEXT, "Category" TEXT, "Result" TEXT, FOREIGN KEY ("Volume") REFERENCES "volume" ("Volume_ID"));

-- Loading data
PRAGMA foreign_keys = OFF;
INSERT INTO "artist" ("artist_id", "artist", "age", "famous_title", "famous_release_date") VALUES (1044, 'recently', 1045, 'Estate agent', 'spring');
INSERT INTO "artist" ("artist_id", "artist", "age", "famous_title", "famous_release_date") VALUES (1049, 'long', 1050, 'Medical sales representative', 'commercial');
INSERT INTO "volume" ("volume_id", "artist_id", "volume_issue", "issue_date", "weeks_on_top", "song") VALUES (1046, 1044, 'figure', 'base', 1047.5, 'top');
INSERT INTO "volume" ("volume_id", "artist_id", "volume_issue", "issue_date", "weeks_on_top", "song") VALUES (1051, 1049, 'hospital', 'hear', 1052.5, 'determine');
INSERT INTO "music_festival" ("id", "volume", "music_festival", "date_of_ceremony", "category", "result") VALUES (1048, 1046, 'early', 'trial', 'blood', 'husband');
INSERT INTO "music_festival" ("id", "volume", "music_festival", "date_of_ceremony", "category", "result") VALUES (1053, 1051, 'religious', 'fall', 'example', 'husband');
INSERT INTO "music_festival" ("id", "volume", "music_festival", "date_of_ceremony", "category", "result") VALUES (1054, 1051, 'religious', 'fall', 'example', 'husband');
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT RESULT, n AS count___ FROM (SELECT date_of_ceremony, RESULT, COUNT(*) AS n FROM music_festival GROUP BY date_of_ceremony, RESULT) ORDER BY RESULT, count___ NULLS LAST;

/*
Gold Result:
('husband', 1)
('husband', 2)
*/

-- Prediction Query
SELECT RESULT, COUNT(*) FROM music_festival GROUP BY RESULT ORDER BY COUNT(*) DESC, RESULT NULLS LAST;

/*
Prediction Result:
('husband', 3)
*/