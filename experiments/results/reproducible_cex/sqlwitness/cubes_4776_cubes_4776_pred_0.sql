-- Schema DDL
CREATE TABLE "city" ("City_ID" INTEGER PRIMARY KEY, "City" TEXT, "Hanzi" TEXT, "Hanyu_Pinyin" TEXT, "Regional_Population" INTEGER, "GDP" REAL);

CREATE TABLE "match" ("Match_ID" INTEGER PRIMARY KEY, "Date" TEXT, "Venue" TEXT, "Score" TEXT, "Result" TEXT, "Competition" TEXT);

CREATE TABLE "temperature" ("City_ID" INTEGER PRIMARY KEY, "Jan" REAL, "Feb" REAL, "Mar" REAL, "Apr" REAL, "Jun" REAL, "Jul" REAL, "Aug" REAL, "Sep" REAL, "Oct" REAL, "Nov" REAL, "Dec" REAL, FOREIGN KEY ("City_ID") REFERENCES "city" ("City_ID"));

CREATE TABLE "hosting_city" ("Year" INTEGER PRIMARY KEY, "Match_ID" INTEGER, "Host_City" TEXT, FOREIGN KEY ("Match_ID") REFERENCES "match" ("Match_ID"), FOREIGN KEY ("Host_City") REFERENCES "city" ("City_ID"));

-- Loading data
PRAGMA foreign_keys = OFF;
INSERT INTO city (city_id, city, hanzi, hanyu_pinyin, regional_population, gdp) VALUES (0, 'default2', 'default2', 'default1', 2, 2.0), (1, 'default1', NULL, NULL, 1, 0.0), (2, 'default1', NULL, 'default2', 2, 2.0), (3, 'default2', 'default2', NULL, NULL, 0.0), (4, NULL, 'default2', 'default2', 2, NULL), (5, 'default1', 'default1', 'default1', 1, 2.0), (6, 'default2', 'default1', 'default2', 0, 0.0), (7, 'default1', 'default1', NULL, 1, 0.0);
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT gdp FROM (SELECT * FROM (SELECT * FROM (SELECT gdp, regional_population, MAX(regional_population) AS maxregional_population FROM city GROUP BY gdp, regional_population) ORDER BY regional_population DESC) LIMIT 1);

/*
Gold Result:
(None,)
*/

-- Prediction Query
SELECT gdp FROM city ORDER BY Regional_Population DESC, city.city_id NULLS LAST LIMIT 1;

/*
Prediction Result:
(2.0,)
*/