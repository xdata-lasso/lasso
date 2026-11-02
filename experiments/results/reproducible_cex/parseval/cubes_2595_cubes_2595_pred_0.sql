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
INSERT INTO "music_festival" ("id", "volume", "music_festival", "date_of_ceremony", "category", "result") VALUES (-2147483648, -2147483648, '5u', 'mus_ddf849', 'mus_7cdfa8', 'w6kl');

INSERT INTO "music_festival" ("id", "volume", "music_festival", "date_of_ceremony", "category", "result") VALUES (-2147483647, -2147483648, 'a9000t5c4eci', 'mus_ddf849', 'mus_7cdfa8', 'gce376nium52');

INSERT INTO "music_festival" ("id", "volume", "music_festival", "date_of_ceremony", "category", "result") VALUES (-2147483646, -2147483648, 'u', 'mus_ddf849', 'mus_7cdfa8', '4nrq');

INSERT INTO "music_festival" ("id", "volume", "music_festival", "date_of_ceremony", "category", "result") VALUES (-2147483645, -2147483648, 'fqyp', 'mus_ddf849', 'mus_7cdfa8', 's5bbp02e');

INSERT INTO "music_festival" ("id", "volume", "music_festival", "date_of_ceremony", "category", "result") VALUES (-2147483644, -2147483648, 'liqa1', 'mus_ddf849', 'mus_7cdfa8', 'ryytoo3');

INSERT INTO "music_festival" ("id", "volume", "music_festival", "date_of_ceremony", "category", "result") VALUES (-2147483643, -2147483648, 'hl72klex1', 'mus_ddf849', 'mus_7cdfa8', 'ji7zwau2');

INSERT INTO "music_festival" ("id", "volume", "music_festival", "date_of_ceremony", "category", "result") VALUES (-2147483642, -2147483648, 'yrq13p', 'mus_ddf849', NULL, 'u78d99r');

INSERT INTO "music_festival" ("id", "volume", "music_festival", "date_of_ceremony", "category", "result") VALUES (-2147483641, -2147483648, 'sl0', 'mus_ddf849', NULL, '4');

INSERT INTO "music_festival" ("id", "volume", "music_festival", "date_of_ceremony", "category", "result") VALUES (-2147483640, -2147483648, 'p5qi2rkf9v', 'mus_ddf849', NULL, 'x58pz');

INSERT INTO "music_festival" ("id", "volume", "music_festival", "date_of_ceremony", "category", "result") VALUES (-2147483639, -2147483648, 'f8jegd21vy9u', NULL, 'mus_7cdfa8', 'j4hwbd');

INSERT INTO "music_festival" ("id", "volume", "music_festival", "date_of_ceremony", "category", "result") VALUES (-2147483638, -2147483648, 'ph2', NULL, 'mus_7cdfa8', 'nd');

INSERT INTO "music_festival" ("id", "volume", "music_festival", "date_of_ceremony", "category", "result") VALUES (-2147483637, -2147483648, 'nqcx5h', NULL, 'mus_7cdfa8', 'cprj');

INSERT INTO "music_festival" ("id", "volume", "music_festival", "date_of_ceremony", "category", "result") VALUES (-2147483636, -2147483648, '0dz79f', 'mus_ddf849', 'mus_7cdfa8', 'gq8');

INSERT INTO "music_festival" ("id", "volume", "music_festival", "date_of_ceremony", "category", "result") VALUES (-2147483635, -2147483648, 'f3dqv0gc', 'mus_ddf849', 'mus_7cdfa8', '9');

INSERT INTO "music_festival" ("id", "volume", "music_festival", "date_of_ceremony", "category", "result") VALUES (-2147483634, -2147483648, 'k3zbily', 'mus_ddf849', 'mus_7cdfa8', 'kn6vc');

INSERT INTO "music_festival" ("id", "volume", "music_festival", "date_of_ceremony", "category", "result") VALUES (-2147483633, -2147483648, 'ah0f8jsww', 'mus_ddf849', 'mus_7cdfa8', 'q7x');

INSERT INTO "music_festival" ("id", "volume", "music_festival", "date_of_ceremony", "category", "result") VALUES (-2147483632, -2147483648, '72fxa7ryfd', 'mus_ddf849', 'mus_7cdfa8', 'z16ni');

INSERT INTO "music_festival" ("id", "volume", "music_festival", "date_of_ceremony", "category", "result") VALUES (-2147483631, -2147483648, 'ai5', 'mus_ddf849', 'mus_7cdfa8', 'h');

INSERT INTO "music_festival" ("id", "volume", "music_festival", "date_of_ceremony", "category", "result") VALUES (-2147483630, -2147483648, 'grgj', 'mus_ddf849', 'mus_7cdfa8', '8');

INSERT INTO "music_festival" ("id", "volume", "music_festival", "date_of_ceremony", "category", "result") VALUES (-2147483629, -2147483648, 't1afgog', 'mus_ddf849', 'mus_7cdfa8', 'itsj3');

INSERT INTO "music_festival" ("id", "volume", "music_festival", "date_of_ceremony", "category", "result") VALUES (-2147483628, -2147483648, 'xp1q430', 'mus_ddf849', 'mus_7cdfa8', 'jh3den8');
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT category, n AS count___ FROM (SELECT category, date_of_ceremony, COUNT(*) AS n FROM music_festival GROUP BY category, date_of_ceremony) ORDER BY category, count___ NULLS LAST;

/*
Gold Result:
(None, 3)
('mus_7cdfa8', 3)
('mus_7cdfa8', 15)
*/

-- Prediction Query
SELECT Category, COUNT(*) FROM music_festival GROUP BY Category;

/*
Prediction Result:
(None, 3)
('mus_7cdfa8', 18)
*/