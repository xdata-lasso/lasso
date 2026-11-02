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
SELECT A.EMPLOYEE_ID, A.DEPARTMENT_ID FROM (SELECT E1.EMPLOYEE_ID, E1.DEPARTMENT_ID, E2.PRIMARY_FLAG FROM EMPLOYEE AS E1 LEFT JOIN EMPLOYEE AS E2 ON E1.EMPLOYEE_ID = E2.EMPLOYEE_ID AND E1.DEPARTMENT_ID <> E2.DEPARTMENT_ID AND E1.PRIMARY_FLAG <> 'Y') AS A WHERE A.PRIMARY_FLAG IS NULL;

/*
Prediction Result:
(1, 10)
(2, 10)
(2, 20)
*/