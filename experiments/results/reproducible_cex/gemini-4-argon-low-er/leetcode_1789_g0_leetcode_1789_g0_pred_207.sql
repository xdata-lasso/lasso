-- Schema DDL
CREATE TABLE "Employee" ("employee_id" INTEGER, "department_id" INTEGER, "primary_flag" TEXT(255), PRIMARY KEY ("employee_id", "department_id"));

-- Loading data
PRAGMA foreign_keys = OFF;
INSERT INTO "Employee" ("employee_id", "department_id", "primary_flag") VALUES (1, NULL, 'N');
INSERT INTO "Employee" ("employee_id", "department_id", "primary_flag") VALUES (1, 10, 'N');
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT EMPLOYEE_ID, DEPARTMENT_ID FROM EMPLOYEE GROUP BY EMPLOYEE_ID HAVING COUNT(*) = 1 UNION SELECT EMPLOYEE_ID, DEPARTMENT_ID FROM EMPLOYEE WHERE PRIMARY_FLAG = 'Y';

/*
Gold Result:
*/

-- Prediction Query
SELECT E.EMPLOYEE_ID, E.DEPARTMENT_ID FROM EMPLOYEE AS E LEFT JOIN (SELECT EMPLOYEE_ID, COUNT(DEPARTMENT_ID) AS NUM_DEP FROM EMPLOYEE GROUP BY EMPLOYEE_ID) AS E2 ON E.EMPLOYEE_ID = E2.EMPLOYEE_ID WHERE E.PRIMARY_FLAG = 'Y' OR E2.NUM_DEP = 1;

/*
Prediction Result:
(1, None)
(1, 10)
*/