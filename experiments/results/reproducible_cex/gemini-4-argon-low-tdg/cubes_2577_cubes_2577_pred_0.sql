-- Schema DDL
CREATE TABLE "artist" ("Artist_ID" INTEGER PRIMARY KEY, "Artist" TEXT, "Age" INTEGER, "Famous_Title" TEXT, "Famous_Release_date" TEXT);

CREATE TABLE "volume" ("Volume_ID" INTEGER PRIMARY KEY, "Artist_ID" INTEGER, "Volume_Issue" TEXT, "Issue_Date" TEXT, "Weeks_on_Top" REAL, "Song" TEXT, FOREIGN KEY ("Artist_ID") REFERENCES "artist" ("Artist_ID"));

CREATE TABLE "music_festival" ("ID" INTEGER PRIMARY KEY, "Volume" INTEGER, "Music_Festival" TEXT, "Date_of_ceremony" TEXT, "Category" TEXT, "Result" TEXT, FOREIGN KEY ("Volume") REFERENCES "volume" ("Volume_ID"));

-- Loading data
PRAGMA foreign_keys = OFF;
-- DATASET 1
-- Tests join condition trap: Reference query joins on LHS.volume_id = RHS.id instead of the foreign key LHS.volume_id = RHS.volume.
-- Also tests WHERE result = 'Nominated' vs other values.
INSERT INTO "artist" ("Artist_ID", "Artist", "Age", "Famous_Title", "Famous_Release_date") VALUES (1, 'Artist One', 30, 'Title One', '2020-01-01');
INSERT INTO "volume" ("Volume_ID", "Artist_ID", "Volume_Issue", "Issue_Date", "Weeks_on_Top", "Song") VALUES (10, 1, 'Issue 10', '2021-01-01', 5.0, 'Song By ID Match');
INSERT INTO "volume" ("Volume_ID", "Artist_ID", "Volume_Issue", "Issue_Date", "Weeks_on_Top", "Song") VALUES (20, 1, 'Issue 20', '2021-02-01', 3.0, 'Song By FK Volume Match');
INSERT INTO "volume" ("Volume_ID", "Artist_ID", "Volume_Issue", "Issue_Date", "Weeks_on_Top", "Song") VALUES (30, 1, 'Issue 30', '2021-03-01', 1.0, 'Song Awarded');
INSERT INTO "music_festival" ("ID", "Volume", "Music_Festival", "Date_of_ceremony", "Category", "Result") VALUES (10, 20, 'Fest A', '2022-01-01', 'Best Song', 'Nominated');
INSERT INTO "music_festival" ("ID", "Volume", "Music_Festival", "Date_of_ceremony", "Category", "Result") VALUES (30, 10, 'Fest B', '2022-02-01', 'Best Song', 'Awarded');
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT "song" FROM (SELECT "LHS"."volume_id" AS "volume_id", "LHS"."volume_issue" AS "volume_issue", "LHS"."issue_date" AS "issue_date", "LHS"."weeks_on_top" AS "weeks_on_top", "LHS"."song" AS "song", "LHS"."artist_id" AS "artist_id", "RHS"."music_festival" AS "music_festival", "RHS"."date_of_ceremony" AS "date_of_ceremony", "RHS"."category" AS "category", "RHS"."volume" AS "volume", "RHS"."result" AS "result" FROM "volume" AS "LHS" INNER JOIN (SELECT * FROM "music_festival" WHERE ("result" = 'Nominated')) AS RHS ON (LHS.volume_id = RHS.id)) ORDER BY song, "song" NULLS LAST;

/*
Gold Result:
('Song By ID Match',)
*/

-- Prediction Query
SELECT T2.Song FROM music_festival AS T1 JOIN volume AS T2 ON T1.Volume = T2.Volume_ID WHERE T1.Result = 'Nominated';

/*
Prediction Result:
('Song By FK Volume Match',)
*/