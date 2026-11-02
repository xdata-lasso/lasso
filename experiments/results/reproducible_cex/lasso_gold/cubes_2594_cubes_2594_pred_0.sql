-- Schema DDL
CREATE TABLE "artist" ("Artist_ID" INTEGER PRIMARY KEY, "Artist" TEXT, "Age" INTEGER, "Famous_Title" TEXT, "Famous_Release_date" TEXT);

CREATE TABLE "volume" ("Volume_ID" INTEGER PRIMARY KEY, "Artist_ID" INTEGER, "Volume_Issue" TEXT, "Issue_Date" TEXT, "Weeks_on_Top" REAL, "Song" TEXT, FOREIGN KEY ("Artist_ID") REFERENCES "artist" ("Artist_ID"));

CREATE TABLE "music_festival" ("ID" INTEGER PRIMARY KEY, "Volume" INTEGER, "Music_Festival" TEXT, "Date_of_ceremony" TEXT, "Category" TEXT, "Result" TEXT, FOREIGN KEY ("Volume") REFERENCES "volume" ("Volume_ID"));

-- Loading data
PRAGMA foreign_keys = OFF;
INSERT INTO "artist" ("artist_id", "artist", "age", "famous_title", "famous_release_date") VALUES (1001, 'purpose', 1002, 'Clinical research associate', 'ago');
INSERT INTO "volume" ("volume_id", "artist_id", "volume_issue", "issue_date", "weeks_on_top", "song") VALUES (1, 1001, 'site', 'face', 1003.5, 'election');
INSERT INTO "music_festival" ("id", "volume", "music_festival", "date_of_ceremony", "category", "result") VALUES (1004, 1, 'dog', 'chair', 'since', 'blue');
INSERT INTO "music_festival" ("id", "volume", "music_festival", "date_of_ceremony", "category", "result") VALUES (1005, 1, 'require', 'sit', 'wait', 'offer');
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT RESULT FROM (SELECT RESULT, volume, volume AS n, result_other FROM (SELECT LHS.result AS RESULT, LHS.volume AS volume, LHS.n AS n, RHS.result AS result_other FROM (SELECT RESULT, volume, COUNT(*) AS n FROM music_festival GROUP BY RESULT, volume) AS LHS INNER JOIN (SELECT RESULT, volume, COUNT(*) AS n FROM music_festival GROUP BY RESULT, volume) AS RHS ON (LHS.volume = RHS.n AND LHS.n = RHS.volume))) ORDER BY RESULT;

/*
Gold Result:
('blue',)
('blue',)
('offer',)
('offer',)
*/

-- Prediction Query
SELECT RESULT FROM music_festival GROUP BY RESULT ORDER BY COUNT(*) DESC, RESULT NULLS LAST LIMIT 1;

/*
Prediction Result:
('blue',)
*/