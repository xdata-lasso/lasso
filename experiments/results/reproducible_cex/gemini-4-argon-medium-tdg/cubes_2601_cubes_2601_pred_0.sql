-- Schema DDL
CREATE TABLE "artist" ("Artist_ID" INTEGER PRIMARY KEY, "Artist" TEXT, "Age" INTEGER, "Famous_Title" TEXT, "Famous_Release_date" TEXT);

CREATE TABLE "volume" ("Volume_ID" INTEGER PRIMARY KEY, "Artist_ID" INTEGER, "Volume_Issue" TEXT, "Issue_Date" TEXT, "Weeks_on_Top" REAL, "Song" TEXT, FOREIGN KEY ("Artist_ID") REFERENCES "artist" ("Artist_ID"));

CREATE TABLE "music_festival" ("ID" INTEGER PRIMARY KEY, "Volume" INTEGER, "Music_Festival" TEXT, "Date_of_ceremony" TEXT, "Category" TEXT, "Result" TEXT, FOREIGN KEY ("Volume") REFERENCES "volume" ("Volume_ID"));

-- Loading data
PRAGMA foreign_keys = OFF;
-- DATASET 1
INSERT INTO artist (Artist_ID, Artist, Age, Famous_Title, Famous_Release_date) VALUES (1, 'Artist A', 25, 'Title A', '2018-01-01');
INSERT INTO volume (Volume_ID, Artist_ID, Volume_Issue, Issue_Date, Weeks_on_Top, Song) VALUES (1, 1, 'Issue 1', '2019-01-01', 3.5, 'Song A');
INSERT INTO music_festival (ID, Volume, Music_Festival, Date_of_ceremony, Category, Result) VALUES (10, 1, 'Fest A', '2020-05-01', 'Pop', 'Won');
INSERT INTO music_festival (ID, Volume, Music_Festival, Date_of_ceremony, Category, Result) VALUES (2, NULL, 'Fest B', '2020-05-01', 'Rock', 'Won');
INSERT INTO music_festival (ID, Volume, Music_Festival, Date_of_ceremony, Category, Result) VALUES (5, 1, 'Fest C', '2020-05-01', 'Jazz', 'Nominated');
INSERT INTO music_festival (ID, Volume, Music_Festival, Date_of_ceremony, Category, Result) VALUES (1, NULL, 'Fest D', '2021-01-01', 'Pop', 'Lost');
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT date_of_ceremony, RESULT FROM music_festival ORDER BY date_of_ceremony, music_festival.id NULLS LAST;

/*
Gold Result:
('2020-05-01', 'Won')
('2020-05-01', 'Nominated')
('2020-05-01', 'Won')
('2021-01-01', 'Lost')
*/

-- Prediction Query
SELECT Date_of_ceremony, RESULT FROM music_festival;

/*
Prediction Result:
('2021-01-01', 'Lost')
('2020-05-01', 'Won')
('2020-05-01', 'Nominated')
('2020-05-01', 'Won')
*/