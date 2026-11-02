-- Schema DDL
CREATE TABLE "Project" ("project_id" INTEGER, "employee_id" INTEGER, PRIMARY KEY ("project_id", "employee_id"), FOREIGN KEY ("employee_id") REFERENCES "Employee" ("employee_id"));

CREATE TABLE "Employee" ("employee_id" INTEGER PRIMARY KEY, "name" TEXT(255), "experience_years" INTEGER, CHECK ("experience_years" >= 0));

-- Loading data
PRAGMA foreign_keys = OFF;
INSERT INTO Employee (employee_id, name, experience_years) VALUES (1, 'Alice', NULL);
INSERT INTO Project (project_id, employee_id) VALUES (10, 1);
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT A.project_id, ROUND(AVG(B.experience_years), 2) AS average_years FROM Project AS A INNER JOIN Employee AS B ON A.employee_id = B.employee_id GROUP BY A.project_id;

/*
Gold Result:
(10, None)
*/

-- Prediction Query
SELECT PROJECT.PROJECT_ID, COALESCE(ROUND(AVG(EMPLOYEE.EXPERIENCE_YEARS), 2), 0) AS AVERAGE_YEARS FROM PROJECT LEFT JOIN EMPLOYEE ON PROJECT.EMPLOYEE_ID = EMPLOYEE.EMPLOYEE_ID GROUP BY PROJECT.PROJECT_ID;

/*
Prediction Result:
(10, 0)
*/