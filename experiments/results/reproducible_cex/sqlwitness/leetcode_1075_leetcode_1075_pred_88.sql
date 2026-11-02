-- Schema DDL
CREATE TABLE "Project" ("project_id" INTEGER, "employee_id" INTEGER, PRIMARY KEY ("project_id", "employee_id"), FOREIGN KEY ("employee_id") REFERENCES "Employee" ("employee_id"));

CREATE TABLE "Employee" ("employee_id" INTEGER PRIMARY KEY, "name" TEXT(255), "experience_years" INTEGER, CHECK ("experience_years" >= 0));

-- Loading data
PRAGMA foreign_keys = OFF;
INSERT INTO employee (employee_id, name, experience_years) VALUES (10, 'default2', 0), (0, 'default2', NULL), (1, 'default2', 3), (3, 'default2', NULL), (2, 'default1', 9), (9, NULL, 3), (11, 'default2', 0), (4, 'default1', 2), (5, 'default2', 9), (6, 'default2', 10), (7, 'default1', 10), (8, 'default2', NULL), (12, NULL, 11), (13, NULL, 3), (14, 'default2', 0), (15, 'default1', 3), (16, NULL, 10);
INSERT INTO project (project_id, employee_id) VALUES (11, 11), (3, 14), (3, 13), (9, 13), (11, 7), (11, 12), (10, 10), (10, 13), (2, 6), (1, 5), (10, 7), (3, 10), (3, 5), (3, 7), (9, 8), (9, 3), (0, 7);
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT A.project_id, ROUND(AVG(B.experience_years), 2) AS average_years FROM Project AS A INNER JOIN Employee AS B ON A.employee_id = B.employee_id GROUP BY A.project_id;

/*
Gold Result:
(0, 10.0)
(1, 9.0)
(2, 10.0)
(3, 4.4)
(9, 3.0)
(10, 4.33)
(11, 7.0)
*/

-- Prediction Query
SELECT PROJECT_ID, ROUND(CAST(SUM(EXPERIENCE_YEARS) AS REAL(10, 2)) / CAST(COUNT(EMPLOYEE_ID) AS REAL(10, 2)), 2) AS AVERAGE_YEARS FROM (SELECT PROJECT_ID, P.EMPLOYEE_ID, EXPERIENCE_YEARS FROM PROJECT AS P INNER JOIN EMPLOYEE AS E ON P.EMPLOYEE_ID = E.EMPLOYEE_ID) AS SUB GROUP BY PROJECT_ID;

/*
Prediction Result:
(0, 10.0)
(1, 9.0)
(2, 10.0)
(3, 4.4)
(9, 1.0)
(10, 4.33)
(11, 7.0)
*/