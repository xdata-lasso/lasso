-- Schema DDL
CREATE TABLE "city" ("City_ID" INTEGER PRIMARY KEY, "City" TEXT, "Hanzi" TEXT, "Hanyu_Pinyin" TEXT, "Regional_Population" INTEGER, "GDP" REAL);

CREATE TABLE "match" ("Match_ID" INTEGER PRIMARY KEY, "Date" TEXT, "Venue" TEXT, "Score" TEXT, "Result" TEXT, "Competition" TEXT);

CREATE TABLE "temperature" ("City_ID" INTEGER PRIMARY KEY, "Jan" REAL, "Feb" REAL, "Mar" REAL, "Apr" REAL, "Jun" REAL, "Jul" REAL, "Aug" REAL, "Sep" REAL, "Oct" REAL, "Nov" REAL, "Dec" REAL, FOREIGN KEY ("City_ID") REFERENCES "city" ("City_ID"));

CREATE TABLE "hosting_city" ("Year" INTEGER PRIMARY KEY, "Match_ID" INTEGER, "Host_City" TEXT, FOREIGN KEY ("Match_ID") REFERENCES "match" ("Match_ID"), FOREIGN KEY ("Host_City") REFERENCES "city" ("City_ID"));

-- Loading data
PRAGMA foreign_keys = OFF;
-- DATASET 1
INSERT INTO city (City_ID, City, Hanzi, Hanyu_Pinyin, Regional_Population, GDP) VALUES (1, 'Beijing', '北京', 'Běijīng', 21540000, 3537.1);
INSERT INTO city (City_ID, City, Hanzi, Hanyu_Pinyin, Regional_Population, GDP) VALUES (2, 'Shanghai', '上海', 'Shànghǎi', 24280000, 3815.5);
INSERT INTO city (City_ID, City, Hanzi, Hanyu_Pinyin, Regional_Population, GDP) VALUES (3, 'Guangzhou', '广州', 'Guǎngzhōu', 15300000, 2362.8);
INSERT INTO match (Match_ID, Date, Venue, Score, Result, Competition) VALUES (10, '2020-05-01', 'Workers Stadium', '2-1', 'Win', 'Cup');
INSERT INTO match (Match_ID, Date, Venue, Score, Result, Competition) VALUES (50, '2021-06-15', 'Shanghai Stadium', '0-0', 'Draw', 'League');
INSERT INTO match (Match_ID, Date, Venue, Score, Result, Competition) VALUES (30, '2022-07-20', 'Tianhe Stadium', '1-3', 'Loss', 'Friendly');
INSERT INTO hosting_city (Year, Match_ID, Host_City) VALUES (2020, 10, '1');
INSERT INTO hosting_city (Year, Match_ID, Host_City) VALUES (2021, 50, '2');
INSERT INTO hosting_city (Year, Match_ID, Host_City) VALUES (2022, 30, '3');
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT host_city FROM (SELECT * FROM (SELECT * FROM hosting_city ORDER BY match_id DESC, hosting_city.year NULLS LAST) LIMIT 1);

/*
Gold Result:
('2',)
*/

-- Prediction Query
SELECT host_city FROM hosting_city ORDER BY YEAR DESC LIMIT 1;

/*
Prediction Result:
('3',)
*/