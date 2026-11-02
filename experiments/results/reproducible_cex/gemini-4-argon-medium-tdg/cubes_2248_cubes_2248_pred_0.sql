-- Schema DDL
CREATE TABLE "city" ("City_ID" INTEGER PRIMARY KEY, "City" TEXT, "Hanzi" TEXT, "Hanyu_Pinyin" TEXT, "Regional_Population" INTEGER, "GDP" REAL);

CREATE TABLE "match" ("Match_ID" INTEGER PRIMARY KEY, "Date" TEXT, "Venue" TEXT, "Score" TEXT, "Result" TEXT, "Competition" TEXT);

CREATE TABLE "temperature" ("City_ID" INTEGER PRIMARY KEY, "Jan" REAL, "Feb" REAL, "Mar" REAL, "Apr" REAL, "Jun" REAL, "Jul" REAL, "Aug" REAL, "Sep" REAL, "Oct" REAL, "Nov" REAL, "Dec" REAL, FOREIGN KEY ("City_ID") REFERENCES "city" ("City_ID"));

CREATE TABLE "hosting_city" ("Year" INTEGER PRIMARY KEY, "Match_ID" INTEGER, "Host_City" TEXT, FOREIGN KEY ("Match_ID") REFERENCES "match" ("Match_ID"), FOREIGN KEY ("Host_City") REFERENCES "city" ("City_ID"));

-- Loading data
PRAGMA foreign_keys = OFF;
-- DATASET 1
-- Tests:
-- 1. COUNT(*) vs COUNT(Competition) / COUNT(Result) / COUNT(Venue) by including NULL Competition and NULL attributes.
-- 2. Primary ordering by count___ ASC vs DESC (counts: 1, 2, 3).
-- 3. Secondary tie-breaker ordering by competition ASC vs DESC (counts tied at 2 for 'Alpha Cup', 'Beta Cup', and NULL).
-- 4. NULLS LAST vs NULLS FIRST on competition when counts are tied.
-- 5. Unintended INNER JOIN with hosting_city (only some matches are linked in hosting_city).
INSERT INTO "city" ("City_ID", "City", "Hanzi", "Hanyu_Pinyin", "Regional_Population", "GDP") VALUES (1, 'Beijing', '北京', 'Běijīng', 21540000, 3537.1);
INSERT INTO "match" ("Match_ID", "Date", "Venue", "Score", "Result", "Competition") VALUES (1, '2021-01-01', 'Stadium A', '1-0', 'Win', 'Zeta Cup');
INSERT INTO "match" ("Match_ID", "Date", "Venue", "Score", "Result", "Competition") VALUES (2, '2021-02-01', 'Stadium B', '2-1', 'Win', 'Beta Cup');
INSERT INTO "match" ("Match_ID", "Date", "Venue", "Score", "Result", "Competition") VALUES (3, '2021-02-02', NULL, NULL, NULL, 'Beta Cup');
INSERT INTO "match" ("Match_ID", "Date", "Venue", "Score", "Result", "Competition") VALUES (4, '2021-03-01', 'Stadium C', '0-0', 'Draw', 'Alpha Cup');
INSERT INTO "match" ("Match_ID", "Date", "Venue", "Score", "Result", "Competition") VALUES (5, '2021-03-02', 'Stadium C', '1-2', 'Loss', 'Alpha Cup');
INSERT INTO "match" ("Match_ID", "Date", "Venue", "Score", "Result", "Competition") VALUES (6, '2021-04-01', 'Stadium D', '3-0', 'Win', NULL);
INSERT INTO "match" ("Match_ID", "Date", "Venue", "Score", "Result", "Competition") VALUES (7, '2021-04-02', 'Stadium E', '0-1', 'Loss', NULL);
INSERT INTO "match" ("Match_ID", "Date", "Venue", "Score", "Result", "Competition") VALUES (8, '2021-05-01', 'Stadium A', '2-2', 'Draw', 'Gamma Cup');
INSERT INTO "match" ("Match_ID", "Date", "Venue", "Score", "Result", "Competition") VALUES (9, '2021-05-02', 'Stadium A', '2-2', 'Draw', 'Gamma Cup');
INSERT INTO "match" ("Match_ID", "Date", "Venue", "Score", "Result", "Competition") VALUES (10, '2021-05-03', 'Stadium A', '2-2', 'Draw', 'Gamma Cup');
INSERT INTO "hosting_city" ("Year", "Match_ID", "Host_City") VALUES (2021, 1, '1');
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT n AS count___, competition FROM (SELECT competition, COUNT(*) AS n FROM match GROUP BY competition) ORDER BY count___, competition NULLS LAST;

/*
Gold Result:
(1, 'Zeta Cup')
(2, 'Alpha Cup')
(2, 'Beta Cup')
(2, None)
(3, 'Gamma Cup')
*/

-- Prediction Query
SELECT COUNT(*), Competition FROM MATCH GROUP BY Competition;

/*
Prediction Result:
(2, None)
(2, 'Alpha Cup')
(2, 'Beta Cup')
(3, 'Gamma Cup')
(1, 'Zeta Cup')
*/