-- Schema DDL
CREATE TABLE "entrepreneur" ("Entrepreneur_ID" INTEGER PRIMARY KEY, "People_ID" INTEGER, "Company" TEXT, "Money_Requested" REAL, "Investor" TEXT, FOREIGN KEY ("People_ID") REFERENCES "people" ("People_ID"));

CREATE TABLE "people" ("People_ID" INTEGER PRIMARY KEY, "Name" TEXT, "Height" REAL, "Weight" REAL, "Date_of_Birth" TEXT);

-- Loading data
PRAGMA foreign_keys = OFF;
-- DATASET 1
-- Empty entrepreneur table: Window function COUNT(*) OVER () returns 0 rows, whereas a standard aggregate COUNT(*) returns 1 row with value 0.
INSERT INTO people (People_ID, Name, Height, Weight, Date_of_Birth) VALUES (1, 'John Doe', 180.0, 75.0, '1980-01-01');
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT DISTINCT COUNT(*) OVER () AS count___ FROM entrepreneur ORDER BY count___;

/*
Gold Result:
*/

-- Prediction Query
SELECT COUNT(*) FROM entrepreneur;

/*
Prediction Result:
(0,)
*/