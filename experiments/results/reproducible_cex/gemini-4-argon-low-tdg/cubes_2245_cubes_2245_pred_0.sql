-- Schema DDL
CREATE TABLE "city" ("City_ID" INTEGER PRIMARY KEY, "City" TEXT, "Hanzi" TEXT, "Hanyu_Pinyin" TEXT, "Regional_Population" INTEGER, "GDP" REAL);

CREATE TABLE "match" ("Match_ID" INTEGER PRIMARY KEY, "Date" TEXT, "Venue" TEXT, "Score" TEXT, "Result" TEXT, "Competition" TEXT);

CREATE TABLE "temperature" ("City_ID" INTEGER PRIMARY KEY, "Jan" REAL, "Feb" REAL, "Mar" REAL, "Apr" REAL, "Jun" REAL, "Jul" REAL, "Aug" REAL, "Sep" REAL, "Oct" REAL, "Nov" REAL, "Dec" REAL, FOREIGN KEY ("City_ID") REFERENCES "city" ("City_ID"));

CREATE TABLE "hosting_city" ("Year" INTEGER PRIMARY KEY, "Match_ID" INTEGER, "Host_City" TEXT, FOREIGN KEY ("Match_ID") REFERENCES "match" ("Match_ID"), FOREIGN KEY ("Host_City") REFERENCES "city" ("City_ID"));

-- Loading data
PRAGMA foreign_keys = OFF;
-- DATASET 2
INSERT INTO "match" ("Match_ID", "Date", "Venue", "Score", "Result", "Competition") VALUES (10, '2023-06-01', 'Olympic Park', '1-0', 'Win', 'Qualifier');
INSERT INTO "match" ("Match_ID", "Date", "Venue", "Score", "Result", "Competition") VALUES (20, '2023-06-02', NULL, '0-0', 'Draw', 'Qualifier');
INSERT INTO "match" ("Match_ID", "Date", "Venue", "Score", "Result", "Competition") VALUES (30, '2023-06-03', '', '2-2', 'Draw', 'Friendly');
INSERT INTO "match" ("Match_ID", "Date", "Venue", "Score", "Result", "Competition") VALUES (40, '2023-06-04', 'National Stadium', '3-1', 'Win', 'Final');
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT venue FROM match ORDER BY venue, match.match_id NULLS LAST;

/*
Gold Result:
(None,)
('',)
('National Stadium',)
('Olympic Park',)
*/

-- Prediction Query
SELECT venue FROM MATCH ORDER BY date DESC, MATCH.match_id NULLS LAST;

/*
Prediction Result:
('National Stadium',)
('',)
(None,)
('Olympic Park',)
*/