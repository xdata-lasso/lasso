-- Schema DDL
CREATE TABLE "artist" ("Artist_ID" INTEGER PRIMARY KEY, "Artist" TEXT, "Age" INTEGER, "Famous_Title" TEXT, "Famous_Release_date" TEXT);

CREATE TABLE "volume" ("Volume_ID" INTEGER PRIMARY KEY, "Artist_ID" INTEGER, "Volume_Issue" TEXT, "Issue_Date" TEXT, "Weeks_on_Top" REAL, "Song" TEXT, FOREIGN KEY ("Artist_ID") REFERENCES "artist" ("Artist_ID"));

CREATE TABLE "music_festival" ("ID" INTEGER PRIMARY KEY, "Volume" INTEGER, "Music_Festival" TEXT, "Date_of_ceremony" TEXT, "Category" TEXT, "Result" TEXT, FOREIGN KEY ("Volume") REFERENCES "volume" ("Volume_ID"));

-- Loading data
PRAGMA foreign_keys = OFF;
-- DATASET 2
-- Tests ORDER BY famous_title ASC vs DESC, and DISTINCT vs ALL (duplicate famous_title values for 'Triumfall').
-- Inserted out of alphabetical order with respect to Artist_ID to catch missing ORDER BY or ORDER BY Artist_ID only.
INSERT INTO "artist" ("Artist_ID", "Artist", "Age", "Famous_Title", "Famous_Release_date") VALUES (1, 'Triumfall', 25, 'Zebra Symphony', '2018-01-01');
INSERT INTO "artist" ("Artist_ID", "Artist", "Age", "Famous_Title", "Famous_Release_date") VALUES (2, 'Triumfall', 30, 'Alpha Sonata', '2019-01-01');
INSERT INTO "artist" ("Artist_ID", "Artist", "Age", "Famous_Title", "Famous_Release_date") VALUES (3, 'Triumfall', 35, 'Alpha Sonata', '2020-01-01');
INSERT INTO "artist" ("Artist_ID", "Artist", "Age", "Famous_Title", "Famous_Release_date") VALUES (4, 'Triumfall', 40, 'Beta Nocturne', '2021-01-01');
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT "famous_title" FROM "artist" WHERE ("artist" = 'Triumfall') ORDER BY famous_title, artist.artist_id NULLS LAST;

/*
Gold Result:
('Alpha Sonata',)
('Alpha Sonata',)
('Beta Nocturne',)
('Zebra Symphony',)
*/

-- Prediction Query
SELECT Famous_Title FROM artist WHERE Artist = 'Triumfall';

/*
Prediction Result:
('Zebra Symphony',)
('Alpha Sonata',)
('Alpha Sonata',)
('Beta Nocturne',)
*/