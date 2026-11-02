-- Schema DDL
CREATE TABLE "city" ("City_ID" INTEGER PRIMARY KEY, "City" TEXT, "Hanzi" TEXT, "Hanyu_Pinyin" TEXT, "Regional_Population" INTEGER, "GDP" REAL);

CREATE TABLE "match" ("Match_ID" INTEGER PRIMARY KEY, "Date" TEXT, "Venue" TEXT, "Score" TEXT, "Result" TEXT, "Competition" TEXT);

CREATE TABLE "temperature" ("City_ID" INTEGER PRIMARY KEY, "Jan" REAL, "Feb" REAL, "Mar" REAL, "Apr" REAL, "Jun" REAL, "Jul" REAL, "Aug" REAL, "Sep" REAL, "Oct" REAL, "Nov" REAL, "Dec" REAL, FOREIGN KEY ("City_ID") REFERENCES "city" ("City_ID"));

CREATE TABLE "hosting_city" ("Year" INTEGER PRIMARY KEY, "Match_ID" INTEGER, "Host_City" TEXT, FOREIGN KEY ("Match_ID") REFERENCES "match" ("Match_ID"), FOREIGN KEY ("Host_City") REFERENCES "city" ("City_ID"));

-- Loading data
PRAGMA foreign_keys = OFF;
-- Inserting into table: city --
INSERT INTO "city" ("city_id", "city", "hanzi", "hanyu_pinyin", "regional_population", "gdp") VALUES (1, 'cit_2e627c', '5k5swwqcgs', '9n8', 0, 874.871895);

INSERT INTO "city" ("city_id", "city", "hanzi", "hanyu_pinyin", "regional_population", "gdp") VALUES (2, 'cit_2e627c', 'pgu7vfe4', 'hria2ypuzhs', 0, 663.049759);

INSERT INTO "city" ("city_id", "city", "hanzi", "hanyu_pinyin", "regional_population", "gdp") VALUES (3, 'cit_2e627c', 'wbbp6luhvdlt', 'ilbnp', 0, 787.938887);

INSERT INTO "city" ("city_id", "city", "hanzi", "hanyu_pinyin", "regional_population", "gdp") VALUES (4, 'dpos', 'ie5', 'nw6klf', 10000000, 741.842896);

INSERT INTO "city" ("city_id", "city", "hanzi", "hanyu_pinyin", "regional_population", "gdp") VALUES (5, '5k5swwqcgs', '9n8', '4', 5000000, 249.706432);

INSERT INTO "city" ("city_id", "city", "hanzi", "hanyu_pinyin", "regional_population", "gdp") VALUES (6, 'u7', 'fe4hri', 'a2ypuzhsrwbb', NULL, 749.826493);

INSERT INTO "city" ("city_id", "city", "hanzi", "hanyu_pinyin", "regional_population", "gdp") VALUES (7, 'luhvdltti', 'bnp', 'mdpos', NULL, 133.007885);

INSERT INTO "city" ("city_id", "city", "hanzi", "hanyu_pinyin", "regional_population", "gdp") VALUES (8, '5u', 'w6kl', 'a9', NULL, 877.276439);

INSERT INTO "city" ("city_id", "city", "hanzi", "hanyu_pinyin", "regional_population", "gdp") VALUES (9, '00t5c4ecigc', 'e376nium52', 'zbuo4nrqrof', NULL, 586.906897);

INSERT INTO "city" ("city_id", "city", "hanzi", "hanyu_pinyin", "regional_population", "gdp") VALUES (10, 'p5s5bbp', '02eutliqa11r', 'ytoo3o9', NULL, 111.926013);

INSERT INTO "city" ("city_id", "city", "hanzi", "hanyu_pinyin", "regional_population", "gdp") VALUES (11, '72klex14ji7z', 'au2dwy', 'q13py', NULL, 326.912005);
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT city FROM city WHERE (regional_population >= 10000000 OR regional_population < 5000000) ORDER BY city, city.city_id NULLS LAST;

/*
Gold Result:
('cit_2e627c',)
('cit_2e627c',)
('cit_2e627c',)
('dpos',)
*/

-- Prediction Query
SELECT city FROM city WHERE regional_population > 10000000 UNION SELECT city FROM city WHERE regional_population < 5000000;

/*
Prediction Result:
('cit_2e627c',)
*/