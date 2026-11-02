-- Schema DDL
CREATE TABLE "Project" ("project_id" INTEGER, "employee_id" INTEGER, PRIMARY KEY ("project_id", "employee_id"), FOREIGN KEY ("employee_id") REFERENCES "Employee" ("employee_id"));

CREATE TABLE "Employee" ("employee_id" INTEGER PRIMARY KEY, "name" TEXT(255), "experience_years" INTEGER, CHECK ("experience_years" >= 0));

-- Loading data
PRAGMA foreign_keys = OFF;
INSERT INTO "Project" ("project_id", "employee_id") VALUES (66, 67);
INSERT INTO "Project" ("project_id", "employee_id") VALUES (66, 68);
INSERT INTO "Employee" ("employee_id", "name", "experience_years") VALUES (67, '15', 9338);
INSERT INTO "Employee" ("employee_id", "name", "experience_years") VALUES (68, NULL, NULL);
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT A.project_id, ROUND(AVG(B.experience_years), 2) AS average_years FROM Project AS A INNER JOIN Employee AS B ON A.employee_id = B.employee_id GROUP BY A.project_id;

/*
Gold Result:
(66, 9338.0)
*/

-- Prediction Query
SELECT PROJECT_ID, ROUND(CAST(SUM(EXPERIENCE_YEARS) AS REAL(10, 2)) / CAST(COUNT(EMPLOYEE_ID) AS REAL(10, 2)), 2) AS AVERAGE_YEARS FROM (SELECT PROJECT_ID, P.EMPLOYEE_ID, EXPERIENCE_YEARS FROM PROJECT AS P INNER JOIN EMPLOYEE AS E ON P.EMPLOYEE_ID = E.EMPLOYEE_ID) AS SUB GROUP BY PROJECT_ID;

/*
Prediction Result:
(66, 4669.0)
*/