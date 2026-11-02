-- Schema DDL
CREATE TABLE "city" ("City_ID" INTEGER PRIMARY KEY, "City" TEXT, "Hanzi" TEXT, "Hanyu_Pinyin" TEXT, "Regional_Population" INTEGER, "GDP" REAL);

CREATE TABLE "match" ("Match_ID" INTEGER PRIMARY KEY, "Date" TEXT, "Venue" TEXT, "Score" TEXT, "Result" TEXT, "Competition" TEXT);

CREATE TABLE "temperature" ("City_ID" INTEGER PRIMARY KEY, "Jan" REAL, "Feb" REAL, "Mar" REAL, "Apr" REAL, "Jun" REAL, "Jul" REAL, "Aug" REAL, "Sep" REAL, "Oct" REAL, "Nov" REAL, "Dec" REAL, FOREIGN KEY ("City_ID") REFERENCES "city" ("City_ID"));

CREATE TABLE "hosting_city" ("Year" INTEGER PRIMARY KEY, "Match_ID" INTEGER, "Host_City" TEXT, FOREIGN KEY ("Match_ID") REFERENCES "match" ("Match_ID"), FOREIGN KEY ("Host_City") REFERENCES "city" ("City_ID"));

-- Loading data
PRAGMA foreign_keys = OFF;
INSERT INTO "city" ("city_id", "city", "hanzi", "hanyu_pinyin", "regional_population", "gdp") VALUES (10, '-635', '-635', '-635', -635, -635);
INSERT INTO "match" ("match_id", "date", "venue", "score", "result", "competition") VALUES (11, '-635', '-635', '-635', '-635', '-635');
INSERT INTO "match" ("match_id", "date", "venue", "score", "result", "competition") VALUES (17, '-635', '-635', '-635', '-635', '-635');
INSERT INTO "temperature" ("city_id", "jan", "feb", "mar", "apr", "jun", "jul", "aug", "sep", "oct", "nov", "dec") VALUES (10, -635, -635, -635, -635, -635, -635, -635, -635, -635, -635, -635);
INSERT INTO "hosting_city" ("year", "match_id", "host_city") VALUES (-635, 17, NULL);
INSERT INTO "hosting_city" ("year", "match_id", "host_city") VALUES (-636, 17, NULL);
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT host_city FROM (SELECT LHS.year AS YEAR, RHS.match_id AS match_id, RHS.host_city AS host_city FROM (SELECT MAX(YEAR) AS YEAR FROM hosting_city) AS LHS LEFT JOIN hosting_city AS RHS ON (LHS.year = RHS.year)) ORDER BY host_city;

/*
Gold Result:
(None,)
*/

-- Prediction Query
SELECT host_city FROM hosting_city ORDER BY YEAR DESC LIMIT 1;

/*
Prediction Result:
(None,)
*/