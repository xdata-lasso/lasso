-- Schema DDL
CREATE TABLE "flight" ("flno" REAL(4, 0) PRIMARY KEY, "aid" REAL(9, 0), "origin" TEXT(20), "destination" TEXT(20), "distance" REAL(6, 0), "departure_date" DATE, "arrival_date" DATE, "price" REAL(7, 2), FOREIGN KEY ("aid") REFERENCES "aircraft" ("aid"));

CREATE TABLE "aircraft" ("aid" REAL(9, 0) PRIMARY KEY, "name" TEXT(30), "distance" REAL(6, 0));

CREATE TABLE "employee" ("eid" REAL(9, 0) PRIMARY KEY, "name" TEXT(30), "salary" REAL(10, 2));

CREATE TABLE "certificate" ("eid" REAL(9, 0), "aid" REAL(9, 0), PRIMARY KEY ("eid", "aid"), FOREIGN KEY ("aid") REFERENCES "aircraft" ("aid"), FOREIGN KEY ("eid") REFERENCES "employee" ("eid"));

-- Loading data
PRAGMA foreign_keys = OFF;
-- DATASET 2
-- Empty result set when no rows match the WHERE clause (kills mutants dropping GROUP BY, which causes AVG to return a single row with NULL instead of 0 rows)
INSERT INTO "aircraft" ("aid", "name", "distance") VALUES (101, 'Boeing 747', 8000);
INSERT INTO "flight" ("flno", "aid", "origin", "destination", "distance", "departure_date", "arrival_date", "price") VALUES (1, 101, 'Los Angeles', 'Chicago', 1744, '2023-06-01', '2023-06-01', 350.00);
INSERT INTO "flight" ("flno", "aid", "origin", "destination", "distance", "departure_date", "arrival_date", "price") VALUES (2, 101, 'San Francisco', 'Honolulu', 2398, '2023-06-02', '2023-06-02', 450.00);
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT "meanprice" AS "avg_price_" FROM (SELECT "destination", "origin", AVG("price") AS "meanprice" FROM (SELECT * FROM "flight" WHERE ("origin" = 'Los Angeles' AND "destination" = 'Honolulu')) GROUP BY destination, origin) ORDER BY avg_price_;

/*
Gold Result:
*/

-- Prediction Query
SELECT AVG(price) FROM Flight WHERE origin = 'Los Angeles' AND destination = 'Honolulu';

/*
Prediction Result:
(None,)
*/