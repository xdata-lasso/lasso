-- Schema DDL
CREATE TABLE "city" ("City_ID" INTEGER PRIMARY KEY, "City" TEXT, "Hanzi" TEXT, "Hanyu_Pinyin" TEXT, "Regional_Population" INTEGER, "GDP" REAL);

CREATE TABLE "match" ("Match_ID" INTEGER PRIMARY KEY, "Date" TEXT, "Venue" TEXT, "Score" TEXT, "Result" TEXT, "Competition" TEXT);

CREATE TABLE "temperature" ("City_ID" INTEGER PRIMARY KEY, "Jan" REAL, "Feb" REAL, "Mar" REAL, "Apr" REAL, "Jun" REAL, "Jul" REAL, "Aug" REAL, "Sep" REAL, "Oct" REAL, "Nov" REAL, "Dec" REAL, FOREIGN KEY ("City_ID") REFERENCES "city" ("City_ID"));

CREATE TABLE "hosting_city" ("Year" INTEGER PRIMARY KEY, "Match_ID" INTEGER, "Host_City" TEXT, FOREIGN KEY ("Match_ID") REFERENCES "match" ("Match_ID"), FOREIGN KEY ("Host_City") REFERENCES "city" ("City_ID"));

-- Loading data
PRAGMA foreign_keys = OFF;
INSERT INTO "match" ("Match_ID", "Date", "Venue", "Score", "Result", "Competition") VALUES (1, '2020-01-01', 'Venue A', '1-0', 'Win', 'Comp A');
INSERT INTO "match" ("Match_ID", "Date", "Venue", "Score", "Result", "Competition") VALUES (2, '2020-01-02', 'Venue A', '2-0', 'Win', 'Comp A');
INSERT INTO "match" ("Match_ID", "Date", "Venue", "Score", "Result", "Competition") VALUES (3, '2020-01-03', 'Venue B', '0-1', 'Loss', 'Comp B');
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT n AS count___, competition FROM (SELECT competition, COUNT(*) AS n FROM match GROUP BY competition) ORDER BY count___, competition NULLS LAST;

/*
Gold Result:
(1, 'Comp B')
(2, 'Comp A')
*/

-- Prediction Query
SELECT COUNT(*), Competition FROM MATCH GROUP BY Competition;

/*
Prediction Result:
(2, 'Comp A')
(1, 'Comp B')
*/