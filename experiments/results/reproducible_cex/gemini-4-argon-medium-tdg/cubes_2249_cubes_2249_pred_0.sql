-- Schema DDL
CREATE TABLE "city" ("City_ID" INTEGER PRIMARY KEY, "City" TEXT, "Hanzi" TEXT, "Hanyu_Pinyin" TEXT, "Regional_Population" INTEGER, "GDP" REAL);

CREATE TABLE "match" ("Match_ID" INTEGER PRIMARY KEY, "Date" TEXT, "Venue" TEXT, "Score" TEXT, "Result" TEXT, "Competition" TEXT);

CREATE TABLE "temperature" ("City_ID" INTEGER PRIMARY KEY, "Jan" REAL, "Feb" REAL, "Mar" REAL, "Apr" REAL, "Jun" REAL, "Jul" REAL, "Aug" REAL, "Sep" REAL, "Oct" REAL, "Nov" REAL, "Dec" REAL, FOREIGN KEY ("City_ID") REFERENCES "city" ("City_ID"));

CREATE TABLE "hosting_city" ("Year" INTEGER PRIMARY KEY, "Match_ID" INTEGER, "Host_City" TEXT, FOREIGN KEY ("Match_ID") REFERENCES "match" ("Match_ID"), FOREIGN KEY ("Host_City") REFERENCES "city" ("City_ID"));

-- Loading data
PRAGMA foreign_keys = OFF;
-- DATASET 1
INSERT INTO "city" ("City_ID", "City", "Hanzi", "Hanyu_Pinyin", "Regional_Population", "GDP") VALUES (1, 'Beijing', '北京', 'Běijīng', 10000000, 3000.0);
INSERT INTO "city" ("City_ID", "City", "Hanzi", "Hanyu_Pinyin", "Regional_Population", "GDP") VALUES (2, 'Tianjin', '天津', 'Tiānjīn', 9999999, 2000.0);
INSERT INTO "city" ("City_ID", "City", "Hanzi", "Hanyu_Pinyin", "Regional_Population", "GDP") VALUES (3, 'Shanghai', '上海', 'Shànghǎi', 15000000, 4000.0);
INSERT INTO "city" ("City_ID", "City", "Hanzi", "Hanyu_Pinyin", "Regional_Population", "GDP") VALUES (4, 'Xiamen', '厦门', 'Xiàmén', 5000000, 1000.0);
INSERT INTO "city" ("City_ID", "City", "Hanzi", "Hanyu_Pinyin", "Regional_Population", "GDP") VALUES (5, 'Sanya', '三亚', 'Sānyà', 4999999, 500.0);
INSERT INTO "city" ("City_ID", "City", "Hanzi", "Hanyu_Pinyin", "Regional_Population", "GDP") VALUES (6, 'Lhasa', '拉萨', 'Lāsà', 800000, 100.0);
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT city FROM city WHERE (regional_population >= 10000000 OR regional_population < 5000000) ORDER BY city, city.city_id NULLS LAST;

/*
Gold Result:
('Beijing',)
('Lhasa',)
('Sanya',)
('Shanghai',)
*/

-- Prediction Query
SELECT city FROM city WHERE regional_population > 10000000 UNION SELECT city FROM city WHERE regional_population < 5000000;

/*
Prediction Result:
('Lhasa',)
('Sanya',)
('Shanghai',)
*/