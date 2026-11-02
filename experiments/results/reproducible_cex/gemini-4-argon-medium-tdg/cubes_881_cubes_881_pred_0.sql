-- Schema DDL
CREATE TABLE "flight" ("flno" REAL(4, 0) PRIMARY KEY, "aid" REAL(9, 0), "origin" TEXT(20), "destination" TEXT(20), "distance" REAL(6, 0), "departure_date" DATE, "arrival_date" DATE, "price" REAL(7, 2), FOREIGN KEY ("aid") REFERENCES "aircraft" ("aid"));

CREATE TABLE "aircraft" ("aid" REAL(9, 0) PRIMARY KEY, "name" TEXT(30), "distance" REAL(6, 0));

CREATE TABLE "employee" ("eid" REAL(9, 0) PRIMARY KEY, "name" TEXT(30), "salary" REAL(10, 2));

CREATE TABLE "certificate" ("eid" REAL(9, 0), "aid" REAL(9, 0), PRIMARY KEY ("eid", "aid"), FOREIGN KEY ("aid") REFERENCES "aircraft" ("aid"), FOREIGN KEY ("eid") REFERENCES "employee" ("eid"));

-- Loading data
PRAGMA foreign_keys = OFF;
-- DATASET 1
-- Tests LIMIT boundary (10 rows vs LIMIT 7), ORDER BY direction (DESC vs ASC), and ensures insertion order / aid order / alphabetical name order do not match distance order.
-- Also includes disconnected rows and orphaned foreign keys (conceptually, via flight/certificate) to catch unintended JOINs.
INSERT INTO aircraft (aid, name, distance) VALUES (1, 'Aircraft_E', 5000);
INSERT INTO aircraft (aid, name, distance) VALUES (2, 'Aircraft_I', 1000);
INSERT INTO aircraft (aid, name, distance) VALUES (3, 'Aircraft_A', 9000);
INSERT INTO aircraft (aid, name, distance) VALUES (4, 'Aircraft_G', 3000);
INSERT INTO aircraft (aid, name, distance) VALUES (5, 'Aircraft_C', 7000);
INSERT INTO aircraft (aid, name, distance) VALUES (6, 'Aircraft_J', 500);
INSERT INTO aircraft (aid, name, distance) VALUES (7, 'Aircraft_B', 8000);
INSERT INTO aircraft (aid, name, distance) VALUES (8, 'Aircraft_H', 2000);
INSERT INTO aircraft (aid, name, distance) VALUES (9, 'Aircraft_D', 6000);
INSERT INTO aircraft (aid, name, distance) VALUES (10, 'Aircraft_F', 4000);
INSERT INTO employee (eid, name, salary) VALUES (101, 'John Doe', 85000.00);
INSERT INTO certificate (eid, aid) VALUES (101, 2);
INSERT INTO certificate (eid, aid) VALUES (101, 4);
INSERT INTO flight (flno, aid, origin, destination, distance, departure_date, arrival_date, price) VALUES (1001, 2, 'NYC', 'LAX', 99999, '2023-01-01', '2023-01-02', 500.00);
INSERT INTO flight (flno, aid, origin, destination, distance, departure_date, arrival_date, price) VALUES (1002, 3, 'NYC', 'BOS', 100, '2023-01-01', '2023-01-02', 150.00);
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT name FROM (SELECT * FROM (SELECT * FROM (SELECT aid, name, AVG(distance) AS meandistance FROM aircraft GROUP BY aid, name) ORDER BY meandistance DESC) LIMIT 7);

/*
Gold Result:
('Aircraft_A',)
('Aircraft_B',)
('Aircraft_C',)
('Aircraft_D',)
('Aircraft_E',)
('Aircraft_F',)
('Aircraft_G',)
*/

-- Prediction Query
SELECT name FROM Aircraft WHERE distance > (SELECT AVG(distance) FROM Aircraft);

/*
Prediction Result:
('Aircraft_E',)
('Aircraft_A',)
('Aircraft_C',)
('Aircraft_B',)
('Aircraft_D',)
*/