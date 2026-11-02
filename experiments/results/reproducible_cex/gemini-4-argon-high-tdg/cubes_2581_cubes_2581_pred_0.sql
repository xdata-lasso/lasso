-- Schema DDL
CREATE TABLE "artist" ("Artist_ID" INTEGER PRIMARY KEY, "Artist" TEXT, "Age" INTEGER, "Famous_Title" TEXT, "Famous_Release_date" TEXT);

CREATE TABLE "volume" ("Volume_ID" INTEGER PRIMARY KEY, "Artist_ID" INTEGER, "Volume_Issue" TEXT, "Issue_Date" TEXT, "Weeks_on_Top" REAL, "Song" TEXT, FOREIGN KEY ("Artist_ID") REFERENCES "artist" ("Artist_ID"));

CREATE TABLE "music_festival" ("ID" INTEGER PRIMARY KEY, "Volume" INTEGER, "Music_Festival" TEXT, "Date_of_ceremony" TEXT, "Category" TEXT, "Result" TEXT, FOREIGN KEY ("Volume") REFERENCES "volume" ("Volume_ID"));

-- Loading data
PRAGMA foreign_keys = OFF;
-- DATASET 1
INSERT INTO "artist" ("Artist_ID", "Artist", "Age", "Famous_Title", "Famous_Release_date") VALUES (1, 'Triumfall', 30, 'Zeta', '2020-01-01');
INSERT INTO "artist" ("Artist_ID", "Artist", "Age", "Famous_Title", "Famous_Release_date") VALUES (2, 'Triumfall', 25, 'Alpha', '2022-05-10');
INSERT INTO "artist" ("Artist_ID", "Artist", "Age", "Famous_Title", "Famous_Release_date") VALUES (3, 'OtherBand', 40, 'Beta', '2018-03-15');
INSERT INTO "volume" ("Volume_ID", "Artist_ID", "Volume_Issue", "Issue_Date", "Weeks_on_Top", "Song") VALUES (10, 3, 'Vol 1', '2018-04-01', 5.0, 'Beta Song');
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT "famous_title" FROM "artist" WHERE ("artist" = 'Triumfall') ORDER BY famous_title, artist.artist_id NULLS LAST;

/*
Gold Result:
('Alpha',)
('Zeta',)
*/

-- Prediction Query
SELECT Famous_Title FROM artist WHERE Artist = 'Triumfall';

/*
Prediction Result:
('Zeta',)
('Alpha',)
*/