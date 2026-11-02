-- Schema DDL
CREATE TABLE "Employee" ("empId" INTEGER PRIMARY KEY, "name" TEXT(255), "supervisor" INTEGER, "salary" INTEGER, CHECK ("empId" <> 'Employee.supervisor'), CHECK ("salary" >= 0));

CREATE TABLE "Bonus" ("empId" INTEGER PRIMARY KEY, "bonus" INTEGER, FOREIGN KEY ("empId") REFERENCES "Employee" ("empId"), CHECK ("bonus" >= 0));

-- Loading data
PRAGMA foreign_keys = OFF;
INSERT INTO "Employee" ("empid", "name", "supervisor", "salary") VALUES (11, NULL, NULL, NULL);
INSERT INTO "Employee" ("empid", "name", "supervisor", "salary") VALUES (14, NULL, 15, 0);
INSERT INTO "Bonus" ("empid", "bonus") VALUES (11, NULL);
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
SELECT EMPLOYEE.NAME, BONUS.BONUS FROM EMPLOYEE LEFT JOIN BONUS ON EMPLOYEE.EMPID = BONUS.EMPID WHERE NOT EMPLOYEE.EMPID IN (SELECT EMPID FROM BONUS) OR BONUS.BONUS < 1000;

/*
Prediction Result:
(None, None)
*/