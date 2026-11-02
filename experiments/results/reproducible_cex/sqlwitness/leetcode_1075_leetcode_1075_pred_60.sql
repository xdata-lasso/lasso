-- Schema DDL
CREATE TABLE "Project" ("project_id" INTEGER, "employee_id" INTEGER, PRIMARY KEY ("project_id", "employee_id"), FOREIGN KEY ("employee_id") REFERENCES "Employee" ("employee_id"));

CREATE TABLE "Employee" ("employee_id" INTEGER PRIMARY KEY, "name" TEXT(255), "experience_years" INTEGER, CHECK ("experience_years" >= 0));

-- Loading data
PRAGMA foreign_keys = OFF;
INSERT INTO employee (employee_id, name, experience_years) VALUES (0, NULL, NULL), (1, NULL, 1), (3, NULL, 3), (2, NULL, 2), (4, NULL, 0);
INSERT INTO project (project_id, employee_id) VALUES (3, 2), (2, 0), (2, 1);
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT A.project_id, ROUND(AVG(B.experience_years), 2) AS average_years FROM Project AS A INNER JOIN Employee AS B ON A.employee_id = B.employee_id GROUP BY A.project_id;

/*
Gold Result:
(2, 1.0)
(3, 2.0)
*/

-- Prediction Query
SELECT T1.PROJECT_ID, ROUND(CAST(SUM(T2.EXPERIENCE_YEARS) AS REAL) / COUNT(T2.EMPLOYEE_ID), 2) AS AVERAGE_YEARS FROM PROJECT AS T1 JOIN EMPLOYEE AS T2 ON T2.EMPLOYEE_ID = T1.EMPLOYEE_ID GROUP BY T1.PROJECT_ID;

/*
Prediction Result:
(2, 0.5)
(3, 2.0)
*/