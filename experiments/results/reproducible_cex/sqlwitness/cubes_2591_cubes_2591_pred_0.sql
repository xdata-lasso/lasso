-- Schema DDL
CREATE TABLE "artist" ("Artist_ID" INTEGER PRIMARY KEY, "Artist" TEXT, "Age" INTEGER, "Famous_Title" TEXT, "Famous_Release_date" TEXT);

CREATE TABLE "volume" ("Volume_ID" INTEGER PRIMARY KEY, "Artist_ID" INTEGER, "Volume_Issue" TEXT, "Issue_Date" TEXT, "Weeks_on_Top" REAL, "Song" TEXT, FOREIGN KEY ("Artist_ID") REFERENCES "artist" ("Artist_ID"));

CREATE TABLE "music_festival" ("ID" INTEGER PRIMARY KEY, "Volume" INTEGER, "Music_Festival" TEXT, "Date_of_ceremony" TEXT, "Category" TEXT, "Result" TEXT, FOREIGN KEY ("Volume") REFERENCES "volume" ("Volume_ID"));

-- Loading data
PRAGMA foreign_keys = OFF;
INSERT INTO artist (artist_id, artist, age, famous_title, famous_release_date) VALUES (0, 'default2', 0, 'default1', NULL), (1, 'default1', NULL, NULL, 'default1'), (2, 'default1', 1, 'default2', NULL), (3, 'default2', NULL, NULL, NULL);
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT age FROM artist ORDER BY age, artist.artist_id NULLS LAST;

/*
Gold Result:
(None,)
(None,)
(0,)
(1,)
*/

-- Prediction Query
SELECT Age FROM artist;

/*
Prediction Result:
(0,)
(None,)
(1,)
(None,)
*/