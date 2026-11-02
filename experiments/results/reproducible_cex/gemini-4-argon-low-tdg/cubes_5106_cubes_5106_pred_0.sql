-- Schema DDL
CREATE TABLE "artist" ("Artist_ID" INTEGER PRIMARY KEY, "Artist" TEXT, "Age" INTEGER, "Famous_Title" TEXT, "Famous_Release_date" TEXT);

CREATE TABLE "volume" ("Volume_ID" INTEGER PRIMARY KEY, "Artist_ID" INTEGER, "Volume_Issue" TEXT, "Issue_Date" TEXT, "Weeks_on_Top" REAL, "Song" TEXT, FOREIGN KEY ("Artist_ID") REFERENCES "artist" ("Artist_ID"));

CREATE TABLE "music_festival" ("ID" INTEGER PRIMARY KEY, "Volume" INTEGER, "Music_Festival" TEXT, "Date_of_ceremony" TEXT, "Category" TEXT, "Result" TEXT, FOREIGN KEY ("Volume") REFERENCES "volume" ("Volume_ID"));

-- Loading data
PRAGMA foreign_keys = OFF;
-- DATASET 2
-- Tests integer vs lexicographical sorting on Volume (e.g., 2 vs 10), and orphan parent records (Volumes/Artists not in music_festival) to kill INNER/LEFT JOIN mutants from parent tables.
INSERT INTO artist (Artist_ID, Artist, Age, Famous_Title, Famous_Release_date) VALUES (1, 'Artist One', 30, 'Hit 1', '2019-01-01');
INSERT INTO volume (Volume_ID, Artist_ID, Volume_Issue, Issue_Date, Weeks_on_Top, Song) VALUES (1, 1, 'V1', '2019-02-01', 2.0, 'Unused Song');
INSERT INTO volume (Volume_ID, Artist_ID, Volume_Issue, Issue_Date, Weeks_on_Top, Song) VALUES (2, 1, 'V2', '2019-03-01', 8.0, 'Winning Song');
INSERT INTO volume (Volume_ID, Artist_ID, Volume_Issue, Issue_Date, Weeks_on_Top, Song) VALUES (10, 1, 'V10', '2019-04-01', 4.0, 'Losing Song');
INSERT INTO music_festival (ID, Volume, Music_Festival, Date_of_ceremony, Category, Result) VALUES (1, 10, 'Fest 10', '2019-05-01', 'Cat A', 'Lexicographical Min');
INSERT INTO music_festival (ID, Volume, Music_Festival, Date_of_ceremony, Category, Result) VALUES (2, 2, 'Fest 2', '2019-06-01', 'Cat B', 'Numeric Min');
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT RESULT FROM (SELECT * FROM (SELECT * FROM (SELECT id, music_festival, date_of_ceremony, category, volume, RESULT, MAX(n) OVER () AS n FROM (SELECT id, music_festival, date_of_ceremony, category, volume, RESULT, COUNT(*) OVER () AS n FROM music_festival)) ORDER BY volume) LIMIT 1);

/*
Gold Result:
('Numeric Min',)
*/

-- Prediction Query
SELECT RESULT FROM music_festival GROUP BY RESULT ORDER BY COUNT(*) DESC, RESULT NULLS LAST LIMIT 1;

/*
Prediction Result:
('Lexicographical Min',)
*/