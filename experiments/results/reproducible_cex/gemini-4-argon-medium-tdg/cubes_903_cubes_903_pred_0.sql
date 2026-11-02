-- Schema DDL
CREATE TABLE "flight" ("flno" REAL(4, 0) PRIMARY KEY, "aid" REAL(9, 0), "origin" TEXT(20), "destination" TEXT(20), "distance" REAL(6, 0), "departure_date" DATE, "arrival_date" DATE, "price" REAL(7, 2), FOREIGN KEY ("aid") REFERENCES "aircraft" ("aid"));

CREATE TABLE "aircraft" ("aid" REAL(9, 0) PRIMARY KEY, "name" TEXT(30), "distance" REAL(6, 0));

CREATE TABLE "employee" ("eid" REAL(9, 0) PRIMARY KEY, "name" TEXT(30), "salary" REAL(10, 2));

CREATE TABLE "certificate" ("eid" REAL(9, 0), "aid" REAL(9, 0), PRIMARY KEY ("eid", "aid"), FOREIGN KEY ("aid") REFERENCES "aircraft" ("aid"), FOREIGN KEY ("eid") REFERENCES "employee" ("eid"));

-- Loading data
PRAGMA foreign_keys = OFF;
-- DATASET 1
-- Tests LIMIT 13 boundary condition (16 rows), ORDER BY salary DESC, duplicate names (DISTINCT vs ALL), and inverse correlation between eid, name, and salary.
INSERT INTO employee (eid, name, salary) VALUES (1, 'P_Emp', 100.00);
INSERT INTO employee (eid, name, salary) VALUES (2, 'O_Emp', 200.00);
INSERT INTO employee (eid, name, salary) VALUES (3, 'N_Emp', 300.00);
INSERT INTO employee (eid, name, salary) VALUES (4, 'M_Emp', 400.00);
INSERT INTO employee (eid, name, salary) VALUES (5, 'L_Emp', 500.00);
INSERT INTO employee (eid, name, salary) VALUES (6, 'K_Emp', 600.00);
INSERT INTO employee (eid, name, salary) VALUES (7, 'J_Emp', 700.00);
INSERT INTO employee (eid, name, salary) VALUES (8, 'I_Emp', 800.00);
INSERT INTO employee (eid, name, salary) VALUES (9, 'H_Emp', 900.00);
INSERT INTO employee (eid, name, salary) VALUES (10, 'G_Emp', 1000.00);
INSERT INTO employee (eid, name, salary) VALUES (11, 'F_Emp', 1100.00);
INSERT INTO employee (eid, name, salary) VALUES (12, 'E_Emp', 1200.00);
INSERT INTO employee (eid, name, salary) VALUES (13, 'D_Emp', 1300.00);
INSERT INTO employee (eid, name, salary) VALUES (14, 'C_Emp', 1400.00);
INSERT INTO employee (eid, name, salary) VALUES (15, 'A_Twin', 1500.00);
INSERT INTO employee (eid, name, salary) VALUES (16, 'A_Twin', 1600.00);
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT name FROM (SELECT * FROM (SELECT * FROM (SELECT eid, name, salary, AVG(salary) OVER () AS meansalary FROM employee) ORDER BY salary DESC) LIMIT 13);

/*
Gold Result:
('A_Twin',)
('A_Twin',)
('C_Emp',)
('D_Emp',)
('E_Emp',)
('F_Emp',)
('G_Emp',)
('H_Emp',)
('I_Emp',)
('J_Emp',)
('K_Emp',)
('L_Emp',)
('M_Emp',)
*/

-- Prediction Query
SELECT name FROM Employee WHERE salary > (SELECT AVG(salary) FROM Employee);

/*
Prediction Result:
('H_Emp',)
('G_Emp',)
('F_Emp',)
('E_Emp',)
('D_Emp',)
('C_Emp',)
('A_Twin',)
('A_Twin',)
*/