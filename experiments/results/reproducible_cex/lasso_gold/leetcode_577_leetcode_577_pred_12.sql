-- Schema DDL
CREATE TABLE "Employee" ("empId" INTEGER PRIMARY KEY, "name" TEXT(255), "supervisor" INTEGER, "salary" INTEGER, CHECK ("empId" <> 'Employee.supervisor'), CHECK ("salary" >= 0));

CREATE TABLE "Bonus" ("empId" INTEGER PRIMARY KEY, "bonus" INTEGER, FOREIGN KEY ("empId") REFERENCES "Employee" ("empId"), CHECK ("bonus" >= 0));

-- Loading data
PRAGMA foreign_keys = OFF;
INSERT INTO "employee" ("empid", "name", "supervisor", "salary") VALUES (1008, 'Noah Rhodes', 1009, 1010);
INSERT INTO "employee" ("empid", "name", "supervisor", "salary") VALUES (1012, 'Noah Rhodes', 1009, 1010);
INSERT INTO "bonus" ("empid", "bonus") VALUES (1008, 1000);
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT Employee.name, Bonus.bonus FROM Employee LEFT JOIN Bonus ON Employee.empid = Bonus.empid WHERE bonus < 1000 OR bonus IS NULL;

/*
Gold Result:
('Noah Rhodes', None)
*/

-- Prediction Query
SELECT E.NAME, B.BONUS FROM EMPLOYEE AS E LEFT JOIN BONUS AS B ON E.EMPID = B.EMPID WHERE NOT E.EMPID IN (SELECT EMPID FROM BONUS WHERE BONUS > 1000);

/*
Prediction Result:
('Noah Rhodes', 1000)
('Noah Rhodes', None)
*/