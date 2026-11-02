-- Schema DDL
CREATE TABLE "Project" ("project_id" INTEGER, "employee_id" INTEGER, PRIMARY KEY ("project_id", "employee_id"), FOREIGN KEY ("employee_id") REFERENCES "Employee" ("employee_id"));

CREATE TABLE "Employee" ("employee_id" INTEGER PRIMARY KEY, "name" TEXT(255), "experience_years" INTEGER, CHECK ("experience_years" >= 0));

-- Loading data
PRAGMA foreign_keys = OFF;
INSERT INTO employee (employee_id, name, experience_years) VALUES (0, 'default2', 3), (1, NULL, 2), (2, NULL, 3), (3, NULL, 3), (4, 'default2', NULL), (5, NULL, 1), (6, 'default2', NULL), (7, 'default1', 0), (8, NULL, NULL), (9, 'default2', 2), (10, 'default1', NULL), (11, NULL, 2);
INSERT INTO project (project_id, employee_id) VALUES (2, 4), (1, 11), (1, 4), (2, 3), (1, 0);
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT A.project_id, ROUND(AVG(B.experience_years), 2) AS average_years FROM Project AS A INNER JOIN Employee AS B ON A.employee_id = B.employee_id GROUP BY A.project_id;

/*
Gold Result:
(1, 2.5)
(2, 3.0)
*/

-- Prediction Query
SELECT PROJECT_ID, ROUND(CAST(SUM(EXPERIENCE_YEARS) AS REAL) / COUNT(PROJECT_ID), 2) AS AVERAGE_YEARS FROM PROJECT LEFT JOIN EMPLOYEE USING (EMPLOYEE_ID) GROUP BY 1;

/*
Prediction Result:
(1, 1.67)
(2, 1.5)
*/