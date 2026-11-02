-- Schema DDL
CREATE TABLE "Employee" ("empId" INTEGER PRIMARY KEY, "name" TEXT(255), "supervisor" INTEGER, "salary" INTEGER, CHECK ("empId" <> 'Employee.supervisor'), CHECK ("salary" >= 0));

CREATE TABLE "Bonus" ("empId" INTEGER PRIMARY KEY, "bonus" INTEGER, FOREIGN KEY ("empId") REFERENCES "Employee" ("empId"), CHECK ("bonus" >= 0));

-- Loading data
PRAGMA foreign_keys = OFF;
INSERT INTO employee (empid, name, supervisor, salary) VALUES (1000, NULL, 5, NULL), (0, 'default2', 5, 1001), (999, NULL, 1, 1001), (1001, 'default2', 999, 999), (1, 'default1', 2, 1000), (2, 'default2', 1001, 0), (3, NULL, 2, NULL), (4, NULL, NULL, 1001), (5, 'default1', 2, 1000);
INSERT INTO bonus (empid, bonus) VALUES (4, 1001), (999, 1000), (1000, 1000), (1, 999), (0, 1001);
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT Employee.name, Bonus.bonus FROM Employee LEFT JOIN Bonus ON Employee.empid = Bonus.empid WHERE bonus < 1000 OR bonus IS NULL;

/*
Gold Result:
('default1', 999)
('default2', None)
(None, None)
('default1', None)
('default2', None)
*/

-- Prediction Query
SELECT DISTINCT E.NAME, B.BONUS FROM EMPLOYEE AS E LEFT JOIN BONUS AS B ON E.EMPID = B.EMPID WHERE B.BONUS < 1000 OR B.BONUS IS NULL;

/*
Prediction Result:
('default1', 999)
('default2', None)
(None, None)
('default1', None)
*/