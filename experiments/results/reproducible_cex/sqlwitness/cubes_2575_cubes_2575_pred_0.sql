-- Schema DDL
CREATE TABLE "artist" ("Artist_ID" INTEGER PRIMARY KEY, "Artist" TEXT, "Age" INTEGER, "Famous_Title" TEXT, "Famous_Release_date" TEXT);

CREATE TABLE "volume" ("Volume_ID" INTEGER PRIMARY KEY, "Artist_ID" INTEGER, "Volume_Issue" TEXT, "Issue_Date" TEXT, "Weeks_on_Top" REAL, "Song" TEXT, FOREIGN KEY ("Artist_ID") REFERENCES "artist" ("Artist_ID"));

CREATE TABLE "music_festival" ("ID" INTEGER PRIMARY KEY, "Volume" INTEGER, "Music_Festival" TEXT, "Date_of_ceremony" TEXT, "Category" TEXT, "Result" TEXT, FOREIGN KEY ("Volume") REFERENCES "volume" ("Volume_ID"));

-- Loading data
PRAGMA foreign_keys = OFF;
INSERT INTO artist (artist_id, artist, age, famous_title, famous_release_date) VALUES (2, NULL, NULL, 'default2', 'default1'), (0, 'default1', NULL, 'default1', NULL), (1, 'default1', 0, 'default2', 'default2');
INSERT INTO volume (volume_id, artist_id, volume_issue, issue_date, weeks_on_top, song) VALUES (0, 2, NULL, NULL, 0.0, 'default2'), (1, 2, 'default1', 'default1', NULL, 'default2'), (2, NULL, 'default2', 'default2', NULL, 'default1');
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT song FROM volume WHERE (weeks_on_top <> 1.0) ORDER BY song, volume.volume_id NULLS LAST;

/*
Gold Result:
('default2',)
*/

-- Prediction Query
SELECT Song FROM volume WHERE Weeks_on_Top > 1;

/*
Prediction Result:
*/