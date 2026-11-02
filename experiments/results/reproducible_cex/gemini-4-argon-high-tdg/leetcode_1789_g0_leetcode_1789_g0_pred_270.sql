-- Schema DDL
CREATE TABLE "Employee" ("employee_id" INTEGER, "department_id" INTEGER, "primary_flag" TEXT(255), PRIMARY KEY ("employee_id", "department_id"));

-- Loading data
PRAGMA foreign_keys = OFF;
-- DATASET 4
INSERT INTO Employee (employee_id, department_id, primary_flag) VALUES (1, 10, NULL);
INSERT INTO Employee (employee_id, department_id, primary_flag) VALUES (2, 10, 'N');
INSERT INTO Employee (employee_id, department_id, primary_flag) VALUES (2, 20, NULL);
INSERT INTO Employee (employee_id, department_id, primary_flag) VALUES (3, 10, 'N');
INSERT INTO Employee (employee_id, department_id, primary_flag) VALUES (3, 20, 'y');
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT EMPLOYEE_ID, DEPARTMENT_ID FROM EMPLOYEE GROUP BY EMPLOYEE_ID HAVING COUNT(*) = 1 UNION SELECT EMPLOYEE_ID, DEPARTMENT_ID FROM EMPLOYEE WHERE PRIMARY_FLAG = 'Y';

/*
Gold Result:
(1, 10)
*/

-- Prediction Query
WITH TMP AS (SELECT *, COUNT(DEPARTMENT_ID) OVER (PARTITION BY EMPLOYEE_ID) AS DEPARTMENT_COUNT FROM EMPLOYEE), TMP2 AS (SELECT EMPLOYEE_ID, CASE WHEN PRIMARY_FLAG = 'N' AND DEPARTMENT_COUNT = 1 THEN DEPARTMENT_ID WHEN PRIMARY_FLAG = 'Y' THEN DEPARTMENT_ID ELSE NULL END AS DEPARTMENT_ID FROM TMP) SELECT EMPLOYEE_ID, DEPARTMENT_ID FROM TMP2 WHERE NOT DEPARTMENT_ID IS NULL;

/*
Prediction Result:
*/