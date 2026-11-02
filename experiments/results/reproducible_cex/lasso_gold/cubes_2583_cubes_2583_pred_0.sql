-- Schema DDL
CREATE TABLE "artist" ("Artist_ID" INTEGER PRIMARY KEY, "Artist" TEXT, "Age" INTEGER, "Famous_Title" TEXT, "Famous_Release_date" TEXT);

CREATE TABLE "volume" ("Volume_ID" INTEGER PRIMARY KEY, "Artist_ID" INTEGER, "Volume_Issue" TEXT, "Issue_Date" TEXT, "Weeks_on_Top" REAL, "Song" TEXT, FOREIGN KEY ("Artist_ID") REFERENCES "artist" ("Artist_ID"));

CREATE TABLE "music_festival" ("ID" INTEGER PRIMARY KEY, "Volume" INTEGER, "Music_Festival" TEXT, "Date_of_ceremony" TEXT, "Category" TEXT, "Result" TEXT, FOREIGN KEY ("Volume") REFERENCES "volume" ("Volume_ID"));

-- Loading data
PRAGMA foreign_keys = OFF;
INSERT INTO "artist" ("artist_id", "artist", "age", "famous_title", "famous_release_date") VALUES (1019, 'discussion', 1020, 'Sports administrator', 'kind');
INSERT INTO "artist" ("artist_id", "artist", "age", "famous_title", "famous_release_date") VALUES (1021, 'sense', 1021, 'Health physicist', 'perform');
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT famous_title FROM (SELECT * FROM artist AS LHS WHERE NOT EXISTS(SELECT 1 FROM volume AS RHS WHERE (LHS.artist_id = RHS.artist_id))) ORDER BY famous_title;

/*
Gold Result:
('Health physicist',)
('Sports administrator',)
*/

-- Prediction Query
SELECT Famous_Title FROM artist WHERE NOT Artist_ID IN (SELECT Artist_ID FROM volume);

/*
Prediction Result:
('Sports administrator',)
('Health physicist',)
*/