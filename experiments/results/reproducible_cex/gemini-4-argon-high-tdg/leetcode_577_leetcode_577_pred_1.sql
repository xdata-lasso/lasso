-- Schema DDL
CREATE TABLE "Employee" ("empId" INTEGER PRIMARY KEY, "name" TEXT(255), "supervisor" INTEGER, "salary" INTEGER, CHECK ("empId" <> 'Employee.supervisor'), CHECK ("salary" >= 0));

CREATE TABLE "Bonus" ("empId" INTEGER PRIMARY KEY, "bonus" INTEGER, FOREIGN KEY ("empId") REFERENCES "Employee" ("empId"), CHECK ("bonus" >= 0));

-- Loading data
PRAGMA foreign_keys = OFF;
-- DATASET 2
INSERT INTO Employee (empId, name, supervisor, salary) VALUES (1, 'John', NULL, 1000);
INSERT INTO Employee (empId, name, supervisor, salary) VALUES (2, 'John', 1, 2000);
INSERT INTO Employee (empId, name, supervisor, salary) VALUES (3, 'John', 1, 1500);
INSERT INTO Employee (empId, name, supervisor, salary) VALUES (4, 'Mary', NULL, 1200);
INSERT INTO Employee (empId, name, supervisor, salary) VALUES (5, 'Mary', 4, 1800);
INSERT INTO Bonus (empId, bonus) VALUES (1, 500);
INSERT INTO Bonus (empId, bonus) VALUES (2, 500);
INSERT INTO Bonus (empId, bonus) VALUES (5, NULL);
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT Employee.name, Bonus.bonus FROM Employee LEFT JOIN Bonus ON Employee.empid = Bonus.empid WHERE bonus < 1000 OR bonus IS NULL;

/*
Gold Result:
('John', 500)
('John', 500)
('John', None)
('Mary', None)
('Mary', None)
*/

-- Prediction Query
SELECT DISTINCT E.NAME, B.BONUS FROM EMPLOYEE AS E LEFT JOIN BONUS AS B ON E.EMPID = B.EMPID WHERE B.BONUS < 1000 OR B.BONUS IS NULL;

/*
Prediction Result:
('John', 500)
('John', None)
('Mary', None)
*/