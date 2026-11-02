-- Schema DDL
CREATE TABLE "artist" ("Artist_ID" INTEGER PRIMARY KEY, "Artist" TEXT, "Age" INTEGER, "Famous_Title" TEXT, "Famous_Release_date" TEXT);

CREATE TABLE "volume" ("Volume_ID" INTEGER PRIMARY KEY, "Artist_ID" INTEGER, "Volume_Issue" TEXT, "Issue_Date" TEXT, "Weeks_on_Top" REAL, "Song" TEXT, FOREIGN KEY ("Artist_ID") REFERENCES "artist" ("Artist_ID"));

CREATE TABLE "music_festival" ("ID" INTEGER PRIMARY KEY, "Volume" INTEGER, "Music_Festival" TEXT, "Date_of_ceremony" TEXT, "Category" TEXT, "Result" TEXT, FOREIGN KEY ("Volume") REFERENCES "volume" ("Volume_ID"));

-- Loading data
PRAGMA foreign_keys = OFF;
INSERT INTO "artist" ("artist_id", "artist", "age", "famous_title", "famous_release_date") VALUES (1001, 'purpose', 24, 'Haematologist', 'chair');
INSERT INTO "artist" ("artist_id", "artist", "age", "famous_title", "famous_release_date") VALUES (1002, 'brother', 24, 'Financial risk analyst', 'since');
INSERT INTO "artist" ("artist_id", "artist", "age", "famous_title", "famous_release_date") VALUES (1003, 'ago', 24, 'Environmental health practitioner', 'blue');
INSERT INTO "volume" ("volume_id", "artist_id", "volume_issue", "issue_date", "weeks_on_top", "song") VALUES (1004, 1001, 'require', 'offer', 1007.5, 'knowledge');
INSERT INTO "volume" ("volume_id", "artist_id", "volume_issue", "issue_date", "weeks_on_top", "song") VALUES (1005, 1001, 'sit', 'begin', 1018.5, 'almost');
INSERT INTO "volume" ("volume_id", "artist_id", "volume_issue", "issue_date", "weeks_on_top", "song") VALUES (1006, 1001, 'wait', 'performance', 1029.5, 'all');
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT weeks_on_top AS avg_t2_weeks_on_top_ FROM (SELECT LHS.age AS age, LHS.artist_id AS artist_id, LHS.meanage AS meanage, RHS.volume_id AS volume_id, RHS.volume_issue AS volume_issue, RHS.issue_date AS issue_date, RHS.weeks_on_top AS weeks_on_top, RHS.song AS song FROM (SELECT * FROM (SELECT age, artist_id, AVG(age) AS meanage FROM artist GROUP BY age, artist_id) WHERE (age < 25 AND meanage >= age)) AS LHS INNER JOIN volume AS RHS ON (LHS.artist_id = RHS.artist_id)) ORDER BY avg_t2_weeks_on_top_;

/*
Gold Result:
(1007.5,)
(1018.5,)
(1029.5,)
*/

-- Prediction Query
SELECT AVG(T2.Weeks_on_Top) FROM artist AS T1 JOIN volume AS T2 ON T1.Artist_ID = T2.Artist_ID WHERE T1.age <= 25;

/*
Prediction Result:
(1018.5,)
*/