-- Schema DDL
CREATE TABLE "Employee" ("employee_id" INTEGER, "department_id" INTEGER, "primary_flag" TEXT(255), PRIMARY KEY ("employee_id", "department_id"));

-- Loading data
PRAGMA foreign_keys = OFF;
INSERT INTO "employee" ("employee_id", "department_id", "primary_flag") VALUES (1061, 1062, 'Y');
INSERT INTO "employee" ("employee_id", "department_id", "primary_flag") VALUES (1063, 1064, 'dog');
INSERT INTO "employee" ("employee_id", "department_id", "primary_flag") VALUES (1063, 1060, 'Y');
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT EMPLOYEE_ID, DEPARTMENT_ID FROM EMPLOYEE GROUP BY EMPLOYEE_ID HAVING COUNT(*) = 1 UNION SELECT EMPLOYEE_ID, DEPARTMENT_ID FROM EMPLOYEE WHERE PRIMARY_FLAG = 'Y';

/*
Gold Result:
(1061, 1062)
(1063, 1060)
*/

-- Prediction Query
SELECT DISTINCT E1.EMPLOYEE_ID, COALESCE(E2.DEPARTMENT_ID, E1.DEPARTMENT_ID) AS DEPARTMENT_ID FROM EMPLOYEE AS E1 LEFT JOIN EMPLOYEE AS E2 ON E1.EMPLOYEE_ID = E2.EMPLOYEE_ID AND E1.PRIMARY_FLAG = 'N' AND E2.PRIMARY_FLAG = 'Y';

/*
Prediction Result:
(1061, 1062)
(1063, 1060)
(1063, 1064)
*/