-- Schema DDL
CREATE TABLE "flight" ("flno" REAL(4, 0) PRIMARY KEY, "aid" REAL(9, 0), "origin" TEXT(20), "destination" TEXT(20), "distance" REAL(6, 0), "departure_date" DATE, "arrival_date" DATE, "price" REAL(7, 2), FOREIGN KEY ("aid") REFERENCES "aircraft" ("aid"));

CREATE TABLE "aircraft" ("aid" REAL(9, 0) PRIMARY KEY, "name" TEXT(30), "distance" REAL(6, 0));

CREATE TABLE "employee" ("eid" REAL(9, 0) PRIMARY KEY, "name" TEXT(30), "salary" REAL(10, 2));

CREATE TABLE "certificate" ("eid" REAL(9, 0), "aid" REAL(9, 0), PRIMARY KEY ("eid", "aid"), FOREIGN KEY ("aid") REFERENCES "aircraft" ("aid"), FOREIGN KEY ("eid") REFERENCES "employee" ("eid"));

-- Loading data
PRAGMA foreign_keys = OFF;
-- DATASET 1
-- Tests LIMIT 13 boundary (15 rows), ORDER BY salary DESC vs ASC vs eid vs name,
-- duplicate names (SELECT vs SELECT DISTINCT), and presence of uncertified employees (INNER JOIN vs no join).
INSERT INTO aircraft (aid, name, distance) VALUES (1, 'Boeing 747', 8000);
INSERT INTO flight (flno, aid, origin, destination, distance, departure_date, arrival_date, price) VALUES (101, 1, 'LAX', 'JFK', 2500, '2023-01-01', '2023-01-02', 300.00);
INSERT INTO employee (eid, name, salary) VALUES (10, 'Zack', 150000.00);
INSERT INTO employee (eid, name, salary) VALUES (2, 'Alice', 140000.00);
INSERT INTO employee (eid, name, salary) VALUES (15, 'Bob', 130000.00);
INSERT INTO employee (eid, name, salary) VALUES (4, 'Alice', 120000.00);
INSERT INTO employee (eid, name, salary) VALUES (12, 'Charlie', 110000.00);
INSERT INTO employee (eid, name, salary) VALUES (6, 'David', 100000.00);
INSERT INTO employee (eid, name, salary) VALUES (7, 'Eve', 90000.00);
INSERT INTO employee (eid, name, salary) VALUES (8, 'Frank', 80000.00);
INSERT INTO employee (eid, name, salary) VALUES (1, 'Grace', 70000.00);
INSERT INTO employee (eid, name, salary) VALUES (9, 'Heidi', 60000.00);
INSERT INTO employee (eid, name, salary) VALUES (11, 'Ivan', 50000.00);
INSERT INTO employee (eid, name, salary) VALUES (5, 'Judy', 40000.00);
INSERT INTO employee (eid, name, salary) VALUES (13, 'Mallory', 30000.00);
INSERT INTO employee (eid, name, salary) VALUES (3, 'Niaj', 20000.00);
INSERT INTO employee (eid, name, salary) VALUES (14, 'Olivia', 10000.00);
INSERT INTO certificate (eid, aid) VALUES (10, 1);
INSERT INTO certificate (eid, aid) VALUES (2, 1);
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT name FROM (SELECT * FROM (SELECT * FROM (SELECT eid, name, salary, AVG(salary) OVER () AS meansalary FROM employee) ORDER BY salary DESC) LIMIT 13);

/*
Gold Result:
('Zack',)
('Alice',)
('Bob',)
('Alice',)
('Charlie',)
('David',)
('Eve',)
('Frank',)
('Grace',)
('Heidi',)
('Ivan',)
('Judy',)
('Mallory',)
*/

-- Prediction Query
SELECT name FROM Employee WHERE salary > (SELECT AVG(salary) FROM Employee);

/*
Prediction Result:
('Zack',)
('Alice',)
('Bob',)
('Alice',)
('Charlie',)
('David',)
('Eve',)
*/