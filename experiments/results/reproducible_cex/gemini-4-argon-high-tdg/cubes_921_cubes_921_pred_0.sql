-- Schema DDL
CREATE TABLE "flight" ("flno" REAL(4, 0) PRIMARY KEY, "aid" REAL(9, 0), "origin" TEXT(20), "destination" TEXT(20), "distance" REAL(6, 0), "departure_date" DATE, "arrival_date" DATE, "price" REAL(7, 2), FOREIGN KEY ("aid") REFERENCES "aircraft" ("aid"));

CREATE TABLE "aircraft" ("aid" REAL(9, 0) PRIMARY KEY, "name" TEXT(30), "distance" REAL(6, 0));

CREATE TABLE "employee" ("eid" REAL(9, 0) PRIMARY KEY, "name" TEXT(30), "salary" REAL(10, 2));

CREATE TABLE "certificate" ("eid" REAL(9, 0), "aid" REAL(9, 0), PRIMARY KEY ("eid", "aid"), FOREIGN KEY ("aid") REFERENCES "aircraft" ("aid"), FOREIGN KEY ("eid") REFERENCES "employee" ("eid"));

-- Loading data
PRAGMA foreign_keys = OFF;
-- DATASET 2
INSERT INTO aircraft (aid, name, distance) VALUES (1, 'Boeing 737', 3000);
INSERT INTO flight (flno, aid, origin, destination, distance, departure_date, arrival_date, price) VALUES (101, 1, 'Los Angeles', 'New York', 2450, '2023-07-01', '2023-07-01', 350.00);
INSERT INTO flight (flno, aid, origin, destination, distance, departure_date, arrival_date, price) VALUES (102, 1, 'San Francisco', 'Honolulu', 2400, '2023-07-02', '2023-07-02', 450.00);
INSERT INTO flight (flno, aid, origin, destination, distance, departure_date, arrival_date, price) VALUES (103, 1, 'Honolulu', 'Los Angeles', 2550, '2023-07-03', '2023-07-03', 550.00);
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