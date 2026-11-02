-- Schema DDL
CREATE TABLE "Project" ("project_id" INTEGER, "employee_id" INTEGER, PRIMARY KEY ("project_id", "employee_id"), FOREIGN KEY ("employee_id") REFERENCES "Employee" ("employee_id"));

CREATE TABLE "Employee" ("employee_id" INTEGER PRIMARY KEY, "name" TEXT(255), "experience_years" INTEGER, CHECK ("experience_years" >= 0));

-- Loading data
PRAGMA foreign_keys = OFF;
INSERT INTO employee (employee_id, name, experience_years) VALUES (-1, 'default1', NULL), (0, 'default1', 0), (1, NULL, 1), (2, 'default1', 1), (3, NULL, 3), (4, 'default1', 1), (5, NULL, NULL);
INSERT INTO project (project_id, employee_id) VALUES (0, 1), (2, 5), (3, 4), (0, 0), (1, 4);
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT A.project_id, ROUND(AVG(B.experience_years), 2) AS average_years FROM Project AS A INNER JOIN Employee AS B ON A.employee_id = B.employee_id GROUP BY A.project_id;

/*
Gold Result:
(0, 0.5)
(1, 1.0)
(2, None)
(3, 1.0)
*/

-- Prediction Query
SELECT PROJECT_ID, ROUND(COALESCE(AVG(EXPERIENCE_YEARS), 0), 2) AS AVERAGE_YEARS FROM EMPLOYEE AS E INNER JOIN PROJECT AS P ON P.EMPLOYEE_ID = E.EMPLOYEE_ID GROUP BY PROJECT_ID;

/*
Prediction Result:
(0, 0.5)
(1, 1.0)
(2, 0.0)
(3, 1.0)
*/