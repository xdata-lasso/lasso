-- Schema DDL
CREATE TABLE "artist" ("Artist_ID" INTEGER PRIMARY KEY, "Artist" TEXT, "Age" INTEGER, "Famous_Title" TEXT, "Famous_Release_date" TEXT);

CREATE TABLE "volume" ("Volume_ID" INTEGER PRIMARY KEY, "Artist_ID" INTEGER, "Volume_Issue" TEXT, "Issue_Date" TEXT, "Weeks_on_Top" REAL, "Song" TEXT, FOREIGN KEY ("Artist_ID") REFERENCES "artist" ("Artist_ID"));

CREATE TABLE "music_festival" ("ID" INTEGER PRIMARY KEY, "Volume" INTEGER, "Music_Festival" TEXT, "Date_of_ceremony" TEXT, "Category" TEXT, "Result" TEXT, FOREIGN KEY ("Volume") REFERENCES "volume" ("Volume_ID"));

-- Loading data
PRAGMA foreign_keys = OFF;
INSERT INTO artist (artist_id, artist, age, famous_title, famous_release_date) VALUES (2, 'default1', 3, 'default2', NULL), (1, 'default1', 0, 'default1', NULL), (3, NULL, 3, NULL, NULL);
INSERT INTO volume (volume_id, artist_id, volume_issue, issue_date, weeks_on_top, song) VALUES (0, 1, 'default2', NULL, 0.0, 'default1'), (3, 2, 'default2', 'default2', 2.0, NULL), (2, NULL, NULL, NULL, NULL, 'default2');
INSERT INTO music_festival (id, volume, music_festival, date_of_ceremony, category, result) VALUES (2, 3, 'default2', NULL, 'default1', 'default1'), (1, 0, 'default1', 'default2', 'default2', 'default1'), (0, 2, NULL, NULL, NULL, 'default2'), (3, NULL, 'default1', 'default1', NULL, 'default2');
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT date_of_ceremony FROM (SELECT volume_id, volume_issue, issue_date, weeks_on_top, song, artist_id, music_festival, date_of_ceremony, category, RESULT, volume_id AS volume FROM (SELECT LHS.volume_id AS volume_id, LHS.volume_issue AS volume_issue, LHS.issue_date AS issue_date, LHS.weeks_on_top AS weeks_on_top, LHS.song AS song, LHS.artist_id AS artist_id, RHS.music_festival AS music_festival, RHS.date_of_ceremony AS date_of_ceremony, RHS.category AS category, RHS.result AS RESULT FROM volume AS LHS INNER JOIN music_festival AS RHS ON (LHS.volume_id = RHS.volume AND LHS.artist_id = RHS.id))) ORDER BY date_of_ceremony;

/*
Gold Result:
(None,)
('default2',)
*/

-- Prediction Query
SELECT T1.Date_of_ceremony FROM music_festival AS T1 JOIN volume AS T2 ON T1.Volume = T2.Volume_ID WHERE T2.Weeks_on_Top > 2;

/*
Prediction Result:
*/