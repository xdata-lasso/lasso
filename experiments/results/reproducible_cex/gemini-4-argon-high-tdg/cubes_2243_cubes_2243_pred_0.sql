-- Schema DDL
CREATE TABLE "city" ("City_ID" INTEGER PRIMARY KEY, "City" TEXT, "Hanzi" TEXT, "Hanyu_Pinyin" TEXT, "Regional_Population" INTEGER, "GDP" REAL);

CREATE TABLE "match" ("Match_ID" INTEGER PRIMARY KEY, "Date" TEXT, "Venue" TEXT, "Score" TEXT, "Result" TEXT, "Competition" TEXT);

CREATE TABLE "temperature" ("City_ID" INTEGER PRIMARY KEY, "Jan" REAL, "Feb" REAL, "Mar" REAL, "Apr" REAL, "Jun" REAL, "Jul" REAL, "Aug" REAL, "Sep" REAL, "Oct" REAL, "Nov" REAL, "Dec" REAL, FOREIGN KEY ("City_ID") REFERENCES "city" ("City_ID"));

CREATE TABLE "hosting_city" ("Year" INTEGER PRIMARY KEY, "Match_ID" INTEGER, "Host_City" TEXT, FOREIGN KEY ("Match_ID") REFERENCES "match" ("Match_ID"), FOREIGN KEY ("Host_City") REFERENCES "city" ("City_ID"));

-- Loading data
PRAGMA foreign_keys = OFF;
-- DATASET 1
INSERT INTO city (City_ID, City, Hanzi, Hanyu_Pinyin, Regional_Population, GDP) VALUES (1, 'Shanghai', '上海', 'Shànghǎi', 24000000, 3800.5);
INSERT INTO city (City_ID, City, Hanzi, Hanyu_Pinyin, Regional_Population, GDP) VALUES (2, 'Beijing', '北京', 'Běijīng', 10000000, 5000.0);
INSERT INTO city (City_ID, City, Hanzi, Hanyu_Pinyin, Regional_Population, GDP) VALUES (3, 'Chongqing', '重庆', 'Chóngqìng', 31000000, 2500.0);
INSERT INTO city (City_ID, City, Hanzi, Hanyu_Pinyin, Regional_Population, GDP) VALUES (4, 'Nanjing', '南京', 'Nánjīng', 9999999, 15000000.0);
INSERT INTO city (City_ID, City, Hanzi, Hanyu_Pinyin, Regional_Population, GDP) VALUES (5, 'Wuhan', '武汉', 'Wǔhàn', 10000001, 1600.0);
INSERT INTO city (City_ID, City, Hanzi, Hanyu_Pinyin, Regional_Population, GDP) VALUES (6, 'Beijing', '燕京', 'Yānjīng', 12000000, 1200.0);
INSERT INTO match (Match_ID, Date, Venue, Score, Result, Competition) VALUES (101, '2022-05-01', 'Workers Stadium', '2-1', 'Win', 'Cup');
INSERT INTO match (Match_ID, Date, Venue, Score, Result, Competition) VALUES (102, '2022-06-01', 'Olympic Center', '0-0', 'Draw', 'League');
INSERT INTO temperature (City_ID, Jan, Feb, Mar, Apr, Jun, Jul, Aug, Sep, Oct, Nov, Dec) VALUES (1, 4.5, 6.0, 10.2, 16.5, 24.0, 28.5, 28.0, 24.2, 19.0, 13.5, 7.0);
INSERT INTO temperature (City_ID, Jan, Feb, Mar, Apr, Jun, Jul, Aug, Sep, Oct, Nov, Dec) VALUES (4, 2.5, 4.5, 9.5, 15.8, 24.5, 28.2, 27.8, 23.0, 17.5, 11.0, 5.0);
INSERT INTO hosting_city (Year, Match_ID, Host_City) VALUES (2021, 101, '1');
INSERT INTO hosting_city (Year, Match_ID, Host_City) VALUES (2022, 102, '1');
INSERT INTO hosting_city (Year, Match_ID, Host_City) VALUES (2023, 101, '4');
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT city FROM city WHERE (regional_population >= 10000000) ORDER BY city, city.city_id NULLS LAST;

/*
Gold Result:
('Beijing',)
('Beijing',)
('Chongqing',)
('Shanghai',)
('Wuhan',)
*/

-- Prediction Query
SELECT city FROM city WHERE regional_population > 10000000;

/*
Prediction Result:
('Shanghai',)
('Chongqing',)
('Wuhan',)
('Beijing',)
*/