-- Schema DDL
CREATE TABLE "Project" ("project_id" INTEGER, "employee_id" INTEGER, PRIMARY KEY ("project_id", "employee_id"), FOREIGN KEY ("employee_id") REFERENCES "Employee" ("employee_id"));

CREATE TABLE "Employee" ("employee_id" INTEGER PRIMARY KEY, "name" TEXT(255), "experience_years" INTEGER, CHECK ("experience_years" >= 0));

-- Loading data
PRAGMA foreign_keys = OFF;
INSERT INTO "Project" ("project_id", "employee_id") VALUES (11, 13);
INSERT INTO "Project" ("project_id", "employee_id") VALUES (11, 12);
INSERT INTO "Employee" ("employee_id", "name", "experience_years") VALUES (13, '18', 1);
INSERT INTO "Employee" ("employee_id", "name", "experience_years") VALUES (12, '19', NULL);
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT A.project_id, ROUND(AVG(B.experience_years), 2) AS average_years FROM Project AS A INNER JOIN Employee AS B ON A.employee_id = B.employee_id GROUP BY A.project_id;

/*
Gold Result:
(11, 1.0)
*/

-- Prediction Query
SELECT PROJECT_ID, ROUND(CAST(SUM(EXPERIENCE_YEARS) AS REAL) / COUNT(*), 2) AS AVERAGE_YEARS FROM PROJECT AS A LEFT JOIN EMPLOYEE AS B USING (EMPLOYEE_ID) GROUP BY PROJECT_ID;

/*
Prediction Result:
(11, 0.5)
*/