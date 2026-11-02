-- Schema DDL
CREATE TABLE "artist" ("Artist_ID" INTEGER PRIMARY KEY, "Artist" TEXT, "Age" INTEGER, "Famous_Title" TEXT, "Famous_Release_date" TEXT);

CREATE TABLE "volume" ("Volume_ID" INTEGER PRIMARY KEY, "Artist_ID" INTEGER, "Volume_Issue" TEXT, "Issue_Date" TEXT, "Weeks_on_Top" REAL, "Song" TEXT, FOREIGN KEY ("Artist_ID") REFERENCES "artist" ("Artist_ID"));

CREATE TABLE "music_festival" ("ID" INTEGER PRIMARY KEY, "Volume" INTEGER, "Music_Festival" TEXT, "Date_of_ceremony" TEXT, "Category" TEXT, "Result" TEXT, FOREIGN KEY ("Volume") REFERENCES "volume" ("Volume_ID"));

-- Loading data
PRAGMA foreign_keys = OFF;
INSERT INTO artist (artist_id, artist, age, famous_title, famous_release_date) VALUES (23, 'default1', 24, 'default1', NULL), (24, 'default2', 1, 'default1', 'default2'), (1, 'default2', 22, 'default1', 'default1'), (22, NULL, NULL, NULL, 'default2'), (0, 'default1', 23, 'default2', 'default2'), (2, 'default2', 1, 'default1', NULL), (3, 'default2', 23, NULL, 'default1'), (4, 'default2', 0, 'default2', 'default1');
INSERT INTO volume (volume_id, artist_id, volume_issue, issue_date, weeks_on_top, song) VALUES (0, 22, 'default1', 'default2', NULL, 'default2'), (22, 23, 'default1', NULL, 1.0, NULL), (23, 24, 'default1', 'default2', 1.0, 'default1'), (24, 0, 'default1', 'default1', 1.0, NULL), (1, 23, 'default1', NULL, 22.0, 'default2'), (2, 24, NULL, NULL, 0.0, 'default2'), (3, 1, 'default1', 'default2', 23.0, NULL);
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT issue_date FROM (SELECT LHS.artist_id AS artist_id, LHS.artist AS artist, LHS.age AS age, LHS.famous_title AS famous_title, LHS.famous_release_date AS famous_release_date, RHS.volume_id AS volume_id, RHS.volume_issue AS volume_issue, RHS.issue_date AS issue_date, RHS.weeks_on_top AS weeks_on_top, RHS.song AS song FROM artist AS LHS INNER JOIN volume AS RHS ON (LHS.artist_id = RHS.artist_id)) WHERE (age <= 23) ORDER BY issue_date;

/*
Gold Result:
(None,)
('default1',)
('default2',)
('default2',)
*/

-- Prediction Query
SELECT Issue_Date FROM artist AS T1 JOIN volume AS T2 ON T1.Artist_ID = T2.Artist_ID WHERE T1.age <= 23;

/*
Prediction Result:
(None,)
('default2',)
('default2',)
('default1',)
*/