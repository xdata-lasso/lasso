-- Schema DDL
CREATE TABLE "Salaries" ("company_id" INTEGER, "employee_id" INTEGER, "employee_name" TEXT(255), "salary" INTEGER, PRIMARY KEY ("company_id", "employee_id"), CHECK ("salary" > 0));

-- Loading data
PRAGMA foreign_keys = OFF;
INSERT INTO salaries (company_id, employee_id, employee_name, salary) VALUES (-1, 10001, 'default2', 1), (1000, 1000, 'default1', 1001), (1, 1, 'default1', 1000), (9999, 10001, NULL, 1), (-1, 1000, NULL, 1000), (1, 10000, 'default2', 1001), (9999, 0, 'default1', 10000), (10000, 10000, 'default1', 1), (1001, -1, NULL, 9999), (10001, 10000, 'default1', 1000), (10001, 0, 'default2', 10000), (10000, 999, NULL, NULL);
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT S.COMPANY_ID, S.EMPLOYEE_ID, S.EMPLOYEE_NAME, CASE WHEN MAX_SALARY < 1000 THEN SALARY WHEN MAX_SALARY >= 1000 AND MAX_SALARY <= 10000 THEN ROUND(SALARY - SALARY * 0.24, 0) WHEN MAX_SALARY > 10000 THEN ROUND(SALARY - SALARY * 0.49, 0) END AS SALARY FROM SALARIES AS S JOIN (SELECT COMPANY_ID, MAX(SALARY) AS MAX_SALARY FROM SALARIES GROUP BY COMPANY_ID) AS T ON S.COMPANY_ID = T.COMPANY_ID;

/*
Gold Result:
(-1, 1000, None, 760.0)
(-1, 10001, 'default2', 1.0)
(1, 1, 'default1', 760.0)
(1, 10000, 'default2', 761.0)
(1000, 1000, 'default1', 761.0)
(1001, -1, None, 7599.0)
(9999, 0, 'default1', 7600.0)
(9999, 10001, None, 1.0)
(10000, 999, None, None)
(10000, 10000, 'default1', 1)
(10001, 0, 'default2', 7600.0)
(10001, 10000, 'default1', 760.0)
*/

-- Prediction Query
WITH CTE AS (SELECT *, MAX(SALARY) OVER (PARTITION BY COMPANY_ID) AS MXSALARY FROM SALARIES ORDER BY COMPANY_ID, SALARIES.employee_id NULLS LAST) SELECT COMPANY_ID, EMPLOYEE_ID, EMPLOYEE_NAME, ROUND(CASE WHEN MXSALARY < 1000 THEN SALARY WHEN MXSALARY < 10000 THEN 0.76 * SALARY ELSE 0.51 * SALARY END) AS SALARY FROM CTE;

/*
Prediction Result:
(-1, 1000, None, 760.0)
(-1, 10001, 'default2', 1.0)
(1, 1, 'default1', 760.0)
(1, 10000, 'default2', 761.0)
(1000, 1000, 'default1', 761.0)
(1001, -1, None, 7599.0)
(9999, 0, 'default1', 5100.0)
(9999, 10001, None, 1.0)
(10000, 999, None, None)
(10000, 10000, 'default1', 1.0)
(10001, 0, 'default2', 5100.0)
(10001, 10000, 'default1', 510.0)
*/