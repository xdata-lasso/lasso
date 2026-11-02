-- Schema DDL
CREATE TABLE "Employee" ("empId" INTEGER PRIMARY KEY, "name" TEXT(255), "supervisor" INTEGER, "salary" INTEGER, CHECK ("empId" <> 'Employee.supervisor'), CHECK ("salary" >= 0));

CREATE TABLE "Bonus" ("empId" INTEGER PRIMARY KEY, "bonus" INTEGER, FOREIGN KEY ("empId") REFERENCES "Employee" ("empId"), CHECK ("bonus" >= 0));

-- Loading data
PRAGMA foreign_keys = OFF;
INSERT INTO employee (empid, name, supervisor, salary) VALUES (0, NULL, 1001, NULL), (1000, 'default2', 1001, 0), (1, 'default2', 1000, NULL), (1001, 'default1', NULL, NULL);
INSERT INTO bonus (empid, bonus) VALUES (1001, 1000), (1000, 0), (0, NULL);
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT Employee.name, Bonus.bonus FROM Employee LEFT JOIN Bonus ON Employee.empid = Bonus.empid WHERE bonus < 1000 OR bonus IS NULL;

/*
Gold Result:
(None, None)
('default2', None)
('default2', 0)
*/

-- Prediction Query
SELECT NAME, BONUS FROM EMPLOYEE LEFT JOIN BONUS ON EMPLOYEE.EMPID = BONUS.EMPID WHERE NOT NAME IN (SELECT NAME FROM EMPLOYEE AS E LEFT JOIN BONUS AS B ON E.EMPID = B.EMPID WHERE B.BONUS > 1000);

/*
Prediction Result:
(None, None)
('default2', None)
('default2', 0)
('default1', 1000)
*/