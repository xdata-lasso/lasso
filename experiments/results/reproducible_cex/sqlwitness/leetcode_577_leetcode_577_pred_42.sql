-- Schema DDL
CREATE TABLE "Employee" ("empId" INTEGER PRIMARY KEY, "name" TEXT(255), "supervisor" INTEGER, "salary" INTEGER, CHECK ("empId" <> 'Employee.supervisor'), CHECK ("salary" >= 0));

CREATE TABLE "Bonus" ("empId" INTEGER PRIMARY KEY, "bonus" INTEGER, FOREIGN KEY ("empId") REFERENCES "Employee" ("empId"), CHECK ("bonus" >= 0));

-- Loading data
PRAGMA foreign_keys = OFF;
INSERT INTO employee (empid, name, supervisor, salary) VALUES (1, 'default2', 1001, 999), (999, 'default2', 1, 999), (0, 'default1', 999, 1), (1000, 'default1', NULL, NULL), (1001, 'default2', 1, 1), (2, 'default1', 1000, 1000);
INSERT INTO bonus (empid, bonus) VALUES (0, NULL);
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT Employee.name, Bonus.bonus FROM Employee LEFT JOIN Bonus ON Employee.empid = Bonus.empid WHERE bonus < 1000 OR bonus IS NULL;

/*
Gold Result:
('default1', None)
('default2', None)
('default1', None)
('default2', None)
('default1', None)
('default2', None)
*/

-- Prediction Query
SELECT NAME, BONUS FROM EMPLOYEE AS E LEFT JOIN BONUS AS B ON E.EMPID = B.EMPID WHERE BONUS < 1000 OR BONUS IS NULL ORDER BY BONUS, E.empid NULLS LAST, B.empid NULLS LAST;

/*
Prediction Result:
('default1', None)
('default2', None)
('default1', None)
('default2', None)
('default1', None)
('default2', None)
*/