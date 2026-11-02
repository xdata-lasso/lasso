-- Schema DDL
CREATE TABLE "Salaries" ("company_id" INTEGER, "employee_id" INTEGER, "employee_name" TEXT(255), "salary" INTEGER, PRIMARY KEY ("company_id", "employee_id"), CHECK ("salary" > 0));

-- Loading data
PRAGMA foreign_keys = OFF;
INSERT INTO salaries (company_id, employee_id, employee_name, salary) VALUES (-1, 1001, 'default2', 1000), (1, 9999, 'default2', 10001), (999, 1000, 'default1', 1001), (1001, 0, 'default2', 1000), (1000, 1000, 'default2', 9999), (1, 1001, NULL, 10001), (1001, 1001, NULL, 1001), (1001, -1, NULL, 999), (9999, 999, 'default2', 999), (1, 999, NULL, 10000), (1000, -1, 'default2', 999);
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT S.COMPANY_ID, S.EMPLOYEE_ID, S.EMPLOYEE_NAME, CASE WHEN MAX_SALARY < 1000 THEN SALARY WHEN MAX_SALARY >= 1000 AND MAX_SALARY <= 10000 THEN ROUND(SALARY - SALARY * 0.24, 0) WHEN MAX_SALARY > 10000 THEN ROUND(SALARY - SALARY * 0.49, 0) END AS SALARY FROM SALARIES AS S JOIN (SELECT COMPANY_ID, MAX(SALARY) AS MAX_SALARY FROM SALARIES GROUP BY COMPANY_ID) AS T ON S.COMPANY_ID = T.COMPANY_ID;

/*
Gold Result:
(-1, 1001, 'default2', 760.0)
(1, 999, None, 5100.0)
(1, 1001, None, 5101.0)
(1, 9999, 'default2', 5101.0)
(999, 1000, 'default1', 761.0)
(1000, -1, 'default2', 759.0)
(1000, 1000, 'default2', 7599.0)
(1001, -1, None, 759.0)
(1001, 0, 'default2', 760.0)
(1001, 1001, None, 761.0)
(9999, 999, 'default2', 999)
*/

-- Prediction Query
WITH CTE AS (SELECT COMPANY_ID, EMPLOYEE_ID, EMPLOYEE_NAME, CASE WHEN MAX_SAL < 1000 THEN 0 WHEN MAX_SAL > 1000 AND MAX_SAL <= 10000 THEN 0.24 WHEN MAX_SAL > 10000 THEN 0.49 END AS PERCENTAGE, SALARY FROM (SELECT COMPANY_ID, EMPLOYEE_ID, EMPLOYEE_NAME, SALARY, MAX(SALARY) OVER (PARTITION BY COMPANY_ID) AS MAX_SAL FROM SALARIES) AS A) SELECT COMPANY_ID, EMPLOYEE_ID, EMPLOYEE_NAME, ROUND(SALARY - (SALARY * PERCENTAGE), 0) AS SALARY FROM CTE;

/*
Prediction Result:
(-1, 1001, 'default2', None)
(1, 999, None, 5100.0)
(1, 1001, None, 5101.0)
(1, 9999, 'default2', 5101.0)
(999, 1000, 'default1', 761.0)
(1000, -1, 'default2', 759.0)
(1000, 1000, 'default2', 7599.0)
(1001, -1, None, 759.0)
(1001, 0, 'default2', 760.0)
(1001, 1001, None, 761.0)
(9999, 999, 'default2', 999.0)
*/