-- Schema DDL
CREATE TABLE "artist" ("Artist_ID" INTEGER PRIMARY KEY, "Artist" TEXT, "Age" INTEGER, "Famous_Title" TEXT, "Famous_Release_date" TEXT);

CREATE TABLE "volume" ("Volume_ID" INTEGER PRIMARY KEY, "Artist_ID" INTEGER, "Volume_Issue" TEXT, "Issue_Date" TEXT, "Weeks_on_Top" REAL, "Song" TEXT, FOREIGN KEY ("Artist_ID") REFERENCES "artist" ("Artist_ID"));

CREATE TABLE "music_festival" ("ID" INTEGER PRIMARY KEY, "Volume" INTEGER, "Music_Festival" TEXT, "Date_of_ceremony" TEXT, "Category" TEXT, "Result" TEXT, FOREIGN KEY ("Volume") REFERENCES "volume" ("Volume_ID"));

-- Loading data
PRAGMA foreign_keys = OFF;
INSERT INTO artist (artist_id, artist, age, famous_title, famous_release_date) VALUES (1, NULL, 0, 'default2', 'default1');
INSERT INTO music_festival (id, volume, music_festival, date_of_ceremony, category, result) VALUES (0, NULL, NULL, NULL, NULL, NULL), (1, NULL, NULL, 'default2', 'default1', 'default2'), (2, NULL, 'default1', 'default2', NULL, 'default2');
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT RESULT, n AS count___ FROM (SELECT date_of_ceremony, RESULT, COUNT(*) AS n FROM music_festival GROUP BY date_of_ceremony, RESULT) ORDER BY RESULT, count___ NULLS LAST;

/*
Gold Result:
(None, 1)
('default2', 2)
*/

-- Prediction Query
SELECT RESULT, COUNT(*) FROM music_festival GROUP BY RESULT ORDER BY COUNT(*) DESC, RESULT NULLS LAST;

/*
Prediction Result:
('default2', 2)
(None, 1)
*/