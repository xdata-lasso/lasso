-- Schema DDL
CREATE TABLE "Project" ("project_id" INTEGER, "employee_id" INTEGER, PRIMARY KEY ("project_id", "employee_id"), FOREIGN KEY ("employee_id") REFERENCES "Employee" ("employee_id"));

CREATE TABLE "Employee" ("employee_id" INTEGER PRIMARY KEY, "name" TEXT(255), "experience_years" INTEGER, CHECK ("experience_years" >= 0));

-- Loading data
PRAGMA foreign_keys = OFF;
INSERT INTO employee (employee_id, name, experience_years) VALUES (0, 'default2', 0), (2, NULL, NULL), (1, NULL, 2), (3, NULL, 3), (4, 'default2', NULL), (5, 'default2', 1), (6, NULL, 1), (7, 'default2', 0), (8, 'default1', NULL), (9, 'default2', 3), (10, 'default2', NULL), (11, 'default1', 3), (12, 'default2', 1), (13, 'default2', 0), (14, 'default2', 3);
INSERT INTO project (project_id, employee_id) VALUES (0, 10), (2, 10), (1, 1), (0, 9), (2, 0), (3, 0), (3, 13), (2, 12), (0, 5), (1, 9), (0, 11);
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT A.project_id, ROUND(AVG(B.experience_years), 2) AS average_years FROM Project AS A INNER JOIN Employee AS B ON A.employee_id = B.employee_id GROUP BY A.project_id;

/*
Gold Result:
(0, 2.33)
(1, 2.5)
(2, 0.5)
(3, 0.0)
*/

-- Prediction Query
SELECT PROJECT_ID, ROUND((CAST(SUM(EXPERIENCE_YEARS) AS REAL) / COUNT(P.EMPLOYEE_ID)), 2) AS AVERAGE_YEARS FROM PROJECT AS P JOIN EMPLOYEE AS E ON P.EMPLOYEE_ID = E.EMPLOYEE_ID GROUP BY PROJECT_ID;

/*
Prediction Result:
(0, 1.75)
(1, 2.5)
(2, 0.33)
(3, 0.0)
*/