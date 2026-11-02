-- Schema DDL
CREATE TABLE "artist" ("Artist_ID" INTEGER PRIMARY KEY, "Artist" TEXT, "Age" INTEGER, "Famous_Title" TEXT, "Famous_Release_date" TEXT);

CREATE TABLE "volume" ("Volume_ID" INTEGER PRIMARY KEY, "Artist_ID" INTEGER, "Volume_Issue" TEXT, "Issue_Date" TEXT, "Weeks_on_Top" REAL, "Song" TEXT, FOREIGN KEY ("Artist_ID") REFERENCES "artist" ("Artist_ID"));

CREATE TABLE "music_festival" ("ID" INTEGER PRIMARY KEY, "Volume" INTEGER, "Music_Festival" TEXT, "Date_of_ceremony" TEXT, "Category" TEXT, "Result" TEXT, FOREIGN KEY ("Volume") REFERENCES "volume" ("Volume_ID"));

-- Loading data
PRAGMA foreign_keys = OFF;
-- DATASET 1
INSERT INTO artist (Artist_ID, Artist, Age, Famous_Title, Famous_Release_date) VALUES (1, 'Artist One', 25, 'First Hit', '2018-01-01');
INSERT INTO artist (Artist_ID, Artist, Age, Famous_Title, Famous_Release_date) VALUES (2, 'Artist Two', 30, 'Second Hit', '2019-05-12');
INSERT INTO artist (Artist_ID, Artist, Age, Famous_Title, Famous_Release_date) VALUES (3, 'Artist Three', 35, 'Third Hit', '2020-07-20');
INSERT INTO artist (Artist_ID, Artist, Age, Famous_Title, Famous_Release_date) VALUES (4, 'Artist Four', 28, 'Fourth Hit', '2021-03-15');
INSERT INTO artist (Artist_ID, Artist, Age, Famous_Title, Famous_Release_date) VALUES (5, 'Artist Five', 40, 'Fifth Hit', '2017-11-30');
INSERT INTO volume (Volume_ID, Artist_ID, Volume_Issue, Issue_Date, Weeks_on_Top, Song) VALUES (1, 5, 'Issue 101', '2021-01-01', 10.0, 'Target LHS Song');
INSERT INTO volume (Volume_ID, Artist_ID, Volume_Issue, Issue_Date, Weeks_on_Top, Song) VALUES (2, 1, 'Issue 102', '2021-02-01', 100.0, 'Max RHS Song');
INSERT INTO volume (Volume_ID, Artist_ID, Volume_Issue, Issue_Date, Weeks_on_Top, Song) VALUES (3, 2, 'Issue 103', '2021-03-01', 20.0, 'NonMax RHS Song');
INSERT INTO volume (Volume_ID, Artist_ID, Volume_Issue, Issue_Date, Weeks_on_Top, Song) VALUES (4, 5, 'Issue 104', '2021-04-01', 30.0, 'Equal Weeks LHS Song');
INSERT INTO volume (Volume_ID, Artist_ID, Volume_Issue, Issue_Date, Weeks_on_Top, Song) VALUES (5, 4, 'Issue 105', '2021-05-01', 30.0, 'Equal Weeks RHS Song');
INSERT INTO music_festival (ID, Volume, Music_Festival, Date_of_ceremony, Category, Result) VALUES (1, 3, 'Global Music Awards', '2021-12-01', 'Best Song', 'Awarded');
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT DISTINCT song FROM (SELECT volume_id, volume_issue, issue_date, weeks_on_top, song, volume_id AS artist_id, maxweeks_on_top, volume_id_other, volume_issue_other, issue_date_other, song_other, maxweeks_on_top_other FROM (SELECT LHS.volume_id AS volume_id, LHS.volume_issue AS volume_issue, LHS.issue_date AS issue_date, LHS.weeks_on_top AS weeks_on_top, LHS.song AS song, LHS.artist_id AS artist_id, LHS.maxweeks_on_top AS maxweeks_on_top, RHS.volume_id AS volume_id_other, RHS.volume_issue AS volume_issue_other, RHS.issue_date AS issue_date_other, RHS.song AS song_other, RHS.maxweeks_on_top AS maxweeks_on_top_other FROM (SELECT volume_id, volume_issue, issue_date, weeks_on_top, song, artist_id, MAX(weeks_on_top) OVER () AS maxweeks_on_top FROM volume) AS LHS INNER JOIN (SELECT volume_id, volume_issue, issue_date, weeks_on_top, song, artist_id, MAX(weeks_on_top) OVER () AS maxweeks_on_top FROM volume) AS RHS ON (LHS.volume_id = RHS.artist_id AND LHS.maxweeks_on_top = RHS.weeks_on_top))) ORDER BY song;

/*
Gold Result:
('Target LHS Song',)
*/

-- Prediction Query
SELECT Song FROM volume ORDER BY Weeks_on_Top DESC, volume.volume_id NULLS LAST LIMIT 1;

/*
Prediction Result:
('Max RHS Song',)
*/