-- Schema DDL
CREATE TABLE "Project" ("project_id" INTEGER, "employee_id" INTEGER, PRIMARY KEY ("project_id", "employee_id"), FOREIGN KEY ("employee_id") REFERENCES "Employee" ("employee_id"));

CREATE TABLE "Employee" ("employee_id" INTEGER PRIMARY KEY, "name" TEXT(255), "experience_years" INTEGER, CHECK ("experience_years" >= 0));

-- Loading data
PRAGMA foreign_keys = OFF;
INSERT INTO "employee" ("employee_id", "name", "experience_years") VALUES (1017, 'Daniel Wagner', 1018);
INSERT INTO "employee" ("employee_id", "name", "experience_years") VALUES (1020, 'Cristian Santos', NULL);
INSERT INTO "employee" ("employee_id", "name", "experience_years") VALUES (1023, 'Connie Lawrence', 1024);
INSERT INTO "project" ("project_id", "employee_id") VALUES (1019, 1017);
INSERT INTO "project" ("project_id", "employee_id") VALUES (1022, 1020);
INSERT INTO "project" ("project_id", "employee_id") VALUES (1022, 1023);
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT A.project_id, ROUND(AVG(B.experience_years), 2) AS average_years FROM Project AS A INNER JOIN Employee AS B ON A.employee_id = B.employee_id GROUP BY A.project_id;

/*
Gold Result:
(1019, 1018.0)
(1022, 1024.0)
*/

-- Prediction Query
SELECT PROJECT_ID, ROUND((CAST(SUM(EXPERIENCE_YEARS) AS REAL) / COUNT(P.EMPLOYEE_ID)), 2) AS AVERAGE_YEARS FROM PROJECT AS P INNER JOIN EMPLOYEE AS E ON P.EMPLOYEE_ID = E.EMPLOYEE_ID GROUP BY PROJECT_ID ORDER BY PROJECT_ID, AVERAGE_YEARS NULLS LAST;

/*
Prediction Result:
(1019, 1018.0)
(1022, 512.0)
*/