-- Schema DDL
CREATE TABLE "Employee" ("empId" INTEGER PRIMARY KEY, "name" TEXT(255), "supervisor" INTEGER, "salary" INTEGER, CHECK ("empId" <> 'Employee.supervisor'), CHECK ("salary" >= 0));

CREATE TABLE "Bonus" ("empId" INTEGER PRIMARY KEY, "bonus" INTEGER, FOREIGN KEY ("empId") REFERENCES "Employee" ("empId"), CHECK ("bonus" >= 0));

-- Loading data
PRAGMA foreign_keys = OFF;
INSERT INTO "Employee" ("empid", "name", "supervisor", "salary") VALUES (15, '18', NULL, 0);
INSERT INTO "Employee" ("empid", "name", "supervisor", "salary") VALUES (14, '19', 17, 0);
INSERT INTO "Bonus" ("empid", "bonus") VALUES (15, 0);
INSERT INTO "Bonus" ("empid", "bonus") VALUES (14, 1000);
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT Employee.name, Bonus.bonus FROM Employee LEFT JOIN Bonus ON Employee.empid = Bonus.empid WHERE bonus < 1000 OR bonus IS NULL;

/*
Gold Result:
('18', 0)
*/

-- Prediction Query
SELECT E.NAME, B.BONUS FROM EMPLOYEE AS E LEFT JOIN BONUS AS B ON E.EMPID = B.EMPID WHERE NOT E.EMPID IN (SELECT EMPID FROM BONUS WHERE BONUS > 1000);

/*
Prediction Result:
('19', 1000)
('18', 0)
*/