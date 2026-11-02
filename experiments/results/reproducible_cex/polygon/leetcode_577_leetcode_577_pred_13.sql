-- Schema DDL
CREATE TABLE "Employee" ("empId" INTEGER PRIMARY KEY, "name" TEXT(255), "supervisor" INTEGER, "salary" INTEGER, CHECK ("empId" <> 'Employee.supervisor'), CHECK ("salary" >= 0));

CREATE TABLE "Bonus" ("empId" INTEGER PRIMARY KEY, "bonus" INTEGER, FOREIGN KEY ("empId") REFERENCES "Employee" ("empId"), CHECK ("bonus" >= 0));

-- Loading data
PRAGMA foreign_keys = OFF;
INSERT INTO "Employee" ("empid", "name", "supervisor", "salary") VALUES (20, NULL, 21, NULL);
INSERT INTO "Employee" ("empid", "name", "supervisor", "salary") VALUES (12, NULL, NULL, 0);
INSERT INTO "Bonus" ("empid", "bonus") VALUES (12, NULL);
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT Employee.name, Bonus.bonus FROM Employee LEFT JOIN Bonus ON Employee.empid = Bonus.empid WHERE bonus < 1000 OR bonus IS NULL;

/*
Gold Result:
(None, None)
(None, None)
*/

-- Prediction Query
SELECT E.NAME AS NAME, B.BONUS AS BONUS FROM EMPLOYEE AS E LEFT JOIN BONUS AS B ON E.EMPID = B.EMPID WHERE B.BONUS < 1000 OR B.EMPID IS NULL;

/*
Prediction Result:
(None, None)
*/