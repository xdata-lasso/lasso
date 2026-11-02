-- Schema DDL
CREATE TABLE "Employee" ("employee_id" INTEGER, "department_id" INTEGER, "primary_flag" TEXT(255), PRIMARY KEY ("employee_id", "department_id"));

-- Loading data
PRAGMA foreign_keys = OFF;
INSERT INTO "employee" ("employee_id", "department_id", "primary_flag") VALUES (1011, NULL, 'Y');
INSERT INTO "employee" ("employee_id", "department_id", "primary_flag") VALUES (1011, NULL, 'Y');
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT EMPLOYEE_ID, DEPARTMENT_ID FROM EMPLOYEE GROUP BY EMPLOYEE_ID HAVING COUNT(*) = 1 UNION SELECT EMPLOYEE_ID, DEPARTMENT_ID FROM EMPLOYEE WHERE PRIMARY_FLAG = 'Y';

/*
Gold Result:
(1011, None)
*/

-- Prediction Query
WITH T1 AS (SELECT *, (SELECT IIF(COUNT(DISTINCT DEPARTMENT_ID) = 1, 1, 0) FROM EMPLOYEE AS E2 WHERE E2.EMPLOYEE_ID = E1.EMPLOYEE_ID) AS ONLY_IN_ONE_DEPARTMENT FROM EMPLOYEE AS E1), T2 AS (SELECT EMPLOYEE_ID, DEPARTMENT_ID FROM T1 WHERE PRIMARY_FLAG = 'Y' OR ONLY_IN_ONE_DEPARTMENT) SELECT * FROM T2;

/*
Prediction Result:
(1011, None)
(1011, None)
*/