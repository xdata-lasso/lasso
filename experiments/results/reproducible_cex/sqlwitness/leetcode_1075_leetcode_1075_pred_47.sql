-- Schema DDL
CREATE TABLE "Project" ("project_id" INTEGER, "employee_id" INTEGER, PRIMARY KEY ("project_id", "employee_id"), FOREIGN KEY ("employee_id") REFERENCES "Employee" ("employee_id"));

CREATE TABLE "Employee" ("employee_id" INTEGER PRIMARY KEY, "name" TEXT(255), "experience_years" INTEGER, CHECK ("experience_years" >= 0));

-- Loading data
PRAGMA foreign_keys = OFF;
INSERT INTO employee (employee_id, name, experience_years) VALUES (5, 'default2', 3), (4, NULL, 0), (1, NULL, 4), (0, NULL, 3), (2, 'default2', 6), (3, 'default2', 0), (6, NULL, 1), (7, NULL, 4), (8, NULL, 3), (9, 'default1', 6), (10, NULL, 3), (11, 'default2', NULL), (12, 'default2', NULL), (13, 'default1', 3), (14, 'default2', NULL);
INSERT INTO project (project_id, employee_id) VALUES (0, 7), (3, 8), (1, 2), (6, 0), (2, 7), (4, 3), (0, 0), (1, 5), (6, 8), (0, 3), (1, 13), (3, 9), (6, 10), (3, 6), (1, 6);
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT A.project_id, ROUND(AVG(B.experience_years), 2) AS average_years FROM Project AS A INNER JOIN Employee AS B ON A.employee_id = B.employee_id GROUP BY A.project_id;

/*
Gold Result:
(0, 2.33)
(1, 3.25)
(2, 4.0)
(3, 3.33)
(4, 0.0)
(6, 3.0)
*/

-- Prediction Query
SELECT PROJECT_ID, CAST(AVG(EXPERIENCE_YEARS) AS REAL(5, 2)) AS AVERAGE_YEARS FROM PROJECT AS P INNER JOIN EMPLOYEE AS E ON P.EMPLOYEE_ID = E.EMPLOYEE_ID GROUP BY 1;

/*
Prediction Result:
(0, 2.3333333333333335)
(1, 3.25)
(2, 4.0)
(3, 3.3333333333333335)
(4, 0.0)
(6, 3.0)
*/