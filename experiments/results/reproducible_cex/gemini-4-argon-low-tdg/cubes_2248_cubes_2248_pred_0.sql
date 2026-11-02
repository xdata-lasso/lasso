-- Schema DDL
CREATE TABLE "city" ("City_ID" INTEGER PRIMARY KEY, "City" TEXT, "Hanzi" TEXT, "Hanyu_Pinyin" TEXT, "Regional_Population" INTEGER, "GDP" REAL);

CREATE TABLE "match" ("Match_ID" INTEGER PRIMARY KEY, "Date" TEXT, "Venue" TEXT, "Score" TEXT, "Result" TEXT, "Competition" TEXT);

CREATE TABLE "temperature" ("City_ID" INTEGER PRIMARY KEY, "Jan" REAL, "Feb" REAL, "Mar" REAL, "Apr" REAL, "Jun" REAL, "Jul" REAL, "Aug" REAL, "Sep" REAL, "Oct" REAL, "Nov" REAL, "Dec" REAL, FOREIGN KEY ("City_ID") REFERENCES "city" ("City_ID"));

CREATE TABLE "hosting_city" ("Year" INTEGER PRIMARY KEY, "Match_ID" INTEGER, "Host_City" TEXT, FOREIGN KEY ("Match_ID") REFERENCES "match" ("Match_ID"), FOREIGN KEY ("Host_City") REFERENCES "city" ("City_ID"));

-- Loading data
PRAGMA foreign_keys = OFF;
-- DATASET 1
-- Tests basic GROUP BY, COUNT(*) vs COUNT(Competition), NULL handling, and tie-breaking ORDER BY with NULLS LAST.
-- Also tests unintended INNER JOINs with hosting_city by only linking a subset of matches.
INSERT INTO "city" ("City_ID", "City", "Hanzi", "Hanyu_Pinyin", "Regional_Population", "GDP") VALUES (1, 'Beijing', '北京', 'Běijīng', 21540000, 3537.0);
INSERT INTO "match" ("Match_ID", "Date", "Venue", "Score", "Result", "Competition") VALUES (1, '2021-01-01', 'Stadium A', '1-0', 'Win', 'Cup');
INSERT INTO "match" ("Match_ID", "Date", "Venue", "Score", "Result", "Competition") VALUES (2, '2021-01-02', 'Stadium B', '2-2', 'Draw', 'League');
INSERT INTO "match" ("Match_ID", "Date", "Venue", "Score", "Result", "Competition") VALUES (3, '2021-01-03', 'Stadium A', '0-1', 'Loss', 'League');
INSERT INTO "match" ("Match_ID", "Date", "Venue", "Score", "Result", "Competition") VALUES (4, '2021-01-04', 'Stadium C', '3-1', 'Win', 'Friendly');
INSERT INTO "match" ("Match_ID", "Date", "Venue", "Score", "Result", "Competition") VALUES (5, '2021-01-05', 'Stadium B', '0-0', 'Draw', 'Friendly');
INSERT INTO "match" ("Match_ID", "Date", "Venue", "Score", "Result", "Competition") VALUES (6, '2021-01-06', 'Stadium C', '1-2', 'Loss', NULL);
INSERT INTO "match" ("Match_ID", "Date", "Venue", "Score", "Result", "Competition") VALUES (7, '2021-01-07', 'Stadium A', '2-0', 'Win', NULL);
INSERT INTO "hosting_city" ("Year", "Match_ID", "Host_City") VALUES (2021, 1, '1');
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT n AS count___, competition FROM (SELECT competition, COUNT(*) AS n FROM match GROUP BY competition) ORDER BY count___, competition NULLS LAST;

/*
Gold Result:
(1, 'Cup')
(2, 'Friendly')
(2, 'League')
(2, None)
*/

-- Prediction Query
SELECT COUNT(*), Competition FROM MATCH GROUP BY Competition;

/*
Prediction Result:
(2, None)
(1, 'Cup')
(2, 'Friendly')
(2, 'League')
*/