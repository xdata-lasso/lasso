-- Schema DDL
CREATE TABLE "Project" ("project_id" INTEGER, "employee_id" INTEGER, PRIMARY KEY ("project_id", "employee_id"), FOREIGN KEY ("employee_id") REFERENCES "Employee" ("employee_id"));

CREATE TABLE "Employee" ("employee_id" INTEGER PRIMARY KEY, "name" TEXT(255), "experience_years" INTEGER, CHECK ("experience_years" >= 0));

-- Loading data
PRAGMA foreign_keys = OFF;
INSERT INTO "Project" ("project_id", "employee_id") VALUES (8, 10);
INSERT INTO "Project" ("project_id", "employee_id") VALUES (8, 9);
INSERT INTO "Employee" ("employee_id", "name", "experience_years") VALUES (10, NULL, 10640);
INSERT INTO "Employee" ("employee_id", "name", "experience_years") VALUES (9, '16', NULL);
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT A.project_id, ROUND(AVG(B.experience_years), 2) AS average_years FROM Project AS A INNER JOIN Employee AS B ON A.employee_id = B.employee_id GROUP BY A.project_id;

/*
Gold Result:
(8, 10640.0)
*/

-- Prediction Query
SELECT PROJECT.PROJECT_ID, ROUND(CAST(SUM(EMPLOYEE.EXPERIENCE_YEARS) AS REAL) / COUNT(PROJECT.PROJECT_ID), 2) AS AVERAGE_YEARS FROM PROJECT INNER JOIN EMPLOYEE ON PROJECT.EMPLOYEE_ID = EMPLOYEE.EMPLOYEE_ID GROUP BY PROJECT.PROJECT_ID;

/*
Prediction Result:
(8, 5320.0)
*/