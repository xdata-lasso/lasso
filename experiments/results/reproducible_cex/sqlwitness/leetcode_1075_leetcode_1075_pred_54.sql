-- Schema DDL
CREATE TABLE "Project" ("project_id" INTEGER, "employee_id" INTEGER, PRIMARY KEY ("project_id", "employee_id"), FOREIGN KEY ("employee_id") REFERENCES "Employee" ("employee_id"));

CREATE TABLE "Employee" ("employee_id" INTEGER PRIMARY KEY, "name" TEXT(255), "experience_years" INTEGER, CHECK ("experience_years" >= 0));

-- Loading data
PRAGMA foreign_keys = OFF;
INSERT INTO employee (employee_id, name, experience_years) VALUES (3, NULL, 3), (0, NULL, 3), (1, 'default2', NULL), (2, 'default2', NULL);
INSERT INTO project (project_id, employee_id) VALUES (2, 3), (0, 2), (1, 3), (2, 2);
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT A.project_id, ROUND(AVG(B.experience_years), 2) AS average_years FROM Project AS A INNER JOIN Employee AS B ON A.employee_id = B.employee_id GROUP BY A.project_id;

/*
Gold Result:
(0, None)
(1, 3.0)
(2, 3.0)
*/

-- Prediction Query
SELECT PROJECT_ID, ROUND(CAST(SUM(EXPERIENCE_YEARS) AS REAL) / COUNT(EMPLOYEE_ID), 2) AS AVERAGE_YEARS FROM (SELECT T1.PROJECT_ID, T1.EMPLOYEE_ID, T2.EXPERIENCE_YEARS FROM PROJECT AS T1 JOIN EMPLOYEE AS T2 ON T1.EMPLOYEE_ID = T2.EMPLOYEE_ID) AS A GROUP BY 1;

/*
Prediction Result:
(0, None)
(1, 3.0)
(2, 1.5)
*/