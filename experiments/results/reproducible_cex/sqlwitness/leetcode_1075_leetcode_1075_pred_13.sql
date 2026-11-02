-- Schema DDL
CREATE TABLE "Project" ("project_id" INTEGER, "employee_id" INTEGER, PRIMARY KEY ("project_id", "employee_id"), FOREIGN KEY ("employee_id") REFERENCES "Employee" ("employee_id"));

CREATE TABLE "Employee" ("employee_id" INTEGER PRIMARY KEY, "name" TEXT(255), "experience_years" INTEGER, CHECK ("experience_years" >= 0));

-- Loading data
PRAGMA foreign_keys = OFF;
INSERT INTO employee (employee_id, name, experience_years) VALUES (0, 'default2', NULL), (3, 'default1', 0), (1, 'default1', 1), (2, NULL, 2), (4, 'default2', 3), (5, 'default1', NULL);
INSERT INTO project (project_id, employee_id) VALUES (0, 1), (0, 4), (0, 0), (1, 1), (2, 0), (0, 5);
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT A.project_id, ROUND(AVG(B.experience_years), 2) AS average_years FROM Project AS A INNER JOIN Employee AS B ON A.employee_id = B.employee_id GROUP BY A.project_id;

/*
Gold Result:
(0, 2.0)
(1, 1.0)
(2, None)
*/

-- Prediction Query
SELECT P.PROJECT_ID, ROUND(CAST(SUM(E.EXPERIENCE_YEARS) AS REAL) / COUNT(P.EMPLOYEE_ID), 2) AS AVERAGE_YEARS FROM PROJECT AS P JOIN EMPLOYEE AS E ON P.EMPLOYEE_ID = E.EMPLOYEE_ID GROUP BY P.PROJECT_ID;

/*
Prediction Result:
(0, 1.0)
(1, 1.0)
(2, None)
*/