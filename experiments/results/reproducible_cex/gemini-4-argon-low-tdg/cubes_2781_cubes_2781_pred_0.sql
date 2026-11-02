-- Schema DDL
CREATE TABLE "entrepreneur" ("Entrepreneur_ID" INTEGER PRIMARY KEY, "People_ID" INTEGER, "Company" TEXT, "Money_Requested" REAL, "Investor" TEXT, FOREIGN KEY ("People_ID") REFERENCES "people" ("People_ID"));

CREATE TABLE "people" ("People_ID" INTEGER PRIMARY KEY, "Name" TEXT, "Height" REAL, "Weight" REAL, "Date_of_Birth" TEXT);

-- Loading data
PRAGMA foreign_keys = OFF;
-- DATASET 1
-- Tests empty entrepreneur table (Window COUNT(*) OVER () returns 0 rows vs scalar aggregate COUNT(*) which returns 1 row with 0).
INSERT INTO "people" ("People_ID", "Name", "Height", "Weight", "Date_of_Birth") VALUES (1, 'Alice', 165.0, 60.0, '1990-01-01');
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT DISTINCT COUNT(*) OVER () AS count_distinct_company_ FROM entrepreneur ORDER BY count_distinct_company_;

/*
Gold Result:
*/

-- Prediction Query
SELECT COUNT(DISTINCT Company) FROM entrepreneur;

/*
Prediction Result:
(0,)
*/