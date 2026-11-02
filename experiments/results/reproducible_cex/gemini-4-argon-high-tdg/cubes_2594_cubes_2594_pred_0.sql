-- Schema DDL
CREATE TABLE "artist" ("Artist_ID" INTEGER PRIMARY KEY, "Artist" TEXT, "Age" INTEGER, "Famous_Title" TEXT, "Famous_Release_date" TEXT);

CREATE TABLE "volume" ("Volume_ID" INTEGER PRIMARY KEY, "Artist_ID" INTEGER, "Volume_Issue" TEXT, "Issue_Date" TEXT, "Weeks_on_Top" REAL, "Song" TEXT, FOREIGN KEY ("Artist_ID") REFERENCES "artist" ("Artist_ID"));

CREATE TABLE "music_festival" ("ID" INTEGER PRIMARY KEY, "Volume" INTEGER, "Music_Festival" TEXT, "Date_of_ceremony" TEXT, "Category" TEXT, "Result" TEXT, FOREIGN KEY ("Volume") REFERENCES "volume" ("Volume_ID"));

-- Loading data
PRAGMA foreign_keys = OFF;
-- DATASET 1
INSERT INTO artist (Artist_ID, Artist, Age, Famous_Title, Famous_Release_date) VALUES (1, 'Alice', 30, 'Sunrise', '2020-01-01');
INSERT INTO volume (Volume_ID, Artist_ID, Volume_Issue, Issue_Date, Weeks_on_Top, Song) VALUES (1, 1, 'Vol 1', '2020-02-01', 4.0, 'Track 1');
INSERT INTO volume (Volume_ID, Artist_ID, Volume_Issue, Issue_Date, Weeks_on_Top, Song) VALUES (2, 1, 'Vol 2', '2020-03-01', 2.0, 'Track 2');
INSERT INTO volume (Volume_ID, Artist_ID, Volume_Issue, Issue_Date, Weeks_on_Top, Song) VALUES (3, 1, 'Vol 3', '2020-04-01', 1.0, 'Track 3');
INSERT INTO music_festival (ID, Volume, Music_Festival, Date_of_ceremony, Category, Result) VALUES (1, 2, 'Fest A', '2021-01-01', 'Best Song', 'Won');
INSERT INTO music_festival (ID, Volume, Music_Festival, Date_of_ceremony, Category, Result) VALUES (2, 1, 'Fest B', '2021-02-01', 'Best Pop', 'Nominated');
INSERT INTO music_festival (ID, Volume, Music_Festival, Date_of_ceremony, Category, Result) VALUES (3, 1, 'Fest C', '2021-03-01', 'Best Rock', 'Nominated');
INSERT INTO music_festival (ID, Volume, Music_Festival, Date_of_ceremony, Category, Result) VALUES (4, 1, 'Fest D', '2021-04-01', 'Best Indie', 'Awarded');
INSERT INTO music_festival (ID, Volume, Music_Festival, Date_of_ceremony, Category, Result) VALUES (5, 1, 'Fest E', '2021-05-01', 'Best Jazz', 'Awarded');
INSERT INTO music_festival (ID, Volume, Music_Festival, Date_of_ceremony, Category, Result) VALUES (6, 3, 'Fest F', '2021-06-01', 'Best Vocal', 'Eliminated');
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT RESULT FROM (SELECT RESULT, volume, volume AS n, result_other FROM (SELECT LHS.result AS RESULT, LHS.volume AS volume, LHS.n AS n, RHS.result AS result_other FROM (SELECT RESULT, volume, COUNT(*) AS n FROM music_festival GROUP BY RESULT, volume) AS LHS INNER JOIN (SELECT RESULT, volume, COUNT(*) AS n FROM music_festival GROUP BY RESULT, volume) AS RHS ON (LHS.volume = RHS.n AND LHS.n = RHS.volume))) ORDER BY RESULT;

/*
Gold Result:
('Awarded',)
('Nominated',)
('Won',)
('Won',)
*/

-- Prediction Query
SELECT RESULT FROM music_festival GROUP BY RESULT ORDER BY COUNT(*) DESC, RESULT NULLS LAST LIMIT 1;

/*
Prediction Result:
('Awarded',)
*/