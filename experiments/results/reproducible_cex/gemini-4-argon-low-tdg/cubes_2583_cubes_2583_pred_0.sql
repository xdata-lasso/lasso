-- Schema DDL
CREATE TABLE "artist" ("Artist_ID" INTEGER PRIMARY KEY, "Artist" TEXT, "Age" INTEGER, "Famous_Title" TEXT, "Famous_Release_date" TEXT);

CREATE TABLE "volume" ("Volume_ID" INTEGER PRIMARY KEY, "Artist_ID" INTEGER, "Volume_Issue" TEXT, "Issue_Date" TEXT, "Weeks_on_Top" REAL, "Song" TEXT, FOREIGN KEY ("Artist_ID") REFERENCES "artist" ("Artist_ID"));

CREATE TABLE "music_festival" ("ID" INTEGER PRIMARY KEY, "Volume" INTEGER, "Music_Festival" TEXT, "Date_of_ceremony" TEXT, "Category" TEXT, "Result" TEXT, FOREIGN KEY ("Volume") REFERENCES "volume" ("Volume_ID"));

-- Loading data
PRAGMA foreign_keys = OFF;
-- DATASET 1
INSERT INTO artist (Artist_ID, Artist, Age, Famous_Title, Famous_Release_date) VALUES (1, 'Alice', 30, 'Zeta', '2020-01-01');
INSERT INTO artist (Artist_ID, Artist, Age, Famous_Title, Famous_Release_date) VALUES (2, 'Bob', 25, 'Alpha', '2021-01-01');
INSERT INTO artist (Artist_ID, Artist, Age, Famous_Title, Famous_Release_date) VALUES (3, 'Charlie', 40, 'Alpha', '2019-01-01');
INSERT INTO artist (Artist_ID, Artist, Age, Famous_Title, Famous_Release_date) VALUES (4, 'David', 35, 'Beta', '2018-01-01');
INSERT INTO artist (Artist_ID, Artist, Age, Famous_Title, Famous_Release_date) VALUES (5, 'Eve', 28, 'Alpha', '2022-01-01');
INSERT INTO volume (Volume_ID, Artist_ID, Volume_Issue, Issue_Date, Weeks_on_Top, Song) VALUES (10, 4, 'Vol 1', '2018-02-01', 5.0, 'Hit 1');
INSERT INTO volume (Volume_ID, Artist_ID, Volume_Issue, Issue_Date, Weeks_on_Top, Song) VALUES (11, 4, 'Vol 2', '2018-03-01', 2.0, 'Hit 2');
INSERT INTO volume (Volume_ID, Artist_ID, Volume_Issue, Issue_Date, Weeks_on_Top, Song) VALUES (12, 5, 'Vol 3', '2022-02-01', 1.0, 'Hit 3');
INSERT INTO volume (Volume_ID, Artist_ID, Volume_Issue, Issue_Date, Weeks_on_Top, Song) VALUES (13, NULL, 'Vol 4', '2022-05-01', 3.0, 'Unknown Hit');
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT famous_title FROM (SELECT * FROM artist AS LHS WHERE NOT EXISTS(SELECT 1 FROM volume AS RHS WHERE (LHS.artist_id = RHS.artist_id))) ORDER BY famous_title;

/*
Gold Result:
('Alpha',)
('Alpha',)
('Zeta',)
*/

-- Prediction Query
SELECT Famous_Title FROM artist WHERE NOT Artist_ID IN (SELECT Artist_ID FROM volume);

/*
Prediction Result:
*/