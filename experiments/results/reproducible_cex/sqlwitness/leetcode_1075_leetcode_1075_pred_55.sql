-- Schema DDL
CREATE TABLE "Project" ("project_id" INTEGER, "employee_id" INTEGER, PRIMARY KEY ("project_id", "employee_id"), FOREIGN KEY ("employee_id") REFERENCES "Employee" ("employee_id"));

CREATE TABLE "Employee" ("employee_id" INTEGER PRIMARY KEY, "name" TEXT(255), "experience_years" INTEGER, CHECK ("experience_years" >= 0));

-- Loading data
PRAGMA foreign_keys = OFF;
INSERT INTO employee (employee_id, name, experience_years) VALUES (0, 'default1', 1), (3, 'default1', 3), (1, NULL, NULL), (2, NULL, 0), (4, 'default2', NULL), (5, 'default2', 2), (6, NULL, 2), (7, 'default2', 1), (8, 'default2', 3), (9, 'default1', 1), (10, 'default2', 3), (11, 'default1', 3), (12, 'default2', 2), (13, 'default2', NULL), (14, 'default2', 0), (15, 'default2', 3), (16, 'default1', 2), (17, NULL, 3), (18, 'default2', 2), (19, NULL, 2);
INSERT INTO project (project_id, employee_id) VALUES (1, 12), (1, 18), (2, 1), (3, 4), (0, 16), (3, 1), (2, 10), (2, 0), (1, 4), (3, 0), (1, 7), (2, 5), (1, 3), (1, 9);
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT A.project_id, ROUND(AVG(B.experience_years), 2) AS average_years FROM Project AS A INNER JOIN Employee AS B ON A.employee_id = B.employee_id GROUP BY A.project_id;

/*
Gold Result:
(0, 2.0)
(1, 1.8)
(2, 2.0)
(3, 1.0)
*/

-- Prediction Query
SELECT PROJECT_ID, ROUND(CAST(SUM(EXPERIENCE_YEARS) AS REAL) / COUNT(EMPLOYEE_ID), 2) AS AVERAGE_YEARS FROM PROJECT JOIN EMPLOYEE USING (EMPLOYEE_ID) GROUP BY PROJECT_ID;

/*
Prediction Result:
(0, 2.0)
(1, 1.5)
(2, 1.5)
(3, 0.33)
*/