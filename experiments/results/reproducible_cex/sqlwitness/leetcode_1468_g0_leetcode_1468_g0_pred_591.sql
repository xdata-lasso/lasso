-- Schema DDL
CREATE TABLE "Salaries" ("company_id" INTEGER, "employee_id" INTEGER, "employee_name" TEXT(255), "salary" INTEGER, PRIMARY KEY ("company_id", "employee_id"), CHECK ("salary" > 0));

-- Loading data
PRAGMA foreign_keys = OFF;
INSERT INTO salaries (company_id, employee_id, employee_name, salary) VALUES (0, 1000, NULL, 1001), (99, 50, NULL, 1000), (23, 9999, 'default2', 1), (-1, 9999, 'default2', 23), (10001, 99, 'default1', 50), (1000, 1, 'default1', 23), (10000, 101, 'default1', 24), (-1, 25, 'default1', 50), (0, 50, NULL, 99), (1, 25, 'default1', 24), (0, 0, 'default2', 23), (48, 23, 'default2', 1001), (101, 1000, NULL, 10000), (25, 10000, 'default1', 999);
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT S.COMPANY_ID, S.EMPLOYEE_ID, S.EMPLOYEE_NAME, ROUND(CASE WHEN X.MAX_SAL BETWEEN 1000 AND 10000 THEN SALARY * 0.76 WHEN X.MAX_SAL > 10000 THEN SALARY * 0.51 ELSE SALARY END, 0) AS SALARY FROM SALARIES AS S INNER JOIN (SELECT COMPANY_ID, MAX(SALARY) AS MAX_SAL FROM SALARIES GROUP BY COMPANY_ID) AS X ON S.COMPANY_ID = X.COMPANY_ID;

/*
Gold Result:
(-1, 25, 'default1', 50.0)
(-1, 9999, 'default2', 23.0)
(0, 0, 'default2', 17.0)
(0, 50, None, 75.0)
(0, 1000, None, 761.0)
(1, 25, 'default1', 24.0)
(23, 9999, 'default2', 1.0)
(25, 10000, 'default1', 999.0)
(48, 23, 'default2', 761.0)
(99, 50, None, 760.0)
(101, 1000, None, 7600.0)
(1000, 1, 'default1', 23.0)
(10000, 101, 'default1', 24.0)
(10001, 99, 'default1', 50.0)
*/

-- Prediction Query
WITH CTE AS (SELECT COMPANY_ID, EMPLOYEE_ID, EMPLOYEE_NAME, SALARY, MAX(SALARY) OVER (PARTITION BY COMPANY_ID) AS MAX_SALARY FROM SALARIES) SELECT COMPANY_ID, EMPLOYEE_ID, EMPLOYEE_NAME, ROUND(CASE WHEN MAX_SALARY > 10000 THEN (SALARY - SALARY * (CAST(49 AS REAL) / 100)) WHEN MAX_SALARY > 1000 AND MAX_SALARY < 10000 THEN (SALARY - SALARY * (CAST(24 AS REAL) / 100)) ELSE SALARY END) AS SALARY FROM CTE;

/*
Prediction Result:
(-1, 25, 'default1', 50.0)
(-1, 9999, 'default2', 23.0)
(0, 0, 'default2', 17.0)
(0, 50, None, 75.0)
(0, 1000, None, 761.0)
(1, 25, 'default1', 24.0)
(23, 9999, 'default2', 1.0)
(25, 10000, 'default1', 999.0)
(48, 23, 'default2', 761.0)
(99, 50, None, 1000.0)
(101, 1000, None, 10000.0)
(1000, 1, 'default1', 23.0)
(10000, 101, 'default1', 24.0)
(10001, 99, 'default1', 50.0)
*/