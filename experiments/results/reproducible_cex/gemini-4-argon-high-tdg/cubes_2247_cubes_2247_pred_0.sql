-- Schema DDL
CREATE TABLE "city" ("City_ID" INTEGER PRIMARY KEY, "City" TEXT, "Hanzi" TEXT, "Hanyu_Pinyin" TEXT, "Regional_Population" INTEGER, "GDP" REAL);

CREATE TABLE "match" ("Match_ID" INTEGER PRIMARY KEY, "Date" TEXT, "Venue" TEXT, "Score" TEXT, "Result" TEXT, "Competition" TEXT);

CREATE TABLE "temperature" ("City_ID" INTEGER PRIMARY KEY, "Jan" REAL, "Feb" REAL, "Mar" REAL, "Apr" REAL, "Jun" REAL, "Jul" REAL, "Aug" REAL, "Sep" REAL, "Oct" REAL, "Nov" REAL, "Dec" REAL, FOREIGN KEY ("City_ID") REFERENCES "city" ("City_ID"));

CREATE TABLE "hosting_city" ("Year" INTEGER PRIMARY KEY, "Match_ID" INTEGER, "Host_City" TEXT, FOREIGN KEY ("Match_ID") REFERENCES "match" ("Match_ID"), FOREIGN KEY ("Host_City") REFERENCES "city" ("City_ID"));

-- Loading data
PRAGMA foreign_keys = OFF;
-- DATASET 1
INSERT INTO city (City_ID, City, Hanzi, Hanyu_Pinyin, Regional_Population, GDP) VALUES (10, 'Beijing', '北京', 'Běijīng', 21500000, 3500.5);
INSERT INTO city (City_ID, City, Hanzi, Hanyu_Pinyin, Regional_Population, GDP) VALUES (20, 'Shanghai', '上海', 'Shànghǎi', 24200000, 3800.0);
INSERT INTO city (City_ID, City, Hanzi, Hanyu_Pinyin, Regional_Population, GDP) VALUES (30, 'Guangzhou', '广州', 'Guǎngzhōu', 14000000, 2300.2);
INSERT INTO city (City_ID, City, Hanzi, Hanyu_Pinyin, Regional_Population, GDP) VALUES (40, 'Shenzhen', '深圳', 'Shēnzhèn', 12500000, 2600.8);
INSERT INTO match (Match_ID, Date, Venue, Score, Result, Competition) VALUES (1, '2004-05-01', 'Stadium A', '1-0', 'Win', 'Cup');
INSERT INTO match (Match_ID, Date, Venue, Score, Result, Competition) VALUES (5, '2001-06-15', 'Stadium B', '2-2', 'Draw', 'League');
INSERT INTO match (Match_ID, Date, Venue, Score, Result, Competition) VALUES (9, '2003-08-20', 'Stadium C', '0-1', 'Loss', 'Friendly');
INSERT INTO match (Match_ID, Date, Venue, Score, Result, Competition) VALUES (10, '2002-10-10', 'Stadium D', '3-1', 'Win', 'Qualifier');
INSERT INTO match (Match_ID, Date, Venue, Score, Result, Competition) VALUES (99, '2005-12-12', 'Stadium E', '4-0', 'Win', 'Final');
INSERT INTO hosting_city (Year, Match_ID, Host_City) VALUES (2001, 5, '30');
INSERT INTO hosting_city (Year, Match_ID, Host_City) VALUES (2002, 10, '20');
INSERT INTO hosting_city (Year, Match_ID, Host_City) VALUES (2003, 9, '10');
INSERT INTO hosting_city (Year, Match_ID, Host_City) VALUES (2004, 1, '40');
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT host_city FROM (SELECT * FROM (SELECT * FROM hosting_city ORDER BY match_id DESC, hosting_city.year NULLS LAST) LIMIT 1);

/*
Gold Result:
('20',)
*/

-- Prediction Query
SELECT host_city FROM hosting_city ORDER BY YEAR DESC LIMIT 1;

/*
Prediction Result:
('40',)
*/