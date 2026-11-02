-- Schema DDL
CREATE TABLE "artist" ("Artist_ID" INTEGER PRIMARY KEY, "Artist" TEXT, "Age" INTEGER, "Famous_Title" TEXT, "Famous_Release_date" TEXT);

CREATE TABLE "volume" ("Volume_ID" INTEGER PRIMARY KEY, "Artist_ID" INTEGER, "Volume_Issue" TEXT, "Issue_Date" TEXT, "Weeks_on_Top" REAL, "Song" TEXT, FOREIGN KEY ("Artist_ID") REFERENCES "artist" ("Artist_ID"));

CREATE TABLE "music_festival" ("ID" INTEGER PRIMARY KEY, "Volume" INTEGER, "Music_Festival" TEXT, "Date_of_ceremony" TEXT, "Category" TEXT, "Result" TEXT, FOREIGN KEY ("Volume") REFERENCES "volume" ("Volume_ID"));

-- Loading data
PRAGMA foreign_keys = OFF;
INSERT INTO artist (artist_id, artist, age, famous_title, famous_release_date) VALUES (1, NULL, 0, NULL, NULL);
INSERT INTO volume (volume_id, artist_id, volume_issue, issue_date, weeks_on_top, song) VALUES (2, 1, NULL, 'default2', 2.0, NULL), (1, 1, 'default2', NULL, 1.0, NULL), (0, 1, 'default1', NULL, NULL, 'default2'), (3, 1, 'default1', 'default2', 2.0, 'default1'), (4, 1, NULL, NULL, 0.0, 'default2');
INSERT INTO music_festival (id, volume, music_festival, date_of_ceremony, category, result) VALUES (0, 2, NULL, 'default1', 'default1', 'default1'), (2, 0, 'default1', NULL, NULL, 'default2'), (1, 3, NULL, NULL, NULL, NULL), (3, 3, NULL, NULL, 'default1', NULL), (4, 4, 'default2', NULL, NULL, 'default2');
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT DISTINCT category FROM (SELECT category, RESULT, COUNT(*) AS n FROM music_festival GROUP BY category, RESULT) WHERE (n > 1) ORDER BY category;

/*
Gold Result:
(None,)
*/

-- Prediction Query
SELECT Category FROM music_festival GROUP BY Category HAVING COUNT(*) > 1;

/*
Prediction Result:
(None,)
('default1',)
*/