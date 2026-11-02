-- Schema DDL
CREATE TABLE "Project" ("project_id" INTEGER, "employee_id" INTEGER, PRIMARY KEY ("project_id", "employee_id"), FOREIGN KEY ("employee_id") REFERENCES "Employee" ("employee_id"));

CREATE TABLE "Employee" ("employee_id" INTEGER PRIMARY KEY, "name" TEXT(255), "experience_years" INTEGER, CHECK ("experience_years" >= 0));

-- Loading data
PRAGMA foreign_keys = OFF;
INSERT INTO employee (employee_id, name, experience_years) VALUES (2, NULL, 3), (3, 'default1', NULL), (1, 'default2', 3), (0, 'default2', 3), (4, 'default2', 2), (5, NULL, 0), (6, 'default1', 0), (7, 'default2', 0), (8, 'default1', 1), (9, NULL, NULL), (10, 'default1', NULL), (11, 'default2', 0), (12, 'default2', 0), (13, 'default1', 1), (14, NULL, NULL), (15, NULL, 1);
INSERT INTO project (project_id, employee_id) VALUES (0, 7), (3, 4), (1, 11), (0, 13), (1, 1), (0, 3), (3, 10), (3, 0), (0, 12), (0, 2), (2, 2), (3, 12), (0, 14);
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT A.project_id, ROUND(AVG(B.experience_years), 2) AS average_years FROM Project AS A INNER JOIN Employee AS B ON A.employee_id = B.employee_id GROUP BY A.project_id;

/*
Gold Result:
(0, 1.0)
(1, 1.5)
(2, 3.0)
(3, 1.67)
*/

-- Prediction Query
SELECT P.PROJECT_ID, ROUND(CAST(SUM(E.EXPERIENCE_YEARS) AS REAL) / COUNT(P.PROJECT_ID), 2) AS AVERAGE_YEARS FROM PROJECT AS P LEFT JOIN EMPLOYEE AS E ON P.EMPLOYEE_ID = E.EMPLOYEE_ID GROUP BY PROJECT_ID;

/*
Prediction Result:
(0, 0.67)
(1, 1.5)
(2, 3.0)
(3, 1.25)
*/