-- Schema DDL
CREATE TABLE "Project" ("project_id" INTEGER, "employee_id" INTEGER, PRIMARY KEY ("project_id", "employee_id"), FOREIGN KEY ("employee_id") REFERENCES "Employee" ("employee_id"));

CREATE TABLE "Employee" ("employee_id" INTEGER PRIMARY KEY, "name" TEXT(255), "experience_years" INTEGER, CHECK ("experience_years" >= 0));

-- Loading data
PRAGMA foreign_keys = OFF;
-- Inserting into table: employee --
INSERT INTO "employee" ("employee_id", "name", "experience_years") VALUES (1, 'emp_4bd5b3', 247012447);

INSERT INTO "employee" ("employee_id", "name", "experience_years") VALUES (-2147483647, 'emp_4bd5b3', 1744686505);

INSERT INTO "employee" ("employee_id", "name", "experience_years") VALUES (5, 'emp_4bd5b3', 1115440883);

INSERT INTO "employee" ("employee_id", "name", "experience_years") VALUES (2, 'emp_4bd5b3', 1644814318);

INSERT INTO "employee" ("employee_id", "name", "experience_years") VALUES (3, 'emp_4bd5b3', 1465859724);

INSERT INTO "employee" ("employee_id", "name", "experience_years") VALUES (4, 'emp_4bd5b3', 1019800248);

INSERT INTO "employee" ("employee_id", "name", "experience_years") VALUES (7, 'emp_4bd5b3', 0);

INSERT INTO "employee" ("employee_id", "name", "experience_years") VALUES (6, 'emp_4bd5b3', 1);

INSERT INTO "employee" ("employee_id", "name", "experience_years") VALUES (9, 'emp_4bd5b3', 0);

INSERT INTO "employee" ("employee_id", "name", "experience_years") VALUES (11, 'emp_4bd5b3', 0);

-- Inserting into table: project --
INSERT INTO "project" ("project_id", "employee_id") VALUES (1, 1);

INSERT INTO "project" ("project_id", "employee_id") VALUES (1, 2);

INSERT INTO "project" ("project_id", "employee_id") VALUES (1, 3);

INSERT INTO "project" ("project_id", "employee_id") VALUES (1, 4);

INSERT INTO "project" ("project_id", "employee_id") VALUES (2, 7);

INSERT INTO "project" ("project_id", "employee_id") VALUES (1, 6);

INSERT INTO "project" ("project_id", "employee_id") VALUES (2, 5);

INSERT INTO "project" ("project_id", "employee_id") VALUES (8, 11);

INSERT INTO "project" ("project_id", "employee_id") VALUES (10, 6);
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT A.project_id, ROUND(AVG(B.experience_years), 2) AS average_years FROM Project AS A INNER JOIN Employee AS B ON A.employee_id = B.employee_id GROUP BY A.project_id;

/*
Gold Result:
(1, 875497347.6)
(2, 557720441.5)
(8, 0.0)
(10, 1.0)
*/

-- Prediction Query
SELECT ROUND(AVG(EXPERIENCE_YEARS), 2) AS AVERAGE_YEARS, PROJECT_ID FROM PROJECT CROSS JOIN EMPLOYEE WHERE PROJECT.EMPLOYEE_ID = EMPLOYEE.EMPLOYEE_ID GROUP BY PROJECT_ID;

/*
Prediction Result:
(875497347.6, 1)
(557720441.5, 2)
(0.0, 8)
(1.0, 10)
*/