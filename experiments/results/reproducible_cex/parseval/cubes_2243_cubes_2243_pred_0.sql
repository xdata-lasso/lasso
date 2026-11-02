-- Schema DDL
CREATE TABLE "city" ("City_ID" INTEGER PRIMARY KEY, "City" TEXT, "Hanzi" TEXT, "Hanyu_Pinyin" TEXT, "Regional_Population" INTEGER, "GDP" REAL);

CREATE TABLE "match" ("Match_ID" INTEGER PRIMARY KEY, "Date" TEXT, "Venue" TEXT, "Score" TEXT, "Result" TEXT, "Competition" TEXT);

CREATE TABLE "temperature" ("City_ID" INTEGER PRIMARY KEY, "Jan" REAL, "Feb" REAL, "Mar" REAL, "Apr" REAL, "Jun" REAL, "Jul" REAL, "Aug" REAL, "Sep" REAL, "Oct" REAL, "Nov" REAL, "Dec" REAL, FOREIGN KEY ("City_ID") REFERENCES "city" ("City_ID"));

CREATE TABLE "hosting_city" ("Year" INTEGER PRIMARY KEY, "Match_ID" INTEGER, "Host_City" TEXT, FOREIGN KEY ("Match_ID") REFERENCES "match" ("Match_ID"), FOREIGN KEY ("Host_City") REFERENCES "city" ("City_ID"));

-- Loading data
PRAGMA foreign_keys = OFF;
-- Inserting into table: city --
INSERT INTO "city" ("city_id", "city", "hanzi", "hanyu_pinyin", "regional_population", "gdp") VALUES (1, 'cit_d68ff0', '5k5swwqcgs', '9n8', 10000000, 874.871895);

INSERT INTO "city" ("city_id", "city", "hanzi", "hanyu_pinyin", "regional_population", "gdp") VALUES (3, 'cit_d68ff0', 'pgu7vfe4', 'hria2ypuzhs', 10000000, 663.049759);

INSERT INTO "city" ("city_id", "city", "hanzi", "hanyu_pinyin", "regional_population", "gdp") VALUES (2, 'wbbp6luhvdlt', 'ilbnp', 'mdpos', 9999999, 133.007885);

INSERT INTO "city" ("city_id", "city", "hanzi", "hanyu_pinyin", "regional_population", "gdp") VALUES (4, '5u', 'w6kl', 'a9', NULL, 877.276439);

INSERT INTO "city" ("city_id", "city", "hanzi", "hanyu_pinyin", "regional_population", "gdp") VALUES (5, NULL, '00t5c4ecigc', 'e376nium52', 10000000, 816.814398);
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT city FROM city WHERE (regional_population >= 10000000) ORDER BY city, city.city_id NULLS LAST;

/*
Gold Result:
(None,)
('cit_d68ff0',)
('cit_d68ff0',)
*/

-- Prediction Query
SELECT city FROM city WHERE regional_population > 10000000;

/*
Prediction Result:
*/