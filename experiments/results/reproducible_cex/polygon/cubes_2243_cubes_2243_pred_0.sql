-- Schema DDL
CREATE TABLE "city" ("City_ID" INTEGER PRIMARY KEY, "City" TEXT, "Hanzi" TEXT, "Hanyu_Pinyin" TEXT, "Regional_Population" INTEGER, "GDP" REAL);

CREATE TABLE "match" ("Match_ID" INTEGER PRIMARY KEY, "Date" TEXT, "Venue" TEXT, "Score" TEXT, "Result" TEXT, "Competition" TEXT);

CREATE TABLE "temperature" ("City_ID" INTEGER PRIMARY KEY, "Jan" REAL, "Feb" REAL, "Mar" REAL, "Apr" REAL, "Jun" REAL, "Jul" REAL, "Aug" REAL, "Sep" REAL, "Oct" REAL, "Nov" REAL, "Dec" REAL, FOREIGN KEY ("City_ID") REFERENCES "city" ("City_ID"));

CREATE TABLE "hosting_city" ("Year" INTEGER PRIMARY KEY, "Match_ID" INTEGER, "Host_City" TEXT, FOREIGN KEY ("Match_ID") REFERENCES "match" ("Match_ID"), FOREIGN KEY ("Host_City") REFERENCES "city" ("City_ID"));

-- Loading data
PRAGMA foreign_keys = OFF;
INSERT INTO "city" ("city_id", "city", "hanzi", "hanyu_pinyin", "regional_population", "gdp") VALUES (9, '20', '14', '15', 10000001, 16);
INSERT INTO "city" ("city_id", "city", "hanzi", "hanyu_pinyin", "regional_population", "gdp") VALUES (8, '20', NULL, '18', 10000000, NULL);
INSERT INTO "match" ("match_id", "date", "venue", "score", "result", "competition") VALUES (11, '20', '20', '20', '20', '20');
INSERT INTO "match" ("match_id", "date", "venue", "score", "result", "competition") VALUES (10, '20', '20', '20', '20', '20');
INSERT INTO "hosting_city" ("year", "match_id", "host_city") VALUES (13, 10, 8);
INSERT INTO "hosting_city" ("year", "match_id", "host_city") VALUES (12, 10, 9);
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT city FROM city WHERE (regional_population >= 10000000) ORDER BY city, city.city_id NULLS LAST;

/*
Gold Result:
('20',)
('20',)
*/

-- Prediction Query
SELECT city FROM city WHERE regional_population > 10000000;

/*
Prediction Result:
('20',)
*/