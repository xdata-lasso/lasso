-- Schema DDL
CREATE TABLE "Project" ("project_id" INTEGER, "employee_id" INTEGER, PRIMARY KEY ("project_id", "employee_id"), FOREIGN KEY ("employee_id") REFERENCES "Employee" ("employee_id"));

CREATE TABLE "Employee" ("employee_id" INTEGER PRIMARY KEY, "name" TEXT(255), "experience_years" INTEGER, CHECK ("experience_years" >= 0));

-- Loading data
PRAGMA foreign_keys = OFF;
INSERT INTO "employee" ("employee_id", "name", "experience_years") VALUES (1130, 'Patty Perez', 1131);
INSERT INTO "employee" ("employee_id", "name", "experience_years") VALUES (1135, 'Patty Perez', 1131);
INSERT INTO "employee" ("employee_id", "name", "experience_years") VALUES (1136, 'Ethan Adams', 1137);
INSERT INTO "employee" ("employee_id", "name", "experience_years") VALUES (1140, 'Ethan Adams', 1137);
INSERT INTO "project" ("project_id", "employee_id") VALUES (1132, 1130);
INSERT INTO "project" ("project_id", "employee_id") VALUES (1133, 1130);
INSERT INTO "project" ("project_id", "employee_id") VALUES (NULL, 1136);
INSERT INTO "project" ("project_id", "employee_id") VALUES (1138, 1136);
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT A.project_id, ROUND(AVG(B.experience_years), 2) AS average_years FROM Project AS A INNER JOIN Employee AS B ON A.employee_id = B.employee_id GROUP BY A.project_id;

/*
Gold Result:
(None, 1137.0)
(1132, 1131.0)
(1133, 1131.0)
(1138, 1137.0)
*/

-- Prediction Query
SELECT B.PROJECT_ID, ROUND(AVG(EXPERIENCE_YEARS), 2) AS AVERAGE_YEARS FROM EMPLOYEE AS A LEFT JOIN PROJECT AS B ON A.EMPLOYEE_ID = B.EMPLOYEE_ID WHERE NOT B.PROJECT_ID IS NULL GROUP BY 1;

/*
Prediction Result:
(1132, 1131.0)
(1133, 1131.0)
(1138, 1137.0)
*/