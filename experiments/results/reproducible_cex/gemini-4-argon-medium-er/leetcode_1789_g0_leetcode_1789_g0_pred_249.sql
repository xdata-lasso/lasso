-- Schema DDL
CREATE TABLE "Employee" ("employee_id" INTEGER, "department_id" INTEGER, "primary_flag" TEXT(255), PRIMARY KEY ("employee_id", "department_id"));

-- Loading data
PRAGMA foreign_keys = OFF;
INSERT INTO "Employee" ("employee_id", "department_id", "primary_flag") VALUES (1, 10, 'N');
INSERT INTO "Employee" ("employee_id", "department_id", "primary_flag") VALUES (1, 20, 'N');
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT EMPLOYEE_ID, DEPARTMENT_ID FROM EMPLOYEE GROUP BY EMPLOYEE_ID HAVING COUNT(*) = 1 UNION SELECT EMPLOYEE_ID, DEPARTMENT_ID FROM EMPLOYEE WHERE PRIMARY_FLAG = 'Y';

/*
Gold Result:
*/

-- Prediction Query
SELECT A.EMPLOYEE_ID, B.DEPARTMENT_ID FROM EMPLOYEE AS A LEFT JOIN (SELECT EMPLOYEE_ID, DEPARTMENT_ID FROM EMPLOYEE WHERE PRIMARY_FLAG = 'Y') AS B ON A.EMPLOYEE_ID = B.EMPLOYEE_ID GROUP BY 1 HAVING COUNT(PRIMARY_FLAG) > 1 UNION ALL SELECT EMPLOYEE_ID, DEPARTMENT_ID FROM EMPLOYEE GROUP BY 1 HAVING COUNT(PRIMARY_FLAG) = 1;

/*
Prediction Result:
(1, None)
*/