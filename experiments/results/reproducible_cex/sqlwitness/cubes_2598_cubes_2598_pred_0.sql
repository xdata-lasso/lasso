-- Schema DDL
CREATE TABLE "artist" ("Artist_ID" INTEGER PRIMARY KEY, "Artist" TEXT, "Age" INTEGER, "Famous_Title" TEXT, "Famous_Release_date" TEXT);

CREATE TABLE "volume" ("Volume_ID" INTEGER PRIMARY KEY, "Artist_ID" INTEGER, "Volume_Issue" TEXT, "Issue_Date" TEXT, "Weeks_on_Top" REAL, "Song" TEXT, FOREIGN KEY ("Artist_ID") REFERENCES "artist" ("Artist_ID"));

CREATE TABLE "music_festival" ("ID" INTEGER PRIMARY KEY, "Volume" INTEGER, "Music_Festival" TEXT, "Date_of_ceremony" TEXT, "Category" TEXT, "Result" TEXT, FOREIGN KEY ("Volume") REFERENCES "volume" ("Volume_ID"));

-- Loading data
PRAGMA foreign_keys = OFF;
INSERT INTO artist (artist_id, artist, age, famous_title, famous_release_date) VALUES (1, NULL, 0, 'default2', 'default1'), (0, 'default2', 0, 'Awarded', 'default2'), (2, NULL, NULL, 'default1', NULL), (3, 'default1', NULL, 'Awarded', 'default1'), (4, 'Awarded', 0, 'Awarded', 'default1'), (5, 'default1', NULL, NULL, 'default1'), (6, 'default1', 0, NULL, 'default2'), (7, 'default2', 0, 'default1', 'Awarded'), (8, 'default1', 1, 'Awarded', 'Awarded'), (9, 'default2', 0, NULL, 'Awarded');
INSERT INTO volume (volume_id, artist_id, volume_issue, issue_date, weeks_on_top, song) VALUES (1, 5, 'default2', NULL, 0.0, 'Awarded'), (0, 9, NULL, 'Awarded', 0.0, 'default1');
INSERT INTO music_festival (id, volume, music_festival, date_of_ceremony, category, result) VALUES (0, NULL, 'default1', 'default2', NULL, 'default2'), (1, NULL, 'default2', NULL, 'Awarded', 'default2'), (2, NULL, 'Awarded', 'default2', 'default1', NULL), (3, 0, 'default1', 'default2', 'Awarded', 'Awarded'), (4, 0, 'default2', NULL, NULL, 'default2'), (5, NULL, 'Awarded', 'default1', 'default1', NULL), (6, NULL, 'default2', NULL, 'Awarded', 'Awarded'), (7, 0, 'default2', 'Awarded', NULL, NULL), (8, 0, 'Awarded', NULL, NULL, 'Awarded'), (9, 0, 'Awarded', NULL, 'Awarded', 'Awarded'), (10, 0, 'Awarded', NULL, 'default1', 'default1'), (11, 0, 'default2', 'default2', 'Awarded', 'default2'), (12, 1, 'default2', NULL, 'Awarded', 'default1');
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT "category" FROM "music_festival" WHERE ("result" = 'Awarded') ORDER BY category, music_festival.id NULLS LAST;

/*
Gold Result:
(None,)
('Awarded',)
('Awarded',)
('Awarded',)
*/

-- Prediction Query
SELECT Category FROM music_festival WHERE RESULT = 'Awarded';

/*
Prediction Result:
('Awarded',)
('Awarded',)
(None,)
('Awarded',)
*/