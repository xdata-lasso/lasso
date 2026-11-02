-- Schema DDL
CREATE TABLE "Employee" ("empId" INTEGER PRIMARY KEY, "name" TEXT(255), "supervisor" INTEGER, "salary" INTEGER, CHECK ("empId" <> 'Employee.supervisor'), CHECK ("salary" >= 0));

CREATE TABLE "Bonus" ("empId" INTEGER PRIMARY KEY, "bonus" INTEGER, FOREIGN KEY ("empId") REFERENCES "Employee" ("empId"), CHECK ("bonus" >= 0));

-- Loading data
PRAGMA foreign_keys = OFF;
INSERT INTO employee (empid, name, supervisor, salary) VALUES (1, NULL, NULL, NULL), (1000, 'default1', 999, NULL), (999, NULL, 1000, 999);
INSERT INTO bonus (empid, bonus) VALUES (1000, 1000), (999, 999), (1, 0);
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT Employee.name, Bonus.bonus FROM Employee LEFT JOIN Bonus ON Employee.empid = Bonus.empid WHERE bonus < 1000 OR bonus IS NULL;

/*
Gold Result:
(None, 0)
(None, 999)
*/

-- Prediction Query
SELECT E.NAME AS NAME, B.BONUS AS BONUS FROM EMPLOYEE AS E LEFT JOIN BONUS AS B ON E.EMPID = B.EMPID WHERE B.BONUS < 1000 OR BONUS IS NULL ORDER BY BONUS DESC, E.empid NULLS LAST, B.empid NULLS LAST;

/*
Prediction Result:
(None, 999)
(None, 0)
*/