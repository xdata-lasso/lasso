-- Schema DDL
CREATE TABLE "artist" ("Artist_ID" INTEGER PRIMARY KEY, "Artist" TEXT, "Age" INTEGER, "Famous_Title" TEXT, "Famous_Release_date" TEXT);

CREATE TABLE "volume" ("Volume_ID" INTEGER PRIMARY KEY, "Artist_ID" INTEGER, "Volume_Issue" TEXT, "Issue_Date" TEXT, "Weeks_on_Top" REAL, "Song" TEXT, FOREIGN KEY ("Artist_ID") REFERENCES "artist" ("Artist_ID"));

CREATE TABLE "music_festival" ("ID" INTEGER PRIMARY KEY, "Volume" INTEGER, "Music_Festival" TEXT, "Date_of_ceremony" TEXT, "Category" TEXT, "Result" TEXT, FOREIGN KEY ("Volume") REFERENCES "volume" ("Volume_ID"));

-- Loading data
PRAGMA foreign_keys = OFF;
-- DATASET 1
-- Tests basic filtering, case sensitivity, prefix/suffix matching, NULL values, and duplicate elimination (DISTINCT mutants) alongside ordering.
INSERT INTO "artist" ("Artist_ID", "Artist", "Age", "Famous_Title", "Famous_Release_date") VALUES (1, 'Triumfall', 30, 'Zeta', '2020-01-01');
INSERT INTO "artist" ("Artist_ID", "Artist", "Age", "Famous_Title", "Famous_Release_date") VALUES (2, 'Triumfall', 25, 'Alpha', '2021-01-01');
INSERT INTO "artist" ("Artist_ID", "Artist", "Age", "Famous_Title", "Famous_Release_date") VALUES (3, 'Triumfall', 28, 'Alpha', '2022-01-01');
INSERT INTO "artist" ("Artist_ID", "Artist", "Age", "Famous_Title", "Famous_Release_date") VALUES (4, 'triumfall', 35, 'Beta', '2019-01-01');
INSERT INTO "artist" ("Artist_ID", "Artist", "Age", "Famous_Title", "Famous_Release_date") VALUES (5, 'Triumfall ', 40, 'Gamma', '2018-01-01');
INSERT INTO "artist" ("Artist_ID", "Artist", "Age", "Famous_Title", "Famous_Release_date") VALUES (6, 'Other', 50, 'Triumfall', '2017-01-01');
INSERT INTO "artist" ("Artist_ID", "Artist", "Age", "Famous_Title", "Famous_Release_date") VALUES (7, NULL, 22, 'Delta', '2023-01-01');
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT "famous_title" FROM "artist" WHERE ("artist" = 'Triumfall') ORDER BY famous_title, artist.artist_id NULLS LAST;

/*
Gold Result:
('Alpha',)
('Alpha',)
('Zeta',)
*/

-- Prediction Query
SELECT Famous_Title FROM artist WHERE Artist = 'Triumfall';

/*
Prediction Result:
('Zeta',)
('Alpha',)
('Alpha',)
*/