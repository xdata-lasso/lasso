-- Schema DDL
CREATE TABLE "Project" ("project_id" INTEGER, "employee_id" INTEGER, PRIMARY KEY ("project_id", "employee_id"), FOREIGN KEY ("employee_id") REFERENCES "Employee" ("employee_id"));

CREATE TABLE "Employee" ("employee_id" INTEGER PRIMARY KEY, "name" TEXT(255), "experience_years" INTEGER, CHECK ("experience_years" >= 0));

-- Loading data
PRAGMA foreign_keys = OFF;
INSERT INTO employee (employee_id, name, experience_years) VALUES (3, NULL, 1), (0, NULL, 1), (1, 'default2', 2), (2, 'default1', 1), (4, NULL, 3);
INSERT INTO project (project_id, employee_id) VALUES (2, 4), (3, 3), (0, 1), (1, 2), (0, 2);
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT A.project_id, ROUND(AVG(B.experience_years), 2) AS average_years FROM Project AS A INNER JOIN Employee AS B ON A.employee_id = B.employee_id GROUP BY A.project_id;

/*
Gold Result:
(0, 1.5)
(1, 1.0)
(2, 3.0)
(3, 1.0)
*/

-- Prediction Query
SELECT ROUND(AVG(EXPERIENCE_YEARS), 2) AS AVERAGE_YEARS, PROJECT_ID FROM PROJECT CROSS JOIN EMPLOYEE WHERE PROJECT.EMPLOYEE_ID = EMPLOYEE.EMPLOYEE_ID GROUP BY PROJECT_ID;

/*
Prediction Result:
(1.5, 0)
(1.0, 1)
(3.0, 2)
(1.0, 3)
*/