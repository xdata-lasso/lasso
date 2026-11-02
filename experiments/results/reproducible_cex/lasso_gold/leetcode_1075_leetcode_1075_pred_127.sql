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
SELECT PR.PROJECT_ID, ROUND(AVG(E.EXPERIENCE_YEARS), 2) AS AVERAGE_YEARS FROM PROJECT AS PR LEFT JOIN EMPLOYEE AS E ON PR.EMPLOYEE_ID = E.EMPLOYEE_ID GROUP BY PR.PROJECT_ID;

/*
Prediction Result:
(1041, None)
*/