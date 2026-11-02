-- Schema DDL
CREATE TABLE "city" ("City_ID" INTEGER PRIMARY KEY, "City" TEXT, "Hanzi" TEXT, "Hanyu_Pinyin" TEXT, "Regional_Population" INTEGER, "GDP" REAL);

CREATE TABLE "match" ("Match_ID" INTEGER PRIMARY KEY, "Date" TEXT, "Venue" TEXT, "Score" TEXT, "Result" TEXT, "Competition" TEXT);

CREATE TABLE "temperature" ("City_ID" INTEGER PRIMARY KEY, "Jan" REAL, "Feb" REAL, "Mar" REAL, "Apr" REAL, "Jun" REAL, "Jul" REAL, "Aug" REAL, "Sep" REAL, "Oct" REAL, "Nov" REAL, "Dec" REAL, FOREIGN KEY ("City_ID") REFERENCES "city" ("City_ID"));

CREATE TABLE "hosting_city" ("Year" INTEGER PRIMARY KEY, "Match_ID" INTEGER, "Host_City" TEXT, FOREIGN KEY ("Match_ID") REFERENCES "match" ("Match_ID"), FOREIGN KEY ("Host_City") REFERENCES "city" ("City_ID"));

-- Loading data
PRAGMA foreign_keys = OFF;
INSERT INTO "city" ("City_ID", "City") VALUES (1, 'CityA');
INSERT INTO "city" ("City_ID", "City") VALUES (2, 'CityB');
INSERT INTO "match" ("Match_ID", "Date") VALUES (1, '2001-01-01');
INSERT INTO "match" ("Match_ID", "Date") VALUES (2, '2000-01-01');
INSERT INTO "hosting_city" ("Year", "Match_ID", "Host_City") VALUES (2000, 2, 1);
INSERT INTO "hosting_city" ("Year", "Match_ID", "Host_City") VALUES (2001, 1, 2);
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT host_city FROM (SELECT * FROM (SELECT * FROM hosting_city ORDER BY match_id DESC, hosting_city.year NULLS LAST) LIMIT 1);

/*
Gold Result:
('1',)
*/

-- Prediction Query
SELECT host_city FROM hosting_city ORDER BY YEAR DESC LIMIT 1;

/*
Prediction Result:
('2',)
*/