-- Schema DDL
CREATE TABLE "Employee" ("empId" INTEGER PRIMARY KEY, "name" TEXT(255), "supervisor" INTEGER, "salary" INTEGER, CHECK ("empId" <> 'Employee.supervisor'), CHECK ("salary" >= 0));

CREATE TABLE "Bonus" ("empId" INTEGER PRIMARY KEY, "bonus" INTEGER, FOREIGN KEY ("empId") REFERENCES "Employee" ("empId"), CHECK ("bonus" >= 0));

-- Loading data
PRAGMA foreign_keys = OFF;
INSERT INTO "employee" ("empid", "name", "supervisor", "salary") VALUES (1001, 'Allison Hill', 1002, 1003);
INSERT INTO "employee" ("empid", "name", "supervisor", "salary") VALUES (1006, 'Allison Hill', 1002, 1003);
INSERT INTO "employee" ("empid", "name", "supervisor", "salary") VALUES (1004, NULL, NULL, NULL);
INSERT INTO "bonus" ("empid", "bonus") VALUES (1001, NULL);
INSERT INTO "bonus" ("empid", "bonus") VALUES (1004, 999);
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT Employee.name, Bonus.bonus FROM Employee LEFT JOIN Bonus ON Employee.empid = Bonus.empid WHERE bonus < 1000 OR bonus IS NULL;

/*
Gold Result:
('Allison Hill', None)
(None, 999)
('Allison Hill', None)
*/

-- Prediction Query
SELECT EMPLOYEE.NAME, BONUS.BONUS FROM EMPLOYEE LEFT JOIN BONUS ON EMPLOYEE.EMPID = BONUS.EMPID WHERE BONUS.EMPID IS NULL OR BONUS.BONUS < 1000;

/*
Prediction Result:
(None, 999)
('Allison Hill', None)
*/