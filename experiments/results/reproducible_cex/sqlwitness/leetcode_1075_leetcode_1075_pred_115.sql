-- Schema DDL
CREATE TABLE "Project" ("project_id" INTEGER, "employee_id" INTEGER, PRIMARY KEY ("project_id", "employee_id"), FOREIGN KEY ("employee_id") REFERENCES "Employee" ("employee_id"));

CREATE TABLE "Employee" ("employee_id" INTEGER PRIMARY KEY, "name" TEXT(255), "experience_years" INTEGER, CHECK ("experience_years" >= 0));

-- Loading data
PRAGMA foreign_keys = OFF;
INSERT INTO employee (employee_id, name, experience_years) VALUES (3, NULL, 2), (0, 'default2', 0), (2, 'default1', 1), (1, NULL, 0), (4, 'default2', 0), (5, 'default1', 3), (6, NULL, 0);
INSERT INTO project (project_id, employee_id) VALUES (3, 3), (1, 5), (3, 5), (0, 2), (1, 4), (2, 1);
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT A.project_id, ROUND(AVG(B.experience_years), 2) AS average_years FROM Project AS A INNER JOIN Employee AS B ON A.employee_id = B.employee_id GROUP BY A.project_id;

/*
Gold Result:
(0, 1.0)
(1, 1.5)
(2, 0.0)
(3, 2.5)
*/

-- Prediction Query
SELECT PROJECT_ID, ROUND(AVG(EXPERIENCE_YEARS), 2) AS AVERAGE_YEARS FROM PROJECT AS P JOIN EMPLOYEE AS E ON P.EMPLOYEE_ID = E.EMPLOYEE_ID GROUP BY 1 ORDER BY 2, PROJECT_ID NULLS LAST, AVERAGE_YEARS NULLS LAST;

/*
Prediction Result:
(2, 0.0)
(0, 1.0)
(1, 1.5)
(3, 2.5)
*/