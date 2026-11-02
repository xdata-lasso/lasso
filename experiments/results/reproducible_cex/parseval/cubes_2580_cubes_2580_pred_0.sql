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
INSERT INTO "music_festival" ("id", "volume", "music_festival", "date_of_ceremony", "category", "result") VALUES (-2147483648, -2147483648, '5u', 'mus_cbde7b', 'w6kl', 'mus_c4efa4');

INSERT INTO "music_festival" ("id", "volume", "music_festival", "date_of_ceremony", "category", "result") VALUES (-2147483647, -2147483648, 'a9000t5c4eci', 'mus_cbde7b', 'gce376nium52', 'mus_c4efa4');

INSERT INTO "music_festival" ("id", "volume", "music_festival", "date_of_ceremony", "category", "result") VALUES (-2147483646, -2147483648, 'u', 'mus_cbde7b', '4nrq', 'mus_c4efa4');

INSERT INTO "music_festival" ("id", "volume", "music_festival", "date_of_ceremony", "category", "result") VALUES (-2147483645, -2147483648, 'fqyp', 'mus_cbde7b', 's5bbp02e', 'mus_c4efa4');

INSERT INTO "music_festival" ("id", "volume", "music_festival", "date_of_ceremony", "category", "result") VALUES (-2147483644, -2147483648, 'liqa1', 'mus_cbde7b', 'ryytoo3', 'mus_c4efa4');

INSERT INTO "music_festival" ("id", "volume", "music_festival", "date_of_ceremony", "category", "result") VALUES (-2147483643, -2147483648, 'hl72klex1', 'mus_cbde7b', 'ji7zwau2', 'mus_c4efa4');

INSERT INTO "music_festival" ("id", "volume", "music_festival", "date_of_ceremony", "category", "result") VALUES (-2147483642, -2147483648, 'yrq13p', NULL, 'u78d99r', 'mus_c4efa4');

INSERT INTO "music_festival" ("id", "volume", "music_festival", "date_of_ceremony", "category", "result") VALUES (-2147483641, -2147483648, 'sl0', NULL, '4', 'mus_c4efa4');

INSERT INTO "music_festival" ("id", "volume", "music_festival", "date_of_ceremony", "category", "result") VALUES (-2147483640, -2147483648, 'p5qi2rkf9v', NULL, 'x58pz', 'mus_c4efa4');

INSERT INTO "music_festival" ("id", "volume", "music_festival", "date_of_ceremony", "category", "result") VALUES (-2147483639, -2147483648, 'f8jegd21vy9u', 'mus_cbde7b', 'j4hwbd', NULL);

INSERT INTO "music_festival" ("id", "volume", "music_festival", "date_of_ceremony", "category", "result") VALUES (-2147483638, -2147483648, 'ph2', 'mus_cbde7b', 'nd', NULL);

INSERT INTO "music_festival" ("id", "volume", "music_festival", "date_of_ceremony", "category", "result") VALUES (-2147483637, -2147483648, 'nqcx5h', 'mus_cbde7b', 'cprj', NULL);

INSERT INTO "music_festival" ("id", "volume", "music_festival", "date_of_ceremony", "category", "result") VALUES (-2147483636, -2147483648, '0dz79f', 'mus_cbde7b', 'gq8', 'mus_c4efa4');

INSERT INTO "music_festival" ("id", "volume", "music_festival", "date_of_ceremony", "category", "result") VALUES (-2147483635, -2147483648, 'f3dqv0gc', 'mus_cbde7b', '9', 'mus_c4efa4');

INSERT INTO "music_festival" ("id", "volume", "music_festival", "date_of_ceremony", "category", "result") VALUES (-2147483634, -2147483648, 'k3zbily', 'mus_cbde7b', 'kn6vc', 'mus_c4efa4');

INSERT INTO "music_festival" ("id", "volume", "music_festival", "date_of_ceremony", "category", "result") VALUES (-2147483633, -2147483648, 'ah0f8jsww', 'mus_cbde7b', 'q7x', 'mus_c4efa4');

INSERT INTO "music_festival" ("id", "volume", "music_festival", "date_of_ceremony", "category", "result") VALUES (-2147483632, -2147483648, '72fxa7ryfd', 'mus_cbde7b', 'z16ni', 'mus_c4efa4');

INSERT INTO "music_festival" ("id", "volume", "music_festival", "date_of_ceremony", "category", "result") VALUES (-2147483631, -2147483648, 'ai5', 'mus_cbde7b', 'h', 'mus_c4efa4');

INSERT INTO "music_festival" ("id", "volume", "music_festival", "date_of_ceremony", "category", "result") VALUES (-2147483630, -2147483648, 'grgj', 'mus_cbde7b', '8', 'mus_c4efa4');

INSERT INTO "music_festival" ("id", "volume", "music_festival", "date_of_ceremony", "category", "result") VALUES (-2147483629, -2147483648, 't1afgog', 'mus_cbde7b', 'itsj3', 'mus_c4efa4');

INSERT INTO "music_festival" ("id", "volume", "music_festival", "date_of_ceremony", "category", "result") VALUES (-2147483628, -2147483648, 'xp1q430', 'mus_cbde7b', 'jh3den8', 'mus_c4efa4');
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT RESULT, n AS count___ FROM (SELECT date_of_ceremony, RESULT, COUNT(*) AS n FROM music_festival GROUP BY date_of_ceremony, RESULT) ORDER BY RESULT, count___ NULLS LAST;

/*
Gold Result:
(None, 3)
('mus_c4efa4', 3)
('mus_c4efa4', 15)
*/

-- Prediction Query
SELECT RESULT, COUNT(*) FROM music_festival GROUP BY RESULT ORDER BY COUNT(*) DESC, RESULT NULLS LAST;

/*
Prediction Result:
('mus_c4efa4', 18)
(None, 3)
*/