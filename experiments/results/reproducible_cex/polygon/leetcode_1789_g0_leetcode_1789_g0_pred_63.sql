-- Schema DDL
CREATE TABLE "Employee" ("employee_id" INTEGER, "department_id" INTEGER, "primary_flag" TEXT(255), PRIMARY KEY ("employee_id", "department_id"));

-- Loading data
PRAGMA foreign_keys = OFF;
INSERT INTO "Employee" ("employee_id", "department_id", "primary_flag") VALUES (14, 11, 'N');
INSERT INTO "Employee" ("employee_id", "department_id", "primary_flag") VALUES (14, 10, NULL);
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT EMPLOYEE_ID, DEPARTMENT_ID FROM EMPLOYEE GROUP BY EMPLOYEE_ID HAVING COUNT(*) = 1 UNION SELECT EMPLOYEE_ID, DEPARTMENT_ID FROM EMPLOYEE WHERE PRIMARY_FLAG = 'Y';

/*
Gold Result:
*/

-- Prediction Query
SELECT A.EMPLOYEE_ID, MAX(CASE WHEN CNT = 1 THEN A.DEPARTMENT_ID WHEN CNT > 1 AND A.PRIMARY_FLAG = 'Y' THEN A.DEPARTMENT_ID END) AS DEPARTMENT_ID FROM EMPLOYEE AS A INNER JOIN (SELECT EMPLOYEE_ID, COUNT(*) AS CNT FROM EMPLOYEE GROUP BY 1) AS B ON A.EMPLOYEE_ID = B.EMPLOYEE_ID GROUP BY 1;

/*
Prediction Result:
(14, None)
*/