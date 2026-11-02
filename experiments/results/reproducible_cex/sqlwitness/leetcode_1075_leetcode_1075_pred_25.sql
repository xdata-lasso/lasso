-- Schema DDL
CREATE TABLE "Project" ("project_id" INTEGER, "employee_id" INTEGER, PRIMARY KEY ("project_id", "employee_id"), FOREIGN KEY ("employee_id") REFERENCES "Employee" ("employee_id"));

CREATE TABLE "Employee" ("employee_id" INTEGER PRIMARY KEY, "name" TEXT(255), "experience_years" INTEGER, CHECK ("experience_years" >= 0));

-- Loading data
PRAGMA foreign_keys = OFF;
INSERT INTO employee (employee_id, name, experience_years) VALUES (2, 'default2', 2), (1, 'default1', 3), (0, 'default1', 0), (3, NULL, 1), (4, NULL, 2), (5, NULL, NULL), (6, 'default2', 3);
INSERT INTO project (project_id, employee_id) VALUES (2, 1), (1, 1), (2, 0), (2, 6), (2, 2), (3, 2), (2, 5);
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT A.project_id, ROUND(AVG(B.experience_years), 2) AS average_years FROM Project AS A INNER JOIN Employee AS B ON A.employee_id = B.employee_id GROUP BY A.project_id;

/*
Gold Result:
(1, 3.0)
(2, 2.0)
(3, 2.0)
*/

-- Prediction Query
SELECT SUB.PROJECT_ID, ROUND(CAST(SUB.EXPERIENCE AS REAL) / SUB.EMPLOYEES, 2) AS AVERAGE_YEARS FROM (SELECT P.PROJECT_ID, COUNT(P.EMPLOYEE_ID) AS EMPLOYEES, SUM(E.EXPERIENCE_YEARS) AS EXPERIENCE FROM PROJECT AS P JOIN EMPLOYEE AS E ON P.EMPLOYEE_ID = E.EMPLOYEE_ID GROUP BY P.PROJECT_ID) AS SUB GROUP BY SUB.PROJECT_ID;

/*
Prediction Result:
(1, 3.0)
(2, 1.6)
(3, 2.0)
*/