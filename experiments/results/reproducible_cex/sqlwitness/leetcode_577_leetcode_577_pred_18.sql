-- Schema DDL
CREATE TABLE "Employee" ("empId" INTEGER PRIMARY KEY, "name" TEXT(255), "supervisor" INTEGER, "salary" INTEGER, CHECK ("empId" <> 'Employee.supervisor'), CHECK ("salary" >= 0));

CREATE TABLE "Bonus" ("empId" INTEGER PRIMARY KEY, "bonus" INTEGER, FOREIGN KEY ("empId") REFERENCES "Employee" ("empId"), CHECK ("bonus" >= 0));

-- Loading data
PRAGMA foreign_keys = OFF;
INSERT INTO employee (empid, name, supervisor, salary) VALUES (1000, 'default1', NULL, NULL), (1, NULL, 9, 999), (999, NULL, 8, 999), (0, NULL, 2, 1001), (1001, NULL, 2, 999), (2, NULL, 8, 999), (3, 'default2', 7, NULL), (4, NULL, 999, 999), (5, NULL, 11, 1001), (6, 'default1', 999, 0), (7, 'default2', 2, 1), (8, 'default2', 5, 999), (9, 'default1', 4, 0), (10, 'default2', 9, 1), (11, 'default2', 1000, 0);
INSERT INTO bonus (empid, bonus) VALUES (1, 1), (4, NULL), (3, NULL), (999, 1), (2, 1), (5, 999), (7, 1), (10, 1001), (1000, 999), (0, 1000);
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT Employee.name, Bonus.bonus FROM Employee LEFT JOIN Bonus ON Employee.empid = Bonus.empid WHERE bonus < 1000 OR bonus IS NULL;

/*
Gold Result:
(None, 1)
(None, 1)
('default2', None)
(None, None)
(None, 999)
('default1', None)
('default2', 1)
('default2', None)
('default1', None)
('default2', None)
(None, 1)
('default1', 999)
(None, None)
*/

-- Prediction Query
SELECT NAME, BONUS FROM EMPLOYEE AS E LEFT JOIN BONUS AS B ON E.EMPID = B.EMPID WHERE BONUS < 1000 UNION SELECT NAME, BONUS FROM EMPLOYEE AS E LEFT JOIN BONUS AS B ON E.EMPID = B.EMPID WHERE BONUS IS NULL;

/*
Prediction Result:
(None, None)
(None, 1)
(None, 999)
('default1', None)
('default1', 999)
('default2', None)
('default2', 1)
*/