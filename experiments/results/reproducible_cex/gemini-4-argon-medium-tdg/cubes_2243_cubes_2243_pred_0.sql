-- Schema DDL
CREATE TABLE "city" ("City_ID" INTEGER PRIMARY KEY, "City" TEXT, "Hanzi" TEXT, "Hanyu_Pinyin" TEXT, "Regional_Population" INTEGER, "GDP" REAL);

CREATE TABLE "match" ("Match_ID" INTEGER PRIMARY KEY, "Date" TEXT, "Venue" TEXT, "Score" TEXT, "Result" TEXT, "Competition" TEXT);

CREATE TABLE "temperature" ("City_ID" INTEGER PRIMARY KEY, "Jan" REAL, "Feb" REAL, "Mar" REAL, "Apr" REAL, "Jun" REAL, "Jul" REAL, "Aug" REAL, "Sep" REAL, "Oct" REAL, "Nov" REAL, "Dec" REAL, FOREIGN KEY ("City_ID") REFERENCES "city" ("City_ID"));

CREATE TABLE "hosting_city" ("Year" INTEGER PRIMARY KEY, "Match_ID" INTEGER, "Host_City" TEXT, FOREIGN KEY ("Match_ID") REFERENCES "match" ("Match_ID"), FOREIGN KEY ("Host_City") REFERENCES "city" ("City_ID"));

-- Loading data
PRAGMA foreign_keys = OFF;
-- DATASET 1
INSERT INTO "city" ("City_ID", "City", "Hanzi", "Hanyu_Pinyin", "Regional_Population", "GDP") VALUES (1, 'Chongqing', '重庆', 'Chóngqìng', 10000000, 2500.5);
INSERT INTO "city" ("City_ID", "City", "Hanzi", "Hanyu_Pinyin", "Regional_Population", "GDP") VALUES (2, 'Shanghai', '上海', 'Shànghǎi', 9999999, 3800.0);
INSERT INTO "city" ("City_ID", "City", "Hanzi", "Hanyu_Pinyin", "Regional_Population", "GDP") VALUES (3, 'Beijing', '北京', 'Běijīng', 10000001, 3500.0);
INSERT INTO "city" ("City_ID", "City", "Hanzi", "Hanyu_Pinyin", "Regional_Population", "GDP") VALUES (4, 'Wuhan', '武汉', 'Wǔhàn', NULL, 1500.0);
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT city FROM city WHERE (regional_population >= 10000000) ORDER BY city, city.city_id NULLS LAST;

/*
Gold Result:
('Beijing',)
('Chongqing',)
*/

-- Prediction Query
SELECT city FROM city WHERE regional_population > 10000000;

/*
Prediction Result:
('Beijing',)
*/