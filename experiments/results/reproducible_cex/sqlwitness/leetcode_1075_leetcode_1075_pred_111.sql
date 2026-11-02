-- Schema DDL
CREATE TABLE "Project" ("project_id" INTEGER, "employee_id" INTEGER, PRIMARY KEY ("project_id", "employee_id"), FOREIGN KEY ("employee_id") REFERENCES "Employee" ("employee_id"));

CREATE TABLE "Employee" ("employee_id" INTEGER PRIMARY KEY, "name" TEXT(255), "experience_years" INTEGER, CHECK ("experience_years" >= 0));

-- Loading data
PRAGMA foreign_keys = OFF;
INSERT INTO employee (employee_id, name, experience_years) VALUES (2, NULL, NULL), (0, 'default1', NULL), (3, NULL, 3), (1, 'default1', 1), (4, NULL, 2), (5, 'default1', NULL), (6, NULL, 0), (7, 'default1', 3), (8, NULL, 0), (9, NULL, 2), (10, NULL, 2), (11, NULL, NULL), (12, 'default2', 0), (13, NULL, NULL), (14, 'default1', NULL), (15, 'default2', 3), (16, NULL, 1), (17, 'default2', 3), (18, 'default2', NULL);
INSERT INTO project (project_id, employee_id) VALUES (1, 17), (3, 11), (0, 7), (3, 18), (0, 11), (1, 4);
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT A.project_id, ROUND(AVG(B.experience_years), 2) AS average_years FROM Project AS A INNER JOIN Employee AS B ON A.employee_id = B.employee_id GROUP BY A.project_id;

/*
Gold Result:
(0, 3.0)
(1, 2.5)
(3, None)
*/

-- Prediction Query
SELECT PROJECT_ID, ROUND(CAST(TOTAL_AMOUNT AS REAL) / CNT, 2) AS AVERAGE_YEARS FROM (SELECT PROJECT_ID, SUM(EXPERIENCE_YEARS) AS TOTAL_AMOUNT, COUNT(1) AS CNT FROM PROJECT AS A INNER JOIN EMPLOYEE AS B ON A.EMPLOYEE_ID = B.EMPLOYEE_ID GROUP BY PROJECT_ID) AS A;

/*
Prediction Result:
(0, 1.5)
(1, 2.5)
(3, None)
*/