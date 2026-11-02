-- Schema DDL
CREATE TABLE "singer" ("Singer_ID" INTEGER PRIMARY KEY, "Name" TEXT, "Birth_Year" REAL, "Net_Worth_Millions" REAL, "Citizenship" TEXT);

CREATE TABLE "song" ("Song_ID" INTEGER PRIMARY KEY, "Singer_ID" INTEGER, "Title" TEXT, "Sales" REAL, "Highest_Position" REAL, FOREIGN KEY ("Singer_ID") REFERENCES "singer" ("Singer_ID"));

-- Loading data
PRAGMA foreign_keys = OFF;
INSERT INTO "singer" ("Singer_ID", "Name", "Birth_Year", "Net_Worth_Millions", "Citizenship") VALUES (1, 'Alice', 2000.0, 10.0, 'USA');
INSERT INTO "singer" ("Singer_ID", "Name", "Birth_Year", "Net_Worth_Millions", "Citizenship") VALUES (2, 'Bob', 1990.0, 20.0, 'UK');
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT birth_year, citizenship FROM singer ORDER BY birth_year, singer.singer_id NULLS LAST;

/*
Gold Result:
(1990.0, 'UK')
(2000.0, 'USA')
*/

-- Prediction Query
SELECT Birth_Year, Citizenship FROM singer;

/*
Prediction Result:
(2000.0, 'USA')
(1990.0, 'UK')
*/