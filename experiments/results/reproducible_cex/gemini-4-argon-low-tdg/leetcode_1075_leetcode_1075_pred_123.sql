-- Schema DDL
CREATE TABLE "Project" ("project_id" INTEGER, "employee_id" INTEGER, PRIMARY KEY ("project_id", "employee_id"), FOREIGN KEY ("employee_id") REFERENCES "Employee" ("employee_id"));

CREATE TABLE "Employee" ("employee_id" INTEGER PRIMARY KEY, "name" TEXT(255), "experience_years" INTEGER, CHECK ("experience_years" >= 0));

-- Loading data
PRAGMA foreign_keys = OFF;
-- DATASET 2
INSERT INTO Employee (employee_id, name, experience_years) VALUES (1, 'Alice', 0);
INSERT INTO Employee (employee_id, name, experience_years) VALUES (2, 'Bob', 5);
INSERT INTO Employee (employee_id, name, experience_years) VALUES (3, 'Charlie', NULL);
INSERT INTO Employee (employee_id, name, experience_years) VALUES (4, 'David', NULL);
INSERT INTO Project (project_id, employee_id) VALUES (1, 1);
INSERT INTO Project (project_id, employee_id) VALUES (1, 2);
INSERT INTO Project (project_id, employee_id) VALUES (1, 3);
INSERT INTO Project (project_id, employee_id) VALUES (2, 1);
INSERT INTO Project (project_id, employee_id) VALUES (3, 4);
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT A.project_id, ROUND(AVG(B.experience_years), 2) AS average_years FROM Project AS A INNER JOIN Employee AS B ON A.employee_id = B.employee_id GROUP BY A.project_id;

/*
Gold Result:
(1, 2.5)
(2, 0.0)
(3, None)
*/

-- Prediction Query
WITH SUB AS (SELECT P.PROJECT_ID AS PROJECT_ID1, E.EMPLOYEE_ID, E.EXPERIENCE_YEARS AS EY FROM PROJECT AS P JOIN EMPLOYEE AS E ON P.EMPLOYEE_ID = E.EMPLOYEE_ID) SELECT PROJECT_ID1 AS PROJECT_ID, ROUND(CAST(SUM(EY) AS REAL) / COUNT(PROJECT_ID1), 2) AS AVERAGE_YEARS FROM SUB GROUP BY PROJECT_ID1 ORDER BY PROJECT_ID1, PROJECT_ID NULLS LAST, AVERAGE_YEARS NULLS LAST;

/*
Prediction Result:
(1, 1.67)
(2, 0.0)
(3, None)
*/