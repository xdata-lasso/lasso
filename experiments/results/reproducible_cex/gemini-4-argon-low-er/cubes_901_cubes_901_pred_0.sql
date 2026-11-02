-- Schema DDL
CREATE TABLE "flight" ("flno" REAL(4, 0) PRIMARY KEY, "aid" REAL(9, 0), "origin" TEXT(20), "destination" TEXT(20), "distance" REAL(6, 0), "departure_date" DATE, "arrival_date" DATE, "price" REAL(7, 2), FOREIGN KEY ("aid") REFERENCES "aircraft" ("aid"));

CREATE TABLE "aircraft" ("aid" REAL(9, 0) PRIMARY KEY, "name" TEXT(30), "distance" REAL(6, 0));

CREATE TABLE "employee" ("eid" REAL(9, 0) PRIMARY KEY, "name" TEXT(30), "salary" REAL(10, 2));

CREATE TABLE "certificate" ("eid" REAL(9, 0), "aid" REAL(9, 0), PRIMARY KEY ("eid", "aid"), FOREIGN KEY ("aid") REFERENCES "aircraft" ("aid"), FOREIGN KEY ("eid") REFERENCES "employee" ("eid"));

-- Loading data
PRAGMA foreign_keys = OFF;
INSERT INTO "aircraft" ("aid", "name", "distance") VALUES (1, 'Boeing 747', 5000);
INSERT INTO "flight" ("flno", "aid", "origin", "destination", "distance", "departure_date", "arrival_date", "price") VALUES (10, 1, 'NYC', 'LA', 3000, '2023-01-01', '2023-01-01', 300.00);
INSERT INTO "flight" ("flno", "aid", "origin", "destination", "distance", "departure_date", "arrival_date", "price") VALUES (20, 1, 'NYC', 'SF', 3000, '2023-01-01', '2023-01-01', 300.00);
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT destination FROM (SELECT * FROM (SELECT * FROM (SELECT destination, flno, COUNT(*) AS n FROM flight GROUP BY destination, flno) ORDER BY flno DESC) LIMIT 1);

/*
Gold Result:
('SF',)
*/

-- Prediction Query
SELECT destination FROM Flight GROUP BY destination ORDER BY COUNT(*), destination NULLS LAST LIMIT 1;

/*
Prediction Result:
('LA',)
*/