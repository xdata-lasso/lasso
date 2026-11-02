-- Schema DDL
CREATE TABLE "Employee" ("employee_id" INTEGER, "department_id" INTEGER, "primary_flag" TEXT(255), PRIMARY KEY ("employee_id", "department_id"));

-- Loading data
PRAGMA foreign_keys = OFF;
-- DATASET 3
INSERT INTO Employee (employee_id, department_id, primary_flag) VALUES (1, 10, 'N');
INSERT INTO Employee (employee_id, department_id, primary_flag) VALUES (1, 20, 'N');
INSERT INTO Employee (employee_id, department_id, primary_flag) VALUES (2, 30, 'Y');
INSERT INTO Employee (employee_id, department_id, primary_flag) VALUES (2, 40, 'Y');
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT EMPLOYEE_ID, DEPARTMENT_ID FROM EMPLOYEE GROUP BY EMPLOYEE_ID HAVING COUNT(*) = 1 UNION SELECT EMPLOYEE_ID, DEPARTMENT_ID FROM EMPLOYEE WHERE PRIMARY_FLAG = 'Y';

/*
Gold Result:
(2, 30)
(2, 40)
*/

-- Prediction Query
SELECT DISTINCT E.EMPLOYEE_ID, COALESCE(E1.DEPARTMENT_ID, E.DEPARTMENT_ID) AS DEPARTMENT_ID FROM EMPLOYEE AS E LEFT JOIN EMPLOYEE AS E1 ON E.EMPLOYEE_ID = E1.EMPLOYEE_ID AND E.PRIMARY_FLAG = 'N' AND E1.PRIMARY_FLAG = 'Y';

/*
Prediction Result:
(1, 10)
(1, 20)
(2, 30)
(2, 40)
*/