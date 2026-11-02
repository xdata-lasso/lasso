-- Schema DDL
CREATE TABLE "city" ("City_ID" INTEGER PRIMARY KEY, "City" TEXT, "Hanzi" TEXT, "Hanyu_Pinyin" TEXT, "Regional_Population" INTEGER, "GDP" REAL);

CREATE TABLE "match" ("Match_ID" INTEGER PRIMARY KEY, "Date" TEXT, "Venue" TEXT, "Score" TEXT, "Result" TEXT, "Competition" TEXT);

CREATE TABLE "temperature" ("City_ID" INTEGER PRIMARY KEY, "Jan" REAL, "Feb" REAL, "Mar" REAL, "Apr" REAL, "Jun" REAL, "Jul" REAL, "Aug" REAL, "Sep" REAL, "Oct" REAL, "Nov" REAL, "Dec" REAL, FOREIGN KEY ("City_ID") REFERENCES "city" ("City_ID"));

CREATE TABLE "hosting_city" ("Year" INTEGER PRIMARY KEY, "Match_ID" INTEGER, "Host_City" TEXT, FOREIGN KEY ("Match_ID") REFERENCES "match" ("Match_ID"), FOREIGN KEY ("Host_City") REFERENCES "city" ("City_ID"));

-- Loading data
PRAGMA foreign_keys = OFF;
INSERT INTO "match" (match_id, date, venue, score, result, competition) VALUES (1, 'default1', 'default2', 'default2', NULL, 'default1'), (0, NULL, 'default2', 'default1', 'default1', 'default1'), (2, 'default2', 'default1', 'default1', 'default1', 'default1'), (3, 'default1', 'default1', NULL, 'default1', 'default1');
INSERT INTO city (city_id, city, hanzi, hanyu_pinyin, regional_population, gdp) VALUES (1, NULL, 'default1', NULL, 2, 1.0), (2, 'default2', 'default2', 'default1', 1, 0.0);
INSERT INTO hosting_city (year, match_id, host_city) VALUES (2, 1, NULL), (1, NULL, 2), (0, NULL, NULL), (3, 1, 1), (4, NULL, 1);
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT host_city FROM (SELECT * FROM (SELECT * FROM hosting_city ORDER BY match_id DESC, hosting_city.year NULLS LAST) LIMIT 1);

/*
Gold Result:
(None,)
*/

-- Prediction Query
SELECT host_city FROM hosting_city ORDER BY YEAR DESC LIMIT 1;

/*
Prediction Result:
('1',)
*/