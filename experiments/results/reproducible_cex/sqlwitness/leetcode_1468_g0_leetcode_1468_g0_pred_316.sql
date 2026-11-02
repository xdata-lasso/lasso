-- Schema DDL
CREATE TABLE "Salaries" ("company_id" INTEGER, "employee_id" INTEGER, "employee_name" TEXT(255), "salary" INTEGER, PRIMARY KEY ("company_id", "employee_id"), CHECK ("salary" > 0));

-- Loading data
PRAGMA foreign_keys = OFF;
INSERT INTO salaries (company_id, employee_id, employee_name, salary) VALUES (23, 1, 'default1', NULL), (-1, 101, 'default2', 9999), (101, 23, NULL, 25), (1001, 1001, 'default2', 9999), (1000, 0, 'default2', 99), (-1, 10000, 'default1', 1001), (10001, 25, 'default2', 24), (50, 10000, 'default1', 24), (99, 48, 'default1', 24), (1000, 10001, 'default1', 23);
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT S.COMPANY_ID, S.EMPLOYEE_ID, S.EMPLOYEE_NAME, ROUND(CASE WHEN X.MAX_SAL BETWEEN 1000 AND 10000 THEN SALARY * 0.76 WHEN X.MAX_SAL > 10000 THEN SALARY * 0.51 ELSE SALARY END, 0) AS SALARY FROM SALARIES AS S INNER JOIN (SELECT COMPANY_ID, MAX(SALARY) AS MAX_SAL FROM SALARIES GROUP BY COMPANY_ID) AS X ON S.COMPANY_ID = X.COMPANY_ID;

/*
Gold Result:
(-1, 101, 'default2', 7599.0)
(-1, 10000, 'default1', 761.0)
(23, 1, 'default1', None)
(50, 10000, 'default1', 24.0)
(99, 48, 'default1', 24.0)
(101, 23, None, 25.0)
(1000, 0, 'default2', 99.0)
(1000, 10001, 'default1', 23.0)
(1001, 1001, 'default2', 7599.0)
(10001, 25, 'default2', 24.0)
*/

-- Prediction Query
WITH A AS (SELECT COMPANY_ID, MAX(SALARY) AS MAX_SALARY FROM SALARIES GROUP BY 1), B AS (SELECT B.COMPANY_ID, EMPLOYEE_ID, EMPLOYEE_NAME, SALARY, MAX_SALARY FROM SALARIES AS B JOIN A ON A.COMPANY_ID = B.COMPANY_ID) SELECT COMPANY_ID, EMPLOYEE_ID, EMPLOYEE_NAME, CASE WHEN MAX_SALARY < 1000 THEN SALARY WHEN MAX_SALARY BETWEEN 1000 AND 10000 THEN ROUND((SALARY - (CAST(24 AS REAL) / 100) * SALARY), 0) WHEN MAX_SALARY > 10000 THEN ROUND((SALARY - (CAST(49 AS REAL) / 100) * SALARY), 0) ELSE 0 END AS SALARY FROM B;

/*
Prediction Result:
(-1, 101, 'default2', 7599.0)
(-1, 10000, 'default1', 761.0)
(23, 1, 'default1', 0)
(50, 10000, 'default1', 24)
(99, 48, 'default1', 24)
(101, 23, None, 25)
(1000, 0, 'default2', 99)
(1000, 10001, 'default1', 23)
(1001, 1001, 'default2', 7599.0)
(10001, 25, 'default2', 24)
*/