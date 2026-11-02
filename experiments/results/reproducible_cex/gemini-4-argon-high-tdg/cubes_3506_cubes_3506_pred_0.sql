-- Schema DDL
CREATE TABLE "flight" ("flno" REAL(4, 0) PRIMARY KEY, "aid" REAL(9, 0), "origin" TEXT(20), "destination" TEXT(20), "distance" REAL(6, 0), "departure_date" DATE, "arrival_date" DATE, "price" REAL(7, 2), FOREIGN KEY ("aid") REFERENCES "aircraft" ("aid"));

CREATE TABLE "aircraft" ("aid" REAL(9, 0) PRIMARY KEY, "name" TEXT(30), "distance" REAL(6, 0));

CREATE TABLE "employee" ("eid" REAL(9, 0) PRIMARY KEY, "name" TEXT(30), "salary" REAL(10, 2));

CREATE TABLE "certificate" ("eid" REAL(9, 0), "aid" REAL(9, 0), PRIMARY KEY ("eid", "aid"), FOREIGN KEY ("aid") REFERENCES "aircraft" ("aid"), FOREIGN KEY ("eid") REFERENCES "employee" ("eid"));

-- Loading data
PRAGMA foreign_keys = OFF;
-- DATASET 2
INSERT INTO aircraft (aid, name, distance) VALUES (30, NULL, 8000);
INSERT INTO aircraft (aid, name, distance) VALUES (10, 'Zulu Jet', 8000);
INSERT INTO aircraft (aid, name, distance) VALUES (40, 'Delta Wing', 4000);
INSERT INTO aircraft (aid, name, distance) VALUES (20, 'Alpha Liner', 8000);
INSERT INTO aircraft (aid, name, distance) VALUES (50, 'Beta Craft', 2000);
INSERT INTO employee (eid, name, salary) VALUES (1, 'Pilot One', 120000.00);
INSERT INTO employee (eid, name, salary) VALUES (2, 'Pilot Two', 110000.00);
INSERT INTO certificate (eid, aid) VALUES (1, 10);
INSERT INTO certificate (eid, aid) VALUES (2, 10);
INSERT INTO certificate (eid, aid) VALUES (1, 20);
INSERT INTO certificate (eid, aid) VALUES (1, 30);
INSERT INTO flight (flno, aid, origin, destination, distance, departure_date, arrival_date, price) VALUES (100, 10, 'LAX', 'SYD', 7500, '2023-06-01', '2023-06-02', 1200.00);
INSERT INTO flight (flno, aid, origin, destination, distance, departure_date, arrival_date, price) VALUES (101, 10, 'SYD', 'LAX', 7500, '2023-06-05', '2023-06-06', 1250.00);
INSERT INTO flight (flno, aid, origin, destination, distance, departure_date, arrival_date, price) VALUES (102, 20, 'JFK', 'LHR', 3500, '2023-06-10', '2023-06-11', 800.00);
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT DISTINCT aid, name FROM (SELECT LHS.aid AS aid, LHS.name AS name, LHS.distance AS distance, LHS.maxdistance AS maxdistance, RHS.aid AS aid_other, RHS.name AS name_other, RHS.distance AS distance_other, RHS.maxdistance AS maxdistance_other FROM (SELECT aid, name, distance, MAX(distance) OVER () AS maxdistance FROM aircraft) AS LHS CROSS JOIN (SELECT aid, name, distance, MAX(distance) OVER () AS maxdistance FROM aircraft) AS RHS) WHERE (distance = maxdistance_other OR distance_other > maxdistance_other) ORDER BY aid, name NULLS LAST;

/*
Gold Result:
(10.0, 'Zulu Jet')
(20.0, 'Alpha Liner')
(30.0, None)
*/

-- Prediction Query
SELECT aid, name FROM Aircraft ORDER BY distance DESC, Aircraft.aid NULLS LAST LIMIT 1;

/*
Prediction Result:
(10.0, 'Zulu Jet')
*/