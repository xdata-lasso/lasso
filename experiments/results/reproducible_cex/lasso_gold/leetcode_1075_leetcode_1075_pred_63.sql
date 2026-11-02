-- Schema DDL
CREATE TABLE "Project" ("project_id" INTEGER, "employee_id" INTEGER, PRIMARY KEY ("project_id", "employee_id"), FOREIGN KEY ("employee_id") REFERENCES "Employee" ("employee_id"));

CREATE TABLE "Employee" ("employee_id" INTEGER PRIMARY KEY, "name" TEXT(255), "experience_years" INTEGER, CHECK ("experience_years" >= 0));

-- Loading data
PRAGMA foreign_keys = OFF;
INSERT INTO "project" ("project_id", "employee_id") VALUES (1041, NULL);
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT A.project_id, ROUND(AVG(B.experience_years), 2) AS average_years FROM Project AS A INNER JOIN Employee AS B ON A.employee_id = B.employee_id GROUP BY A.project_id;

/*
Gold Result:
*/

-- Prediction Query
WITH PROJ_EXP AS (SELECT A.*, B.EXPERIENCE_YEARS FROM PROJECT AS A LEFT JOIN EMPLOYEE AS B ON A.EMPLOYEE_ID = B.EMPLOYEE_ID) SELECT PROJECT_ID, ROUND(AVG(EXPERIENCE_YEARS), 2) AS AVERAGE_YEARS FROM PROJ_EXP GROUP BY PROJECT_ID ORDER BY PROJECT_ID, AVERAGE_YEARS NULLS LAST;

/*
Prediction Result:
(1041, None)
*/