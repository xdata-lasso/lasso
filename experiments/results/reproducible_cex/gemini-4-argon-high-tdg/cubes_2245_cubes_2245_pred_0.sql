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
INSERT INTO match (Match_ID, Date, Venue, Score, Result, Competition) VALUES (1, '2021-05-10', 'Zenith Arena', '2-1', 'Win', 'Cup');
INSERT INTO match (Match_ID, Date, Venue, Score, Result, Competition) VALUES (2, '2021-03-15', 'Alpha Stadium', '0-0', 'Draw', 'League');
INSERT INTO match (Match_ID, Date, Venue, Score, Result, Competition) VALUES (3, '2021-04-20', 'Beta Field', '1-3', 'Loss', 'Friendly');
INSERT INTO match (Match_ID, Date, Venue, Score, Result, Competition) VALUES (4, '2021-06-01', 'Alpha Stadium', '3-0', 'Win', 'Qualifier');
INSERT INTO temperature (City_ID, Jan, Feb, Mar, Apr, Jun, Jul, Aug, Sep, Oct, Nov, Dec) VALUES (1, -3.1, 0.3, 6.7, 14.8, 24.7, 26.7, 25.5, 20.4, 13.1, 4.3, -1.5);
INSERT INTO hosting_city (Year, Match_ID, Host_City) VALUES (2020, 1, '1');
INSERT INTO hosting_city (Year, Match_ID, Host_City) VALUES (2021, 1, '2');
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT venue FROM match ORDER BY venue, match.match_id NULLS LAST;

/*
Gold Result:
('Alpha Stadium',)
('Alpha Stadium',)
('Beta Field',)
('Zenith Arena',)
*/

-- Prediction Query
SELECT venue FROM MATCH ORDER BY date DESC, MATCH.match_id NULLS LAST;

/*
Prediction Result:
('Alpha Stadium',)
('Zenith Arena',)
('Beta Field',)
('Alpha Stadium',)
*/