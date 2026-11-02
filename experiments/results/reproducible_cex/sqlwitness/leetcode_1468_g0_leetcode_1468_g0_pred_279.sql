-- Schema DDL
CREATE TABLE "Salaries" ("company_id" INTEGER, "employee_id" INTEGER, "employee_name" TEXT(255), "salary" INTEGER, PRIMARY KEY ("company_id", "employee_id"), CHECK ("salary" > 0));

-- Loading data
PRAGMA foreign_keys = OFF;
INSERT INTO salaries (company_id, employee_id, employee_name, salary) VALUES (1000, 1, 'default2', 1000), (2, 1001, 'default2', 9999), (1, 999, 'default1', 1001), (999, 10000, 'default2', 999), (1, 9999, 'default1', NULL), (999, 0, 'default1', 2), (10000, 0, NULL, NULL), (1000, 10000, 'default2', 1001), (-1, 1, NULL, 1000), (1000, -1, 'default1', NULL), (1001, 2, 'default2', 10001), (0, -1, 'default2', 1000);
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT S.COMPANY_ID, S.EMPLOYEE_ID, S.EMPLOYEE_NAME, ROUND(CASE WHEN X.MAX_SAL BETWEEN 1000 AND 10000 THEN SALARY * 0.76 WHEN X.MAX_SAL > 10000 THEN SALARY * 0.51 ELSE SALARY END, 0) AS SALARY FROM SALARIES AS S INNER JOIN (SELECT COMPANY_ID, MAX(SALARY) AS MAX_SAL FROM SALARIES GROUP BY COMPANY_ID) AS X ON S.COMPANY_ID = X.COMPANY_ID;

/*
Gold Result:
(-1, 1, None, 760.0)
(0, -1, 'default2', 760.0)
(1, 999, 'default1', 761.0)
(1, 9999, 'default1', None)
(2, 1001, 'default2', 7599.0)
(999, 0, 'default1', 2.0)
(999, 10000, 'default2', 999.0)
(1000, -1, 'default1', None)
(1000, 1, 'default2', 760.0)
(1000, 10000, 'default2', 761.0)
(1001, 2, 'default2', 5101.0)
(10000, 0, None, None)
*/

-- Prediction Query
WITH TAX_RATE_BY_SALARY AS (SELECT *, CASE WHEN SALARY < 1000 THEN 0.0 WHEN SALARY <= 10000 THEN 0.24 ELSE 0.49 END AS TAX_RATE FROM SALARIES AS S), TAX_BY_COMPANY AS (SELECT COMPANY_ID, MAX(TAX_RATE) AS TAX FROM TAX_RATE_BY_SALARY AS T GROUP BY 1) SELECT S.COMPANY_ID, S.EMPLOYEE_ID, S.EMPLOYEE_NAME, ROUND(S.SALARY * (1 - T.TAX), 0) AS SALARY FROM SALARIES AS S LEFT JOIN TAX_BY_COMPANY AS T ON T.COMPANY_ID = S.COMPANY_ID;

/*
Prediction Result:
(1000, 1, 'default2', 510.0)
(2, 1001, 'default2', 7599.0)
(1, 999, 'default1', 511.0)
(999, 10000, 'default2', 999.0)
(1, 9999, 'default1', None)
(999, 0, 'default1', 2.0)
(10000, 0, None, None)
(1000, 10000, 'default2', 511.0)
(-1, 1, None, 760.0)
(1000, -1, 'default1', None)
(1001, 2, 'default2', 5101.0)
(0, -1, 'default2', 760.0)
*/