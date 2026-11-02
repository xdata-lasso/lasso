-- Schema DDL
CREATE TABLE "Project" ("project_id" INTEGER, "employee_id" INTEGER, PRIMARY KEY ("project_id", "employee_id"), FOREIGN KEY ("employee_id") REFERENCES "Employee" ("employee_id"));

CREATE TABLE "Employee" ("employee_id" INTEGER PRIMARY KEY, "name" TEXT(255), "experience_years" INTEGER, CHECK ("experience_years" >= 0));

-- Loading data
PRAGMA foreign_keys = OFF;
INSERT INTO Employee (employee_id, name, experience_years) VALUES (1, 'Alice', 5);
INSERT INTO Project (project_id, employee_id) VALUES (10, NULL);
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT A.project_id, ROUND(AVG(B.experience_years), 2) AS average_years FROM Project AS A INNER JOIN Employee AS B ON A.employee_id = B.employee_id GROUP BY A.project_id;

/*
Gold Result:
*/

-- Prediction Query
SELECT DISTINCT A.PROJECT_ID, ROUND(CAST(SUM(B.EXPERIENCE_YEARS) AS REAL) / COUNT(B.EXPERIENCE_YEARS), 2) AS AVERAGE_YEARS FROM PROJECT AS A LEFT JOIN EMPLOYEE AS B ON A.EMPLOYEE_ID = B.EMPLOYEE_ID GROUP BY 1;

/*
Prediction Result:
(10, None)
*/