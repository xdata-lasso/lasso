-- Schema DDL
CREATE TABLE "Salaries" ("company_id" INTEGER, "employee_id" INTEGER, "employee_name" TEXT(255), "salary" INTEGER, PRIMARY KEY ("company_id", "employee_id"), CHECK ("salary" > 0));

-- Loading data
PRAGMA foreign_keys = OFF;
INSERT INTO salaries (company_id, employee_id, employee_name, salary) VALUES (1, 999, 'default1', 1001), (2, 1, 'default2', 10000), (10001, 2, 'default2', 2), (0, 10001, 'default1', 1001), (10000, 0, 'default2', 10000), (2, 10001, 'default2', 1001);
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT S.COMPANY_ID, S.EMPLOYEE_ID, S.EMPLOYEE_NAME, ROUND(CASE WHEN X.MAX_SAL BETWEEN 1000 AND 10000 THEN SALARY * 0.76 WHEN X.MAX_SAL > 10000 THEN SALARY * 0.51 ELSE SALARY END, 0) AS SALARY FROM SALARIES AS S INNER JOIN (SELECT COMPANY_ID, MAX(SALARY) AS MAX_SAL FROM SALARIES GROUP BY COMPANY_ID) AS X ON S.COMPANY_ID = X.COMPANY_ID;

/*
Gold Result:
(0, 10001, 'default1', 761.0)
(1, 999, 'default1', 761.0)
(2, 1, 'default2', 7600.0)
(2, 10001, 'default2', 761.0)
(10000, 0, 'default2', 7600.0)
(10001, 2, 'default2', 2.0)
*/

-- Prediction Query
WITH TAX_RATES AS (SELECT COMPANY_ID, CASE WHEN MAX(SALARY) < 1000 THEN 0.0 WHEN MAX(SALARY) < 10000 THEN 0.24 ELSE 0.49 END AS TAX_RATE FROM SALARIES GROUP BY 1) SELECT S.COMPANY_ID, EMPLOYEE_ID, EMPLOYEE_NAME, ROUND(SALARY * (1 - TAX_RATE)) AS SALARY FROM SALARIES AS S LEFT JOIN TAX_RATES AS T ON S.COMPANY_ID = T.COMPANY_ID;

/*
Prediction Result:
(1, 999, 'default1', 761.0)
(2, 1, 'default2', 5100.0)
(10001, 2, 'default2', 2.0)
(0, 10001, 'default1', 761.0)
(10000, 0, 'default2', 5100.0)
(2, 10001, 'default2', 511.0)
*/