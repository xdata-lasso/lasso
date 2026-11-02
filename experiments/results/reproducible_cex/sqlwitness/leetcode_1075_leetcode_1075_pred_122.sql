-- Schema DDL
CREATE TABLE "Project" ("project_id" INTEGER, "employee_id" INTEGER, PRIMARY KEY ("project_id", "employee_id"), FOREIGN KEY ("employee_id") REFERENCES "Employee" ("employee_id"));

CREATE TABLE "Employee" ("employee_id" INTEGER PRIMARY KEY, "name" TEXT(255), "experience_years" INTEGER, CHECK ("experience_years" >= 0));

-- Loading data
PRAGMA foreign_keys = OFF;
INSERT INTO employee (employee_id, name, experience_years) VALUES (1, 'default1', 0), (2, 'default2', 0), (3, NULL, NULL), (0, 'default1', 2), (4, 'default1', 2), (5, 'default2', 1);
INSERT INTO project (project_id, employee_id) VALUES (1, 4), (1, 2), (1, 3), (3, 3), (0, 1), (0, 0);
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT A.project_id, ROUND(AVG(B.experience_years), 2) AS average_years FROM Project AS A INNER JOIN Employee AS B ON A.employee_id = B.employee_id GROUP BY A.project_id;

/*
Gold Result:
(0, 1.0)
(1, 1.0)
(3, None)
*/

-- Prediction Query
SELECT PROJECT_ID, ROUND(CAST(SUM(EXPERIENCE_YEARS) AS REAL) / COUNT(E.EMPLOYEE_ID), 2) AS AVERAGE_YEARS FROM EMPLOYEE AS E JOIN PROJECT AS P ON E.EMPLOYEE_ID = P.EMPLOYEE_ID GROUP BY PROJECT_ID;

/*
Prediction Result:
(0, 1.0)
(1, 0.67)
(3, None)
*/