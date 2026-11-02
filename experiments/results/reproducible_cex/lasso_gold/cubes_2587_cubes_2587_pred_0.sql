-- Schema DDL
CREATE TABLE "artist" ("Artist_ID" INTEGER PRIMARY KEY, "Artist" TEXT, "Age" INTEGER, "Famous_Title" TEXT, "Famous_Release_date" TEXT);

CREATE TABLE "volume" ("Volume_ID" INTEGER PRIMARY KEY, "Artist_ID" INTEGER, "Volume_Issue" TEXT, "Issue_Date" TEXT, "Weeks_on_Top" REAL, "Song" TEXT, FOREIGN KEY ("Artist_ID") REFERENCES "artist" ("Artist_ID"));

CREATE TABLE "music_festival" ("ID" INTEGER PRIMARY KEY, "Volume" INTEGER, "Music_Festival" TEXT, "Date_of_ceremony" TEXT, "Category" TEXT, "Result" TEXT, FOREIGN KEY ("Volume") REFERENCES "volume" ("Volume_ID"));

-- Loading data
PRAGMA foreign_keys = OFF;
INSERT INTO "artist" ("artist_id", "artist", "age", "famous_title", "famous_release_date") VALUES (1038, 'song', 1033, 'Pharmacist, hospital', 'show');
INSERT INTO "artist" ("artist_id", "artist", "age", "famous_title", "famous_release_date") VALUES (1037, 'sure', 1039.0, 'Librarian, public', 'source');
INSERT INTO "artist" ("artist_id", "artist", "age", "famous_title", "famous_release_date") VALUES (1036, 'collection', 1046.0, 'Health physicist', 'great');
INSERT INTO "artist" ("artist_id", "artist", "age", "famous_title", "famous_release_date") VALUES (1031, 'save', 1053.0, 'Designer, furniture', 'blue');
INSERT INTO "artist" ("artist_id", "artist", "age", "famous_title", "famous_release_date") VALUES (1039, 'best', 1032, 'Local government officer', 'dinner');
INSERT INTO "artist" ("artist_id", "artist", "age", "famous_title", "famous_release_date") VALUES (1030, 'husband', 1047.0, 'Trade mark attorney', 'machine');
INSERT INTO "artist" ("artist_id", "artist", "age", "famous_title", "famous_release_date") VALUES (1029, 'bill', 1054.0, 'Geneticist, molecular', 'not');
INSERT INTO "artist" ("artist_id", "artist", "age", "famous_title", "famous_release_date") VALUES (1028, 'her', 1061.0, 'Armed forces logistics/support/administrative officer', 'capital');
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT famous_release_date FROM (SELECT * FROM (SELECT * FROM artist ORDER BY artist_id DESC) LIMIT 1);

/*
Gold Result:
('dinner',)
*/

-- Prediction Query
SELECT Famous_Release_date FROM artist ORDER BY Age DESC, artist.artist_id NULLS LAST LIMIT 1;

/*
Prediction Result:
('capital',)
*/