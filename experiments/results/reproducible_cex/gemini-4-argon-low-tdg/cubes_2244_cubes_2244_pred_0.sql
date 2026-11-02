-- Schema DDL
CREATE TABLE "city" ("City_ID" INTEGER PRIMARY KEY, "City" TEXT, "Hanzi" TEXT, "Hanyu_Pinyin" TEXT, "Regional_Population" INTEGER, "GDP" REAL);

CREATE TABLE "match" ("Match_ID" INTEGER PRIMARY KEY, "Date" TEXT, "Venue" TEXT, "Score" TEXT, "Result" TEXT, "Competition" TEXT);

CREATE TABLE "temperature" ("City_ID" INTEGER PRIMARY KEY, "Jan" REAL, "Feb" REAL, "Mar" REAL, "Apr" REAL, "Jun" REAL, "Jul" REAL, "Aug" REAL, "Sep" REAL, "Oct" REAL, "Nov" REAL, "Dec" REAL, FOREIGN KEY ("City_ID") REFERENCES "city" ("City_ID"));

CREATE TABLE "hosting_city" ("Year" INTEGER PRIMARY KEY, "Match_ID" INTEGER, "Host_City" TEXT, FOREIGN KEY ("Match_ID") REFERENCES "match" ("Match_ID"), FOREIGN KEY ("Host_City") REFERENCES "city" ("City_ID"));

-- Loading data
PRAGMA foreign_keys = OFF;
-- DATASET 1
INSERT INTO city (City_ID, City, Hanzi, Hanyu_Pinyin, Regional_Population, GDP) VALUES (1, 'Nanjing', '南京', 'Nánjīng', 8000000, 1200.5);
INSERT INTO city (City_ID, City, Hanzi, Hanyu_Pinyin, Regional_Population, GDP) VALUES (2, 'Beijing', '北京', 'Běijīng', 21000000, 3500.0);
INSERT INTO city (City_ID, City, Hanzi, Hanyu_Pinyin, Regional_Population, GDP) VALUES (3, 'Shanghai', '上海', 'Shànghǎi', 24000000, 800.25);
INSERT INTO match (Match_ID, Date, Venue, Score, Result, Competition) VALUES (10, '2021-05-01', 'Olympic Stadium', '2-1', 'Win', 'Cup');
INSERT INTO temperature (City_ID, Jan, Feb, Mar, Apr, Jun, Jul, Aug, Sep, Oct, Nov, Dec) VALUES (2, -3.0, 0.0, 6.0, 14.0, 24.0, 26.0, 25.0, 20.0, 13.0, 4.0, -1.0);
INSERT INTO hosting_city (Year, Match_ID, Host_City) VALUES (2021, 10, '2');
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT gdp FROM (SELECT * FROM (SELECT * FROM city ORDER BY city_id) LIMIT 1);

/*
Gold Result:
(1200.5,)
*/

-- Prediction Query
SELECT gdp FROM city ORDER BY Regional_Population DESC, city.city_id NULLS LAST LIMIT 1;

/*
Prediction Result:
(800.25,)
*/