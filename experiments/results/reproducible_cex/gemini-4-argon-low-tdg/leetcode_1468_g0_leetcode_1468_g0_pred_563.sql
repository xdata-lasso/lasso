-- Schema DDL
CREATE TABLE "Salaries" ("company_id" INTEGER, "employee_id" INTEGER, "employee_name" TEXT(255), "salary" INTEGER, PRIMARY KEY ("company_id", "employee_id"), CHECK ("salary" > 0));

-- Loading data
PRAGMA foreign_keys = OFF;
-- DATASET 1
INSERT INTO "Salaries" ("company_id", "employee_id", "employee_name", "salary") VALUES (1, 101, 'Alice', 999);
INSERT INTO "Salaries" ("company_id", "employee_id", "employee_name", "salary") VALUES (2, 201, 'Bob', 1000);
INSERT INTO "Salaries" ("company_id", "employee_id", "employee_name", "salary") VALUES (3, 301, 'Charlie', 10000);
INSERT INTO "Salaries" ("company_id", "employee_id", "employee_name", "salary") VALUES (4, 401, 'Diana', 10001);
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT S.COMPANY_ID, S.EMPLOYEE_ID, S.EMPLOYEE_NAME, ROUND(CASE WHEN X.MAX_SAL BETWEEN 1000 AND 10000 THEN SALARY * 0.76 WHEN X.MAX_SAL > 10000 THEN SALARY * 0.51 ELSE SALARY END, 0) AS SALARY FROM SALARIES AS S INNER JOIN (SELECT COMPANY_ID, MAX(SALARY) AS MAX_SAL FROM SALARIES GROUP BY COMPANY_ID) AS X ON S.COMPANY_ID = X.COMPANY_ID;

/*
Gold Result:
(1, 101, 'Alice', 999.0)
(2, 201, 'Bob', 760.0)
(3, 301, 'Charlie', 7600.0)
(4, 401, 'Diana', 5101.0)
*/

-- Prediction Query
WITH CTE1 AS (SELECT COMPANY_ID, MAX(SALARY) AS MAX_SALARY FROM SALARIES GROUP BY COMPANY_ID), CTE2 AS (SELECT S.*, CTE1.MAX_SALARY FROM SALARIES AS S LEFT JOIN CTE1 ON S.COMPANY_ID = CTE1.COMPANY_ID) SELECT COMPANY_ID, EMPLOYEE_ID, EMPLOYEE_NAME, ROUND(CASE WHEN MAX_SALARY < 1000 AND MAX_SALARY > 0 THEN SALARY WHEN MAX_SALARY < 10000 AND MAX_SALARY >= 1000 THEN SALARY * 0.76 ELSE SALARY * 0.51 END, 0) AS SALARY FROM CTE2;

/*
Prediction Result:
(1, 101, 'Alice', 999.0)
(2, 201, 'Bob', 760.0)
(3, 301, 'Charlie', 5100.0)
(4, 401, 'Diana', 5101.0)
*/