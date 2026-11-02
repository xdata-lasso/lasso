-- Schema DDL
CREATE TABLE "Project" ("project_id" INTEGER, "employee_id" INTEGER, PRIMARY KEY ("project_id", "employee_id"), FOREIGN KEY ("employee_id") REFERENCES "Employee" ("employee_id"));

CREATE TABLE "Employee" ("employee_id" INTEGER PRIMARY KEY, "name" TEXT(255), "experience_years" INTEGER, CHECK ("experience_years" >= 0));

-- Loading data
PRAGMA foreign_keys = OFF;
INSERT INTO "Project" ("project_id", "employee_id") VALUES (13, 12);
INSERT INTO "Project" ("project_id", "employee_id") VALUES (13, 11);
INSERT INTO "Employee" ("employee_id", "name", "experience_years") VALUES (11, NULL, NULL);
INSERT INTO "Employee" ("employee_id", "name", "experience_years") VALUES (12, '19', 1);
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT A.project_id, ROUND(AVG(B.experience_years), 2) AS average_years FROM Project AS A INNER JOIN Employee AS B ON A.employee_id = B.employee_id GROUP BY A.project_id;

/*
Gold Result:
(13, 1.0)
*/

-- Prediction Query
SELECT P.PROJECT_ID, ROUND(CAST(SUM(E.EXPERIENCE_YEARS) AS REAL) / COUNT(E.EMPLOYEE_ID), 2) AS AVERAGE_YEARS FROM PROJECT AS P LEFT JOIN EMPLOYEE AS E ON E.EMPLOYEE_ID = P.EMPLOYEE_ID GROUP BY PROJECT_ID;

/*
Prediction Result:
(13, 0.5)
*/