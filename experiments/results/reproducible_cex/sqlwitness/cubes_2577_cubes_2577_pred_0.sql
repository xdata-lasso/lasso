-- Schema DDL
CREATE TABLE "artist" ("Artist_ID" INTEGER PRIMARY KEY, "Artist" TEXT, "Age" INTEGER, "Famous_Title" TEXT, "Famous_Release_date" TEXT);

CREATE TABLE "volume" ("Volume_ID" INTEGER PRIMARY KEY, "Artist_ID" INTEGER, "Volume_Issue" TEXT, "Issue_Date" TEXT, "Weeks_on_Top" REAL, "Song" TEXT, FOREIGN KEY ("Artist_ID") REFERENCES "artist" ("Artist_ID"));

CREATE TABLE "music_festival" ("ID" INTEGER PRIMARY KEY, "Volume" INTEGER, "Music_Festival" TEXT, "Date_of_ceremony" TEXT, "Category" TEXT, "Result" TEXT, FOREIGN KEY ("Volume") REFERENCES "volume" ("Volume_ID"));

-- Loading data
PRAGMA foreign_keys = OFF;
INSERT INTO artist (artist_id, artist, age, famous_title, famous_release_date) VALUES (0, 'default1', 0, NULL, 'default1');
INSERT INTO volume (volume_id, artist_id, volume_issue, issue_date, weeks_on_top, song) VALUES (1, NULL, NULL, 'default2', 1.0, NULL), (0, 0, 'default1', NULL, 1.0, 'Nominated');
INSERT INTO music_festival (id, volume, music_festival, date_of_ceremony, category, result) VALUES (1, 0, NULL, NULL, 'default1', 'Nominated'), (0, 0, NULL, 'Nominated', 'default1', 'Nominated');
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT "song" FROM (SELECT "LHS"."volume_id" AS "volume_id", "LHS"."volume_issue" AS "volume_issue", "LHS"."issue_date" AS "issue_date", "LHS"."weeks_on_top" AS "weeks_on_top", "LHS"."song" AS "song", "LHS"."artist_id" AS "artist_id", "RHS"."music_festival" AS "music_festival", "RHS"."date_of_ceremony" AS "date_of_ceremony", "RHS"."category" AS "category", "RHS"."volume" AS "volume", "RHS"."result" AS "result" FROM "volume" AS "LHS" INNER JOIN (SELECT * FROM "music_festival" WHERE ("result" = 'Nominated')) AS RHS ON (LHS.volume_id = RHS.id)) ORDER BY song, "song" NULLS LAST;

/*
Gold Result:
(None,)
('Nominated',)
*/

-- Prediction Query
SELECT T2.Song FROM music_festival AS T1 JOIN volume AS T2 ON T1.Volume = T2.Volume_ID WHERE T1.Result = 'Nominated';

/*
Prediction Result:
('Nominated',)
('Nominated',)
*/