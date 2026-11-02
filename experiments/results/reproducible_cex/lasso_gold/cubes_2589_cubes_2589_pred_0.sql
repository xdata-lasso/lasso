-- Schema DDL
CREATE TABLE "artist" ("Artist_ID" INTEGER PRIMARY KEY, "Artist" TEXT, "Age" INTEGER, "Famous_Title" TEXT, "Famous_Release_date" TEXT);

CREATE TABLE "volume" ("Volume_ID" INTEGER PRIMARY KEY, "Artist_ID" INTEGER, "Volume_Issue" TEXT, "Issue_Date" TEXT, "Weeks_on_Top" REAL, "Song" TEXT, FOREIGN KEY ("Artist_ID") REFERENCES "artist" ("Artist_ID"));

CREATE TABLE "music_festival" ("ID" INTEGER PRIMARY KEY, "Volume" INTEGER, "Music_Festival" TEXT, "Date_of_ceremony" TEXT, "Category" TEXT, "Result" TEXT, FOREIGN KEY ("Volume") REFERENCES "volume" ("Volume_ID"));

-- Loading data
PRAGMA foreign_keys = OFF;
INSERT INTO "artist" ("artist_id", "artist", "age", "famous_title", "famous_release_date") VALUES (1001, 'purpose', 1002, 'Clinical research associate', 'ago');
INSERT INTO "volume" ("volume_id", "artist_id", "volume_issue", "issue_date", "weeks_on_top", "song") VALUES (1003, 1001, 'site', 'election', 1006.5, 'chair');
INSERT INTO "volume" ("volume_id", "artist_id", "volume_issue", "issue_date", "weeks_on_top", "song") VALUES (1004, 1001, 'face', 'dog', 1017.5, 'since');
INSERT INTO "music_festival" ("id", "volume", "music_festival", "date_of_ceremony", "category", "result") VALUES (1008, 1003, 'blue', 'sit', 'offer', 'begin');
INSERT INTO "music_festival" ("id", "volume", "music_festival", "date_of_ceremony", "category", "result") VALUES (1009, 1003, 'require', 'wait', 'offer', 'performance');
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT DISTINCT category FROM (SELECT category, RESULT, COUNT(*) AS n FROM music_festival GROUP BY category, RESULT) WHERE (n > 1) ORDER BY category;

/*
Gold Result:
*/

-- Prediction Query
SELECT Category FROM music_festival GROUP BY Category HAVING COUNT(*) > 1;

/*
Prediction Result:
('offer',)
*/