-- Schema DDL
CREATE TABLE "artist" ("Artist_ID" INTEGER PRIMARY KEY, "Artist" TEXT, "Age" INTEGER, "Famous_Title" TEXT, "Famous_Release_date" TEXT);

CREATE TABLE "volume" ("Volume_ID" INTEGER PRIMARY KEY, "Artist_ID" INTEGER, "Volume_Issue" TEXT, "Issue_Date" TEXT, "Weeks_on_Top" REAL, "Song" TEXT, FOREIGN KEY ("Artist_ID") REFERENCES "artist" ("Artist_ID"));

CREATE TABLE "music_festival" ("ID" INTEGER PRIMARY KEY, "Volume" INTEGER, "Music_Festival" TEXT, "Date_of_ceremony" TEXT, "Category" TEXT, "Result" TEXT, FOREIGN KEY ("Volume") REFERENCES "volume" ("Volume_ID"));

-- Loading data
PRAGMA foreign_keys = OFF;
-- DATASET 1
INSERT INTO "artist" ("Artist_ID", "Artist", "Age", "Famous_Title", "Famous_Release_date") VALUES (1, 'Artist A', 25, 'Title A', '2020-01-01');
INSERT INTO "volume" ("Volume_ID", "Artist_ID", "Volume_Issue", "Issue_Date", "Weeks_on_Top", "Song") VALUES (1, 1, 'Issue 1', '2020-02-01', 3.5, 'Song 1');
INSERT INTO "volume" ("Volume_ID", "Artist_ID", "Volume_Issue", "Issue_Date", "Weeks_on_Top", "Song") VALUES (2, 1, 'Issue 2', '2020-03-01', 4.0, 'Song 2');
INSERT INTO "music_festival" ("ID", "Volume", "Music_Festival", "Date_of_ceremony", "Category", "Result") VALUES (1, 1, 'Fest 1', '2020-05-01', 'Cat 1', 'Nominated');
INSERT INTO "music_festival" ("ID", "Volume", "Music_Festival", "Date_of_ceremony", "Category", "Result") VALUES (2, 1, 'Fest 2', '2020-06-01', 'Cat 2', 'Nominated');
INSERT INTO "music_festival" ("ID", "Volume", "Music_Festival", "Date_of_ceremony", "Category", "Result") VALUES (3, 2, 'Fest 3', '2020-07-01', 'Cat 1', 'Awarded');
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT RESULT FROM (SELECT RESULT, volume, volume AS n, result_other FROM (SELECT LHS.result AS RESULT, LHS.volume AS volume, LHS.n AS n, RHS.result AS result_other FROM (SELECT RESULT, volume, COUNT(*) AS n FROM music_festival GROUP BY RESULT, volume) AS LHS INNER JOIN (SELECT RESULT, volume, COUNT(*) AS n FROM music_festival GROUP BY RESULT, volume) AS RHS ON (LHS.volume = RHS.n AND LHS.n = RHS.volume))) ORDER BY RESULT;

/*
Gold Result:
('Awarded',)
('Nominated',)
*/

-- Prediction Query
SELECT RESULT FROM music_festival GROUP BY RESULT ORDER BY COUNT(*) DESC, RESULT NULLS LAST LIMIT 1;

/*
Prediction Result:
('Nominated',)
*/