-- Schema DDL
CREATE TABLE "singer" ("Singer_ID" INTEGER PRIMARY KEY, "Name" TEXT, "Birth_Year" REAL, "Net_Worth_Millions" REAL, "Citizenship" TEXT);

CREATE TABLE "song" ("Song_ID" INTEGER PRIMARY KEY, "Singer_ID" INTEGER, "Title" TEXT, "Sales" REAL, "Highest_Position" REAL, FOREIGN KEY ("Singer_ID") REFERENCES "singer" ("Singer_ID"));

-- Loading data
PRAGMA foreign_keys = OFF;
INSERT INTO "singer" ("singer_id", "name", "birth_year", "net_worth_millions", "citizenship") VALUES (1033, 'Maria Lynch', 1948.0, 1034.5, 'Congress');
INSERT INTO "singer" ("singer_id", "name", "birth_year", "net_worth_millions", "citizenship") VALUES (1035, 'Margaret Hawkins DDS', 1948.0, 1035.5, 'expect');
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT name FROM singer WHERE (birth_year >= 1948.0 AND birth_year <= 1949.0) ORDER BY name, singer.singer_id NULLS LAST;

/*
Gold Result:
('Margaret Hawkins DDS',)
('Maria Lynch',)
*/

-- Prediction Query
SELECT Name FROM singer WHERE Birth_Year = 1948 OR Birth_Year = 1949;

/*
Prediction Result:
('Maria Lynch',)
('Margaret Hawkins DDS',)
*/