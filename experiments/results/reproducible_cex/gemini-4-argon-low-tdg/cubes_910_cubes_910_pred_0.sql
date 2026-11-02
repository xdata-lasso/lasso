-- Schema DDL
CREATE TABLE "flight" ("flno" REAL(4, 0) PRIMARY KEY, "aid" REAL(9, 0), "origin" TEXT(20), "destination" TEXT(20), "distance" REAL(6, 0), "departure_date" DATE, "arrival_date" DATE, "price" REAL(7, 2), FOREIGN KEY ("aid") REFERENCES "aircraft" ("aid"));

CREATE TABLE "aircraft" ("aid" REAL(9, 0) PRIMARY KEY, "name" TEXT(30), "distance" REAL(6, 0));

CREATE TABLE "employee" ("eid" REAL(9, 0) PRIMARY KEY, "name" TEXT(30), "salary" REAL(10, 2));

CREATE TABLE "certificate" ("eid" REAL(9, 0), "aid" REAL(9, 0), PRIMARY KEY ("eid", "aid"), FOREIGN KEY ("aid") REFERENCES "aircraft" ("aid"), FOREIGN KEY ("eid") REFERENCES "employee" ("eid"));

-- Loading data
PRAGMA foreign_keys = OFF;
-- DATASET 1
INSERT INTO aircraft (aid, name, distance) VALUES (1, 'Boeing 747', 8000);
INSERT INTO aircraft (aid, name, distance) VALUES (2, 'Airbus A320', 3000);
INSERT INTO employee (eid, name, salary) VALUES (101, 'John Doe', 95000.00);
INSERT INTO certificate (eid, aid) VALUES (101, 1);
INSERT INTO flight (flno, aid, origin, destination, distance, departure_date, arrival_date, price) VALUES (300, 1, 'Los Angeles', 'New York', 2500, '2023-05-01', '2023-05-02', 450.00);
INSERT INTO flight (flno, aid, origin, destination, distance, departure_date, arrival_date, price) VALUES (100, 2, 'Chicago', 'Miami', 1200, '2023-06-10', '2023-06-10', 220.50);
INSERT INTO flight (flno, aid, origin, destination, distance, departure_date, arrival_date, price) VALUES (200, 1, 'Boston', 'Seattle', 3000, '2023-04-15', '2023-04-16', 600.75);
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT flno, origin, destination FROM flight ORDER BY flno;

/*
Gold Result:
(100.0, 'Chicago', 'Miami')
(200.0, 'Boston', 'Seattle')
(300.0, 'Los Angeles', 'New York')
*/

-- Prediction Query
SELECT flno, origin, destination FROM Flight ORDER BY origin, Flight.flno NULLS LAST;

/*
Prediction Result:
(200.0, 'Boston', 'Seattle')
(100.0, 'Chicago', 'Miami')
(300.0, 'Los Angeles', 'New York')
*/