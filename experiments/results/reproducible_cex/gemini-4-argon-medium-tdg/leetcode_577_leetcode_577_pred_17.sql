-- Schema DDL
CREATE TABLE "Employee" ("empId" INTEGER PRIMARY KEY, "name" TEXT(255), "supervisor" INTEGER, "salary" INTEGER, CHECK ("empId" <> 'Employee.supervisor'), CHECK ("salary" >= 0));

CREATE TABLE "Bonus" ("empId" INTEGER PRIMARY KEY, "bonus" INTEGER, FOREIGN KEY ("empId") REFERENCES "Employee" ("empId"), CHECK ("bonus" >= 0));

-- Loading data
PRAGMA foreign_keys = OFF;
-- DATASET 2
INSERT INTO Employee (empId, name, supervisor, salary) VALUES (10, 'Alice', NULL, 2000);
INSERT INTO Employee (empId, name, supervisor, salary) VALUES (20, 'Alice', 10, 2000);
INSERT INTO Employee (empId, name, supervisor, salary) VALUES (30, 'Bob', 10, 500);
INSERT INTO Employee (empId, name, supervisor, salary) VALUES (40, NULL, 20, 3000);
INSERT INTO Bonus (empId, bonus) VALUES (10, 500);
INSERT INTO Bonus (empId, bonus) VALUES (20, 500);
INSERT INTO Bonus (empId, bonus) VALUES (30, NULL);
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT Employee.name, Bonus.bonus FROM Employee LEFT JOIN Bonus ON Employee.empid = Bonus.empid WHERE bonus < 1000 OR bonus IS NULL;

/*
Gold Result:
('Alice', 500)
('Alice', 500)
('Bob', None)
(None, None)
*/

-- Prediction Query
SELECT EMPLOYEE.NAME, BONUS.BONUS FROM EMPLOYEE LEFT JOIN BONUS ON EMPLOYEE.EMPID = BONUS.EMPID WHERE NOT EMPLOYEE.EMPID IN (SELECT EMPID FROM BONUS) OR BONUS.BONUS < 1000;

/*
Prediction Result:
('Alice', 500)
('Alice', 500)
(None, None)
*/