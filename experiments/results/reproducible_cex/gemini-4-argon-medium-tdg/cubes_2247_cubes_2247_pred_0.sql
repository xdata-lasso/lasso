-- Schema DDL
CREATE TABLE "city" ("City_ID" INTEGER PRIMARY KEY, "City" TEXT, "Hanzi" TEXT, "Hanyu_Pinyin" TEXT, "Regional_Population" INTEGER, "GDP" REAL);

CREATE TABLE "match" ("Match_ID" INTEGER PRIMARY KEY, "Date" TEXT, "Venue" TEXT, "Score" TEXT, "Result" TEXT, "Competition" TEXT);

CREATE TABLE "temperature" ("City_ID" INTEGER PRIMARY KEY, "Jan" REAL, "Feb" REAL, "Mar" REAL, "Apr" REAL, "Jun" REAL, "Jul" REAL, "Aug" REAL, "Sep" REAL, "Oct" REAL, "Nov" REAL, "Dec" REAL, FOREIGN KEY ("City_ID") REFERENCES "city" ("City_ID"));

CREATE TABLE "hosting_city" ("Year" INTEGER PRIMARY KEY, "Match_ID" INTEGER, "Host_City" TEXT, FOREIGN KEY ("Match_ID") REFERENCES "match" ("Match_ID"), FOREIGN KEY ("Host_City") REFERENCES "city" ("City_ID"));

-- Loading data
PRAGMA foreign_keys = OFF;
-- DATASET 1
INSERT INTO city (City_ID, City, Hanzi, Hanyu_Pinyin, Regional_Population, GDP) VALUES (101, 'Beijing', '北京', 'Běijīng', 21540000, 3537.1);
INSERT INTO city (City_ID, City, Hanzi, Hanyu_Pinyin, Regional_Population, GDP) VALUES (102, 'Shanghai', '上海', 'Shànghǎi', 24280000, 3815.5);
INSERT INTO city (City_ID, City, Hanzi, Hanyu_Pinyin, Regional_Population, GDP) VALUES (103, 'Guangzhou', '广州', 'Guǎngzhōu', 15300000, 2362.8);
INSERT INTO match (Match_ID, Date, Venue, Score, Result, Competition) VALUES (1, '2020-05-01', 'Stadium A', '1-0', 'Win', 'Cup');
INSERT INTO match (Match_ID, Date, Venue, Score, Result, Competition) VALUES (5, '2020-06-01', 'Stadium B', '2-2', 'Draw', 'League');
INSERT INTO match (Match_ID, Date, Venue, Score, Result, Competition) VALUES (10, '2020-07-01', 'Stadium C', '0-1', 'Loss', 'Friendly');
INSERT INTO hosting_city (Year, Match_ID, Host_City) VALUES (2018, 5, '102');
INSERT INTO hosting_city (Year, Match_ID, Host_City) VALUES (2019, 10, '103');
INSERT INTO hosting_city (Year, Match_ID, Host_City) VALUES (2020, 1, '101');
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT host_city FROM (SELECT * FROM (SELECT * FROM hosting_city ORDER BY match_id DESC, hosting_city.year NULLS LAST) LIMIT 1);

/*
Gold Result:
('103',)
*/

-- Prediction Query
SELECT host_city FROM hosting_city ORDER BY YEAR DESC LIMIT 1;

/*
Prediction Result:
('101',)
*/