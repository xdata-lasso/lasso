-- Schema DDL
CREATE TABLE "artist" ("Artist_ID" INTEGER PRIMARY KEY, "Artist" TEXT, "Age" INTEGER, "Famous_Title" TEXT, "Famous_Release_date" TEXT);

CREATE TABLE "volume" ("Volume_ID" INTEGER PRIMARY KEY, "Artist_ID" INTEGER, "Volume_Issue" TEXT, "Issue_Date" TEXT, "Weeks_on_Top" REAL, "Song" TEXT, FOREIGN KEY ("Artist_ID") REFERENCES "artist" ("Artist_ID"));

CREATE TABLE "music_festival" ("ID" INTEGER PRIMARY KEY, "Volume" INTEGER, "Music_Festival" TEXT, "Date_of_ceremony" TEXT, "Category" TEXT, "Result" TEXT, FOREIGN KEY ("Volume") REFERENCES "volume" ("Volume_ID"));

-- Loading data
PRAGMA foreign_keys = OFF;
-- DATASET 1
INSERT INTO "artist" ("Artist_ID", "Artist", "Age", "Famous_Title", "Famous_Release_date") VALUES (1, 'Artist A', 30, 'Title A', '2020-01-01');
INSERT INTO "volume" ("Volume_ID", "Artist_ID", "Volume_Issue", "Issue_Date", "Weeks_on_Top", "Song") VALUES (1, 1, 'Issue 1', '2020-02-01', 5.0, 'Song A');
INSERT INTO "music_festival" ("ID", "Volume", "Music_Festival", "Date_of_ceremony", "Category", "Result") VALUES (10, 1, 'Fest 1', '2020-05-01', 'Rock', 'Awarded');
INSERT INTO "music_festival" ("ID", "Volume", "Music_Festival", "Date_of_ceremony", "Category", "Result") VALUES (20, 1, 'Fest 2', '2020-06-01', 'Pop', 'Awarded');
INSERT INTO "music_festival" ("ID", "Volume", "Music_Festival", "Date_of_ceremony", "Category", "Result") VALUES (30, 1, 'Fest 3', '2020-07-01', 'Pop', 'Awarded');
INSERT INTO "music_festival" ("ID", "Volume", "Music_Festival", "Date_of_ceremony", "Category", "Result") VALUES (40, 1, 'Fest 4', '2020-08-01', 'Jazz', 'Nominated');
INSERT INTO "music_festival" ("ID", "Volume", "Music_Festival", "Date_of_ceremony", "Category", "Result") VALUES (50, 1, 'Fest 5', '2020-09-01', 'Classical', 'awarded');
INSERT INTO "music_festival" ("ID", "Volume", "Music_Festival", "Date_of_ceremony", "Category", "Result") VALUES (60, 1, 'Fest 6', '2020-10-01', 'Blues', NULL);
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT "category" FROM "music_festival" WHERE ("result" = 'Awarded') ORDER BY category, music_festival.id NULLS LAST;

/*
Gold Result:
('Pop',)
('Pop',)
('Rock',)
*/

-- Prediction Query
SELECT Category FROM music_festival WHERE RESULT = 'Awarded';

/*
Prediction Result:
('Rock',)
('Pop',)
('Pop',)
*/