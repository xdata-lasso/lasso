-- Schema DDL
CREATE TABLE "Salaries" ("company_id" INTEGER, "employee_id" INTEGER, "employee_name" TEXT(255), "salary" INTEGER, PRIMARY KEY ("company_id", "employee_id"), CHECK ("salary" > 0));

-- Loading data
PRAGMA foreign_keys = OFF;
INSERT INTO salaries (company_id, employee_id, employee_name, salary) VALUES (10001, 999, NULL, 10000), (2, 10001, 'default1', NULL), (0, 0, NULL, 1001), (1000, 1000, NULL, 9999), (2, 1000, 'default1', 999), (999, 0, 'default2', 9999), (-1, 1000, 'default2', 10001), (10000, 10001, 'default1', 9999), (9999, 0, 'default1', 1001), (-1, 2, 'default2', NULL), (0, -1, 'default1', 1);
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT S.COMPANY_ID, S.EMPLOYEE_ID, S.EMPLOYEE_NAME, CASE WHEN MAX_SALARY < 1000 THEN SALARY WHEN MAX_SALARY >= 1000 AND MAX_SALARY <= 10000 THEN ROUND(SALARY - SALARY * 0.24, 0) WHEN MAX_SALARY > 10000 THEN ROUND(SALARY - SALARY * 0.49, 0) END AS SALARY FROM SALARIES AS S JOIN (SELECT COMPANY_ID, MAX(SALARY) AS MAX_SALARY FROM SALARIES GROUP BY COMPANY_ID) AS T ON S.COMPANY_ID = T.COMPANY_ID;

/*
Gold Result:
(-1, 2, 'default2', None)
(-1, 1000, 'default2', 5101.0)
(0, -1, 'default1', 1.0)
(0, 0, None, 761.0)
(2, 1000, 'default1', 999)
(2, 10001, 'default1', None)
(999, 0, 'default2', 7599.0)
(1000, 1000, None, 7599.0)
(9999, 0, 'default1', 761.0)
(10000, 10001, 'default1', 7599.0)
(10001, 999, None, 7600.0)
*/

-- Prediction Query
WITH T AS (SELECT CASE WHEN MAX(SALARY) < 1000 THEN 0 WHEN MAX(SALARY) < 10000 THEN 0.24 ELSE 0.49 END AS RATE, COMPANY_ID FROM SALARIES GROUP BY COMPANY_ID) SELECT S.COMPANY_ID, EMPLOYEE_ID, EMPLOYEE_NAME, ROUND(SALARY * (1 - RATE), 0) AS SALARY FROM SALARIES AS S JOIN T ON S.COMPANY_ID = T.COMPANY_ID;

/*
Prediction Result:
(-1, 2, 'default2', None)
(-1, 1000, 'default2', 5101.0)
(0, -1, 'default1', 1.0)
(0, 0, None, 761.0)
(2, 1000, 'default1', 999.0)
(2, 10001, 'default1', None)
(999, 0, 'default2', 7599.0)
(1000, 1000, None, 7599.0)
(9999, 0, 'default1', 761.0)
(10000, 10001, 'default1', 7599.0)
(10001, 999, None, 5100.0)
*/