-- Schema DDL
CREATE TABLE "Project" ("project_id" INTEGER, "employee_id" INTEGER, PRIMARY KEY ("project_id", "employee_id"), FOREIGN KEY ("employee_id") REFERENCES "Employee" ("employee_id"));

CREATE TABLE "Employee" ("employee_id" INTEGER PRIMARY KEY, "name" TEXT(255), "experience_years" INTEGER, CHECK ("experience_years" >= 0));

-- Loading data
PRAGMA foreign_keys = OFF;
-- DATASET 1
INSERT INTO Employee (employee_id, name, experience_years) VALUES (1, 'Alice', 1);
INSERT INTO Employee (employee_id, name, experience_years) VALUES (2, 'Bob', 2);
INSERT INTO Employee (employee_id, name, experience_years) VALUES (3, 'Charlie', 4);
INSERT INTO Employee (employee_id, name, experience_years) VALUES (4, 'David', 1);
INSERT INTO Employee (employee_id, name, experience_years) VALUES (5, 'Eve', 3);
INSERT INTO Employee (employee_id, name, experience_years) VALUES (6, 'Frank', 100);
INSERT INTO Project (project_id, employee_id) VALUES (101, 1);
INSERT INTO Project (project_id, employee_id) VALUES (101, 2);
INSERT INTO Project (project_id, employee_id) VALUES (101, 3);
INSERT INTO Project (project_id, employee_id) VALUES (102, 4);
INSERT INTO Project (project_id, employee_id) VALUES (102, 5);
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT A.project_id, ROUND(AVG(B.experience_years), 2) AS average_years FROM Project AS A INNER JOIN Employee AS B ON A.employee_id = B.employee_id GROUP BY A.project_id;

/*
Gold Result:
(101, 2.33)
(102, 2.0)
*/

-- Prediction Query
SELECT PRJ.PROJECT_ID, CAST(AVG(EMP.EXPERIENCE_YEARS) AS REAL(4, 2)) AS AVERAGE_YEARS FROM PROJECT AS PRJ JOIN EMPLOYEE AS EMP ON EMP.EMPLOYEE_ID = PRJ.EMPLOYEE_ID GROUP BY PROJECT_ID;

/*
Prediction Result:
(101, 2.3333333333333335)
(102, 2.0)
*/