-- Schema DDL
CREATE TABLE "Project" ("project_id" INTEGER, "employee_id" INTEGER, PRIMARY KEY ("project_id", "employee_id"), FOREIGN KEY ("employee_id") REFERENCES "Employee" ("employee_id"));

CREATE TABLE "Employee" ("employee_id" INTEGER PRIMARY KEY, "name" TEXT(255), "experience_years" INTEGER, CHECK ("experience_years" >= 0));

-- Loading data
PRAGMA foreign_keys = OFF;
INSERT INTO employee (employee_id, name, experience_years) VALUES (1, 'default1', 1), (2, NULL, 1), (3, NULL, NULL), (0, 'default1', 1), (4, NULL, NULL), (5, 'default2', 2), (6, 'default2', 2), (7, 'default2', 0), (8, NULL, 1), (9, 'default1', 3), (10, 'default2', 1), (11, NULL, 1), (12, NULL, 1), (13, 'default2', 2), (14, NULL, NULL), (15, 'default1', 1), (16, 'default2', 0), (17, 'default1', 2), (18, 'default2', 0), (19, NULL, 0), (20, 'default1', 1), (21, 'default1', 3);
INSERT INTO project (project_id, employee_id) VALUES (0, 4), (3, 4), (2, 1), (1, 11), (0, 13), (0, 2), (1, 16), (0, 8), (0, 11);
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT A.project_id, ROUND(AVG(B.experience_years), 2) AS average_years FROM Project AS A INNER JOIN Employee AS B ON A.employee_id = B.employee_id GROUP BY A.project_id;

/*
Gold Result:
(0, 1.25)
(1, 0.5)
(2, 1.0)
(3, None)
*/

-- Prediction Query
SELECT PROJECT_ID, ROUND(CAST(SUM(EXPERIENCE_YEARS) AS REAL) / COUNT(*), 2) AS AVERAGE_YEARS FROM (SELECT PROJECT_ID, EXPERIENCE_YEARS FROM PROJECT JOIN EMPLOYEE ON PROJECT.EMPLOYEE_ID = EMPLOYEE.EMPLOYEE_ID) AS A GROUP BY PROJECT_ID ORDER BY PROJECT_ID, AVERAGE_YEARS NULLS LAST;

/*
Prediction Result:
(0, 1.0)
(1, 0.5)
(2, 1.0)
(3, None)
*/