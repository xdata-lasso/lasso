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
SELECT P1.PROJECT_ID, ROUND(AVG(E1.EXPERIENCE_YEARS), 2) AS AVERAGE_YEARS FROM PROJECT AS P1 LEFT JOIN EMPLOYEE AS E1 ON P1.EMPLOYEE_ID = E1.EMPLOYEE_ID GROUP BY PROJECT_ID;

/*
Prediction Result:
(1041, None)
*/