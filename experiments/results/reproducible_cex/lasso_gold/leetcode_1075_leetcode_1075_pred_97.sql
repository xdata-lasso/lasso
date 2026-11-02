-- Schema DDL
CREATE TABLE "Project" ("project_id" INTEGER, "employee_id" INTEGER, PRIMARY KEY ("project_id", "employee_id"), FOREIGN KEY ("employee_id") REFERENCES "Employee" ("employee_id"));

CREATE TABLE "Employee" ("employee_id" INTEGER PRIMARY KEY, "name" TEXT(255), "experience_years" INTEGER, CHECK ("experience_years" >= 0));

-- Loading data
PRAGMA foreign_keys = OFF;
INSERT INTO "employee" ("employee_id", "name", "experience_years") VALUES (1017, 'Daniel Wagner', 1018);
INSERT INTO "employee" ("employee_id", "name", "experience_years") VALUES (1020, 'Cristian Santos', NULL);
INSERT INTO "project" ("project_id", "employee_id") VALUES (1019, 1017);
INSERT INTO "project" ("project_id", "employee_id") VALUES (1022, 1020);
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT A.project_id, ROUND(AVG(B.experience_years), 2) AS average_years FROM Project AS A INNER JOIN Employee AS B ON A.employee_id = B.employee_id GROUP BY A.project_id;

/*
Gold Result:
(1019, 1018.0)
(1022, None)
*/

-- Prediction Query
SELECT A.PROJECT_ID, ROUND(CAST(A.EXP AS REAL) / A.CNT, 2) AS AVERAGE_YEARS FROM (SELECT A.PROJECT_ID, SUM(COALESCE(B.EXPERIENCE_YEARS, 0)) AS EXP, IIF(COUNT(*) = 0, 1, COUNT(*)) AS CNT FROM PROJECT AS A LEFT JOIN EMPLOYEE AS B ON A.EMPLOYEE_ID = B.EMPLOYEE_ID GROUP BY PROJECT_ID) AS A;

/*
Prediction Result:
(1019, 1018.0)
(1022, 0.0)
*/