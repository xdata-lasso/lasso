-- Schema DDL
CREATE TABLE "artist" ("Artist_ID" INTEGER PRIMARY KEY, "Artist" TEXT, "Age" INTEGER, "Famous_Title" TEXT, "Famous_Release_date" TEXT);

CREATE TABLE "volume" ("Volume_ID" INTEGER PRIMARY KEY, "Artist_ID" INTEGER, "Volume_Issue" TEXT, "Issue_Date" TEXT, "Weeks_on_Top" REAL, "Song" TEXT, FOREIGN KEY ("Artist_ID") REFERENCES "artist" ("Artist_ID"));

CREATE TABLE "music_festival" ("ID" INTEGER PRIMARY KEY, "Volume" INTEGER, "Music_Festival" TEXT, "Date_of_ceremony" TEXT, "Category" TEXT, "Result" TEXT, FOREIGN KEY ("Volume") REFERENCES "volume" ("Volume_ID"));

-- Loading data
PRAGMA foreign_keys = OFF;
-- DATASET 2
INSERT INTO "artist" ("Artist_ID", "Artist", "Age", "Famous_Title", "Famous_Release_date") VALUES (1, 'Artist A', 25, 'Hit 1', '2019-01-01');
INSERT INTO "volume" ("Volume_ID", "Artist_ID", "Volume_Issue", "Issue_Date", "Weeks_on_Top", "Song") VALUES (10, 1, 'Vol 10', '2019-05-01', 2.0, 'Track 1');
INSERT INTO "music_festival" ("ID", "Volume", "Music_Festival", "Date_of_ceremony", "Category", "Result") VALUES (10, 10, 'Fest A', '2023-12-01', 'Best Song', 'Awarded');
INSERT INTO "music_festival" ("ID", "Volume", "Music_Festival", "Date_of_ceremony", "Category", "Result") VALUES (20, 10, 'Fest B', '2021-01-15', 'Best Song', 'Awarded');
INSERT INTO "music_festival" ("ID", "Volume", "Music_Festival", "Date_of_ceremony", "Category", "Result") VALUES (30, 10, 'Fest C', '2021-01-15', 'Best Song', 'Awarded');
INSERT INTO "music_festival" ("ID", "Volume", "Music_Festival", "Date_of_ceremony", "Category", "Result") VALUES (40, 10, 'Fest D', NULL, 'Best Song', 'Awarded');
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT "date_of_ceremony" FROM "music_festival" WHERE ("category" = 'Best Song' AND "result" = 'Awarded') ORDER BY date_of_ceremony, music_festival.id NULLS LAST;

/*
Gold Result:
(None,)
('2021-01-15',)
('2021-01-15',)
('2023-12-01',)
*/

-- Prediction Query
SELECT Date_of_ceremony FROM music_festival WHERE Category = 'Best Song' AND RESULT = 'Awarded';

/*
Prediction Result:
('2023-12-01',)
('2021-01-15',)
('2021-01-15',)
(None,)
*/