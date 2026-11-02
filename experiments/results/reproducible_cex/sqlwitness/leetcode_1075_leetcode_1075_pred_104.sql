-- Schema DDL
CREATE TABLE "Project" ("project_id" INTEGER, "employee_id" INTEGER, PRIMARY KEY ("project_id", "employee_id"), FOREIGN KEY ("employee_id") REFERENCES "Employee" ("employee_id"));

CREATE TABLE "Employee" ("employee_id" INTEGER PRIMARY KEY, "name" TEXT(255), "experience_years" INTEGER, CHECK ("experience_years" >= 0));

-- Loading data
PRAGMA foreign_keys = OFF;
INSERT INTO employee (employee_id, name, experience_years) VALUES (1, 'default1', 6), (5, 'default2', 2), (3, 'default1', 5), (2, NULL, 0), (0, 'default1', 3), (7, 'default1', 6), (6, NULL, 5), (4, 'default1', 3), (8, NULL, 2), (9, 'default1', 3), (10, NULL, 3), (11, 'default2', NULL), (12, NULL, NULL), (13, NULL, 1), (14, 'default1', 3), (15, NULL, 1), (16, 'default2', 3), (17, 'default1', 2), (18, 'default1', 7), (19, NULL, 0), (20, 'default2', 0), (21, NULL, 5), (22, 'default2', 0);
INSERT INTO project (project_id, employee_id) VALUES (7, 1), (7, 5), (6, 5), (0, 14), (1, 6), (2, 1), (6, 20), (1, 15), (1, 1), (3, 18), (7, 6), (3, 4);
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT A.project_id, ROUND(AVG(B.experience_years), 2) AS average_years FROM Project AS A INNER JOIN Employee AS B ON A.employee_id = B.employee_id GROUP BY A.project_id;

/*
Gold Result:
(0, 3.0)
(1, 4.0)
(2, 6.0)
(3, 5.0)
(6, 1.0)
(7, 4.33)
*/

-- Prediction Query
SELECT PROJECT_ID, CAST(AVG(EXPERIENCE_YEARS) AS REAL(6, 2)) AS AVERAGE_YEARS FROM PROJECT AS P INNER JOIN EMPLOYEE AS E ON P.EMPLOYEE_ID = E.EMPLOYEE_ID GROUP BY P.PROJECT_ID;

/*
Prediction Result:
(0, 3.0)
(1, 4.0)
(2, 6.0)
(3, 5.0)
(6, 1.0)
(7, 4.333333333333333)
*/