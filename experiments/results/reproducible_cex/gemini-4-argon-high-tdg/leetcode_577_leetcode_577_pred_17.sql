-- Schema DDL
CREATE TABLE "Employee" ("empId" INTEGER PRIMARY KEY, "name" TEXT(255), "supervisor" INTEGER, "salary" INTEGER, CHECK ("empId" <> 'Employee.supervisor'), CHECK ("salary" >= 0));

CREATE TABLE "Bonus" ("empId" INTEGER PRIMARY KEY, "bonus" INTEGER, FOREIGN KEY ("empId") REFERENCES "Employee" ("empId"), CHECK ("bonus" >= 0));

-- Loading data
PRAGMA foreign_keys = OFF;
-- DATASET 1
INSERT INTO Employee (empId, name, supervisor, salary) VALUES (1, 'Alice', NULL, 2000);
INSERT INTO Employee (empId, name, supervisor, salary) VALUES (2, 'Bob', 1, 500);
INSERT INTO Employee (empId, name, supervisor, salary) VALUES (3, 'Charlie', 2, 3000);
INSERT INTO Employee (empId, name, supervisor, salary) VALUES (4, 'David', 3, 400);
INSERT INTO Employee (empId, name, supervisor, salary) VALUES (5, 'Eve', 1, 1500);
INSERT INTO Employee (empId, name, supervisor, salary) VALUES (6, 'Frank', 2, 800);
INSERT INTO Bonus (empId, bonus) VALUES (2, 1000);
INSERT INTO Bonus (empId, bonus) VALUES (3, 999);
INSERT INTO Bonus (empId, bonus) VALUES (4, 1500);
INSERT INTO Bonus (empId, bonus) VALUES (5, 0);
INSERT INTO Bonus (empId, bonus) VALUES (6, NULL);
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT Employee.name, Bonus.bonus FROM Employee LEFT JOIN Bonus ON Employee.empid = Bonus.empid WHERE bonus < 1000 OR bonus IS NULL;

/*
Gold Result:
('Alice', None)
('Charlie', 999)
('Eve', 0)
('Frank', None)
*/

-- Prediction Query
SELECT EMPLOYEE.NAME, BONUS.BONUS FROM EMPLOYEE LEFT JOIN BONUS ON EMPLOYEE.EMPID = BONUS.EMPID WHERE NOT EMPLOYEE.EMPID IN (SELECT EMPID FROM BONUS) OR BONUS.BONUS < 1000;

/*
Prediction Result:
('Alice', None)
('Charlie', 999)
('Eve', 0)
*/