-- Schema DDL
CREATE TABLE "artist" ("Artist_ID" INTEGER PRIMARY KEY, "Artist" TEXT, "Age" INTEGER, "Famous_Title" TEXT, "Famous_Release_date" TEXT);

CREATE TABLE "volume" ("Volume_ID" INTEGER PRIMARY KEY, "Artist_ID" INTEGER, "Volume_Issue" TEXT, "Issue_Date" TEXT, "Weeks_on_Top" REAL, "Song" TEXT, FOREIGN KEY ("Artist_ID") REFERENCES "artist" ("Artist_ID"));

CREATE TABLE "music_festival" ("ID" INTEGER PRIMARY KEY, "Volume" INTEGER, "Music_Festival" TEXT, "Date_of_ceremony" TEXT, "Category" TEXT, "Result" TEXT, FOREIGN KEY ("Volume") REFERENCES "volume" ("Volume_ID"));

-- Loading data
PRAGMA foreign_keys = OFF;
-- DATASET 1
INSERT INTO artist (Artist_ID, Artist, Age, Famous_Title, Famous_Release_date) VALUES (1, 'Alice', 18, 'Sunrise', '2020-01-10');
INSERT INTO artist (Artist_ID, Artist, Age, Famous_Title, Famous_Release_date) VALUES (2, 'Bob', 20, 'Horizon', '2019-05-15');
INSERT INTO artist (Artist_ID, Artist, Age, Famous_Title, Famous_Release_date) VALUES (3, 'Charlie', 20, 'Echoes', '2021-03-22');
INSERT INTO artist (Artist_ID, Artist, Age, Famous_Title, Famous_Release_date) VALUES (4, 'Diana', 24, 'Velvet', '2018-11-01');
INSERT INTO artist (Artist_ID, Artist, Age, Famous_Title, Famous_Release_date) VALUES (5, 'Evan', 25, 'Boundary', '2017-07-07');
INSERT INTO artist (Artist_ID, Artist, Age, Famous_Title, Famous_Release_date) VALUES (6, 'Fiona', 30, 'Legacy', '2015-09-30');
INSERT INTO artist (Artist_ID, Artist, Age, Famous_Title, Famous_Release_date) VALUES (7, 'George', 22, 'Unplugged', '2022-02-14');
INSERT INTO volume (Volume_ID, Artist_ID, Volume_Issue, Issue_Date, Weeks_on_Top, Song) VALUES (101, 4, 'Vol. 1', '2019-01-01', 12.5, 'Velvet Night');
INSERT INTO volume (Volume_ID, Artist_ID, Volume_Issue, Issue_Date, Weeks_on_Top, Song) VALUES (102, 1, 'Vol. 2', '2020-06-01', 3.0, 'Morning Dew');
INSERT INTO volume (Volume_ID, Artist_ID, Volume_Issue, Issue_Date, Weeks_on_Top, Song) VALUES (103, 2, 'Vol. 3', '2019-08-01', 8.0, 'Far Away');
INSERT INTO volume (Volume_ID, Artist_ID, Volume_Issue, Issue_Date, Weeks_on_Top, Song) VALUES (104, 3, 'Vol. 4', '2021-04-01', 8.0, 'Deep Sound');
INSERT INTO volume (Volume_ID, Artist_ID, Volume_Issue, Issue_Date, Weeks_on_Top, Song) VALUES (105, 1, 'Vol. 5', '2021-01-01', 15.0, 'Golden Ray');
INSERT INTO volume (Volume_ID, Artist_ID, Volume_Issue, Issue_Date, Weeks_on_Top, Song) VALUES (106, 5, 'Vol. 6', '2018-01-01', 5.0, 'Edge Line');
INSERT INTO volume (Volume_ID, Artist_ID, Volume_Issue, Issue_Date, Weeks_on_Top, Song) VALUES (107, 6, 'Vol. 7', '2016-01-01', 20.0, 'Old Times');
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT weeks_on_top AS avg_t2_weeks_on_top_ FROM (SELECT LHS.age AS age, LHS.artist_id AS artist_id, LHS.meanage AS meanage, RHS.volume_id AS volume_id, RHS.volume_issue AS volume_issue, RHS.issue_date AS issue_date, RHS.weeks_on_top AS weeks_on_top, RHS.song AS song FROM (SELECT * FROM (SELECT age, artist_id, AVG(age) AS meanage FROM artist GROUP BY age, artist_id) WHERE (age < 25 AND meanage >= age)) AS LHS INNER JOIN volume AS RHS ON (LHS.artist_id = RHS.artist_id)) ORDER BY avg_t2_weeks_on_top_;

/*
Gold Result:
(3.0,)
(8.0,)
(8.0,)
(12.5,)
(15.0,)
*/

-- Prediction Query
SELECT AVG(T2.Weeks_on_Top) FROM artist AS T1 JOIN volume AS T2 ON T1.Artist_ID = T2.Artist_ID WHERE T1.age <= 25;

/*
Prediction Result:
(8.583333333333334,)
*/