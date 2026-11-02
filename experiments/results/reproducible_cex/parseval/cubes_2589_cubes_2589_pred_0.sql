-- Schema DDL
CREATE TABLE "artist" ("Artist_ID" INTEGER PRIMARY KEY, "Artist" TEXT, "Age" INTEGER, "Famous_Title" TEXT, "Famous_Release_date" TEXT);

CREATE TABLE "volume" ("Volume_ID" INTEGER PRIMARY KEY, "Artist_ID" INTEGER, "Volume_Issue" TEXT, "Issue_Date" TEXT, "Weeks_on_Top" REAL, "Song" TEXT, FOREIGN KEY ("Artist_ID") REFERENCES "artist" ("Artist_ID"));

CREATE TABLE "music_festival" ("ID" INTEGER PRIMARY KEY, "Volume" INTEGER, "Music_Festival" TEXT, "Date_of_ceremony" TEXT, "Category" TEXT, "Result" TEXT, FOREIGN KEY ("Volume") REFERENCES "volume" ("Volume_ID"));

-- Loading data
PRAGMA foreign_keys = OFF;
-- Inserting into table: artist --
INSERT INTO "artist" ("artist_id", "artist", "age", "famous_title", "famous_release_date") VALUES (-2147483648, '5k5swwqcgs', 247012447, '8c4pgu7vfe', 'hria2ypu');

-- Inserting into table: volume --
INSERT INTO "volume" ("volume_id", "artist_id", "volume_issue", "issue_date", "weeks_on_top", "song") VALUES (-2147483648, -2147483648, 'hsrwbbp', 'luhvdltti', 182.319045, 'nprmdposii');

-- Inserting into table: music_festival --
INSERT INTO "music_festival" ("id", "volume", "music_festival", "date_of_ceremony", "category", "result") VALUES (-2147483648, -2147483648, '5u', 'w6kl', 'mus_5df316', 'a9');

INSERT INTO "music_festival" ("id", "volume", "music_festival", "date_of_ceremony", "category", "result") VALUES (-2147483647, -2147483648, '00t5c4ecigc', 'e376nium52', 'mus_5df316', 'zbuo4nrqrof');

INSERT INTO "music_festival" ("id", "volume", "music_festival", "date_of_ceremony", "category", "result") VALUES (-2147483646, -2147483648, 'p5s5bbp', '02eutliqa11r', 'mus_5df316', 'ytoo3o9');

INSERT INTO "music_festival" ("id", "volume", "music_festival", "date_of_ceremony", "category", "result") VALUES (2, -2147483648, '72k', 'ex1', 'mus_5df316', 'ji7zwau2');

INSERT INTO "music_festival" ("id", "volume", "music_festival", "date_of_ceremony", "category", "result") VALUES (3, -2147483648, 'yrq13p', 'u78d99r', 'mus_5df316', 'jsl');

INSERT INTO "music_festival" ("id", "volume", "music_festival", "date_of_ceremony", "category", "result") VALUES (-2147483645, -2147483648, '4', 'p5qi2rk', 'mus_5df316', '9v');

INSERT INTO "music_festival" ("id", "volume", "music_festival", "date_of_ceremony", "category", "result") VALUES (-2147483642, -2147483648, 'x58pz0f8je', 'd2', 'mus_5df316', 'vy9uxj4');

INSERT INTO "music_festival" ("id", "volume", "music_festival", "date_of_ceremony", "category", "result") VALUES (-2147483641, -2147483648, 'bdvlph', 'gndqwnqc', 'mus_5df316', 'x5hncprjtu0');

INSERT INTO "music_festival" ("id", "volume", "music_festival", "date_of_ceremony", "category", "result") VALUES (-2147483640, -2147483648, '79fjgq8', 'n2f3dqv0gcb9', 'mus_5df316', 'ozk3zbily');

INSERT INTO "music_festival" ("id", "volume", "music_festival", "date_of_ceremony", "category", "result") VALUES (-2147483639, -2147483648, 'kn6vck6ah0f8', 'sww', 'mus_5df316', 'q7x');

INSERT INTO "music_festival" ("id", "volume", "music_festival", "date_of_ceremony", "category", "result") VALUES (-2147483638, -2147483648, '72fxa7ryfd', 'z16ni', 'mus_5df316', 'jai');

INSERT INTO "music_festival" ("id", "volume", "music_festival", "date_of_ceremony", "category", "result") VALUES (-2147483637, -2147483648, 'h', 'ogrgjd8y', 'mus_5df316', 't1afgog');

INSERT INTO "music_festival" ("id", "volume", "music_festival", "date_of_ceremony", "category", "result") VALUES (-2147483636, -2147483648, 'tsj', 'ayxp1q43', NULL, '1jh3den');

INSERT INTO "music_festival" ("id", "volume", "music_festival", "date_of_ceremony", "category", "result") VALUES (-2147483635, -2147483648, '68x8vacx7a', 'u5', NULL, '1of77p');

INSERT INTO "music_festival" ("id", "volume", "music_festival", "date_of_ceremony", "category", "result") VALUES (-2147483634, -2147483648, '72ct', 'c', NULL, 'mfg62');

INSERT INTO "music_festival" ("id", "volume", "music_festival", "date_of_ceremony", "category", "result") VALUES (5, -2147483648, 'v5q8qdj', 'e1io', 'mus_ea1013', '278507cv');

INSERT INTO "music_festival" ("id", "volume", "music_festival", "date_of_ceremony", "category", "result") VALUES (4, -2147483648, 'ptt', '6b', 'mus_ea1013', 'ou5z');
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT DISTINCT category FROM (SELECT category, RESULT, COUNT(*) AS n FROM music_festival GROUP BY category, RESULT) WHERE (n > 1) ORDER BY category;

/*
Gold Result:
*/

-- Prediction Query
SELECT Category FROM music_festival GROUP BY Category HAVING COUNT(*) > 1;

/*
Prediction Result:
(None,)
('mus_5df316',)
('mus_ea1013',)
*/