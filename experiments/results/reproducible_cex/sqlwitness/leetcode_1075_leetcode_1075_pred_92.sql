-- Schema DDL
CREATE TABLE "Project" ("project_id" INTEGER, "employee_id" INTEGER, PRIMARY KEY ("project_id", "employee_id"), FOREIGN KEY ("employee_id") REFERENCES "Employee" ("employee_id"));

CREATE TABLE "Employee" ("employee_id" INTEGER PRIMARY KEY, "name" TEXT(255), "experience_years" INTEGER, CHECK ("experience_years" >= 0));

-- Loading data
PRAGMA foreign_keys = OFF;
INSERT INTO employee (employee_id, name, experience_years) VALUES (1, 'default2', 2), (4, NULL, 0), (5, NULL, 4), (2, NULL, NULL), (3, NULL, 5), (0, 'default1', 1), (6, 'default1', 4), (7, 'default2', 5), (8, 'default2', 2), (9, 'default2', 4), (10, 'default2', 5), (11, NULL, 1);
INSERT INTO project (project_id, employee_id) VALUES (5, 5), (2, 1), (1, 11), (3, 7), (4, 6), (3, 3), (1, 10), (3, 2), (2, 5), (1, 9), (0, 11);
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT A.project_id, ROUND(AVG(B.experience_years), 2) AS average_years FROM Project AS A INNER JOIN Employee AS B ON A.employee_id = B.employee_id GROUP BY A.project_id;

/*
Gold Result:
(0, 1.0)
(1, 3.33)
(2, 3.0)
(3, 5.0)
(4, 4.0)
(5, 4.0)
*/

-- Prediction Query
SELECT PRJ.PROJECT_ID, CAST(AVG(EMP.EXPERIENCE_YEARS) AS REAL(4, 2)) AS AVERAGE_YEARS FROM PROJECT AS PRJ JOIN EMPLOYEE AS EMP ON EMP.EMPLOYEE_ID = PRJ.EMPLOYEE_ID GROUP BY PROJECT_ID;

/*
Prediction Result:
(0, 1.0)
(1, 3.3333333333333335)
(2, 3.0)
(3, 5.0)
(4, 4.0)
(5, 4.0)
*/