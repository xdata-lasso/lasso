-- Schema DDL
CREATE TABLE "Project" ("project_id" INTEGER, "employee_id" INTEGER, PRIMARY KEY ("project_id", "employee_id"), FOREIGN KEY ("employee_id") REFERENCES "Employee" ("employee_id"));

CREATE TABLE "Employee" ("employee_id" INTEGER PRIMARY KEY, "name" TEXT(255), "experience_years" INTEGER, CHECK ("experience_years" >= 0));

-- Loading data
PRAGMA foreign_keys = OFF;
INSERT INTO "Project" ("project_id", "employee_id") VALUES (14, 12);
INSERT INTO "Project" ("project_id", "employee_id") VALUES (13, 12);
INSERT INTO "Employee" ("employee_id", "name", "experience_years") VALUES (12, NULL, 0);
INSERT INTO "Employee" ("employee_id", "name", "experience_years") VALUES (69, NULL, 0);
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT A.project_id, ROUND(AVG(B.experience_years), 2) AS average_years FROM Project AS A INNER JOIN Employee AS B ON A.employee_id = B.employee_id GROUP BY A.project_id;

/*
Gold Result:
(13, 0.0)
(14, 0.0)
*/

-- Prediction Query
SELECT B.PROJECT_ID, ROUND((CAST(SUM(A.EXPERIENCE_YEARS) AS REAL) / COUNT(A.EXPERIENCE_YEARS)), 2) AS AVERAGE_YEARS FROM EMPLOYEE AS A LEFT JOIN PROJECT AS B ON A.EMPLOYEE_ID = B.EMPLOYEE_ID WHERE B.PROJECT_ID GROUP BY B.PROJECT_ID;

/*
Prediction Result:
(13, 0.0)
(14, 0.0)
*/