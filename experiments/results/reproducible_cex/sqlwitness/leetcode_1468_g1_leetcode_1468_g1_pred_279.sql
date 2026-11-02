-- Schema DDL
CREATE TABLE "Salaries" ("company_id" INTEGER, "employee_id" INTEGER, "employee_name" TEXT(255), "salary" INTEGER, PRIMARY KEY ("company_id", "employee_id"), CHECK ("salary" > 0));

-- Loading data
PRAGMA foreign_keys = OFF;
INSERT INTO salaries (company_id, employee_id, employee_name, salary) VALUES (999, 1000, 'default2', 2), (9999, 1001, NULL, 1), (999, 1, 'default1', NULL), (10000, -1, NULL, 1001), (1, -1, 'default1', 1001), (9999, 10000, 'default2', 9999), (1001, 999, 'default1', 1000), (1000, 1001, NULL, 2), (10001, 10000, 'default1', 1000), (0, 1000, 'default1', 9999), (10000, 999, 'default2', 2), (2, -1, NULL, 9999), (-1, 10000, 'default1', 1000), (1, 10001, 'default2', 10000), (10001, 1001, 'default2', 1), (-1, 0, 'default1', NULL), (-1, 10001, NULL, NULL);
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT S.COMPANY_ID, S.EMPLOYEE_ID, S.EMPLOYEE_NAME, CASE WHEN MAX_SALARY < 1000 THEN SALARY WHEN MAX_SALARY >= 1000 AND MAX_SALARY <= 10000 THEN ROUND(SALARY - SALARY * 0.24, 0) WHEN MAX_SALARY > 10000 THEN ROUND(SALARY - SALARY * 0.49, 0) END AS SALARY FROM SALARIES AS S JOIN (SELECT COMPANY_ID, MAX(SALARY) AS MAX_SALARY FROM SALARIES GROUP BY COMPANY_ID) AS T ON S.COMPANY_ID = T.COMPANY_ID;

/*
Gold Result:
(-1, 0, 'default1', None)
(-1, 10000, 'default1', 760.0)
(-1, 10001, None, None)
(0, 1000, 'default1', 7599.0)
(1, -1, 'default1', 761.0)
(1, 10001, 'default2', 7600.0)
(2, -1, None, 7599.0)
(999, 1, 'default1', None)
(999, 1000, 'default2', 2)
(1000, 1001, None, 2)
(1001, 999, 'default1', 760.0)
(9999, 1001, None, 1.0)
(9999, 10000, 'default2', 7599.0)
(10000, -1, None, 761.0)
(10000, 999, 'default2', 2.0)
(10001, 1001, 'default2', 1.0)
(10001, 10000, 'default1', 760.0)
*/

-- Prediction Query
WITH TAX_RATE_BY_SALARY AS (SELECT *, CASE WHEN SALARY < 1000 THEN 0.0 WHEN SALARY <= 10000 THEN 0.24 ELSE 0.49 END AS TAX_RATE FROM SALARIES AS S), TAX_BY_COMPANY AS (SELECT COMPANY_ID, MAX(TAX_RATE) AS TAX FROM TAX_RATE_BY_SALARY AS T GROUP BY 1) SELECT S.COMPANY_ID, S.EMPLOYEE_ID, S.EMPLOYEE_NAME, ROUND(S.SALARY * (1 - T.TAX), 0) AS SALARY FROM SALARIES AS S LEFT JOIN TAX_BY_COMPANY AS T ON T.COMPANY_ID = S.COMPANY_ID;

/*
Prediction Result:
(999, 1000, 'default2', 1.0)
(9999, 1001, None, 1.0)
(999, 1, 'default1', None)
(10000, -1, None, 761.0)
(1, -1, 'default1', 761.0)
(9999, 10000, 'default2', 7599.0)
(1001, 999, 'default1', 760.0)
(1000, 1001, None, 2.0)
(10001, 10000, 'default1', 760.0)
(0, 1000, 'default1', 7599.0)
(10000, 999, 'default2', 2.0)
(2, -1, None, 7599.0)
(-1, 10000, 'default1', 510.0)
(1, 10001, 'default2', 7600.0)
(10001, 1001, 'default2', 1.0)
(-1, 0, 'default1', None)
(-1, 10001, None, None)
*/