-- Schema DDL
CREATE TABLE "Project" ("project_id" INTEGER, "employee_id" INTEGER, PRIMARY KEY ("project_id", "employee_id"), FOREIGN KEY ("employee_id") REFERENCES "Employee" ("employee_id"));

CREATE TABLE "Employee" ("employee_id" INTEGER PRIMARY KEY, "name" TEXT(255), "experience_years" INTEGER, CHECK ("experience_years" >= 0));

-- Loading data
PRAGMA foreign_keys = OFF;
INSERT INTO employee (employee_id, name, experience_years) VALUES (1, 'default2', 0), (3, 'default2', 0), (2, NULL, 1), (0, 'default2', 0), (4, 'default2', NULL), (5, 'default1', 0), (6, 'default2', 3), (7, 'default1', 1), (8, 'default2', 3), (9, 'default2', 3), (10, NULL, 1), (11, 'default1', 1);
INSERT INTO project (project_id, employee_id) VALUES (2, 4), (2, 1), (2, 7), (1, 1), (0, 6), (2, 3), (3, 6), (2, 2), (1, 0), (3, 5);
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT A.project_id, ROUND(AVG(B.experience_years), 2) AS average_years FROM Project AS A INNER JOIN Employee AS B ON A.employee_id = B.employee_id GROUP BY A.project_id;

/*
Gold Result:
(0, 3.0)
(1, 0.0)
(2, 0.5)
(3, 1.5)
*/

-- Prediction Query
SELECT A.PROJECT_ID, ROUND(CAST(SUM(B.EXPERIENCE_YEARS) AS REAL) / COUNT(B.EMPLOYEE_ID), 2) AS AVERAGE_YEARS FROM PROJECT AS A JOIN EMPLOYEE AS B ON A.EMPLOYEE_ID = B.EMPLOYEE_ID GROUP BY A.PROJECT_ID;

/*
Prediction Result:
(0, 3.0)
(1, 0.0)
(2, 0.4)
(3, 1.5)
*/