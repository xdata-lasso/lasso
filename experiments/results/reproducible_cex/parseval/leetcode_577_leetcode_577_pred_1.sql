-- Schema DDL
CREATE TABLE "Employee" ("empId" INTEGER PRIMARY KEY, "name" TEXT(255), "supervisor" INTEGER, "salary" INTEGER, CHECK ("empId" <> 'Employee.supervisor'), CHECK ("salary" >= 0));

CREATE TABLE "Bonus" ("empId" INTEGER PRIMARY KEY, "bonus" INTEGER, FOREIGN KEY ("empId") REFERENCES "Employee" ("empId"), CHECK ("bonus" >= 0));

-- Loading data
PRAGMA foreign_keys = OFF;
-- Inserting into table: employee --
INSERT INTO "employee" ("empid", "name", "supervisor", "salary") VALUES (1, 'e_s_ed1161', -1726781632, 247012447);

INSERT INTO "employee" ("empid", "name", "supervisor", "salary") VALUES (-2147483648, 'e_s_ed1161', -252690330, 1115440883);

INSERT INTO "employee" ("empid", "name", "supervisor", "salary") VALUES (-2147483646, 'e_s_ed1161', 1644814318, 1465859724);

INSERT INTO "employee" ("empid", "name", "supervisor", "salary") VALUES (3, NULL, -1349201381, 1019800248);

-- Inserting into table: bonus --
INSERT INTO "bonus" ("empid", "bonus") VALUES (1, 0);
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT Employee.name, Bonus.bonus FROM Employee LEFT JOIN Bonus ON Employee.empid = Bonus.empid WHERE bonus < 1000 OR bonus IS NULL;

/*
Gold Result:
('e_s_ed1161', None)
('e_s_ed1161', None)
('e_s_ed1161', 0)
(None, None)
*/

-- Prediction Query
SELECT DISTINCT E.NAME, B.BONUS FROM EMPLOYEE AS E LEFT JOIN BONUS AS B ON E.EMPID = B.EMPID WHERE B.BONUS < 1000 OR B.BONUS IS NULL;

/*
Prediction Result:
('e_s_ed1161', None)
('e_s_ed1161', 0)
(None, None)
*/