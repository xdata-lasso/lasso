-- Schema DDL
CREATE TABLE "artist" ("Artist_ID" INTEGER PRIMARY KEY, "Artist" TEXT, "Age" INTEGER, "Famous_Title" TEXT, "Famous_Release_date" TEXT);

CREATE TABLE "volume" ("Volume_ID" INTEGER PRIMARY KEY, "Artist_ID" INTEGER, "Volume_Issue" TEXT, "Issue_Date" TEXT, "Weeks_on_Top" REAL, "Song" TEXT, FOREIGN KEY ("Artist_ID") REFERENCES "artist" ("Artist_ID"));

CREATE TABLE "music_festival" ("ID" INTEGER PRIMARY KEY, "Volume" INTEGER, "Music_Festival" TEXT, "Date_of_ceremony" TEXT, "Category" TEXT, "Result" TEXT, FOREIGN KEY ("Volume") REFERENCES "volume" ("Volume_ID"));

-- Loading data
PRAGMA foreign_keys = OFF;
-- DATASET 1
INSERT INTO artist (Artist_ID, Artist, Age, Famous_Title, Famous_Release_date) VALUES (1, 'Artist A', 25, 'Title 1', '2020-01-01');
INSERT INTO artist (Artist_ID, Artist, Age, Famous_Title, Famous_Release_date) VALUES (2, 'Artist B', 30, 'Title 2', '2020-02-02');
INSERT INTO artist (Artist_ID, Artist, Age, Famous_Title, Famous_Release_date) VALUES (3, 'Artist C', 35, 'Title 3', '2020-03-03');
INSERT INTO artist (Artist_ID, Artist, Age, Famous_Title, Famous_Release_date) VALUES (4, 'Artist D', 40, 'Title 4', '2020-04-04');
INSERT INTO volume (Volume_ID, Artist_ID, Volume_Issue, Issue_Date, Weeks_on_Top, Song) VALUES (10, 1, 'V10', '2021-01-01', 5.0, 'Song 1');
INSERT INTO volume (Volume_ID, Artist_ID, Volume_Issue, Issue_Date, Weeks_on_Top, Song) VALUES (20, 2, 'V20', '2021-02-02', 3.0, 'Song 2');
INSERT INTO volume (Volume_ID, Artist_ID, Volume_Issue, Issue_Date, Weeks_on_Top, Song) VALUES (30, 3, 'V30', '2021-03-03', 1.0, 'Song 3');
INSERT INTO volume (Volume_ID, Artist_ID, Volume_Issue, Issue_Date, Weeks_on_Top, Song) VALUES (40, 4, 'V40', '2021-04-04', 2.0, 'Song 4');
INSERT INTO music_festival (ID, Volume, Music_Festival, Date_of_ceremony, Category, Result) VALUES (1, 10, 'Fest 1', '2022-12-01', 'Cat A', 'Won');
INSERT INTO music_festival (ID, Volume, Music_Festival, Date_of_ceremony, Category, Result) VALUES (2, 10, 'Fest 2', '2022-05-01', 'Cat B', 'Nominated');
INSERT INTO music_festival (ID, Volume, Music_Festival, Date_of_ceremony, Category, Result) VALUES (99, 20, 'Fest 3', '2022-06-01', 'Cat C', 'Won');
INSERT INTO music_festival (ID, Volume, Music_Festival, Date_of_ceremony, Category, Result) VALUES (3, 30, 'Fest 4', '2022-01-01', 'Cat D', 'Lost');
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT date_of_ceremony FROM (SELECT volume_id, volume_issue, issue_date, weeks_on_top, song, artist_id, music_festival, date_of_ceremony, category, RESULT, volume_id AS volume FROM (SELECT LHS.volume_id AS volume_id, LHS.volume_issue AS volume_issue, LHS.issue_date AS issue_date, LHS.weeks_on_top AS weeks_on_top, LHS.song AS song, LHS.artist_id AS artist_id, RHS.music_festival AS music_festival, RHS.date_of_ceremony AS date_of_ceremony, RHS.category AS category, RHS.result AS RESULT FROM volume AS LHS INNER JOIN music_festival AS RHS ON (LHS.volume_id = RHS.volume AND LHS.artist_id = RHS.id))) ORDER BY date_of_ceremony;

/*
Gold Result:
('2022-01-01',)
('2022-12-01',)
*/

-- Prediction Query
SELECT T1.Date_of_ceremony FROM music_festival AS T1 JOIN volume AS T2 ON T1.Volume = T2.Volume_ID WHERE T2.Weeks_on_Top > 2;

/*
Prediction Result:
('2022-12-01',)
('2022-05-01',)
('2022-06-01',)
*/