-- Schema DDL
CREATE TABLE "artist" ("Artist_ID" INTEGER PRIMARY KEY, "Artist" TEXT, "Age" INTEGER, "Famous_Title" TEXT, "Famous_Release_date" TEXT);

CREATE TABLE "volume" ("Volume_ID" INTEGER PRIMARY KEY, "Artist_ID" INTEGER, "Volume_Issue" TEXT, "Issue_Date" TEXT, "Weeks_on_Top" REAL, "Song" TEXT, FOREIGN KEY ("Artist_ID") REFERENCES "artist" ("Artist_ID"));

CREATE TABLE "music_festival" ("ID" INTEGER PRIMARY KEY, "Volume" INTEGER, "Music_Festival" TEXT, "Date_of_ceremony" TEXT, "Category" TEXT, "Result" TEXT, FOREIGN KEY ("Volume") REFERENCES "volume" ("Volume_ID"));

-- Loading data
PRAGMA foreign_keys = OFF;
-- DATASET 1
-- Tests basic ordering by Date_of_ceremony, secondary ordering by ID, and duplicate projection values (to kill SELECT DISTINCT mutants).
INSERT INTO "artist" ("Artist_ID", "Artist", "Age", "Famous_Title", "Famous_Release_date") VALUES (1, 'Artist A', 30, 'Hit 1', '2020-01-01');
INSERT INTO "volume" ("Volume_ID", "Artist_ID", "Volume_Issue", "Issue_Date", "Weeks_on_Top", "Song") VALUES (10, 1, 'Issue 1', '2020-02-01', 5.0, 'Song A');
INSERT INTO "music_festival" ("ID", "Volume", "Music_Festival", "Date_of_ceremony", "Category", "Result") VALUES (3, 10, 'Fest C', '2022-05-10', 'Pop', 'Won');
INSERT INTO "music_festival" ("ID", "Volume", "Music_Festival", "Date_of_ceremony", "Category", "Result") VALUES (1, 10, 'Fest A', '2021-08-15', 'Rock', 'Nominated');
INSERT INTO "music_festival" ("ID", "Volume", "Music_Festival", "Date_of_ceremony", "Category", "Result") VALUES (2, 10, 'Fest B', '2021-08-15', 'Jazz', 'Won');
INSERT INTO "music_festival" ("ID", "Volume", "Music_Festival", "Date_of_ceremony", "Category", "Result") VALUES (4, 10, 'Fest D', '2021-08-15', 'Country', 'Nominated');
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT date_of_ceremony, RESULT FROM music_festival ORDER BY date_of_ceremony, music_festival.id NULLS LAST;

/*
Gold Result:
('2021-08-15', 'Nominated')
('2021-08-15', 'Won')
('2021-08-15', 'Nominated')
('2022-05-10', 'Won')
*/

-- Prediction Query
SELECT Date_of_ceremony, RESULT FROM music_festival;

/*
Prediction Result:
('2021-08-15', 'Nominated')
('2021-08-15', 'Won')
('2022-05-10', 'Won')
('2021-08-15', 'Nominated')
*/