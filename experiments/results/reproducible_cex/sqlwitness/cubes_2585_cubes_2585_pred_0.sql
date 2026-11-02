-- Schema DDL
CREATE TABLE "artist" ("Artist_ID" INTEGER PRIMARY KEY, "Artist" TEXT, "Age" INTEGER, "Famous_Title" TEXT, "Famous_Release_date" TEXT);

CREATE TABLE "volume" ("Volume_ID" INTEGER PRIMARY KEY, "Artist_ID" INTEGER, "Volume_Issue" TEXT, "Issue_Date" TEXT, "Weeks_on_Top" REAL, "Song" TEXT, FOREIGN KEY ("Artist_ID") REFERENCES "artist" ("Artist_ID"));

CREATE TABLE "music_festival" ("ID" INTEGER PRIMARY KEY, "Volume" INTEGER, "Music_Festival" TEXT, "Date_of_ceremony" TEXT, "Category" TEXT, "Result" TEXT, FOREIGN KEY ("Volume") REFERENCES "volume" ("Volume_ID"));

-- Loading data
PRAGMA foreign_keys = OFF;
INSERT INTO artist (artist_id, artist, age, famous_title, famous_release_date) VALUES (31, 'default1', 0, 'default1', NULL), (0, 'default1', 33, 'default1', NULL), (32, 'default2', 1, NULL, 'default2'), (33, NULL, NULL, 'default2', NULL), (1, NULL, 1, 'default1', 'default2'), (2, NULL, 33, 'default1', 'default1'), (3, 'default2', 0, NULL, 'default1'), (4, NULL, NULL, 'default1', 'default1'), (5, 'default2', 32, 'default2', NULL);
INSERT INTO volume (volume_id, artist_id, volume_issue, issue_date, weeks_on_top, song) VALUES (0, 31, NULL, 'default2', 0.0, 'default2'), (1, 0, 'default2', 'default1', 0.0, NULL), (33, 31, 'default2', NULL, 33.0, 'default1'), (31, 1, 'default2', 'default1', NULL, 'default1'), (32, 4, NULL, NULL, NULL, 'default2'), (2, 0, 'default1', NULL, 1.0, 'default2'), (3, 31, NULL, 'default2', 31.0, 'default2'), (4, 33, 'default1', NULL, 0.0, 'default2'), (5, 32, NULL, 'default2', 1.0, 'default1'), (6, 2, 'default2', 'default1', 1.0, 'default1');
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT song FROM (SELECT LHS.artist_id AS artist_id, LHS.artist AS artist, LHS.age AS age, LHS.famous_title AS famous_title, LHS.famous_release_date AS famous_release_date, RHS.volume_id AS volume_id, RHS.volume_issue AS volume_issue, RHS.issue_date AS issue_date, RHS.weeks_on_top AS weeks_on_top, RHS.song AS song FROM artist AS LHS INNER JOIN volume AS RHS ON (LHS.artist_id = RHS.artist_id)) WHERE (age >= 32) ORDER BY song;

/*
Gold Result:
(None,)
('default1',)
('default2',)
*/

-- Prediction Query
SELECT T2.Song FROM artist AS T1 JOIN volume AS T2 ON T1.Artist_ID = T2.Artist_ID WHERE T1.age >= 32;

/*
Prediction Result:
(None,)
('default2',)
('default1',)
*/