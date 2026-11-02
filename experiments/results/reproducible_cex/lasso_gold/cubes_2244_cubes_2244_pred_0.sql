-- Schema DDL
CREATE TABLE "city" ("City_ID" INTEGER PRIMARY KEY, "City" TEXT, "Hanzi" TEXT, "Hanyu_Pinyin" TEXT, "Regional_Population" INTEGER, "GDP" REAL);

CREATE TABLE "match" ("Match_ID" INTEGER PRIMARY KEY, "Date" TEXT, "Venue" TEXT, "Score" TEXT, "Result" TEXT, "Competition" TEXT);

CREATE TABLE "temperature" ("City_ID" INTEGER PRIMARY KEY, "Jan" REAL, "Feb" REAL, "Mar" REAL, "Apr" REAL, "Jun" REAL, "Jul" REAL, "Aug" REAL, "Sep" REAL, "Oct" REAL, "Nov" REAL, "Dec" REAL, FOREIGN KEY ("City_ID") REFERENCES "city" ("City_ID"));

CREATE TABLE "hosting_city" ("Year" INTEGER PRIMARY KEY, "Match_ID" INTEGER, "Host_City" TEXT, FOREIGN KEY ("Match_ID") REFERENCES "match" ("Match_ID"), FOREIGN KEY ("Host_City") REFERENCES "city" ("City_ID"));

-- Loading data
PRAGMA foreign_keys = OFF;
INSERT INTO "city" ("city_id", "city", "hanzi", "hanyu_pinyin", "regional_population", "gdp") VALUES (1001, 'North Judithbury', 'option', 'science', 1005, 1009.5);
INSERT INTO "city" ("city_id", "city", "hanzi", "hanyu_pinyin", "regional_population", "gdp") VALUES (1002, 'East Jill', 'decide', 'offer', 1016.0, 1022.5);
INSERT INTO "city" ("city_id", "city", "hanzi", "hanyu_pinyin", "regional_population", "gdp") VALUES (1003, 'New Roberttown', 'sense', 'kind', 1027.0, 1035.5);
INSERT INTO "city" ("city_id", "city", "hanzi", "hanyu_pinyin", "regional_population", "gdp") VALUES (1004, 'East Jessetown', 'rate', 'discussion', 1038.0, 1048.5);
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT gdp FROM (SELECT * FROM (SELECT * FROM city ORDER BY city_id) LIMIT 1);

/*
Gold Result:
(1009.5,)
*/

-- Prediction Query
SELECT gdp FROM city ORDER BY Regional_Population DESC, city.city_id NULLS LAST LIMIT 1;

/*
Prediction Result:
(1048.5,)
*/