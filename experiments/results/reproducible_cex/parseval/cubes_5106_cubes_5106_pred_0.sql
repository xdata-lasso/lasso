-- Schema DDL
CREATE TABLE "artist" ("Artist_ID" INTEGER PRIMARY KEY, "Artist" TEXT, "Age" INTEGER, "Famous_Title" TEXT, "Famous_Release_date" TEXT);

CREATE TABLE "volume" ("Volume_ID" INTEGER PRIMARY KEY, "Artist_ID" INTEGER, "Volume_Issue" TEXT, "Issue_Date" TEXT, "Weeks_on_Top" REAL, "Song" TEXT, FOREIGN KEY ("Artist_ID") REFERENCES "artist" ("Artist_ID"));

CREATE TABLE "music_festival" ("ID" INTEGER PRIMARY KEY, "Volume" INTEGER, "Music_Festival" TEXT, "Date_of_ceremony" TEXT, "Category" TEXT, "Result" TEXT, FOREIGN KEY ("Volume") REFERENCES "volume" ("Volume_ID"));

-- Loading data
PRAGMA foreign_keys = OFF;
-- Inserting into table: artist --
INSERT INTO "artist" ("artist_id", "artist", "age", "famous_title", "famous_release_date") VALUES (-2147483648, '5k5swwqcgs', 247012447, '8c4pgu7vfe', 'hria2ypu');

-- Inserting into table: volume --
INSERT INTO "volume" ("volume_id", "artist_id", "volume_issue", "issue_date", "weeks_on_top", "song") VALUES (1, -2147483648, 'hsrwbbp', 'luhvdltti', 182.319045, 'nprmdposii');

-- Inserting into table: music_festival --
INSERT INTO "music_festival" ("id", "volume", "music_festival", "date_of_ceremony", "category", "result") VALUES (1, 1, 'mus_0f2010', 'mus_da8325', 'mus_83541f', 'mus_08e9f9');

INSERT INTO "music_festival" ("id", "volume", "music_festival", "date_of_ceremony", "category", "result") VALUES (-2147483647, 1, 'mus_8e4daa', 'mus_7be9cd', 'mus_c9d229', 'mus_ad876b');

INSERT INTO "music_festival" ("id", "volume", "music_festival", "date_of_ceremony", "category", "result") VALUES (-2147483646, 1, 'nw6klf', 'a9000t5c4eci', 'gce376nium52', 'q_3_824488');

INSERT INTO "music_festival" ("id", "volume", "music_festival", "date_of_ceremony", "category", "result") VALUES (-2147483645, 1, 'u', '4nrq', 'rofqyp5s5b', 'q_3_824488');

INSERT INTO "music_festival" ("id", "volume", "music_festival", "date_of_ceremony", "category", "result") VALUES (2, 1, '02eu', 'liqa1', 'ryytoo3', '9hl7');

INSERT INTO "music_festival" ("id", "volume", "music_festival", "date_of_ceremony", "category", "result") VALUES (3, 1, 'lex', '4ji7zwa', '2dwyrq', '3pyu78d');
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT RESULT FROM (SELECT * FROM (SELECT * FROM (SELECT id, music_festival, date_of_ceremony, category, volume, RESULT, MAX(n) OVER () AS n FROM (SELECT id, music_festival, date_of_ceremony, category, volume, RESULT, COUNT(*) OVER () AS n FROM music_festival)) ORDER BY volume) LIMIT 1);

/*
Gold Result:
('mus_ad876b',)
*/

-- Prediction Query
SELECT RESULT FROM music_festival GROUP BY RESULT ORDER BY COUNT(*) DESC, RESULT NULLS LAST LIMIT 1;

/*
Prediction Result:
('q_3_824488',)
*/