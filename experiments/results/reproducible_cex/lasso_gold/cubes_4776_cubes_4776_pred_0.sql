-- Schema DDL
CREATE TABLE "city" ("City_ID" INTEGER PRIMARY KEY, "City" TEXT, "Hanzi" TEXT, "Hanyu_Pinyin" TEXT, "Regional_Population" INTEGER, "GDP" REAL);

CREATE TABLE "match" ("Match_ID" INTEGER PRIMARY KEY, "Date" TEXT, "Venue" TEXT, "Score" TEXT, "Result" TEXT, "Competition" TEXT);

CREATE TABLE "temperature" ("City_ID" INTEGER PRIMARY KEY, "Jan" REAL, "Feb" REAL, "Mar" REAL, "Apr" REAL, "Jun" REAL, "Jul" REAL, "Aug" REAL, "Sep" REAL, "Oct" REAL, "Nov" REAL, "Dec" REAL, FOREIGN KEY ("City_ID") REFERENCES "city" ("City_ID"));

CREATE TABLE "hosting_city" ("Year" INTEGER PRIMARY KEY, "Match_ID" INTEGER, "Host_City" TEXT, FOREIGN KEY ("Match_ID") REFERENCES "match" ("Match_ID"), FOREIGN KEY ("Host_City") REFERENCES "city" ("City_ID"));

-- Loading data
PRAGMA foreign_keys = OFF;
INSERT INTO "city" ("city_id", "city", "hanzi", "hanyu_pinyin", "regional_population", "gdp") VALUES (1104, 'Kington', 'ok', 'right', 2114.0, 1115.5);
INSERT INTO "city" ("city_id", "city", "hanzi", "hanyu_pinyin", "regional_population", "gdp") VALUES (1105, 'Lake Lisaport', 'series', 'protect', 2094.0, 1115.5);
INSERT INTO "city" ("city_id", "city", "hanzi", "hanyu_pinyin", "regional_population", "gdp") VALUES (1106, 'East Josephville', 'gun', 'tonight', 2084.0, 1115.5);
INSERT INTO "city" ("city_id", "city", "hanzi", "hanyu_pinyin", "regional_population", "gdp") VALUES (1107, 'West Juan', 'Democrat', 'everything', 2074.0, 1115.5);
INSERT INTO "city" ("city_id", "city", "hanzi", "hanyu_pinyin", "regional_population", "gdp") VALUES (1110, 'Cherylhaven', 'develop', 'act', 2114.0, 1109.5);
INSERT INTO "city" ("city_id", "city", "hanzi", "hanyu_pinyin", "regional_population", "gdp") VALUES (1111, 'Lake Rodneyview', 'season', 'brother', 2004.0, 1109.5);
INSERT INTO "city" ("city_id", "city", "hanzi", "hanyu_pinyin", "regional_population", "gdp") VALUES (1112, 'North Matthewberg', 'late', 'bag', 1994.0, 1109.5);
INSERT INTO "city" ("city_id", "city", "hanzi", "hanyu_pinyin", "regional_population", "gdp") VALUES (1113, 'Evanmouth', 'option', 'you', 1984.0, 1109.5);
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT gdp FROM (SELECT * FROM (SELECT * FROM (SELECT gdp, regional_population, MAX(regional_population) AS maxregional_population FROM city GROUP BY gdp, regional_population) ORDER BY regional_population DESC) LIMIT 1);

/*
Gold Result:
(1109.5,)
*/

-- Prediction Query
SELECT gdp FROM city ORDER BY Regional_Population DESC, city.city_id NULLS LAST LIMIT 1;

/*
Prediction Result:
(1115.5,)
*/