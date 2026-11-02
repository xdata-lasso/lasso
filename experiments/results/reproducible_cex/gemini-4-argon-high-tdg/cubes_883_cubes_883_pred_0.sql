-- Schema DDL
CREATE TABLE "flight" ("flno" REAL(4, 0) PRIMARY KEY, "aid" REAL(9, 0), "origin" TEXT(20), "destination" TEXT(20), "distance" REAL(6, 0), "departure_date" DATE, "arrival_date" DATE, "price" REAL(7, 2), FOREIGN KEY ("aid") REFERENCES "aircraft" ("aid"));

CREATE TABLE "aircraft" ("aid" REAL(9, 0) PRIMARY KEY, "name" TEXT(30), "distance" REAL(6, 0));

CREATE TABLE "employee" ("eid" REAL(9, 0) PRIMARY KEY, "name" TEXT(30), "salary" REAL(10, 2));

CREATE TABLE "certificate" ("eid" REAL(9, 0), "aid" REAL(9, 0), PRIMARY KEY ("eid", "aid"), FOREIGN KEY ("aid") REFERENCES "aircraft" ("aid"), FOREIGN KEY ("eid") REFERENCES "employee" ("eid"));

-- Loading data
PRAGMA foreign_keys = OFF;
-- DATASET 1
INSERT INTO aircraft (aid, name, distance) VALUES (1, 'Boeing 737', 3000);
INSERT INTO flight (flno, aid, origin, destination, distance, departure_date, arrival_date, price) VALUES (101, 1, 'AAA', 'LAX', 1000, '2023-05-01', '2023-05-01', 200.00);
INSERT INTO flight (flno, aid, origin, destination, distance, departure_date, arrival_date, price) VALUES (102, 1, 'ZZZ', 'LAX', 1000, '2023-05-01', '2023-05-01', 200.00);
INSERT INTO flight (flno, aid, origin, destination, distance, departure_date, arrival_date, price) VALUES (103, 1, 'ZZZ', 'LAX', 1000, '2023-05-01', '2023-05-01', 200.00);
INSERT INTO flight (flno, aid, origin, destination, distance, departure_date, arrival_date, price) VALUES (104, 1, 'BBB', 'LAX', 1000, '2023-05-01', '2023-05-01', 200.00);
INSERT INTO flight (flno, aid, origin, destination, distance, departure_date, arrival_date, price) VALUES (105, 1, 'BBB', 'LAX', 1000, '2023-05-01', '2023-05-01', 200.00);
INSERT INTO flight (flno, aid, origin, destination, distance, departure_date, arrival_date, price) VALUES (106, 1, 'BBB', 'LAX', 1000, '2023-05-01', '2023-05-01', 200.00);
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT origin_other AS origin FROM (SELECT LHS.departure_date AS departure_date, LHS.origin AS origin, LHS.n AS n, RHS.departure_date AS departure_date_other, RHS.origin AS origin_other, RHS.n AS n_other FROM (SELECT departure_date, origin, COUNT(*) AS n FROM flight GROUP BY departure_date, origin) AS LHS CROSS JOIN (SELECT departure_date, origin, COUNT(*) AS n FROM flight GROUP BY departure_date, origin) AS RHS) WHERE (n < n_other) ORDER BY origin;

/*
Gold Result:
('BBB',)
('BBB',)
('ZZZ',)
*/

-- Prediction Query
SELECT origin FROM Flight GROUP BY origin ORDER BY COUNT(*) DESC, origin NULLS LAST LIMIT 1;

/*
Prediction Result:
('BBB',)
*/