-- Schema DDL
CREATE TABLE "artist" ("Artist_ID" INTEGER PRIMARY KEY, "Artist" TEXT, "Age" INTEGER, "Famous_Title" TEXT, "Famous_Release_date" TEXT);

CREATE TABLE "volume" ("Volume_ID" INTEGER PRIMARY KEY, "Artist_ID" INTEGER, "Volume_Issue" TEXT, "Issue_Date" TEXT, "Weeks_on_Top" REAL, "Song" TEXT, FOREIGN KEY ("Artist_ID") REFERENCES "artist" ("Artist_ID"));

CREATE TABLE "music_festival" ("ID" INTEGER PRIMARY KEY, "Volume" INTEGER, "Music_Festival" TEXT, "Date_of_ceremony" TEXT, "Category" TEXT, "Result" TEXT, FOREIGN KEY ("Volume") REFERENCES "volume" ("Volume_ID"));

-- Loading data
PRAGMA foreign_keys = OFF;
INSERT INTO artist (artist_id, artist, age, famous_title, famous_release_date) VALUES (0, NULL, 0, 'default2', 'default2'), (1, 'default1', 0, 'default1', 'default1'), (2, NULL, 0, NULL, 'default2'), (3, 'default1', 1, 'default2', 'default1'), (4, 'default1', 1, 'default2', NULL), (5, 'default1', 1, 'default1', NULL);
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT DISTINCT famous_release_date FROM artist ORDER BY famous_release_date;

/*
Gold Result:
(None,)
('default1',)
('default2',)
*/

-- Prediction Query
SELECT DISTINCT (Famous_Release_date) FROM artist;

/*
Prediction Result:
('default2',)
('default1',)
(None,)
*/