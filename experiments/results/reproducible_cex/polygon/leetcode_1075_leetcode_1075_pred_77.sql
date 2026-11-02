-- Schema DDL
CREATE TABLE "Project" ("project_id" INTEGER, "employee_id" INTEGER, PRIMARY KEY ("project_id", "employee_id"), FOREIGN KEY ("employee_id") REFERENCES "Employee" ("employee_id"));

CREATE TABLE "Employee" ("employee_id" INTEGER PRIMARY KEY, "name" TEXT(255), "experience_years" INTEGER, CHECK ("experience_years" >= 0));

-- Loading data
PRAGMA foreign_keys = OFF;
INSERT INTO "Project" ("project_id", "employee_id") VALUES (68, 67);
INSERT INTO "Project" ("project_id", "employee_id") VALUES (68, 69);
INSERT INTO "Employee" ("employee_id", "name", "experience_years") VALUES (67, '15', 12008);
INSERT INTO "Employee" ("employee_id", "name", "experience_years") VALUES (69, '16', NULL);
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT A.project_id, ROUND(AVG(B.experience_years), 2) AS average_years FROM Project AS A INNER JOIN Employee AS B ON A.employee_id = B.employee_id GROUP BY A.project_id;

/*
Gold Result:
(68, 12008.0)
*/

-- Prediction Query
SELECT TEMP.PROJECT_ID, ROUND(CAST(SUM(TEMP.EXPERIENCE_YEARS) AS REAL) / COUNT(*), 2) AS AVERAGE_YEARS FROM (SELECT E.EMPLOYEE_ID, E.EXPERIENCE_YEARS, P.PROJECT_ID FROM EMPLOYEE AS E JOIN PROJECT AS P ON E.EMPLOYEE_ID = P.EMPLOYEE_ID) AS TEMP GROUP BY TEMP.PROJECT_ID;

/*
Prediction Result:
(68, 6004.0)
*/