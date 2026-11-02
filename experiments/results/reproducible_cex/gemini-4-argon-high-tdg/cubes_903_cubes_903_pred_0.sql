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
INSERT INTO aircraft (aid, name, distance) VALUES (3, 'Embraer E190', 2400);
INSERT INTO employee (eid, name, salary) VALUES (1, 'emp_rank_16', 10000.00);
INSERT INTO employee (eid, name, salary) VALUES (2, 'emp_rank_01', 900000.00);
INSERT INTO employee (eid, name, salary) VALUES (3, 'emp_rank_15', 11000.00);
INSERT INTO employee (eid, name, salary) VALUES (4, 'emp_rank_05', 21000.00);
INSERT INTO employee (eid, name, salary) VALUES (5, 'emp_rank_14', 12000.00);
INSERT INTO employee (eid, name, salary) VALUES (6, 'emp_rank_13', 13000.00);
INSERT INTO employee (eid, name, salary) VALUES (7, 'emp_rank_02', 24000.00);
INSERT INTO employee (eid, name, salary) VALUES (8, 'emp_rank_12', 14000.00);
INSERT INTO employee (eid, name, salary) VALUES (9, 'emp_rank_03', 23000.00);
INSERT INTO employee (eid, name, salary) VALUES (10, 'emp_rank_11', 15000.00);
INSERT INTO employee (eid, name, salary) VALUES (11, 'emp_rank_04', 22000.00);
INSERT INTO employee (eid, name, salary) VALUES (12, 'emp_rank_10', 16000.00);
INSERT INTO employee (eid, name, salary) VALUES (13, 'emp_rank_06', 20000.00);
INSERT INTO employee (eid, name, salary) VALUES (14, 'emp_rank_09', 17000.00);
INSERT INTO employee (eid, name, salary) VALUES (15, 'emp_rank_07', 19000.00);
INSERT INTO employee (eid, name, salary) VALUES (16, 'emp_rank_08', 18000.00);
INSERT INTO certificate (eid, aid) VALUES (2, 1);
INSERT INTO certificate (eid, aid) VALUES (2, 2);
INSERT INTO certificate (eid, aid) VALUES (2, 3);
INSERT INTO certificate (eid, aid) VALUES (1, 1);
INSERT INTO certificate (eid, aid) VALUES (3, 2);
INSERT INTO certificate (eid, aid) VALUES (5, 3);
INSERT INTO flight (flno, aid, origin, destination, distance, departure_date, arrival_date, price) VALUES (101, 1, 'New York', 'London', 3459, '2023-05-01', '2023-05-02', 850.00);
INSERT INTO flight (flno, aid, origin, destination, distance, departure_date, arrival_date, price) VALUES (102, 2, 'Chicago', 'Miami', 1197, '2023-05-03', '2023-05-03', 220.50);
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT name FROM (SELECT * FROM (SELECT * FROM (SELECT eid, name, salary, AVG(salary) OVER () AS meansalary FROM employee) ORDER BY salary DESC) LIMIT 13);

/*
Gold Result:
('emp_rank_01',)
('emp_rank_02',)
('emp_rank_03',)
('emp_rank_04',)
('emp_rank_05',)
('emp_rank_06',)
('emp_rank_07',)
('emp_rank_08',)
('emp_rank_09',)
('emp_rank_10',)
('emp_rank_11',)
('emp_rank_12',)
('emp_rank_13',)
*/

-- Prediction Query
SELECT name FROM Employee WHERE salary > (SELECT AVG(salary) FROM Employee);

/*
Prediction Result:
('emp_rank_01',)
*/