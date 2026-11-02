-- Schema DDL
CREATE TABLE "artist" ("Artist_ID" INTEGER PRIMARY KEY, "Artist" TEXT, "Age" INTEGER, "Famous_Title" TEXT, "Famous_Release_date" TEXT);

CREATE TABLE "volume" ("Volume_ID" INTEGER PRIMARY KEY, "Artist_ID" INTEGER, "Volume_Issue" TEXT, "Issue_Date" TEXT, "Weeks_on_Top" REAL, "Song" TEXT, FOREIGN KEY ("Artist_ID") REFERENCES "artist" ("Artist_ID"));

CREATE TABLE "music_festival" ("ID" INTEGER PRIMARY KEY, "Volume" INTEGER, "Music_Festival" TEXT, "Date_of_ceremony" TEXT, "Category" TEXT, "Result" TEXT, FOREIGN KEY ("Volume") REFERENCES "volume" ("Volume_ID"));

-- Loading data
PRAGMA foreign_keys = OFF;
-- DATASET 1
INSERT INTO "artist" ("Artist_ID", "Artist", "Age", "Famous_Title", "Famous_Release_date") VALUES (1, 'Artist A', 25, 'Title A', '2020-01-01');
INSERT INTO "volume" ("Volume_ID", "Artist_ID", "Volume_Issue", "Issue_Date", "Weeks_on_Top", "Song") VALUES (1, 1, 'Issue 1', '2020-02-01', 3.5, 'Song Alpha');
INSERT INTO "volume" ("Volume_ID", "Artist_ID", "Volume_Issue", "Issue_Date", "Weeks_on_Top", "Song") VALUES (2, 1, 'Issue 2', '2020-03-01', 1.0, 'Song Beta');
INSERT INTO "volume" ("Volume_ID", "Artist_ID", "Volume_Issue", "Issue_Date", "Weeks_on_Top", "Song") VALUES (3, 1, 'Issue 3', '2020-04-01', 2.0, 'Song Gamma');
INSERT INTO "music_festival" ("ID", "Volume", "Music_Festival", "Date_of_ceremony", "Category", "Result") VALUES (1, 2, 'Fest 1', '2020-05-01', 'Pop', 'Nominated');
INSERT INTO "music_festival" ("ID", "Volume", "Music_Festival", "Date_of_ceremony", "Category", "Result") VALUES (2, 3, 'Fest 2', '2020-06-01', 'Rock', 'Awarded');
INSERT INTO "music_festival" ("ID", "Volume", "Music_Festival", "Date_of_ceremony", "Category", "Result") VALUES (4, 1, 'Fest 3', '2020-07-01', 'Jazz', 'Nominated');
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT "song" FROM (SELECT "LHS"."volume_id" AS "volume_id", "LHS"."volume_issue" AS "volume_issue", "LHS"."issue_date" AS "issue_date", "LHS"."weeks_on_top" AS "weeks_on_top", "LHS"."song" AS "song", "LHS"."artist_id" AS "artist_id", "RHS"."music_festival" AS "music_festival", "RHS"."date_of_ceremony" AS "date_of_ceremony", "RHS"."category" AS "category", "RHS"."volume" AS "volume", "RHS"."result" AS "result" FROM "volume" AS "LHS" INNER JOIN (SELECT * FROM "music_festival" WHERE ("result" = 'Nominated')) AS RHS ON (LHS.volume_id = RHS.id)) ORDER BY song, "song" NULLS LAST;

/*
Gold Result:
('Song Alpha',)
*/

-- Prediction Query
SELECT T2.Song FROM music_festival AS T1 JOIN volume AS T2 ON T1.Volume = T2.Volume_ID WHERE T1.Result = 'Nominated';

/*
Prediction Result:
('Song Beta',)
('Song Alpha',)
*/