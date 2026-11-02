-- Schema DDL
CREATE TABLE "Project" ("project_id" INTEGER, "employee_id" INTEGER, PRIMARY KEY ("project_id", "employee_id"), FOREIGN KEY ("employee_id") REFERENCES "Employee" ("employee_id"));

CREATE TABLE "Employee" ("employee_id" INTEGER PRIMARY KEY, "name" TEXT(255), "experience_years" INTEGER, CHECK ("experience_years" >= 0));

-- Loading data
PRAGMA foreign_keys = OFF;
INSERT INTO employee (employee_id, name, experience_years) VALUES (0, 'default1', 3), (1, NULL, 1), (3, 'default2', 2), (2, NULL, 1), (4, 'default2', 1), (5, NULL, 0), (6, 'default2', 2), (7, 'default1', 3), (8, NULL, 3), (9, 'default1', 2), (10, NULL, 3), (11, NULL, NULL);
INSERT INTO project (project_id, employee_id) VALUES (3, 11), (3, 6), (3, 4), (1, 6), (2, 4);
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT A.project_id, ROUND(AVG(B.experience_years), 2) AS average_years FROM Project AS A INNER JOIN Employee AS B ON A.employee_id = B.employee_id GROUP BY A.project_id;

/*
Gold Result:
(1, 2.0)
(2, 1.0)
(3, 1.5)
*/

-- Prediction Query
SELECT TEMP.PROJECT_ID, ROUND(CAST(SUM(TEMP.EXPERIENCE_YEARS) AS REAL) / COUNT(*), 2) AS AVERAGE_YEARS FROM (SELECT E.EMPLOYEE_ID, E.EXPERIENCE_YEARS, P.PROJECT_ID FROM EMPLOYEE AS E JOIN PROJECT AS P ON E.EMPLOYEE_ID = P.EMPLOYEE_ID) AS TEMP GROUP BY TEMP.PROJECT_ID;

/*
Prediction Result:
(1, 2.0)
(2, 1.0)
(3, 1.0)
*/