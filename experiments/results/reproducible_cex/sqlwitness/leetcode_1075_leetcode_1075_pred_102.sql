-- Schema DDL
CREATE TABLE "Project" ("project_id" INTEGER, "employee_id" INTEGER, PRIMARY KEY ("project_id", "employee_id"), FOREIGN KEY ("employee_id") REFERENCES "Employee" ("employee_id"));

CREATE TABLE "Employee" ("employee_id" INTEGER PRIMARY KEY, "name" TEXT(255), "experience_years" INTEGER, CHECK ("experience_years" >= 0));

-- Loading data
PRAGMA foreign_keys = OFF;
INSERT INTO employee (employee_id, name, experience_years) VALUES (3, NULL, 3), (2, 'default1', 2), (1, 'default2', 1), (0, 'default2', NULL), (4, 'default2', NULL);
INSERT INTO project (project_id, employee_id) VALUES (2, 4), (1, 1), (2, 0), (2, 3), (3, 3);
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT A.project_id, ROUND(AVG(B.experience_years), 2) AS average_years FROM Project AS A INNER JOIN Employee AS B ON A.employee_id = B.employee_id GROUP BY A.project_id;

/*
Gold Result:
(1, 1.0)
(2, 3.0)
(3, 3.0)
*/

-- Prediction Query
SELECT PROJECT_ID, ROUND(CAST(1.0 * SUM(EXPERIENCE_YEARS) AS REAL) / COUNT(DISTINCT P.EMPLOYEE_ID), 2) AS AVERAGE_YEARS FROM PROJECT AS P LEFT JOIN EMPLOYEE AS E ON P.EMPLOYEE_ID = E.EMPLOYEE_ID GROUP BY PROJECT_ID;

/*
Prediction Result:
(1, 1.0)
(2, 1.0)
(3, 3.0)
*/