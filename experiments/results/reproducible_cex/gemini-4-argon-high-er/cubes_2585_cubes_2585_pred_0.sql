-- Schema DDL
CREATE TABLE "artist" ("Artist_ID" INTEGER PRIMARY KEY, "Artist" TEXT, "Age" INTEGER, "Famous_Title" TEXT, "Famous_Release_date" TEXT);

CREATE TABLE "volume" ("Volume_ID" INTEGER PRIMARY KEY, "Artist_ID" INTEGER, "Volume_Issue" TEXT, "Issue_Date" TEXT, "Weeks_on_Top" REAL, "Song" TEXT, FOREIGN KEY ("Artist_ID") REFERENCES "artist" ("Artist_ID"));

CREATE TABLE "music_festival" ("ID" INTEGER PRIMARY KEY, "Volume" INTEGER, "Music_Festival" TEXT, "Date_of_ceremony" TEXT, "Category" TEXT, "Result" TEXT, FOREIGN KEY ("Volume") REFERENCES "volume" ("Volume_ID"));

-- Loading data
PRAGMA foreign_keys = OFF;
INSERT INTO artist (Artist_ID, Artist, Age, Famous_Title, Famous_Release_date) VALUES (1, 'Artist 1', 35, 'Title 1', '2000-01-01');
INSERT INTO artist (Artist_ID, Artist, Age, Famous_Title, Famous_Release_date) VALUES (2, 'Artist 2', 40, 'Title 2', '2005-01-01');
INSERT INTO volume (Volume_ID, Artist_ID, Volume_Issue, Issue_Date, Weeks_on_Top, Song) VALUES (1, 1, 'Issue 1', '2010-01-01', 2.0, 'Zebra');
INSERT INTO volume (Volume_ID, Artist_ID, Volume_Issue, Issue_Date, Weeks_on_Top, Song) VALUES (2, 2, 'Issue 2', '2011-01-01', 3.0, 'Alpha');
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT song FROM (SELECT LHS.artist_id AS artist_id, LHS.artist AS artist, LHS.age AS age, LHS.famous_title AS famous_title, LHS.famous_release_date AS famous_release_date, RHS.volume_id AS volume_id, RHS.volume_issue AS volume_issue, RHS.issue_date AS issue_date, RHS.weeks_on_top AS weeks_on_top, RHS.song AS song FROM artist AS LHS INNER JOIN volume AS RHS ON (LHS.artist_id = RHS.artist_id)) WHERE (age >= 32) ORDER BY song;

/*
Gold Result:
('Alpha',)
('Zebra',)
*/

-- Prediction Query
SELECT T2.Song FROM artist AS T1 JOIN volume AS T2 ON T1.Artist_ID = T2.Artist_ID WHERE T1.age >= 32;

/*
Prediction Result:
('Zebra',)
('Alpha',)
*/