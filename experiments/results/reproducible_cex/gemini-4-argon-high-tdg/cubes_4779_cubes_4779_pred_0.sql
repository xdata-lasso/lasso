-- Schema DDL
CREATE TABLE "city" ("City_ID" INTEGER PRIMARY KEY, "City" TEXT, "Hanzi" TEXT, "Hanyu_Pinyin" TEXT, "Regional_Population" INTEGER, "GDP" REAL);

CREATE TABLE "match" ("Match_ID" INTEGER PRIMARY KEY, "Date" TEXT, "Venue" TEXT, "Score" TEXT, "Result" TEXT, "Competition" TEXT);

CREATE TABLE "temperature" ("City_ID" INTEGER PRIMARY KEY, "Jan" REAL, "Feb" REAL, "Mar" REAL, "Apr" REAL, "Jun" REAL, "Jul" REAL, "Aug" REAL, "Sep" REAL, "Oct" REAL, "Nov" REAL, "Dec" REAL, FOREIGN KEY ("City_ID") REFERENCES "city" ("City_ID"));

CREATE TABLE "hosting_city" ("Year" INTEGER PRIMARY KEY, "Match_ID" INTEGER, "Host_City" TEXT, FOREIGN KEY ("Match_ID") REFERENCES "match" ("Match_ID"), FOREIGN KEY ("Host_City") REFERENCES "city" ("City_ID"));

-- Loading data
PRAGMA foreign_keys = OFF;
-- DATASET 2
INSERT INTO city (City_ID, City, Hanzi, Hanyu_Pinyin, Regional_Population, GDP) VALUES (1, 'Nanjing', '南京', 'Nánjīng', 8500000, 1403.0);
INSERT INTO match (Match_ID, Date, Venue, Score, Result, Competition) VALUES (1, '2021-04-01', 'Olympic Sports Center', '1-0', 'Win', 'Qualifier');
INSERT INTO temperature (City_ID, Jan, Feb, Mar, Apr, Jun, Jul, Aug, Sep, Oct, Nov, Dec) VALUES (1, 2.7, 5.0, 9.8, 16.1, 25.1, 28.1, 27.5, 23.0, 17.4, 10.9, 4.7);
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT host_city FROM (SELECT LHS.year AS YEAR, RHS.match_id AS match_id, RHS.host_city AS host_city FROM (SELECT MAX(YEAR) AS YEAR FROM hosting_city) AS LHS LEFT JOIN hosting_city AS RHS ON (LHS.year = RHS.year)) ORDER BY host_city;

/*
Gold Result:
(None,)
*/

-- Prediction Query
SELECT host_city FROM hosting_city ORDER BY YEAR DESC LIMIT 1;

/*
Prediction Result:
*/