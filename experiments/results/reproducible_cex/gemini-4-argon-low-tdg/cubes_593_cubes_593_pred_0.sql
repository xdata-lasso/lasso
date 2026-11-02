-- Schema DDL
CREATE TABLE "singer" ("Singer_ID" INTEGER PRIMARY KEY, "Name" TEXT, "Birth_Year" REAL, "Net_Worth_Millions" REAL, "Citizenship" TEXT);

CREATE TABLE "song" ("Song_ID" INTEGER PRIMARY KEY, "Singer_ID" INTEGER, "Title" TEXT, "Sales" REAL, "Highest_Position" REAL, FOREIGN KEY ("Singer_ID") REFERENCES "singer" ("Singer_ID"));

-- Loading data
PRAGMA foreign_keys = OFF;
-- DATASET 1
-- Tests basic ordering by Birth_Year, tie-breaking by Singer_ID, duplicate rows (catches DISTINCT), and inner joins with song table (catches extraneous JOINs).
INSERT INTO "singer" ("Singer_ID", "Name", "Birth_Year", "Net_Worth_Millions", "Citizenship") VALUES (1, 'Alice', 1990.0, 10.5, 'USA');
INSERT INTO "singer" ("Singer_ID", "Name", "Birth_Year", "Net_Worth_Millions", "Citizenship") VALUES (2, 'Bob', 1985.0, 20.0, 'UK');
INSERT INTO "singer" ("Singer_ID", "Name", "Birth_Year", "Net_Worth_Millions", "Citizenship") VALUES (3, 'Charlie', 1985.0, 15.0, 'Canada');
INSERT INTO "singer" ("Singer_ID", "Name", "Birth_Year", "Net_Worth_Millions", "Citizenship") VALUES (4, 'David', 1990.0, 5.0, 'USA');
INSERT INTO "song" ("Song_ID", "Singer_ID", "Title", "Sales", "Highest_Position") VALUES (101, 1, 'Song A', 500000.0, 1.0);
INSERT INTO "song" ("Song_ID", "Singer_ID", "Title", "Sales", "Highest_Position") VALUES (102, 1, 'Song B', 300000.0, 5.0);
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT birth_year, citizenship FROM singer ORDER BY birth_year, singer.singer_id NULLS LAST;

/*
Gold Result:
(1985.0, 'UK')
(1985.0, 'Canada')
(1990.0, 'USA')
(1990.0, 'USA')
*/

-- Prediction Query
SELECT Birth_Year, Citizenship FROM singer;

/*
Prediction Result:
(1990.0, 'USA')
(1985.0, 'UK')
(1985.0, 'Canada')
(1990.0, 'USA')
*/