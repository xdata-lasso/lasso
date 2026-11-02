-- Schema DDL
CREATE TABLE "Project" ("project_id" INTEGER, "employee_id" INTEGER, PRIMARY KEY ("project_id", "employee_id"), FOREIGN KEY ("employee_id") REFERENCES "Employee" ("employee_id"));

CREATE TABLE "Employee" ("employee_id" INTEGER PRIMARY KEY, "name" TEXT(255), "experience_years" INTEGER, CHECK ("experience_years" >= 0));

-- Loading data
PRAGMA foreign_keys = OFF;
INSERT INTO employee (employee_id, name, experience_years) VALUES (3, 'default1', 2), (0, 'default1', NULL), (1, 'default2', 0), (2, 'default2', 2), (4, 'default1', NULL), (5, 'default1', 2), (6, NULL, NULL), (7, 'default2', 3), (8, NULL, 3), (9, 'default1', 0), (10, 'default2', 1), (11, 'default2', 1), (12, 'default2', 2);
INSERT INTO project (project_id, employee_id) VALUES (0, 1), (0, 7), (0, 4), (1, 8), (2, 0), (2, 3), (3, 9), (1, 10), (1, 0), (1, 6), (0, 8), (2, 11);
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT A.project_id, ROUND(AVG(B.experience_years), 2) AS average_years FROM Project AS A INNER JOIN Employee AS B ON A.employee_id = B.employee_id GROUP BY A.project_id;

/*
Gold Result:
(0, 2.0)
(1, 2.0)
(2, 1.5)
(3, 0.0)
*/

-- Prediction Query
WITH SUB AS (SELECT P.PROJECT_ID AS PROJECT_ID1, E.EMPLOYEE_ID, E.EXPERIENCE_YEARS AS EY FROM PROJECT AS P JOIN EMPLOYEE AS E ON P.EMPLOYEE_ID = E.EMPLOYEE_ID) SELECT PROJECT_ID1 AS PROJECT_ID, ROUND(CAST(SUM(EY) AS REAL) / COUNT(PROJECT_ID1), 2) AS AVERAGE_YEARS FROM SUB GROUP BY PROJECT_ID1 ORDER BY PROJECT_ID1, PROJECT_ID NULLS LAST, AVERAGE_YEARS NULLS LAST;

/*
Prediction Result:
(0, 1.5)
(1, 1.0)
(2, 1.0)
(3, 0.0)
*/