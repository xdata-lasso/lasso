-- Schema DDL
CREATE TABLE "Project" ("project_id" INTEGER, "employee_id" INTEGER, PRIMARY KEY ("project_id", "employee_id"), FOREIGN KEY ("employee_id") REFERENCES "Employee" ("employee_id"));

CREATE TABLE "Employee" ("employee_id" INTEGER PRIMARY KEY, "name" TEXT(255), "experience_years" INTEGER, CHECK ("experience_years" >= 0));

-- Loading data
PRAGMA foreign_keys = OFF;
INSERT INTO employee (employee_id, name, experience_years) VALUES (2, NULL, 1), (3, 'default1', NULL), (0, NULL, 3), (1, 'default1', NULL), (4, 'default2', NULL), (5, 'default1', NULL), (6, NULL, 0), (7, 'default1', NULL), (8, 'default2', 3), (9, 'default1', NULL), (10, NULL, 0), (11, NULL, NULL), (12, 'default2', 2), (13, 'default2', 0), (14, 'default2', 0), (15, 'default1', NULL);
INSERT INTO project (project_id, employee_id) VALUES (0, 1), (1, 12), (0, 4), (2, 2), (2, 1), (1, 11), (0, 3), (2, 0), (3, 10), (2, 3), (1, 13), (0, 5), (3, 6), (2, 11), (0, 11), (2, 8);
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT A.project_id, ROUND(AVG(B.experience_years), 2) AS average_years FROM Project AS A INNER JOIN Employee AS B ON A.employee_id = B.employee_id GROUP BY A.project_id;

/*
Gold Result:
(0, None)
(1, 1.0)
(2, 2.33)
(3, 0.0)
*/

-- Prediction Query
SELECT PROJECT.PROJECT_ID, ROUND(CAST(SUM(EMPLOYEE.EXPERIENCE_YEARS) AS REAL) / COUNT(PROJECT.PROJECT_ID), 2) AS AVERAGE_YEARS FROM PROJECT INNER JOIN EMPLOYEE ON PROJECT.EMPLOYEE_ID = EMPLOYEE.EMPLOYEE_ID GROUP BY PROJECT.PROJECT_ID;

/*
Prediction Result:
(0, None)
(1, 0.67)
(2, 1.17)
(3, 0.0)
*/