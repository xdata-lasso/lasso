-- Schema DDL
CREATE TABLE "Employee" ("empId" INTEGER PRIMARY KEY, "name" TEXT(255), "supervisor" INTEGER, "salary" INTEGER, CHECK ("empId" <> 'Employee.supervisor'), CHECK ("salary" >= 0));

CREATE TABLE "Bonus" ("empId" INTEGER PRIMARY KEY, "bonus" INTEGER, FOREIGN KEY ("empId") REFERENCES "Employee" ("empId"), CHECK ("bonus" >= 0));

-- Loading data
PRAGMA foreign_keys = OFF;
INSERT INTO employee (empid, name, supervisor, salary) VALUES (999, 'default2', 5, 999), (1000, 'default1', 0, 1000), (1001, NULL, 999, NULL), (1, 'default2', 999, 0), (0, 'default1', 1000, 0), (2, 'default2', 999, 1000), (3, 'default2', 999, 0), (4, NULL, 7, 999), (5, NULL, 2, 999), (6, NULL, 4, NULL), (7, 'default1', 5, 0);
INSERT INTO bonus (empid, bonus) VALUES (5, 1000), (3, NULL), (7, 0), (999, 1001), (1000, 1000), (1001, 0);
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT Employee.name, Bonus.bonus FROM Employee LEFT JOIN Bonus ON Employee.empid = Bonus.empid WHERE bonus < 1000 OR bonus IS NULL;

/*
Gold Result:
('default1', None)
('default2', None)
('default2', None)
('default2', None)
(None, None)
(None, None)
('default1', 0)
(None, 0)
*/

-- Prediction Query
SELECT E.NAME, B.BONUS FROM EMPLOYEE AS E LEFT JOIN BONUS AS B ON E.EMPID = B.EMPID WHERE NOT E.EMPID IN (SELECT EMPID FROM BONUS WHERE BONUS > 1000);

/*
Prediction Result:
('default1', None)
('default2', None)
('default2', None)
('default2', None)
(None, None)
(None, 1000)
(None, None)
('default1', 0)
('default1', 1000)
(None, 0)
*/