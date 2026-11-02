-- Schema DDL
CREATE TABLE "artist" ("Artist_ID" INTEGER PRIMARY KEY, "Artist" TEXT, "Age" INTEGER, "Famous_Title" TEXT, "Famous_Release_date" TEXT);

CREATE TABLE "volume" ("Volume_ID" INTEGER PRIMARY KEY, "Artist_ID" INTEGER, "Volume_Issue" TEXT, "Issue_Date" TEXT, "Weeks_on_Top" REAL, "Song" TEXT, FOREIGN KEY ("Artist_ID") REFERENCES "artist" ("Artist_ID"));

CREATE TABLE "music_festival" ("ID" INTEGER PRIMARY KEY, "Volume" INTEGER, "Music_Festival" TEXT, "Date_of_ceremony" TEXT, "Category" TEXT, "Result" TEXT, FOREIGN KEY ("Volume") REFERENCES "volume" ("Volume_ID"));

-- Loading data
PRAGMA foreign_keys = OFF;
-- Inserting into table: artist --
INSERT INTO "artist" ("artist_id", "artist", "age", "famous_title", "famous_release_date") VALUES (1, '5k5swwqcgs', 247012447, '8c4pgu7vfe', 'hria2ypu');

-- Inserting into table: volume --
INSERT INTO "volume" ("volume_id", "artist_id", "volume_issue", "issue_date", "weeks_on_top", "song") VALUES (1, 1, 'lhs_540ab5', 'lhs_7570e4', 1.0, 'lhs_6337db');

INSERT INTO "volume" ("volume_id", "artist_id", "volume_issue", "issue_date", "weeks_on_top", "song") VALUES (-2147483647, 1, 'lhs_74b2d2', 'lhs_e22e73', 1.0, 'lhs_bcd133');

INSERT INTO "volume" ("volume_id", "artist_id", "volume_issue", "issue_date", "weeks_on_top", "song") VALUES (2, 1, 'tilbn', 'rmdp', 227.766936, 'iie5u');

INSERT INTO "volume" ("volume_id", "artist_id", "volume_issue", "issue_date", "weeks_on_top", "song") VALUES (4, 1, '6klfa9', '00t5c4e', 950.466571, 'i');

-- Inserting into table: music_festival --
INSERT INTO "music_festival" ("id", "volume", "music_festival", "date_of_ceremony", "category", "result") VALUES (1, 1, 'rhs_951e8a', 'rhs_8e957c', 'rhs_03c784', 'rhs_926f01');

INSERT INTO "music_festival" ("id", "volume", "music_festival", "date_of_ceremony", "category", "result") VALUES (-2147483647, -2147483647, 'rhs_0895f6', 'rhs_f54ec8', 'rhs_9a3adf', 'rhs_c235a2');

INSERT INTO "music_festival" ("id", "volume", "music_festival", "date_of_ceremony", "category", "result") VALUES (3, 1, 'e', '76nium52', 'zbuo4nrqrof', 'qyp5s5bbp0');

INSERT INTO "music_festival" ("id", "volume", "music_festival", "date_of_ceremony", "category", "result") VALUES (5, 4, 'eutliqa11r', 'ytoo3o9', 'l7', 'klex14ji');

INSERT INTO "music_festival" ("id", "volume", "music_festival", "date_of_ceremony", "category", "result") VALUES (-2147483644, 4, 'au2dwy', 'q_1_cffcb0', 'q13py', '78d99r');

INSERT INTO "music_festival" ("id", "volume", "music_festival", "date_of_ceremony", "category", "result") VALUES (-2147483643, -2147483647, 'sl0', 'q_1_cffcb0', '4', 'p5qi2rk');
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT date_of_ceremony FROM (SELECT volume_id, volume_issue, issue_date, weeks_on_top, song, artist_id, music_festival, date_of_ceremony, category, RESULT, volume_id AS volume FROM (SELECT LHS.volume_id AS volume_id, LHS.volume_issue AS volume_issue, LHS.issue_date AS issue_date, LHS.weeks_on_top AS weeks_on_top, LHS.song AS song, LHS.artist_id AS artist_id, RHS.music_festival AS music_festival, RHS.date_of_ceremony AS date_of_ceremony, RHS.category AS category, RHS.result AS RESULT FROM volume AS LHS INNER JOIN music_festival AS RHS ON (LHS.volume_id = RHS.volume AND LHS.artist_id = RHS.id))) ORDER BY date_of_ceremony;

/*
Gold Result:
('rhs_8e957c',)
*/

-- Prediction Query
SELECT T1.Date_of_ceremony FROM music_festival AS T1 JOIN volume AS T2 ON T1.Volume = T2.Volume_ID WHERE T2.Weeks_on_Top > 2;

/*
Prediction Result:
('q_1_cffcb0',)
('ytoo3o9',)
*/