-- Schema DDL
CREATE TABLE "city" ("City_ID" INTEGER PRIMARY KEY, "City" TEXT, "Hanzi" TEXT, "Hanyu_Pinyin" TEXT, "Regional_Population" INTEGER, "GDP" REAL);

CREATE TABLE "match" ("Match_ID" INTEGER PRIMARY KEY, "Date" TEXT, "Venue" TEXT, "Score" TEXT, "Result" TEXT, "Competition" TEXT);

CREATE TABLE "temperature" ("City_ID" INTEGER PRIMARY KEY, "Jan" REAL, "Feb" REAL, "Mar" REAL, "Apr" REAL, "Jun" REAL, "Jul" REAL, "Aug" REAL, "Sep" REAL, "Oct" REAL, "Nov" REAL, "Dec" REAL, FOREIGN KEY ("City_ID") REFERENCES "city" ("City_ID"));

CREATE TABLE "hosting_city" ("Year" INTEGER PRIMARY KEY, "Match_ID" INTEGER, "Host_City" TEXT, FOREIGN KEY ("Match_ID") REFERENCES "match" ("Match_ID"), FOREIGN KEY ("Host_City") REFERENCES "city" ("City_ID"));

-- Loading data
PRAGMA foreign_keys = OFF;
-- DATASET 1
INSERT INTO city (City_ID, City, Hanzi, Hanyu_Pinyin, Regional_Population, GDP) VALUES (10, 'Alpha', '甲', 'Jia', 5000000, 100.5);
INSERT INTO city (City_ID, City, Hanzi, Hanyu_Pinyin, Regional_Population, GDP) VALUES (2, 'Beta', '乙', 'Yi', 2000000, 450.75);
INSERT INTO city (City_ID, City, Hanzi, Hanyu_Pinyin, Regional_Population, GDP) VALUES (5, 'Gamma', '丙', 'Bing', 1000000, 900.25);
INSERT INTO match (Match_ID, Date, Venue, Score, Result, Competition) VALUES (101, '2020-05-01', 'Stadium A', '2-1', 'Win', 'Cup');
INSERT INTO match (Match_ID, Date, Venue, Score, Result, Competition) VALUES (102, '2021-06-15', 'Stadium B', '0-0', 'Draw', 'League');
INSERT INTO temperature (City_ID, Jan, Feb, Mar, Apr, Jun, Jul, Aug, Sep, Oct, Nov, Dec) VALUES (5, 5.0, 6.0, 10.0, 15.0, 25.0, 28.0, 27.0, 22.0, 16.0, 10.0, 6.0);
INSERT INTO temperature (City_ID, Jan, Feb, Mar, Apr, Jun, Jul, Aug, Sep, Oct, Nov, Dec) VALUES (10, 1.0, 2.0, 8.0, 14.0, 24.0, 29.0, 28.0, 20.0, 14.0, 8.0, 2.0);
INSERT INTO hosting_city (Year, Match_ID, Host_City) VALUES (2020, 101, '5');
INSERT INTO hosting_city (Year, Match_ID, Host_City) VALUES (2021, 102, '10');
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT gdp FROM (SELECT * FROM (SELECT * FROM city ORDER BY city_id) LIMIT 1);

/*
Gold Result:
(450.75,)
*/

-- Prediction Query
SELECT gdp FROM city ORDER BY Regional_Population DESC, city.city_id NULLS LAST LIMIT 1;

/*
Prediction Result:
(100.5,)
*/