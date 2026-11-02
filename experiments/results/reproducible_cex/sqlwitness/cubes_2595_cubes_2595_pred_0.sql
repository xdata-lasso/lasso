-- Schema DDL
CREATE TABLE "artist" ("Artist_ID" INTEGER PRIMARY KEY, "Artist" TEXT, "Age" INTEGER, "Famous_Title" TEXT, "Famous_Release_date" TEXT);

CREATE TABLE "volume" ("Volume_ID" INTEGER PRIMARY KEY, "Artist_ID" INTEGER, "Volume_Issue" TEXT, "Issue_Date" TEXT, "Weeks_on_Top" REAL, "Song" TEXT, FOREIGN KEY ("Artist_ID") REFERENCES "artist" ("Artist_ID"));

CREATE TABLE "music_festival" ("ID" INTEGER PRIMARY KEY, "Volume" INTEGER, "Music_Festival" TEXT, "Date_of_ceremony" TEXT, "Category" TEXT, "Result" TEXT, FOREIGN KEY ("Volume") REFERENCES "volume" ("Volume_ID"));

-- Loading data
PRAGMA foreign_keys = OFF;
INSERT INTO volume (volume_id, artist_id, volume_issue, issue_date, weeks_on_top, song) VALUES (0, NULL, NULL, 'default2', 1.0, NULL), (1, NULL, 'default1', 'default2', 1.0, 'default2'), (2, NULL, 'default1', NULL, NULL, NULL), (3, NULL, NULL, NULL, 0.0, 'default1'), (4, NULL, 'default2', NULL, 1.0, NULL);
INSERT INTO music_festival (id, volume, music_festival, date_of_ceremony, category, result) VALUES (0, 4, 'default2', NULL, 'default1', 'default2'), (1, 4, NULL, 'default2', 'default1', NULL), (2, NULL, 'default1', 'default2', 'default2', 'default1'), (3, 4, 'default1', 'default2', 'default2', 'default2');
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT category, n AS count___ FROM (SELECT category, date_of_ceremony, COUNT(*) AS n FROM music_festival GROUP BY category, date_of_ceremony) ORDER BY category, count___ NULLS LAST;

/*
Gold Result:
('default1', 1)
('default1', 1)
('default2', 2)
*/

-- Prediction Query
SELECT Category, COUNT(*) FROM music_festival GROUP BY Category;

/*
Prediction Result:
('default1', 2)
('default2', 2)
*/