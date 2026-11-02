-- Schema DDL
CREATE TABLE "Project" ("project_id" INTEGER, "employee_id" INTEGER, PRIMARY KEY ("project_id", "employee_id"), FOREIGN KEY ("employee_id") REFERENCES "Employee" ("employee_id"));

CREATE TABLE "Employee" ("employee_id" INTEGER PRIMARY KEY, "name" TEXT(255), "experience_years" INTEGER, CHECK ("experience_years" >= 0));

-- Loading data
PRAGMA foreign_keys = OFF;
INSERT INTO "Project" ("project_id", "employee_id") VALUES (13, 15);
INSERT INTO "Project" ("project_id", "employee_id") VALUES (12, 14);
INSERT INTO "Employee" ("employee_id", "name", "experience_years") VALUES (15, NULL, 2759);
INSERT INTO "Employee" ("employee_id", "name", "experience_years") VALUES (14, '21', 2759);
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT A.project_id, ROUND(AVG(B.experience_years), 2) AS average_years FROM Project AS A INNER JOIN Employee AS B ON A.employee_id = B.employee_id GROUP BY A.project_id;

/*
Gold Result:
(12, 2759.0)
(13, 2759.0)
*/

-- Prediction Query
WITH CTE AS (SELECT P.PROJECT_ID, AVG(E.EXPERIENCE_YEARS) OVER (PARTITION BY P.PROJECT_ID) AS AVERAGE FROM PROJECT AS P INNER JOIN EMPLOYEE AS E ON P.EMPLOYEE_ID = E.EMPLOYEE_ID) SELECT DISTINCT PROJECT_ID, ROUND(AVERAGE, 2) AS AVERAGE_YEARS FROM CTE;

/*
Prediction Result:
(12, 2759.0)
(13, 2759.0)
*/