-- Schema DDL
CREATE TABLE "Project" ("project_id" INTEGER, "employee_id" INTEGER, PRIMARY KEY ("project_id", "employee_id"), FOREIGN KEY ("employee_id") REFERENCES "Employee" ("employee_id"));

CREATE TABLE "Employee" ("employee_id" INTEGER PRIMARY KEY, "name" TEXT(255), "experience_years" INTEGER, CHECK ("experience_years" >= 0));

-- Loading data
PRAGMA foreign_keys = OFF;
-- DATASET 1
INSERT INTO Employee (employee_id, name, experience_years) VALUES (1001, 'Alice', 1);
INSERT INTO Employee (employee_id, name, experience_years) VALUES (1002, 'Bob', 1);
INSERT INTO Employee (employee_id, name, experience_years) VALUES (1003, 'Charlie', 2);
INSERT INTO Employee (employee_id, name, experience_years) VALUES (1004, 'Diana', 5);
INSERT INTO Employee (employee_id, name, experience_years) VALUES (1005, 'Evan', 10);
INSERT INTO Project (project_id, employee_id) VALUES (101, 1001);
INSERT INTO Project (project_id, employee_id) VALUES (101, 1002);
INSERT INTO Project (project_id, employee_id) VALUES (101, 1003);
INSERT INTO Project (project_id, employee_id) VALUES (102, 1001);
INSERT INTO Project (project_id, employee_id) VALUES (102, 1003);
INSERT INTO Project (project_id, employee_id) VALUES (102, 1004);
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT A.project_id, ROUND(AVG(B.experience_years), 2) AS average_years FROM Project AS A INNER JOIN Employee AS B ON A.employee_id = B.employee_id GROUP BY A.project_id;

/*
Gold Result:
(101, 1.33)
(102, 2.67)
*/

-- Prediction Query
SELECT ROUND(AVG(EXPERIENCE_YEARS), 2) AS AVERAGE_YEARS, PROJECT_ID FROM PROJECT CROSS JOIN EMPLOYEE WHERE PROJECT.EMPLOYEE_ID = EMPLOYEE.EMPLOYEE_ID GROUP BY PROJECT_ID;

/*
Prediction Result:
(1.33, 101)
(2.67, 102)
*/