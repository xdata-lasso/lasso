-- Schema DDL
CREATE TABLE "artist" ("Artist_ID" INTEGER PRIMARY KEY, "Artist" TEXT, "Age" INTEGER, "Famous_Title" TEXT, "Famous_Release_date" TEXT);

CREATE TABLE "volume" ("Volume_ID" INTEGER PRIMARY KEY, "Artist_ID" INTEGER, "Volume_Issue" TEXT, "Issue_Date" TEXT, "Weeks_on_Top" REAL, "Song" TEXT, FOREIGN KEY ("Artist_ID") REFERENCES "artist" ("Artist_ID"));

CREATE TABLE "music_festival" ("ID" INTEGER PRIMARY KEY, "Volume" INTEGER, "Music_Festival" TEXT, "Date_of_ceremony" TEXT, "Category" TEXT, "Result" TEXT, FOREIGN KEY ("Volume") REFERENCES "volume" ("Volume_ID"));

-- Loading data
PRAGMA foreign_keys = OFF;
INSERT INTO artist (artist_id, artist, age, famous_title, famous_release_date) VALUES (1, 'default1', 1, 'default2', 'default2');
INSERT INTO volume (volume_id, artist_id, volume_issue, issue_date, weeks_on_top, song) VALUES (0, NULL, 'default2', 'default1', 0.0, NULL), (2, 1, NULL, 'default2', NULL, 'default2'), (1, 1, NULL, NULL, 0.0, 'default2');
INSERT INTO music_festival (id, volume, music_festival, date_of_ceremony, category, result) VALUES (0, NULL, NULL, 'default1', NULL, 'default2'), (1, 1, NULL, NULL, 'default1', 'default1');
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT RESULT FROM (SELECT * FROM (SELECT * FROM (SELECT id, music_festival, date_of_ceremony, category, volume, RESULT, MAX(n) OVER () AS n FROM (SELECT id, music_festival, date_of_ceremony, category, volume, RESULT, COUNT(*) OVER () AS n FROM music_festival)) ORDER BY volume) LIMIT 1);

/*
Gold Result:
('default2',)
*/

-- Prediction Query
SELECT RESULT FROM music_festival GROUP BY RESULT ORDER BY COUNT(*) DESC, RESULT NULLS LAST LIMIT 1;

/*
Prediction Result:
('default1',)
*/