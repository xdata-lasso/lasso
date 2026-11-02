-- Schema DDL
CREATE TABLE "city" ("City_ID" INTEGER PRIMARY KEY, "City" TEXT, "Hanzi" TEXT, "Hanyu_Pinyin" TEXT, "Regional_Population" INTEGER, "GDP" REAL);

CREATE TABLE "match" ("Match_ID" INTEGER PRIMARY KEY, "Date" TEXT, "Venue" TEXT, "Score" TEXT, "Result" TEXT, "Competition" TEXT);

CREATE TABLE "temperature" ("City_ID" INTEGER PRIMARY KEY, "Jan" REAL, "Feb" REAL, "Mar" REAL, "Apr" REAL, "Jun" REAL, "Jul" REAL, "Aug" REAL, "Sep" REAL, "Oct" REAL, "Nov" REAL, "Dec" REAL, FOREIGN KEY ("City_ID") REFERENCES "city" ("City_ID"));

CREATE TABLE "hosting_city" ("Year" INTEGER PRIMARY KEY, "Match_ID" INTEGER, "Host_City" TEXT, FOREIGN KEY ("Match_ID") REFERENCES "match" ("Match_ID"), FOREIGN KEY ("Host_City") REFERENCES "city" ("City_ID"));

-- Loading data
PRAGMA foreign_keys = OFF;
-- DATASET 1
INSERT INTO city (City_ID, City, Hanzi, Hanyu_Pinyin, Regional_Population, GDP) VALUES (1, 'Delta', 'D', 'D', 4999999, 100.0);
INSERT INTO city (City_ID, City, Hanzi, Hanyu_Pinyin, Regional_Population, GDP) VALUES (2, 'Bravo', 'B', 'B', 5000000, 200.0);
INSERT INTO city (City_ID, City, Hanzi, Hanyu_Pinyin, Regional_Population, GDP) VALUES (3, 'Charlie', 'C', 'C', 9999999, 300.0);
INSERT INTO city (City_ID, City, Hanzi, Hanyu_Pinyin, Regional_Population, GDP) VALUES (4, 'Alpha', 'A', 'A', 10000000, 400.0);
INSERT INTO city (City_ID, City, Hanzi, Hanyu_Pinyin, Regional_Population, GDP) VALUES (5, 'Echo', 'E', 'E', 10000001, 500.0);
INSERT INTO city (City_ID, City, Hanzi, Hanyu_Pinyin, Regional_Population, GDP) VALUES (6, 'Foxtrot', 'F', 'F', NULL, 600.0);
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT city FROM city WHERE (regional_population >= 10000000 OR regional_population < 5000000) ORDER BY city, city.city_id NULLS LAST;

/*
Gold Result:
('Alpha',)
('Delta',)
('Echo',)
*/

-- Prediction Query
SELECT city FROM city WHERE regional_population > 10000000 UNION SELECT city FROM city WHERE regional_population < 5000000;

/*
Prediction Result:
('Delta',)
('Echo',)
*/