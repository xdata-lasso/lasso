-- Schema DDL
CREATE TABLE "Salaries" ("company_id" INTEGER, "employee_id" INTEGER, "employee_name" TEXT(255), "salary" INTEGER, PRIMARY KEY ("company_id", "employee_id"), CHECK ("salary" > 0));

-- Loading data
PRAGMA foreign_keys = OFF;
INSERT INTO salaries (company_id, employee_id, employee_name, salary) VALUES (1000, 1000, NULL, 10001), (2, 1001, 'default2', 1000), (1000, 1, 'default2', 9999), (0, 1001, 'default1', NULL), (999, 10001, 'default2', 1001), (2, 9999, 'default1', 2);
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT S.COMPANY_ID, S.EMPLOYEE_ID, S.EMPLOYEE_NAME, CASE WHEN MAX_SALARY < 1000 THEN SALARY WHEN MAX_SALARY >= 1000 AND MAX_SALARY <= 10000 THEN ROUND(SALARY - SALARY * 0.24, 0) WHEN MAX_SALARY > 10000 THEN ROUND(SALARY - SALARY * 0.49, 0) END AS SALARY FROM SALARIES AS S JOIN (SELECT COMPANY_ID, MAX(SALARY) AS MAX_SALARY FROM SALARIES GROUP BY COMPANY_ID) AS T ON S.COMPANY_ID = T.COMPANY_ID;

/*
Gold Result:
(0, 1001, 'default1', None)
(2, 1001, 'default2', 760.0)
(2, 9999, 'default1', 2.0)
(999, 10001, 'default2', 761.0)
(1000, 1, 'default2', 5099.0)
(1000, 1000, None, 5101.0)
*/

-- Prediction Query
WITH CTE AS (SELECT COMPANY_ID, (CASE WHEN MAX(SALARY) < 1000 THEN 0.00 WHEN MAX(SALARY) > 1000 AND MAX(SALARY) < 10000 THEN 0.24 WHEN MAX(SALARY) > 10000 THEN 0.49 END) AS TAX FROM SALARIES GROUP BY 1) SELECT S.COMPANY_ID, S.EMPLOYEE_ID, S.EMPLOYEE_NAME, ROUND(S.SALARY * (1 - CTE.TAX)) AS SALARY FROM SALARIES AS S JOIN CTE ON S.COMPANY_ID = CTE.COMPANY_ID;

/*
Prediction Result:
(0, 1001, 'default1', None)
(2, 1001, 'default2', None)
(2, 9999, 'default1', None)
(999, 10001, 'default2', 761.0)
(1000, 1, 'default2', 5099.0)
(1000, 1000, None, 5101.0)
*/