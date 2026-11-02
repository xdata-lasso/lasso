-- Schema DDL
CREATE TABLE "Salaries" ("company_id" INTEGER, "employee_id" INTEGER, "employee_name" TEXT(255), "salary" INTEGER, PRIMARY KEY ("company_id", "employee_id"), CHECK ("salary" > 0));

-- Loading data
PRAGMA foreign_keys = OFF;
INSERT INTO salaries (company_id, employee_id, employee_name, salary) VALUES (10000, 0, 'default1', 999), (1001, 9999, 'default1', 1), (999, 9999, 'default2', 1000), (999, 1001, NULL, 9999), (10001, -1, 'default2', 9999), (999, -1, NULL, 10000), (1, 10001, 'default2', 1001), (999, 1, NULL, 1001), (-1, 9999, 'default2', 10000), (999, 1000, 'default1', NULL), (1, 10000, 'default2', 1);
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT S.COMPANY_ID, S.EMPLOYEE_ID, S.EMPLOYEE_NAME, ROUND(CASE WHEN X.MAX_SAL BETWEEN 1000 AND 10000 THEN SALARY * 0.76 WHEN X.MAX_SAL > 10000 THEN SALARY * 0.51 ELSE SALARY END, 0) AS SALARY FROM SALARIES AS S INNER JOIN (SELECT COMPANY_ID, MAX(SALARY) AS MAX_SAL FROM SALARIES GROUP BY COMPANY_ID) AS X ON S.COMPANY_ID = X.COMPANY_ID;

/*
Gold Result:
(-1, 9999, 'default2', 7600.0)
(1, 10000, 'default2', 1.0)
(1, 10001, 'default2', 761.0)
(999, -1, None, 7600.0)
(999, 1, None, 761.0)
(999, 1000, 'default1', None)
(999, 1001, None, 7599.0)
(999, 9999, 'default2', 760.0)
(1001, 9999, 'default1', 1.0)
(10000, 0, 'default1', 999.0)
(10001, -1, 'default2', 7599.0)
*/

-- Prediction Query
WITH CTE1 AS (SELECT COMPANY_ID, MAX(SALARY) AS MAX_SALARY FROM SALARIES GROUP BY COMPANY_ID), CTE2 AS (SELECT S.*, CTE1.MAX_SALARY FROM SALARIES AS S LEFT JOIN CTE1 ON S.COMPANY_ID = CTE1.COMPANY_ID) SELECT COMPANY_ID, EMPLOYEE_ID, EMPLOYEE_NAME, ROUND(CASE WHEN MAX_SALARY < 1000 AND MAX_SALARY > 0 THEN SALARY WHEN MAX_SALARY < 10000 AND MAX_SALARY >= 1000 THEN SALARY * 0.76 ELSE SALARY * 0.51 END, 0) AS SALARY FROM CTE2;

/*
Prediction Result:
(10000, 0, 'default1', 999.0)
(1001, 9999, 'default1', 1.0)
(999, 9999, 'default2', 510.0)
(999, 1001, None, 5099.0)
(10001, -1, 'default2', 7599.0)
(999, -1, None, 5100.0)
(1, 10001, 'default2', 761.0)
(999, 1, None, 511.0)
(-1, 9999, 'default2', 5100.0)
(999, 1000, 'default1', None)
(1, 10000, 'default2', 1.0)
*/