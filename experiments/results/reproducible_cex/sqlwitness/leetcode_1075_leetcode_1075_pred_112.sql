-- Schema DDL
CREATE TABLE "Project" ("project_id" INTEGER, "employee_id" INTEGER, PRIMARY KEY ("project_id", "employee_id"), FOREIGN KEY ("employee_id") REFERENCES "Employee" ("employee_id"));

CREATE TABLE "Employee" ("employee_id" INTEGER PRIMARY KEY, "name" TEXT(255), "experience_years" INTEGER, CHECK ("experience_years" >= 0));

-- Loading data
PRAGMA foreign_keys = OFF;
INSERT INTO employee (employee_id, name, experience_years) VALUES (2, 'default1', NULL), (1, NULL, 0), (3, NULL, NULL), (0, NULL, 3), (4, 'default1', NULL), (5, 'default2', 3), (6, 'default2', 1), (7, NULL, NULL), (8, NULL, NULL), (9, 'default1', NULL), (10, 'default1', 0);
INSERT INTO project (project_id, employee_id) VALUES (2, 7), (1, 4), (1, 6), (1, 0), (1, 3), (1, 7);
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT A.project_id, ROUND(AVG(B.experience_years), 2) AS average_years FROM Project AS A INNER JOIN Employee AS B ON A.employee_id = B.employee_id GROUP BY A.project_id;

/*
Gold Result:
(1, 2.0)
(2, None)
*/

-- Prediction Query
SELECT P.PROJECT_ID, ROUND(CAST(SUM(E.EXPERIENCE_YEARS) AS REAL) / COUNT(E.EMPLOYEE_ID), 2) AS AVERAGE_YEARS FROM PROJECT AS P LEFT JOIN EMPLOYEE AS E ON E.EMPLOYEE_ID = P.EMPLOYEE_ID GROUP BY PROJECT_ID;

/*
Prediction Result:
(1, 0.8)
(2, None)
*/