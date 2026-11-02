-- Schema DDL
CREATE TABLE "Employee" ("empId" INTEGER PRIMARY KEY, "name" TEXT(255), "supervisor" INTEGER, "salary" INTEGER, CHECK ("empId" <> 'Employee.supervisor'), CHECK ("salary" >= 0));

CREATE TABLE "Bonus" ("empId" INTEGER PRIMARY KEY, "bonus" INTEGER, FOREIGN KEY ("empId") REFERENCES "Employee" ("empId"), CHECK ("bonus" >= 0));

-- Loading data
PRAGMA foreign_keys = OFF;
INSERT INTO employee (empid, name, supervisor, salary) VALUES (999, 'default1', 0, NULL), (0, 'default1', 1000, 1), (1, 'default2', 1000, NULL), (1000, 'default1', 999, 1), (1001, 'default1', 0, 1), (2, 'default1', NULL, 1);
INSERT INTO bonus (empid, bonus) VALUES (999, 0), (0, 1001), (2, NULL);
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT Employee.name, Bonus.bonus FROM Employee LEFT JOIN Bonus ON Employee.empid = Bonus.empid WHERE bonus < 1000 OR bonus IS NULL;

/*
Gold Result:
('default2', None)
('default1', None)
('default1', 0)
('default1', None)
('default1', None)
*/

-- Prediction Query
SELECT EMPLOYEE.NAME, BONUS.BONUS FROM EMPLOYEE LEFT JOIN BONUS ON EMPLOYEE.EMPID = BONUS.EMPID WHERE NOT EMPLOYEE.EMPID IN (SELECT EMPID FROM BONUS) OR BONUS.BONUS < 1000;

/*
Prediction Result:
('default2', None)
('default1', 0)
('default1', None)
('default1', None)
*/