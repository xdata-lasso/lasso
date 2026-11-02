-- Schema DDL
CREATE TABLE "artist" ("Artist_ID" INTEGER PRIMARY KEY, "Artist" TEXT, "Age" INTEGER, "Famous_Title" TEXT, "Famous_Release_date" TEXT);

CREATE TABLE "volume" ("Volume_ID" INTEGER PRIMARY KEY, "Artist_ID" INTEGER, "Volume_Issue" TEXT, "Issue_Date" TEXT, "Weeks_on_Top" REAL, "Song" TEXT, FOREIGN KEY ("Artist_ID") REFERENCES "artist" ("Artist_ID"));

CREATE TABLE "music_festival" ("ID" INTEGER PRIMARY KEY, "Volume" INTEGER, "Music_Festival" TEXT, "Date_of_ceremony" TEXT, "Category" TEXT, "Result" TEXT, FOREIGN KEY ("Volume") REFERENCES "volume" ("Volume_ID"));

-- Loading data
PRAGMA foreign_keys = OFF;
-- DATASET 1
-- Tests standard grouping by both Category and Date_of_ceremony, ORDER BY Category ASC, count___ ASC, and duplicate counts across different dates for the same category (to catch DISTINCT mutants).
INSERT INTO "artist" ("Artist_ID", "Artist", "Age", "Famous_Title", "Famous_Release_date") VALUES (1, 'Artist A', 25, 'Title A', '2020-01-01');
INSERT INTO "volume" ("Volume_ID", "Artist_ID", "Volume_Issue", "Issue_Date", "Weeks_on_Top", "Song") VALUES (10, 1, 'Issue 1', '2020-02-01', 3.5, 'Song A');
INSERT INTO "music_festival" ("ID", "Volume", "Music_Festival", "Date_of_ceremony", "Category", "Result") VALUES (1, 10, 'Fest 1', '2021-05-01', 'Rock', 'Nominated');
INSERT INTO "music_festival" ("ID", "Volume", "Music_Festival", "Date_of_ceremony", "Category", "Result") VALUES (2, 10, 'Fest 2', '2021-05-01', 'Rock', 'Awarded');
INSERT INTO "music_festival" ("ID", "Volume", "Music_Festival", "Date_of_ceremony", "Category", "Result") VALUES (3, 10, 'Fest 3', '2021-06-01', 'Rock', 'Nominated');
INSERT INTO "music_festival" ("ID", "Volume", "Music_Festival", "Date_of_ceremony", "Category", "Result") VALUES (4, 10, 'Fest 1', '2021-05-01', 'Pop', 'Awarded');
INSERT INTO "music_festival" ("ID", "Volume", "Music_Festival", "Date_of_ceremony", "Category", "Result") VALUES (5, 10, 'Fest 2', '2021-06-01', 'Pop', 'Nominated');
INSERT INTO "music_festival" ("ID", "Volume", "Music_Festival", "Date_of_ceremony", "Category", "Result") VALUES (6, 10, 'Fest 3', '2021-07-01', 'Pop', 'Nominated');
INSERT INTO "music_festival" ("ID", "Volume", "Music_Festival", "Date_of_ceremony", "Category", "Result") VALUES (7, 10, 'Fest 4', '2021-07-01', 'Pop', 'Awarded');
INSERT INTO "music_festival" ("ID", "Volume", "Music_Festival", "Date_of_ceremony", "Category", "Result") VALUES (8, 10, 'Fest 5', '2021-07-01', 'Pop', 'Nominated');
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT category, n AS count___ FROM (SELECT category, date_of_ceremony, COUNT(*) AS n FROM music_festival GROUP BY category, date_of_ceremony) ORDER BY category, count___ NULLS LAST;

/*
Gold Result:
('Pop', 1)
('Pop', 1)
('Pop', 3)
('Rock', 1)
('Rock', 2)
*/

-- Prediction Query
SELECT Category, COUNT(*) FROM music_festival GROUP BY Category;

/*
Prediction Result:
('Pop', 5)
('Rock', 3)
*/