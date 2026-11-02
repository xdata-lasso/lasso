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
INSERT INTO temperature (City_ID, Jan, Feb, Mar, Apr, Jun, Jul, Aug, Sep, Oct, Nov, Dec) VALUES (1, -3.1, 0.3, 6.7, 14.8, 24.9, 26.7, 25.5, 20.4, 13.0, 4.3, -1.7);
INSERT INTO temperature (City_ID, Jan, Feb, Mar, Apr, Jun, Jul, Aug, Sep, Oct, Nov, Dec) VALUES (2, 4.8, 6.6, 10.4, 15.8, 24.5, 28.8, 28.3, 24.3, 19.2, 13.3, 7.0);
INSERT INTO match (Match_ID, Date, Venue, Score, Result, Competition) VALUES (1, '2021-01-10', 'Workers Stadium', '2-1', 'Win', 'World Cup Qualifier');
INSERT INTO match (Match_ID, Date, Venue, Score, Result, Competition) VALUES (2, '2021-02-15', 'Shanghai Stadium', '1-1', 'Draw', 'Asian Cup');
INSERT INTO match (Match_ID, Date, Venue, Score, Result, Competition) VALUES (3, '2021-02-20', 'Workers Stadium', '0-2', 'Loss', 'Asian Cup');
INSERT INTO match (Match_ID, Date, Venue, Score, Result, Competition) VALUES (4, '2021-03-05', 'Shanghai Stadium', '3-0', 'Win', 'Friendly');
INSERT INTO match (Match_ID, Date, Venue, Score, Result, Competition) VALUES (5, '2021-03-12', 'Workers Stadium', '1-0', 'Win', 'Friendly');
INSERT INTO match (Match_ID, Date, Venue, Score, Result, Competition) VALUES (6, '2021-04-01', 'Workers Stadium', '2-2', 'Draw', 'EAFF Championship');
INSERT INTO match (Match_ID, Date, Venue, Score, Result, Competition) VALUES (7, '2021-04-01', 'Workers Stadium', '2-2', 'Draw', 'EAFF Championship');
INSERT INTO match (Match_ID, Date, Venue, Score, Result, Competition) VALUES (8, '2021-04-08', 'Shanghai Stadium', '0-1', 'Loss', 'EAFF Championship');
INSERT INTO hosting_city (Year, Match_ID, Host_City) VALUES (2021, 1, '1');
INSERT INTO hosting_city (Year, Match_ID, Host_City) VALUES (2022, 1, '2');
INSERT INTO hosting_city (Year, Match_ID, Host_City) VALUES (2023, 2, '2');
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT n AS count___, competition FROM (SELECT competition, COUNT(*) AS n FROM match GROUP BY competition) ORDER BY count___, competition NULLS LAST;

/*
Gold Result:
(1, 'World Cup Qualifier')
(2, 'Asian Cup')
(2, 'Friendly')
(3, 'EAFF Championship')
*/

-- Prediction Query
SELECT COUNT(*), Competition FROM MATCH GROUP BY Competition;

/*
Prediction Result:
(2, 'Asian Cup')
(3, 'EAFF Championship')
(2, 'Friendly')
(1, 'World Cup Qualifier')
*/