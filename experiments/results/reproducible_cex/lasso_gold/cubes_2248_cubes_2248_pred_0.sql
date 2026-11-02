-- Schema DDL
CREATE TABLE "city" ("City_ID" INTEGER PRIMARY KEY, "City" TEXT, "Hanzi" TEXT, "Hanyu_Pinyin" TEXT, "Regional_Population" INTEGER, "GDP" REAL);

CREATE TABLE "match" ("Match_ID" INTEGER PRIMARY KEY, "Date" TEXT, "Venue" TEXT, "Score" TEXT, "Result" TEXT, "Competition" TEXT);

CREATE TABLE "temperature" ("City_ID" INTEGER PRIMARY KEY, "Jan" REAL, "Feb" REAL, "Mar" REAL, "Apr" REAL, "Jun" REAL, "Jul" REAL, "Aug" REAL, "Sep" REAL, "Oct" REAL, "Nov" REAL, "Dec" REAL, FOREIGN KEY ("City_ID") REFERENCES "city" ("City_ID"));

CREATE TABLE "hosting_city" ("Year" INTEGER PRIMARY KEY, "Match_ID" INTEGER, "Host_City" TEXT, FOREIGN KEY ("Match_ID") REFERENCES "match" ("Match_ID"), FOREIGN KEY ("Host_City") REFERENCES "city" ("City_ID"));

-- Loading data
PRAGMA foreign_keys = OFF;
INSERT INTO "match" ("match_id", "date", "venue", "score", "result", "competition") VALUES (1002, 'election', 'dog', 'chair', 'since', 'blue');
INSERT INTO "match" ("match_id", "date", "venue", "score", "result", "competition") VALUES (1003, NULL, 'sit', 'wait', 'offer', 'begin');
INSERT INTO "match" ("match_id", "date", "venue", "score", "result", "competition") VALUES (1004, 'performance', 'knowledge', 'almost', 'all', 'begin');
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT n AS count___, competition FROM (SELECT competition, COUNT(*) AS n FROM match GROUP BY competition) ORDER BY count___, competition NULLS LAST;

/*
Gold Result:
(1, 'blue')
(2, 'begin')
*/

-- Prediction Query
SELECT COUNT(*), Competition FROM MATCH GROUP BY Competition;

/*
Prediction Result:
(2, 'begin')
(1, 'blue')
*/