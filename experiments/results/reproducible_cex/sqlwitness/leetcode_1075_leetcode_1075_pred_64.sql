-- Schema DDL
CREATE TABLE "Project" ("project_id" INTEGER, "employee_id" INTEGER, PRIMARY KEY ("project_id", "employee_id"), FOREIGN KEY ("employee_id") REFERENCES "Employee" ("employee_id"));

CREATE TABLE "Employee" ("employee_id" INTEGER PRIMARY KEY, "name" TEXT(255), "experience_years" INTEGER, CHECK ("experience_years" >= 0));

-- Loading data
PRAGMA foreign_keys = OFF;
INSERT INTO employee (employee_id, name, experience_years) VALUES (0, 'default1', 2), (2, NULL, 0), (1, 'default1', 3), (3, 'default2', 2), (4, 'default2', 2), (5, 'default2', NULL), (6, 'default2', 1), (7, 'default2', NULL);
INSERT INTO project (project_id, employee_id) VALUES (1, 6), (3, 4), (1, 7), (0, 2), (2, 1), (1, 5);
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT A.project_id, ROUND(AVG(B.experience_years), 2) AS average_years FROM Project AS A INNER JOIN Employee AS B ON A.employee_id = B.employee_id GROUP BY A.project_id;

/*
Gold Result:
(0, 0.0)
(1, 1.0)
(2, 3.0)
(3, 2.0)
*/

-- Prediction Query
WITH T AS (SELECT A.PROJECT_ID, A.EMPLOYEE_ID, B.EXPERIENCE_YEARS, ROUND(CAST(SUM(B.EXPERIENCE_YEARS) AS REAL) / COUNT(A.EMPLOYEE_ID), 2) AS AVERAGE_YEARS FROM PROJECT AS A LEFT JOIN EMPLOYEE AS B ON A.EMPLOYEE_ID = B.EMPLOYEE_ID GROUP BY A.PROJECT_ID) SELECT PROJECT_ID, AVERAGE_YEARS FROM T GROUP BY PROJECT_ID;

/*
Prediction Result:
(0, 0.0)
(1, 0.33)
(2, 3.0)
(3, 2.0)
*/