-- Schema DDL
CREATE TABLE "Employee" ("empId" INTEGER PRIMARY KEY, "name" TEXT(255), "supervisor" INTEGER, "salary" INTEGER, CHECK ("empId" <> 'Employee.supervisor'), CHECK ("salary" >= 0));

CREATE TABLE "Bonus" ("empId" INTEGER PRIMARY KEY, "bonus" INTEGER, FOREIGN KEY ("empId") REFERENCES "Employee" ("empId"), CHECK ("bonus" >= 0));

-- Loading data
PRAGMA foreign_keys = OFF;
INSERT INTO employee (empid, name, supervisor, salary) VALUES (1000, NULL, NULL, NULL), (1001, NULL, 1000, 1), (999, 'default1', NULL, 1001);
INSERT INTO bonus (empid, bonus) VALUES (999, 0), (1000, 1001);
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT Employee.name, Bonus.bonus FROM Employee LEFT JOIN Bonus ON Employee.empid = Bonus.empid WHERE bonus < 1000 OR bonus IS NULL;

/*
Gold Result:
('default1', 0)
(None, None)
*/

-- Prediction Query
SELECT NAME, BONUS FROM EMPLOYEE LEFT JOIN BONUS ON EMPLOYEE.EMPID = BONUS.EMPID GROUP BY NAME HAVING COALESCE(BONUS, 0) < 1000;

/*
Prediction Result:
('default1', 0)
*/