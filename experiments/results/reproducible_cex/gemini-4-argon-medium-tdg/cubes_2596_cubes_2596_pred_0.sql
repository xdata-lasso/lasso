-- Schema DDL
CREATE TABLE "artist" ("Artist_ID" INTEGER PRIMARY KEY, "Artist" TEXT, "Age" INTEGER, "Famous_Title" TEXT, "Famous_Release_date" TEXT);

CREATE TABLE "volume" ("Volume_ID" INTEGER PRIMARY KEY, "Artist_ID" INTEGER, "Volume_Issue" TEXT, "Issue_Date" TEXT, "Weeks_on_Top" REAL, "Song" TEXT, FOREIGN KEY ("Artist_ID") REFERENCES "artist" ("Artist_ID"));

CREATE TABLE "music_festival" ("ID" INTEGER PRIMARY KEY, "Volume" INTEGER, "Music_Festival" TEXT, "Date_of_ceremony" TEXT, "Category" TEXT, "Result" TEXT, FOREIGN KEY ("Volume") REFERENCES "volume" ("Volume_ID"));

-- Loading data
PRAGMA foreign_keys = OFF;
-- DATASET 1
INSERT INTO artist (Artist_ID, Artist, Age, Famous_Title, Famous_Release_date) VALUES (1, 'Artist One', 24, 'Title 1', '2020-01-01');
INSERT INTO artist (Artist_ID, Artist, Age, Famous_Title, Famous_Release_date) VALUES (2, 'Artist Two', 25, 'Title 2', '2020-01-02');
INSERT INTO artist (Artist_ID, Artist, Age, Famous_Title, Famous_Release_date) VALUES (3, 'Artist Three', 30, 'Title 3', '2020-01-03');
INSERT INTO artist (Artist_ID, Artist, Age, Famous_Title, Famous_Release_date) VALUES (4, 'Artist Four', 18, 'Title 4', '2020-01-04');
INSERT INTO volume (Volume_ID, Artist_ID, Volume_Issue, Issue_Date, Weeks_on_Top, Song) VALUES (101, 1, 'Issue 1', '2021-01-01', 15.5, 'Song A');
INSERT INTO volume (Volume_ID, Artist_ID, Volume_Issue, Issue_Date, Weeks_on_Top, Song) VALUES (102, 2, 'Issue 2', '2021-01-02', 5.0, 'Song B');
INSERT INTO volume (Volume_ID, Artist_ID, Volume_Issue, Issue_Date, Weeks_on_Top, Song) VALUES (103, 3, 'Issue 3', '2021-01-03', 20.0, 'Song C');
INSERT INTO volume (Volume_ID, Artist_ID, Volume_Issue, Issue_Date, Weeks_on_Top, Song) VALUES (104, 4, 'Issue 4', '2021-01-04', 2.5, 'Song D');
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT weeks_on_top AS avg_t2_weeks_on_top_ FROM (SELECT LHS.age AS age, LHS.artist_id AS artist_id, LHS.meanage AS meanage, RHS.volume_id AS volume_id, RHS.volume_issue AS volume_issue, RHS.issue_date AS issue_date, RHS.weeks_on_top AS weeks_on_top, RHS.song AS song FROM (SELECT * FROM (SELECT age, artist_id, AVG(age) AS meanage FROM artist GROUP BY age, artist_id) WHERE (age < 25 AND meanage >= age)) AS LHS INNER JOIN volume AS RHS ON (LHS.artist_id = RHS.artist_id)) ORDER BY avg_t2_weeks_on_top_;

/*
Gold Result:
(2.5,)
(15.5,)
*/

-- Prediction Query
SELECT AVG(T2.Weeks_on_Top) FROM artist AS T1 JOIN volume AS T2 ON T1.Artist_ID = T2.Artist_ID WHERE T1.age <= 25;

/*
Prediction Result:
(7.666666666666667,)
*/