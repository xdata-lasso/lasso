-- Schema DDL
CREATE TABLE "Project" ("project_id" INTEGER, "employee_id" INTEGER, PRIMARY KEY ("project_id", "employee_id"), FOREIGN KEY ("employee_id") REFERENCES "Employee" ("employee_id"));

CREATE TABLE "Employee" ("employee_id" INTEGER PRIMARY KEY, "name" TEXT(255), "experience_years" INTEGER, CHECK ("experience_years" >= 0));

-- Loading data
PRAGMA foreign_keys = OFF;
INSERT INTO Employee (employee_id, name, experience_years) VALUES (1, 'Alice', 10);
INSERT INTO Employee (employee_id, name, experience_years) VALUES (2, 'Bob', NULL);
INSERT INTO Project (project_id, employee_id) VALUES (1, 1);
INSERT INTO Project (project_id, employee_id) VALUES (1, 2);
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT A.project_id, ROUND(AVG(B.experience_years), 2) AS average_years FROM Project AS A INNER JOIN Employee AS B ON A.employee_id = B.employee_id GROUP BY A.project_id;

/*
Gold Result:
(1, 10.0)
*/

-- Prediction Query
SELECT SUB.PROJECT_ID, ROUND(CAST(SUB.EXPERIENCE AS REAL) / SUB.EMPLOYEES, 2) AS AVERAGE_YEARS FROM (SELECT P.PROJECT_ID, COUNT(P.EMPLOYEE_ID) AS EMPLOYEES, SUM(E.EXPERIENCE_YEARS) AS EXPERIENCE FROM PROJECT AS P JOIN EMPLOYEE AS E ON P.EMPLOYEE_ID = E.EMPLOYEE_ID GROUP BY P.PROJECT_ID) AS SUB GROUP BY SUB.PROJECT_ID;

/*
Prediction Result:
(1, 5.0)
*/