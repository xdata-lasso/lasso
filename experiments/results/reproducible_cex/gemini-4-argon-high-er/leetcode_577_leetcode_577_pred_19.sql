-- Schema DDL
CREATE TABLE "Employee" ("empId" INTEGER PRIMARY KEY, "name" TEXT(255), "supervisor" INTEGER, "salary" INTEGER, CHECK ("empId" <> 'Employee.supervisor'), CHECK ("salary" >= 0));

CREATE TABLE "Bonus" ("empId" INTEGER PRIMARY KEY, "bonus" INTEGER, FOREIGN KEY ("empId") REFERENCES "Employee" ("empId"), CHECK ("bonus" >= 0));

-- Loading data
PRAGMA foreign_keys = OFF;
INSERT INTO Employee (empId, name, supervisor, salary) VALUES (1, 'Alice', 3, 1000);
INSERT INTO Employee (empId, name, supervisor, salary) VALUES (2, 'Alice', 3, 1000);
INSERT INTO Bonus (empId, bonus) VALUES (1, 100);
INSERT INTO Bonus (empId, bonus) VALUES (2, 200);
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT Employee.name, Bonus.bonus FROM Employee LEFT JOIN Bonus ON Employee.empid = Bonus.empid WHERE bonus < 1000 OR bonus IS NULL;

/*
Gold Result:
('Alice', 100)
('Alice', 200)
*/

-- Prediction Query
SELECT NAME, BONUS FROM EMPLOYEE LEFT JOIN BONUS ON EMPLOYEE.EMPID = BONUS.EMPID GROUP BY NAME HAVING COALESCE(BONUS, 0) < 1000;

/*
Prediction Result:
('Alice', 100)
*/