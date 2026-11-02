-- Schema DDL
CREATE TABLE "Project" ("project_id" INTEGER, "employee_id" INTEGER, PRIMARY KEY ("project_id", "employee_id"), FOREIGN KEY ("employee_id") REFERENCES "Employee" ("employee_id"));

CREATE TABLE "Employee" ("employee_id" INTEGER PRIMARY KEY, "name" TEXT(255), "experience_years" INTEGER, CHECK ("experience_years" >= 0));

-- Loading data
PRAGMA foreign_keys = OFF;
INSERT INTO employee (employee_id, name, experience_years) VALUES (1, 'default1', 1), (2, 'default1', 3), (3, 'default2', 0), (0, NULL, 2), (4, 'default1', 2), (5, NULL, 3), (6, 'default2', NULL), (7, NULL, 1), (8, 'default1', 0), (9, 'default2', 3), (10, 'default1', 2);
INSERT INTO project (project_id, employee_id) VALUES (0, 7), (1, 2), (2, 1), (1, 4), (0, 6), (2, 9), (1, 7), (3, 9), (2, 2), (2, 5), (2, 8);
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT A.project_id, ROUND(AVG(B.experience_years), 2) AS average_years FROM Project AS A INNER JOIN Employee AS B ON A.employee_id = B.employee_id GROUP BY A.project_id;

/*
Gold Result:
(0, 1.0)
(1, 2.0)
(2, 2.0)
(3, 3.0)
*/

-- Prediction Query
SELECT P.PROJECT_ID, ROUND((CAST(SUM(E.EXPERIENCE_YEARS) AS REAL) / COUNT(E.EMPLOYEE_ID)), 2) AS AVERAGE_YEARS FROM PROJECT AS P JOIN EMPLOYEE AS E ON P.EMPLOYEE_ID = E.EMPLOYEE_ID GROUP BY P.PROJECT_ID;

/*
Prediction Result:
(0, 0.5)
(1, 2.0)
(2, 2.0)
(3, 3.0)
*/