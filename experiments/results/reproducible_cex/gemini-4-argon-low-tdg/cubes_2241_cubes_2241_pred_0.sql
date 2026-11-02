-- Schema DDL
CREATE TABLE "city" ("City_ID" INTEGER PRIMARY KEY, "City" TEXT, "Hanzi" TEXT, "Hanyu_Pinyin" TEXT, "Regional_Population" INTEGER, "GDP" REAL);

CREATE TABLE "match" ("Match_ID" INTEGER PRIMARY KEY, "Date" TEXT, "Venue" TEXT, "Score" TEXT, "Result" TEXT, "Competition" TEXT);

CREATE TABLE "temperature" ("City_ID" INTEGER PRIMARY KEY, "Jan" REAL, "Feb" REAL, "Mar" REAL, "Apr" REAL, "Jun" REAL, "Jul" REAL, "Aug" REAL, "Sep" REAL, "Oct" REAL, "Nov" REAL, "Dec" REAL, FOREIGN KEY ("City_ID") REFERENCES "city" ("City_ID"));

CREATE TABLE "hosting_city" ("Year" INTEGER PRIMARY KEY, "Match_ID" INTEGER, "Host_City" TEXT, FOREIGN KEY ("Match_ID") REFERENCES "match" ("Match_ID"), FOREIGN KEY ("Host_City") REFERENCES "city" ("City_ID"));

-- Loading data
PRAGMA foreign_keys = OFF;
-- DATASET 1
-- Tests the CROSS JOIN behavior between city and match vs an INNER JOIN on Host_City = City_ID.
-- Also tests DISTINCT elimination, ORDER BY sorting, and NULLS LAST behavior.
INSERT INTO "city" ("City_ID", "City", "Hanzi", "Hanyu_Pinyin", "Regional_Population", "GDP") VALUES (1, 'Nanjing ( Jiangsu )', '南京', 'Nánjīng', 8000000, 1000.5);
INSERT INTO "city" ("City_ID", "City", "Hanzi", "Hanyu_Pinyin", "Regional_Population", "GDP") VALUES (2, 'Beijing', '北京', 'Běijīng', 20000000, 3000.0);
INSERT INTO "match" ("Match_ID", "Date", "Venue", "Score", "Result", "Competition") VALUES (101, '1993-05-01', 'Zeta Stadium', '1-0', 'Win', 'Friendly');
INSERT INTO "match" ("Match_ID", "Date", "Venue", "Score", "Result", "Competition") VALUES (102, '1993-06-01', 'Alpha Arena', '2-1', 'Win', '1994 FIFA World Cup qualification');
INSERT INTO "match" ("Match_ID", "Date", "Venue", "Score", "Result", "Competition") VALUES (103, '1993-07-01', NULL, '0-0', 'Draw', 'Friendly');
INSERT INTO "match" ("Match_ID", "Date", "Venue", "Score", "Result", "Competition") VALUES (104, '1993-08-01', 'Unreferenced Ground', '3-0', 'Win', '1994 FIFA World Cup qualification');
INSERT INTO "hosting_city" ("Year", "Match_ID", "Host_City") VALUES (1990, 101, 2);
INSERT INTO "hosting_city" ("Year", "Match_ID", "Host_City") VALUES (1991, 101, 2);
INSERT INTO "hosting_city" ("Year", "Match_ID", "Host_City") VALUES (1992, 102, 2);
INSERT INTO "hosting_city" ("Year", "Match_ID", "Host_City") VALUES (1993, 103, 1);
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT DISTINCT "venue" FROM (SELECT "LHS"."city_id" AS "city_id", "LHS"."city" AS "city", "LHS"."hanzi" AS "hanzi", "LHS"."hanyu_pinyin" AS "hanyu_pinyin", "LHS"."regional_population" AS "regional_population", "LHS"."gdp" AS "gdp", "LHS"."match_id" AS "match_id", "LHS"."date" AS "date", "LHS"."venue" AS "venue", "LHS"."score" AS "score", "LHS"."result" AS "result", "LHS"."competition" AS "competition", "RHS"."year" AS "year", "RHS"."host_city" AS "host_city" FROM (SELECT "LHS"."city_id" AS "city_id", "LHS"."city" AS "city", "LHS"."hanzi" AS "hanzi", "LHS"."hanyu_pinyin" AS "hanyu_pinyin", "LHS"."regional_population" AS "regional_population", "LHS"."gdp" AS "gdp", "RHS"."match_id" AS "match_id", "RHS"."date" AS "date", "RHS"."venue" AS "venue", "RHS"."score" AS "score", "RHS"."result" AS "result", "RHS"."competition" AS "competition" FROM "city" AS "LHS" CROSS JOIN "match" AS "RHS") AS "LHS" INNER JOIN "hosting_city" AS "RHS" ON ("LHS"."match_id" = "RHS"."match_id")) WHERE ("city" = 'Nanjing ( Jiangsu )' OR "competition" = '1994 FIFA World Cup qualification') ORDER BY venue, "venue" NULLS LAST;

/*
Gold Result:
(None,)
('Alpha Arena',)
('Zeta Stadium',)
*/

-- Prediction Query
SELECT T3.venue FROM city AS T1 JOIN hosting_city AS T2 ON T1.city_id = T2.host_city JOIN MATCH AS T3 ON T2.match_id = T3.match_id WHERE T1.city = 'Nanjing ( Jiangsu )' AND T3.competition = '1994 FIFA World Cup qualification';

/*
Prediction Result:
*/