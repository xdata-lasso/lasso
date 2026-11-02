-- Schema DDL
CREATE TABLE "Salaries" ("company_id" INTEGER, "employee_id" INTEGER, "employee_name" TEXT(255), "salary" INTEGER, PRIMARY KEY ("company_id", "employee_id"), CHECK ("salary" > 0));

-- Loading data
PRAGMA foreign_keys = OFF;
INSERT INTO salaries (company_id, employee_id, employee_name, salary) VALUES (1001, 999, 'default1', 10000), (9999, 1, 'default2', 100), (-1, 0, 'default2', 1), (9999, -1, NULL, 100), (0, -1, 'default2', 99), (24, 101, 'default1', 25), (10001, 49, 'default2', 9999), (99, 101, NULL, NULL), (49, 49, 'default1', 23), (-1, 100, NULL, 23), (99, 50, 'default1', 99), (24, 10001, 'default1', 100), (1, 100, 'default1', 1000), (1001, 101, 'default1', NULL);
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT S.COMPANY_ID, S.EMPLOYEE_ID, S.EMPLOYEE_NAME, CASE WHEN MAX_SALARY < 1000 THEN SALARY WHEN MAX_SALARY >= 1000 AND MAX_SALARY <= 10000 THEN ROUND(SALARY - SALARY * 0.24, 0) WHEN MAX_SALARY > 10000 THEN ROUND(SALARY - SALARY * 0.49, 0) END AS SALARY FROM SALARIES AS S JOIN (SELECT COMPANY_ID, MAX(SALARY) AS MAX_SALARY FROM SALARIES GROUP BY COMPANY_ID) AS T ON S.COMPANY_ID = T.COMPANY_ID;

/*
Gold Result:
(-1, 0, 'default2', 1)
(-1, 100, None, 23)
(0, -1, 'default2', 99)
(1, 100, 'default1', 760.0)
(24, 101, 'default1', 25)
(24, 10001, 'default1', 100)
(49, 49, 'default1', 23)
(99, 50, 'default1', 99)
(99, 101, None, None)
(1001, 101, 'default1', None)
(1001, 999, 'default1', 7600.0)
(9999, -1, None, 100)
(9999, 1, 'default2', 100)
(10001, 49, 'default2', 7599.0)
*/

-- Prediction Query
WITH RATES AS (SELECT COMPANY_ID, CASE WHEN MAX(SALARY) < 1000 THEN 0 WHEN MAX(SALARY) >= 1000 AND MAX(SALARY) < 10000 THEN 24 ELSE 49 END AS RATE FROM SALARIES GROUP BY COMPANY_ID) SELECT SALARIES.COMPANY_ID, SALARIES.EMPLOYEE_ID, SALARIES.EMPLOYEE_NAME, ROUND(SALARIES.SALARY - (CAST((RATES.RATE * SALARIES.SALARY) AS REAL) / 100), 0) AS SALARY FROM SALARIES JOIN RATES ON SALARIES.COMPANY_ID = RATES.COMPANY_ID;

/*
Prediction Result:
(-1, 0, 'default2', 1.0)
(-1, 100, None, 23.0)
(0, -1, 'default2', 99.0)
(1, 100, 'default1', 760.0)
(24, 101, 'default1', 25.0)
(24, 10001, 'default1', 100.0)
(49, 49, 'default1', 23.0)
(99, 50, 'default1', 99.0)
(99, 101, None, None)
(1001, 101, 'default1', None)
(1001, 999, 'default1', 5100.0)
(9999, -1, None, 100.0)
(9999, 1, 'default2', 100.0)
(10001, 49, 'default2', 7599.0)
*/