-- Schema DDL
CREATE TABLE "Project" ("project_id" INTEGER, "employee_id" INTEGER, PRIMARY KEY ("project_id", "employee_id"), FOREIGN KEY ("employee_id") REFERENCES "Employee" ("employee_id"));

CREATE TABLE "Employee" ("employee_id" INTEGER PRIMARY KEY, "name" TEXT(255), "experience_years" INTEGER, CHECK ("experience_years" >= 0));

-- Loading data
PRAGMA foreign_keys = OFF;
INSERT INTO "Project" ("project_id", "employee_id") VALUES (12, 14);
INSERT INTO "Project" ("project_id", "employee_id") VALUES (11, 14);
INSERT INTO "Employee" ("employee_id", "name", "experience_years") VALUES (14, NULL, NULL);
INSERT INTO "Employee" ("employee_id", "name", "experience_years") VALUES (13, '14', 0);
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT A.project_id, ROUND(AVG(B.experience_years), 2) AS average_years FROM Project AS A INNER JOIN Employee AS B ON A.employee_id = B.employee_id GROUP BY A.project_id;

/*
Gold Result:
(11, None)
(12, None)
*/

-- Prediction Query
SELECT PROJECT_ID, ROUND(COALESCE(AVG(EXPERIENCE_YEARS), 0), 2) AS AVERAGE_YEARS FROM PROJECT AS P LEFT JOIN EMPLOYEE AS E ON P.EMPLOYEE_ID = E.EMPLOYEE_ID GROUP BY PROJECT_ID;

/*
Prediction Result:
(11, 0.0)
(12, 0.0)
*/