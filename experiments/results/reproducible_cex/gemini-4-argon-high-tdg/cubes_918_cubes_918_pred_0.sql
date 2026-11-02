-- Schema DDL
CREATE TABLE "flight" ("flno" REAL(4, 0) PRIMARY KEY, "aid" REAL(9, 0), "origin" TEXT(20), "destination" TEXT(20), "distance" REAL(6, 0), "departure_date" DATE, "arrival_date" DATE, "price" REAL(7, 2), FOREIGN KEY ("aid") REFERENCES "aircraft" ("aid"));

CREATE TABLE "aircraft" ("aid" REAL(9, 0) PRIMARY KEY, "name" TEXT(30), "distance" REAL(6, 0));

CREATE TABLE "employee" ("eid" REAL(9, 0) PRIMARY KEY, "name" TEXT(30), "salary" REAL(10, 2));

CREATE TABLE "certificate" ("eid" REAL(9, 0), "aid" REAL(9, 0), PRIMARY KEY ("eid", "aid"), FOREIGN KEY ("aid") REFERENCES "aircraft" ("aid"), FOREIGN KEY ("eid") REFERENCES "employee" ("eid"));

-- Loading data
PRAGMA foreign_keys = OFF;
-- DATASET 1
INSERT INTO aircraft (aid, name, distance) VALUES (1, 'Boeing 747', 8000);
INSERT INTO aircraft (aid, name, distance) VALUES (2, 'Airbus A320', 3500);
INSERT INTO employee (eid, name, salary) VALUES (105, 'Charlie', 60000.00);
INSERT INTO employee (eid, name, salary) VALUES (102, 'Alice', 55000.00);
INSERT INTO employee (eid, name, salary) VALUES (104, 'Bob', 95000.00);
INSERT INTO employee (eid, name, salary) VALUES (101, 'Alice', 85000.00);
INSERT INTO employee (eid, name, salary) VALUES (103, 'Bob', 40000.00);
INSERT INTO employee (eid, name, salary) VALUES (106, 'Charlie', 60000.00);
INSERT INTO certificate (eid, aid) VALUES (101, 1);
INSERT INTO certificate (eid, aid) VALUES (103, 2);
INSERT INTO certificate (eid, aid) VALUES (104, 1);
INSERT INTO certificate (eid, aid) VALUES (104, 2);
INSERT INTO certificate (eid, aid) VALUES (106, 1);
INSERT INTO certificate (eid, aid) VALUES (106, 2);
INSERT INTO flight (flno, aid, origin, destination, distance, departure_date, arrival_date, price) VALUES (10, 1, 'Los Angeles', 'Tokyo', 5400, '2023-05-01', '2023-05-02', 1200.00);
INSERT INTO flight (flno, aid, origin, destination, distance, departure_date, arrival_date, price) VALUES (20, 2, 'Chicago', 'New York', 740, '2023-05-03', '2023-05-03', 350.00);
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT name, salary FROM employee ORDER BY name, employee.eid NULLS LAST;

/*
Gold Result:
('Alice', 85000.0)
('Alice', 55000.0)
('Bob', 40000.0)
('Bob', 95000.0)
('Charlie', 60000.0)
('Charlie', 60000.0)
*/

-- Prediction Query
SELECT name, salary FROM Employee ORDER BY salary, Employee.eid NULLS LAST;

/*
Prediction Result:
('Bob', 40000.0)
('Alice', 55000.0)
('Charlie', 60000.0)
('Charlie', 60000.0)
('Alice', 85000.0)
('Bob', 95000.0)
*/