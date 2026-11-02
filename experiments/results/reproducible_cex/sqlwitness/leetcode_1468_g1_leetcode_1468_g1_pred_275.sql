-- Schema DDL
CREATE TABLE "Salaries" ("company_id" INTEGER, "employee_id" INTEGER, "employee_name" TEXT(255), "salary" INTEGER, PRIMARY KEY ("company_id", "employee_id"), CHECK ("salary" > 0));

-- Loading data
PRAGMA foreign_keys = OFF;
INSERT INTO salaries (company_id, employee_id, employee_name, salary) VALUES (1000, 10001, NULL, 10001), (1000, 1000, 'default2', 1), (1, 1001, NULL, 1), (1001, 999, NULL, 10000), (1001, 9999, NULL, NULL), (999, 9999, 'default1', NULL), (0, 9999, 'default2', 10001), (999, 999, 'default2', 9999), (1000, 999, 'default2', 1000), (2, 2, 'default1', 1000), (999, 2, 'default1', 999), (1001, -1, NULL, 1000), (-1, 2, 'default2', 1), (9999, 999, 'default1', 10001), (0, 1001, NULL, NULL);
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT S.COMPANY_ID, S.EMPLOYEE_ID, S.EMPLOYEE_NAME, CASE WHEN MAX_SALARY < 1000 THEN SALARY WHEN MAX_SALARY >= 1000 AND MAX_SALARY <= 10000 THEN ROUND(SALARY - SALARY * 0.24, 0) WHEN MAX_SALARY > 10000 THEN ROUND(SALARY - SALARY * 0.49, 0) END AS SALARY FROM SALARIES AS S JOIN (SELECT COMPANY_ID, MAX(SALARY) AS MAX_SALARY FROM SALARIES GROUP BY COMPANY_ID) AS T ON S.COMPANY_ID = T.COMPANY_ID;

/*
Gold Result:
(-1, 2, 'default2', 1)
(0, 1001, None, None)
(0, 9999, 'default2', 5101.0)
(1, 1001, None, 1)
(2, 2, 'default1', 760.0)
(999, 2, 'default1', 759.0)
(999, 999, 'default2', 7599.0)
(999, 9999, 'default1', None)
(1000, 999, 'default2', 510.0)
(1000, 1000, 'default2', 1.0)
(1000, 10001, None, 5101.0)
(1001, -1, None, 760.0)
(1001, 999, None, 7600.0)
(1001, 9999, None, None)
(9999, 999, 'default1', 5101.0)
*/

-- Prediction Query
WITH TAX AS (SELECT COMPANY_ID, CASE WHEN MAX_SALARY <= 1000 THEN 0 WHEN MAX_SALARY <= 10000 THEN 0.24 ELSE 0.49 END AS TAX_RATE FROM (SELECT COMPANY_ID, MAX(SALARY) AS MAX_SALARY FROM SALARIES GROUP BY COMPANY_ID) AS TEMP) SELECT SALARIES.COMPANY_ID, SALARIES.EMPLOYEE_ID, SALARIES.EMPLOYEE_NAME, ROUND(SALARY * (1 - TAX_RATE), 0) AS SALARY FROM SALARIES LEFT JOIN TAX ON SALARIES.COMPANY_ID = TAX.COMPANY_ID;

/*
Prediction Result:
(1000, 10001, None, 5101.0)
(1000, 1000, 'default2', 1.0)
(1, 1001, None, 1.0)
(1001, 999, None, 7600.0)
(1001, 9999, None, None)
(999, 9999, 'default1', None)
(0, 9999, 'default2', 5101.0)
(999, 999, 'default2', 7599.0)
(1000, 999, 'default2', 510.0)
(2, 2, 'default1', 1000.0)
(999, 2, 'default1', 759.0)
(1001, -1, None, 760.0)
(-1, 2, 'default2', 1.0)
(9999, 999, 'default1', 5101.0)
(0, 1001, None, None)
*/