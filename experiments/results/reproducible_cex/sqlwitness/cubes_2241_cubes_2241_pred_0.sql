-- Schema DDL
CREATE TABLE "city" ("City_ID" INTEGER PRIMARY KEY, "City" TEXT, "Hanzi" TEXT, "Hanyu_Pinyin" TEXT, "Regional_Population" INTEGER, "GDP" REAL);

CREATE TABLE "match" ("Match_ID" INTEGER PRIMARY KEY, "Date" TEXT, "Venue" TEXT, "Score" TEXT, "Result" TEXT, "Competition" TEXT);

CREATE TABLE "temperature" ("City_ID" INTEGER PRIMARY KEY, "Jan" REAL, "Feb" REAL, "Mar" REAL, "Apr" REAL, "Jun" REAL, "Jul" REAL, "Aug" REAL, "Sep" REAL, "Oct" REAL, "Nov" REAL, "Dec" REAL, FOREIGN KEY ("City_ID") REFERENCES "city" ("City_ID"));

CREATE TABLE "hosting_city" ("Year" INTEGER PRIMARY KEY, "Match_ID" INTEGER, "Host_City" TEXT, FOREIGN KEY ("Match_ID") REFERENCES "match" ("Match_ID"), FOREIGN KEY ("Host_City") REFERENCES "city" ("City_ID"));

-- Loading data
PRAGMA foreign_keys = OFF;
INSERT INTO "match" (match_id, date, venue, score, result, competition) VALUES (1, 'default2', 'default2', 'default2', 'default2', 'default2'), (0, 'default1', 'Nanjing ( Jiangsu )', 'default1', '1994 FIFA World Cup qualification', NULL);
INSERT INTO city (city_id, city, hanzi, hanyu_pinyin, regional_population, gdp) VALUES (0, 'Nanjing ( Jiangsu )', 'Nanjing ( Jiangsu )', NULL, 0, 0.0), (1, 'Nanjing ( Jiangsu )', '1994 FIFA World Cup qualification', '1994 FIFA World Cup qualification', NULL, 0.0);
INSERT INTO hosting_city (year, match_id, host_city) VALUES (0, 1, NULL), (1, 1, 1);
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT DISTINCT "venue" FROM (SELECT "LHS"."city_id" AS "city_id", "LHS"."city" AS "city", "LHS"."hanzi" AS "hanzi", "LHS"."hanyu_pinyin" AS "hanyu_pinyin", "LHS"."regional_population" AS "regional_population", "LHS"."gdp" AS "gdp", "LHS"."match_id" AS "match_id", "LHS"."date" AS "date", "LHS"."venue" AS "venue", "LHS"."score" AS "score", "LHS"."result" AS "result", "LHS"."competition" AS "competition", "RHS"."year" AS "year", "RHS"."host_city" AS "host_city" FROM (SELECT "LHS"."city_id" AS "city_id", "LHS"."city" AS "city", "LHS"."hanzi" AS "hanzi", "LHS"."hanyu_pinyin" AS "hanyu_pinyin", "LHS"."regional_population" AS "regional_population", "LHS"."gdp" AS "gdp", "RHS"."match_id" AS "match_id", "RHS"."date" AS "date", "RHS"."venue" AS "venue", "RHS"."score" AS "score", "RHS"."result" AS "result", "RHS"."competition" AS "competition" FROM "city" AS "LHS" CROSS JOIN "match" AS "RHS") AS "LHS" INNER JOIN "hosting_city" AS "RHS" ON ("LHS"."match_id" = "RHS"."match_id")) WHERE ("city" = 'Nanjing ( Jiangsu )' OR "competition" = '1994 FIFA World Cup qualification') ORDER BY venue, "venue" NULLS LAST;

/*
Gold Result:
('default2',)
*/

-- Prediction Query
SELECT T3.venue FROM city AS T1 JOIN hosting_city AS T2 ON T1.city_id = T2.host_city JOIN MATCH AS T3 ON T2.match_id = T3.match_id WHERE T1.city = 'Nanjing ( Jiangsu )' AND T3.competition = '1994 FIFA World Cup qualification';

/*
Prediction Result:
*/