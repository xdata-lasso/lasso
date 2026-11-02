-- Schema DDL
CREATE TABLE "Project" ("project_id" INTEGER, "employee_id" INTEGER, PRIMARY KEY ("project_id", "employee_id"), FOREIGN KEY ("employee_id") REFERENCES "Employee" ("employee_id"));

CREATE TABLE "Employee" ("employee_id" INTEGER PRIMARY KEY, "name" TEXT(255), "experience_years" INTEGER, CHECK ("experience_years" >= 0));

-- Loading data
PRAGMA foreign_keys = OFF;
INSERT INTO employee (employee_id, name, experience_years) VALUES (1, 'default2', 2), (3, 'default2', 0), (0, 'default1', 1), (2, 'default2', 3), (4, NULL, 0), (5, NULL, 2), (6, NULL, NULL), (7, 'default1', 0);
INSERT INTO project (project_id, employee_id) VALUES (2, 0), (2, 1), (2, 6), (0, 4);
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT A.project_id, ROUND(AVG(B.experience_years), 2) AS average_years FROM Project AS A INNER JOIN Employee AS B ON A.employee_id = B.employee_id GROUP BY A.project_id;

/*
Gold Result:
(0, 0.0)
(2, 1.5)
*/

-- Prediction Query
SELECT P.PROJECT_ID, ROUND((CAST(SUM(E.EXPERIENCE_YEARS) AS REAL) / COUNT(PROJECT_ID)), 2) AS AVERAGE_YEARS FROM PROJECT AS P JOIN EMPLOYEE AS E ON P.EMPLOYEE_ID = E.EMPLOYEE_ID GROUP BY PROJECT_ID;

/*
Prediction Result:
(0, 0.0)
(2, 1.0)
*/