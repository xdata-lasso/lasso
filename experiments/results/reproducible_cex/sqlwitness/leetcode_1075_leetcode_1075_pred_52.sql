-- Schema DDL
CREATE TABLE "Project" ("project_id" INTEGER, "employee_id" INTEGER, PRIMARY KEY ("project_id", "employee_id"), FOREIGN KEY ("employee_id") REFERENCES "Employee" ("employee_id"));

CREATE TABLE "Employee" ("employee_id" INTEGER PRIMARY KEY, "name" TEXT(255), "experience_years" INTEGER, CHECK ("experience_years" >= 0));

-- Loading data
PRAGMA foreign_keys = OFF;
INSERT INTO employee (employee_id, name, experience_years) VALUES (2, 'default2', 0), (1, 'default1', 2), (3, NULL, 1), (0, 'default1', NULL), (4, NULL, NULL), (5, 'default2', 3), (6, 'default1', NULL), (7, 'default2', NULL), (8, 'default2', 0), (9, NULL, 0), (10, 'default1', 1), (11, NULL, NULL), (12, NULL, 3);
INSERT INTO project (project_id, employee_id) VALUES (0, 4), (1, 1), (0, 3), (3, 0), (2, 3), (2, 9), (2, 2), (0, 11), (2, 8);
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT A.project_id, ROUND(AVG(B.experience_years), 2) AS average_years FROM Project AS A INNER JOIN Employee AS B ON A.employee_id = B.employee_id GROUP BY A.project_id;

/*
Gold Result:
(0, 1.0)
(1, 2.0)
(2, 0.25)
(3, None)
*/

-- Prediction Query
SELECT PROJECT_ID, ROUND(CAST(SUM(EXPERIENCE_YEARS) AS REAL) / COUNT(*), 2) AS AVERAGE_YEARS FROM PROJECT AS A LEFT JOIN EMPLOYEE AS B USING (EMPLOYEE_ID) GROUP BY PROJECT_ID;

/*
Prediction Result:
(0, 0.33)
(1, 2.0)
(2, 0.25)
(3, None)
*/