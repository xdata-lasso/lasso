-- Schema DDL
CREATE TABLE "Salaries" ("company_id" INTEGER, "employee_id" INTEGER, "employee_name" TEXT(255), "salary" INTEGER, PRIMARY KEY ("company_id", "employee_id"), CHECK ("salary" > 0));

-- Loading data
PRAGMA foreign_keys = OFF;
INSERT INTO salaries (company_id, employee_id, employee_name, salary) VALUES (1000, 1001, NULL, 9999), (10000, 1001, 'default1', 1), (10001, 1, 'default1', 10000), (1, -1, 'default2', 10000), (-1, 10001, 'default2', NULL), (10000, 999, NULL, 10001);
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT S.COMPANY_ID, S.EMPLOYEE_ID, S.EMPLOYEE_NAME, ROUND(CASE WHEN X.MAX_SAL BETWEEN 1000 AND 10000 THEN SALARY * 0.76 WHEN X.MAX_SAL > 10000 THEN SALARY * 0.51 ELSE SALARY END, 0) AS SALARY FROM SALARIES AS S INNER JOIN (SELECT COMPANY_ID, MAX(SALARY) AS MAX_SAL FROM SALARIES GROUP BY COMPANY_ID) AS X ON S.COMPANY_ID = X.COMPANY_ID;

/*
Gold Result:
(-1, 10001, 'default2', None)
(1, -1, 'default2', 7600.0)
(1000, 1001, None, 7599.0)
(10000, 999, None, 5101.0)
(10000, 1001, 'default1', 1.0)
(10001, 1, 'default1', 7600.0)
*/

-- Prediction Query
WITH CTE AS (SELECT *, MAX(SALARY) OVER (PARTITION BY COMPANY_ID) AS MXSALARY FROM SALARIES ORDER BY COMPANY_ID, SALARIES.employee_id NULLS LAST) SELECT COMPANY_ID, EMPLOYEE_ID, EMPLOYEE_NAME, ROUND(CASE WHEN MXSALARY < 1000 THEN SALARY WHEN MXSALARY < 10000 THEN 0.76 * SALARY ELSE 0.51 * SALARY END) AS SALARY FROM CTE;

/*
Prediction Result:
(-1, 10001, 'default2', None)
(1, -1, 'default2', 5100.0)
(1000, 1001, None, 7599.0)
(10000, 999, None, 5101.0)
(10000, 1001, 'default1', 1.0)
(10001, 1, 'default1', 5100.0)
*/