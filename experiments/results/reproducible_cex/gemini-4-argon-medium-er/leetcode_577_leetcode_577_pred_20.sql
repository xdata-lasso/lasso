-- Schema DDL
CREATE TABLE "Employee" ("empId" INTEGER PRIMARY KEY, "name" TEXT(255), "supervisor" INTEGER, "salary" INTEGER, CHECK ("empId" <> 'Employee.supervisor'), CHECK ("salary" >= 0));

CREATE TABLE "Bonus" ("empId" INTEGER PRIMARY KEY, "bonus" INTEGER, FOREIGN KEY ("empId") REFERENCES "Employee" ("empId"), CHECK ("bonus" >= 0));

-- Loading data
PRAGMA foreign_keys = OFF;
INSERT INTO Employee (empId, name, supervisor, salary) VALUES (1, 'Alice', NULL, 50000);
INSERT INTO Bonus (empId, bonus) VALUES (1, 1000);
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT Employee.name, Bonus.bonus FROM Employee LEFT JOIN Bonus ON Employee.empid = Bonus.empid WHERE bonus < 1000 OR bonus IS NULL;

/*
Gold Result:
*/

-- Prediction Query
SELECT NAME, BONUS FROM EMPLOYEE LEFT JOIN BONUS ON EMPLOYEE.EMPID = BONUS.EMPID WHERE NOT NAME IN (SELECT NAME FROM EMPLOYEE AS E LEFT JOIN BONUS AS B ON E.EMPID = B.EMPID WHERE B.BONUS > 1000);

/*
Prediction Result:
('Alice', 1000)
*/