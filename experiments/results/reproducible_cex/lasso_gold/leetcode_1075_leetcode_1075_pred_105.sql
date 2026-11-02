-- Schema DDL
CREATE TABLE "Project" ("project_id" INTEGER, "employee_id" INTEGER, PRIMARY KEY ("project_id", "employee_id"), FOREIGN KEY ("employee_id") REFERENCES "Employee" ("employee_id"));

CREATE TABLE "Employee" ("employee_id" INTEGER PRIMARY KEY, "name" TEXT(255), "experience_years" INTEGER, CHECK ("experience_years" >= 0));

-- Loading data
PRAGMA foreign_keys = OFF;
INSERT INTO "employee" ("employee_id", "name", "experience_years") VALUES (1004, 'Noah Rhodes', 1005);
INSERT INTO "employee" ("employee_id", "name", "experience_years") VALUES (1010, 'Noah Rhodes', 1006);
INSERT INTO "employee" ("employee_id", "name", "experience_years") VALUES (1011, 'Noah Rhodes', 1009);
INSERT INTO "project" ("project_id", "employee_id") VALUES (1006, 1004);
INSERT INTO "project" ("project_id", "employee_id") VALUES (1006, 1010);
INSERT INTO "project" ("project_id", "employee_id") VALUES (1006, 1011);
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT A.project_id, ROUND(AVG(B.experience_years), 2) AS average_years FROM Project AS A INNER JOIN Employee AS B ON A.employee_id = B.employee_id GROUP BY A.project_id;

/*
Gold Result:
(1006, 1006.67)
*/

-- Prediction Query
SELECT P.PROJECT_ID, CAST(AVG(E.EXPERIENCE_YEARS) AS REAL(10, 2)) AS AVERAGE_YEARS FROM PROJECT AS P JOIN EMPLOYEE AS E ON P.EMPLOYEE_ID = E.EMPLOYEE_ID GROUP BY P.PROJECT_ID;

/*
Prediction Result:
(1006, 1006.6666666666666)
*/