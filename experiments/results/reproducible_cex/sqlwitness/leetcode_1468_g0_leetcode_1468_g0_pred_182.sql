-- Schema DDL
CREATE TABLE "Salaries" ("company_id" INTEGER, "employee_id" INTEGER, "employee_name" TEXT(255), "salary" INTEGER, PRIMARY KEY ("company_id", "employee_id"), CHECK ("salary" > 0));

-- Loading data
PRAGMA foreign_keys = OFF;
INSERT INTO salaries (company_id, employee_id, employee_name, salary) VALUES (1000, 1001, 'default1', 1), (10001, 999, NULL, 10001), (1001, 0, 'default1', 9999), (0, 0, 'default1', 10000), (9999, 1000, NULL, 1), (-1, 999, 'default1', 1001), (999, -1, 'default1', 1), (9999, 999, 'default2', 9999), (10000, 999, 'default1', NULL);
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT S.COMPANY_ID, S.EMPLOYEE_ID, S.EMPLOYEE_NAME, ROUND(CASE WHEN X.MAX_SAL BETWEEN 1000 AND 10000 THEN SALARY * 0.76 WHEN X.MAX_SAL > 10000 THEN SALARY * 0.51 ELSE SALARY END, 0) AS SALARY FROM SALARIES AS S INNER JOIN (SELECT COMPANY_ID, MAX(SALARY) AS MAX_SAL FROM SALARIES GROUP BY COMPANY_ID) AS X ON S.COMPANY_ID = X.COMPANY_ID;

/*
Gold Result:
(-1, 999, 'default1', 761.0)
(0, 0, 'default1', 7600.0)
(999, -1, 'default1', 1.0)
(1000, 1001, 'default1', 1.0)
(1001, 0, 'default1', 7599.0)
(9999, 999, 'default2', 7599.0)
(9999, 1000, None, 1.0)
(10000, 999, 'default1', None)
(10001, 999, None, 5101.0)
*/

-- Prediction Query
SELECT S.COMPANY_ID, S.EMPLOYEE_ID, S.EMPLOYEE_NAME, ROUND(S.SALARY * (1 - TEMP.TAX_RATE), 0) AS SALARY FROM SALARIES AS S LEFT JOIN (SELECT DISTINCT COMPANY_ID, MAX(SALARY), CASE WHEN MAX(SALARY) < 1000 THEN 0 WHEN MAX(SALARY) >= 1000 AND MAX(SALARY) < 10000 THEN 0.24 ELSE 0.49 END AS TAX_RATE FROM SALARIES GROUP BY COMPANY_ID) AS TEMP ON TEMP.COMPANY_ID = S.COMPANY_ID;

/*
Prediction Result:
(1000, 1001, 'default1', 1.0)
(10001, 999, None, 5101.0)
(1001, 0, 'default1', 7599.0)
(0, 0, 'default1', 5100.0)
(9999, 1000, None, 1.0)
(-1, 999, 'default1', 761.0)
(999, -1, 'default1', 1.0)
(9999, 999, 'default2', 7599.0)
(10000, 999, 'default1', None)
*/