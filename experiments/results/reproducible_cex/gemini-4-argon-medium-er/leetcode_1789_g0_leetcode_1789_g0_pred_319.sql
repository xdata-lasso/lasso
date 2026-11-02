-- Schema DDL
CREATE TABLE "Employee" ("employee_id" INTEGER, "department_id" INTEGER, "primary_flag" TEXT(255), PRIMARY KEY ("employee_id", "department_id"));

-- Loading data
PRAGMA foreign_keys = OFF;
INSERT INTO Employee (employee_id, department_id, primary_flag) VALUES (1, 1, 'N');
INSERT INTO Employee (employee_id, department_id, primary_flag) VALUES (1, NULL, 'N');
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT EMPLOYEE_ID, DEPARTMENT_ID FROM EMPLOYEE GROUP BY EMPLOYEE_ID HAVING COUNT(*) = 1 UNION SELECT EMPLOYEE_ID, DEPARTMENT_ID FROM EMPLOYEE WHERE PRIMARY_FLAG = 'Y';

/*
Gold Result:
*/

-- Prediction Query
WITH EMPLOYEE_WITH_ONE_DEPART AS (SELECT EMPLOYEE_ID FROM EMPLOYEE GROUP BY EMPLOYEE_ID HAVING COUNT(DISTINCT DEPARTMENT_ID) = 1) SELECT EMPLOYEE_ID, DEPARTMENT_ID FROM EMPLOYEE WHERE PRIMARY_FLAG = 'Y' OR EMPLOYEE_ID IN (SELECT * FROM EMPLOYEE_WITH_ONE_DEPART);

/*
Prediction Result:
(1, 1)
(1, None)
*/