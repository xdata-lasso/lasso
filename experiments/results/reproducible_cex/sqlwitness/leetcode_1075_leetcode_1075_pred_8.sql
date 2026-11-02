-- Schema DDL
CREATE TABLE "Project" ("project_id" INTEGER, "employee_id" INTEGER, PRIMARY KEY ("project_id", "employee_id"), FOREIGN KEY ("employee_id") REFERENCES "Employee" ("employee_id"));

CREATE TABLE "Employee" ("employee_id" INTEGER PRIMARY KEY, "name" TEXT(255), "experience_years" INTEGER, CHECK ("experience_years" >= 0));

-- Loading data
PRAGMA foreign_keys = OFF;
INSERT INTO employee (employee_id, name, experience_years) VALUES (0, 'default2', 2), (3, NULL, 0), (2, 'default2', 1), (1, NULL, 0), (4, 'default2', NULL), (5, NULL, 0), (6, NULL, 1), (7, 'default1', 0), (8, 'default2', 2), (9, 'default2', 1);
INSERT INTO project (project_id, employee_id) VALUES (2, 4), (0, 3), (2, 0), (1, 4), (2, 9), (3, 3), (3, 6), (3, 2), (2, 5), (1, 3);
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT A.project_id, ROUND(AVG(B.experience_years), 2) AS average_years FROM Project AS A INNER JOIN Employee AS B ON A.employee_id = B.employee_id GROUP BY A.project_id;

/*
Gold Result:
(0, 0.0)
(1, 0.0)
(2, 1.0)
(3, 0.67)
*/

-- Prediction Query
SELECT P.PROJECT_ID, ROUND(CAST(SUM(E.EXPERIENCE_YEARS) AS REAL) / COUNT(E.EMPLOYEE_ID), 2) AS AVERAGE_YEARS FROM PROJECT AS P CROSS JOIN EMPLOYEE AS E WHERE P.EMPLOYEE_ID = E.EMPLOYEE_ID GROUP BY P.PROJECT_ID;

/*
Prediction Result:
(0, 0.0)
(1, 0.0)
(2, 0.75)
(3, 0.67)
*/