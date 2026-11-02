-- Schema DDL
CREATE TABLE "Employee" ("empId" INTEGER PRIMARY KEY, "name" TEXT(255), "supervisor" INTEGER, "salary" INTEGER, CHECK ("empId" <> 'Employee.supervisor'), CHECK ("salary" >= 0));

CREATE TABLE "Bonus" ("empId" INTEGER PRIMARY KEY, "bonus" INTEGER, FOREIGN KEY ("empId") REFERENCES "Employee" ("empId"), CHECK ("bonus" >= 0));

-- Loading data
PRAGMA foreign_keys = OFF;
INSERT INTO employee (empid, name, supervisor, salary) VALUES (1000, NULL, 0, 999), (1, NULL, 999, NULL), (999, 'default2', 1001, 1000), (1001, 'default1', 0, 1), (0, 'default1', 999, 1001);
INSERT INTO bonus (empid, bonus) VALUES (1001, 0), (0, 999), (1000, 1000), (1, NULL);
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT Employee.name, Bonus.bonus FROM Employee LEFT JOIN Bonus ON Employee.empid = Bonus.empid WHERE bonus < 1000 OR bonus IS NULL;

/*
Gold Result:
('default1', 999)
(None, None)
('default2', None)
('default1', 0)
*/

-- Prediction Query
SELECT NAME, BONUS.BONUS FROM EMPLOYEE LEFT JOIN BONUS ON EMPLOYEE.EMPID = BONUS.EMPID WHERE BONUS < 1000 OR BONUS IS NULL ORDER BY NAME, EMPLOYEE.empid NULLS LAST, BONUS.empid NULLS LAST;

/*
Prediction Result:
(None, None)
('default1', 999)
('default1', 0)
('default2', None)
*/