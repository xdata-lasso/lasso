-- Schema DDL
CREATE TABLE "Employee" ("employee_id" INTEGER, "department_id" INTEGER, "primary_flag" TEXT(255), PRIMARY KEY ("employee_id", "department_id"));

-- Loading data
PRAGMA foreign_keys = OFF;
-- DATASET 3
INSERT INTO Employee (employee_id, department_id, primary_flag) VALUES (1, 10, 'N');
INSERT INTO Employee (employee_id, department_id, primary_flag) VALUES (1, 20, 'N');
INSERT INTO Employee (employee_id, department_id, primary_flag) VALUES (2, 30, 'Y');
INSERT INTO Employee (employee_id, department_id, primary_flag) VALUES (2, 40, 'Y');
INSERT INTO Employee (employee_id, department_id, primary_flag) VALUES (3, 50, NULL);
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT EMPLOYEE_ID, DEPARTMENT_ID FROM EMPLOYEE GROUP BY EMPLOYEE_ID HAVING COUNT(*) = 1 UNION SELECT EMPLOYEE_ID, DEPARTMENT_ID FROM EMPLOYEE WHERE PRIMARY_FLAG = 'Y';

/*
Gold Result:
(2, 30)
(2, 40)
(3, 50)
*/

-- Prediction Query
SELECT B.EMPLOYEE_ID, B.DEPARTMENT_ID FROM EMPLOYEE AS B WHERE B.PRIMARY_FLAG = 'Y' OR (B.PRIMARY_FLAG = 'N' AND B.EMPLOYEE_ID IN (SELECT A.EMPLOYEE_ID FROM EMPLOYEE AS A GROUP BY A.EMPLOYEE_ID HAVING COUNT(*) = 1)) GROUP BY B.EMPLOYEE_ID;

/*
Prediction Result:
(2, 30)
*/