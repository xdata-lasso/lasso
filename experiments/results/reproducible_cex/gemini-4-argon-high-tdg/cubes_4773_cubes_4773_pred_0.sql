-- Schema DDL
CREATE TABLE "city" ("City_ID" INTEGER PRIMARY KEY, "City" TEXT, "Hanzi" TEXT, "Hanyu_Pinyin" TEXT, "Regional_Population" INTEGER, "GDP" REAL);

CREATE TABLE "match" ("Match_ID" INTEGER PRIMARY KEY, "Date" TEXT, "Venue" TEXT, "Score" TEXT, "Result" TEXT, "Competition" TEXT);

CREATE TABLE "temperature" ("City_ID" INTEGER PRIMARY KEY, "Jan" REAL, "Feb" REAL, "Mar" REAL, "Apr" REAL, "Jun" REAL, "Jul" REAL, "Aug" REAL, "Sep" REAL, "Oct" REAL, "Nov" REAL, "Dec" REAL, FOREIGN KEY ("City_ID") REFERENCES "city" ("City_ID"));

CREATE TABLE "hosting_city" ("Year" INTEGER PRIMARY KEY, "Match_ID" INTEGER, "Host_City" TEXT, FOREIGN KEY ("Match_ID") REFERENCES "match" ("Match_ID"), FOREIGN KEY ("Host_City") REFERENCES "city" ("City_ID"));

-- Loading data
PRAGMA foreign_keys = OFF;
-- DATASET 1
INSERT INTO city (City_ID, City, Hanzi, Hanyu_Pinyin, Regional_Population, GDP) VALUES (1, 'Beijing', '北京', 'Běijīng', 21540000, 3537.1);
INSERT INTO city (City_ID, City, Hanzi, Hanyu_Pinyin, Regional_Population, GDP) VALUES (2, 'Tianjin', '天津', 'Tiānjīn', 15600000, 1410.4);
INSERT INTO city (City_ID, City, Hanzi, Hanyu_Pinyin, Regional_Population, GDP) VALUES (3, 'Shanghai', '上海', 'Shànghǎi', 24280000, 3815.5);
INSERT INTO city (City_ID, City, Hanzi, Hanyu_Pinyin, Regional_Population, GDP) VALUES (4, 'Chongqing', '重庆', 'Chóngqìng', 31240000, 2360.6);
INSERT INTO city (City_ID, City, Hanzi, Hanyu_Pinyin, Regional_Population, GDP) VALUES (5, 'Guangzhou', '广州', 'Guǎngzhōu', 15300000, 2362.9);
INSERT INTO city (City_ID, City, Hanzi, Hanyu_Pinyin, Regional_Population, GDP) VALUES (6, 'Shenzhen', '深圳', 'Shēnzhèn', 13440000, 2692.7);
INSERT INTO city (City_ID, City, Hanzi, Hanyu_Pinyin, Regional_Population, GDP) VALUES (10, 'Wuhan', '武汉', 'Wǔhàn', 11210000, 1622.3);
INSERT INTO city (City_ID, City, Hanzi, Hanyu_Pinyin, Regional_Population, GDP) VALUES (20, 'Chengdu', '成都', 'Chéngdū', 16580000, 1701.3);
INSERT INTO match (Match_ID, Date, Venue, Score, Result, Competition) VALUES (1, '2020-05-01', 'Stadium A', '2-1', 'Win', 'Cup');
INSERT INTO match (Match_ID, Date, Venue, Score, Result, Competition) VALUES (2, '2020-06-15', 'Stadium B', '1-1', 'Draw', 'League');
INSERT INTO match (Match_ID, Date, Venue, Score, Result, Competition) VALUES (3, '2020-07-20', 'Stadium C', '0-3', 'Loss', 'Friendly');
INSERT INTO temperature (City_ID, Jan, Feb, Mar, Apr, Jun, Jul, Aug, Sep, Oct, Nov, Dec) VALUES (1, -3.7, -0.7, 5.8, 14.2, 24.4, 26.2, 24.9, 20.0, 13.1, 4.6, -1.5);
INSERT INTO temperature (City_ID, Jan, Feb, Mar, Apr, Jun, Jul, Aug, Sep, Oct, Nov, Dec) VALUES (3, 4.6, 6.1, 9.9, 15.3, 24.3, 28.6, 28.3, 24.4, 19.2, 13.5, 7.1);
INSERT INTO temperature (City_ID, Jan, Feb, Mar, Apr, Jun, Jul, Aug, Sep, Oct, Nov, Dec) VALUES (10, 4.0, 6.6, 10.9, 17.4, 26.2, 29.1, 28.4, 23.6, 17.9, 11.4, 6.0);
INSERT INTO hosting_city (Year, Match_ID, Host_City) VALUES (2001, 1, '10');
INSERT INTO hosting_city (Year, Match_ID, Host_City) VALUES (2002, 2, '10');
INSERT INTO hosting_city (Year, Match_ID, Host_City) VALUES (2003, 3, '10');
INSERT INTO hosting_city (Year, Match_ID, Host_City) VALUES (2004, 1, '20');
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT DISTINCT city FROM (SELECT LHS.city_id AS city_id, LHS.city AS city, LHS.hanzi AS hanzi, LHS.hanyu_pinyin AS hanyu_pinyin, LHS.regional_population AS regional_population, LHS.gdp AS gdp, RHS.host_city AS host_city, RHS.n AS n FROM city AS LHS INNER JOIN (SELECT host_city, n, MAX(n) OVER () AS maxn FROM (SELECT host_city, COUNT(*) AS n FROM hosting_city GROUP BY host_city)) AS RHS ON (LHS.city_id = RHS.maxn)) ORDER BY city;

/*
Gold Result:
('Shanghai',)
*/

-- Prediction Query
SELECT T1.city FROM city AS T1 JOIN hosting_city AS T2 ON T1.city_id = T2.host_city GROUP BY T2.host_city ORDER BY COUNT(*) DESC, T1.city NULLS LAST LIMIT 1;

/*
Prediction Result:
('Wuhan',)
*/