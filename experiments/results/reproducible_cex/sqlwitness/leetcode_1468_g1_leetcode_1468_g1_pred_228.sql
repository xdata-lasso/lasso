-- Schema DDL
CREATE TABLE "Salaries" ("company_id" INTEGER, "employee_id" INTEGER, "employee_name" TEXT(255), "salary" INTEGER, PRIMARY KEY ("company_id", "employee_id"), CHECK ("salary" > 0));

-- Loading data
PRAGMA foreign_keys = OFF;
INSERT INTO salaries (company_id, employee_id, employee_name, salary) VALUES (1000, 1000, 'default1', 1000), (999, 9999, 'default1', NULL), (2, 1001, 'default2', 10000), (999, 10001, NULL, 10000), (0, 1001, 'default2', 2);
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT S.COMPANY_ID, S.EMPLOYEE_ID, S.EMPLOYEE_NAME, CASE WHEN MAX_SALARY < 1000 THEN SALARY WHEN MAX_SALARY >= 1000 AND MAX_SALARY <= 10000 THEN ROUND(SALARY - SALARY * 0.24, 0) WHEN MAX_SALARY > 10000 THEN ROUND(SALARY - SALARY * 0.49, 0) END AS SALARY FROM SALARIES AS S JOIN (SELECT COMPANY_ID, MAX(SALARY) AS MAX_SALARY FROM SALARIES GROUP BY COMPANY_ID) AS T ON S.COMPANY_ID = T.COMPANY_ID;

/*
Gold Result:
(0, 1001, 'default2', 2)
(2, 1001, 'default2', 7600.0)
(999, 9999, 'default1', None)
(999, 10001, None, 7600.0)
(1000, 1000, 'default1', 760.0)
*/

-- Prediction Query
WITH CTE AS (SELECT COMPANY_ID, CASE WHEN MAX(SALARY) > 10000 THEN 0.49 WHEN MAX(SALARY) > 1000 THEN 0.24 ELSE 0 END AS TAX FROM SALARIES GROUP BY 1) SELECT COMPANY_ID, EMPLOYEE_ID, EMPLOYEE_NAME, ROUND(SALARY * (1 - TAX), 0) AS SALARY FROM SALARIES AS S LEFT JOIN CTE AS C USING (COMPANY_ID);

/*
Prediction Result:
(1000, 1000, 'default1', 1000.0)
(999, 9999, 'default1', None)
(2, 1001, 'default2', 7600.0)
(999, 10001, None, 7600.0)
(0, 1001, 'default2', 2.0)
*/