-- Schema DDL
CREATE TABLE "Employee" ("employee_id" INTEGER, "department_id" INTEGER, "primary_flag" TEXT(255), PRIMARY KEY ("employee_id", "department_id"));

-- Loading data
PRAGMA foreign_keys = OFF;
-- Inserting into table: employee --
INSERT INTO "employee" ("employee_id", "department_id", "primary_flag") VALUES (1, 2, 'emp_d90689');

INSERT INTO "employee" ("employee_id", "department_id", "primary_flag") VALUES (1, 3, 'emp_d90689');

INSERT INTO "employee" ("employee_id", "department_id", "primary_flag") VALUES (1, 4, 'emp_d90689');

INSERT INTO "employee" ("employee_id", "department_id", "primary_flag") VALUES (1, 1, 'emp_d90689');

INSERT INTO "employee" ("employee_id", "department_id", "primary_flag") VALUES (2, -2147483644, 'emp_d90689');
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT e.employee_id, e.department_id FROM employee AS e WHERE e.primary_flag = 'Y' OR e.employee_id IN (SELECT employee_id FROM employee GROUP BY employee_id HAVING COUNT(DISTINCT department_id) = 1);

/*
Gold Result:
(2, -2147483644)
*/

-- Prediction Query
SELECT A.EMPLOYEE_ID, A.DEPARTMENT_ID FROM (SELECT E1.EMPLOYEE_ID, E1.DEPARTMENT_ID, CASE WHEN E2.PRIMARY_FLAG IS NULL THEN NULL ELSE E2.PRIMARY_FLAG END AS PRIMARY_FLAG_V1 FROM EMPLOYEE AS E1 LEFT JOIN EMPLOYEE AS E2 ON E1.EMPLOYEE_ID = E2.EMPLOYEE_ID AND E1.DEPARTMENT_ID <> E2.DEPARTMENT_ID AND E1.PRIMARY_FLAG <> 'Y') AS A WHERE A.PRIMARY_FLAG_V1 = 'NULL';

/*
Prediction Result:
*/