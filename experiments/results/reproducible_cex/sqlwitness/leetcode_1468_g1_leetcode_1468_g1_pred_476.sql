-- Schema DDL
CREATE TABLE "Salaries" ("company_id" INTEGER, "employee_id" INTEGER, "employee_name" TEXT(255), "salary" INTEGER, PRIMARY KEY ("company_id", "employee_id"), CHECK ("salary" > 0));

-- Loading data
PRAGMA foreign_keys = OFF;
INSERT INTO salaries (company_id, employee_id, employee_name, salary) VALUES (10001, -1, NULL, 1001), (1000, 1000, 'default1', NULL), (-1, 9999, 'default2', 1001), (1001, 9999, 'default2', 1000), (10001, 0, NULL, 10000), (9999, -1, 'default2', 10001), (9999, 999, 'default2', 1), (1, 1, 'default1', NULL), (10001, 1, 'default2', 1000), (10000, 10000, NULL, 1);
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT S.COMPANY_ID, S.EMPLOYEE_ID, S.EMPLOYEE_NAME, CASE WHEN MAX_SALARY < 1000 THEN SALARY WHEN MAX_SALARY >= 1000 AND MAX_SALARY <= 10000 THEN ROUND(SALARY - SALARY * 0.24, 0) WHEN MAX_SALARY > 10000 THEN ROUND(SALARY - SALARY * 0.49, 0) END AS SALARY FROM SALARIES AS S JOIN (SELECT COMPANY_ID, MAX(SALARY) AS MAX_SALARY FROM SALARIES GROUP BY COMPANY_ID) AS T ON S.COMPANY_ID = T.COMPANY_ID;

/*
Gold Result:
(-1, 9999, 'default2', 761.0)
(1, 1, 'default1', None)
(1000, 1000, 'default1', None)
(1001, 9999, 'default2', 760.0)
(9999, -1, 'default2', 5101.0)
(9999, 999, 'default2', 1.0)
(10000, 10000, None, 1)
(10001, -1, None, 761.0)
(10001, 0, None, 7600.0)
(10001, 1, 'default2', 760.0)
*/

-- Prediction Query
SELECT COMPANY_ID, EMPLOYEE_ID, EMPLOYEE_NAME, CASE WHEN MAX(SALARY) OVER (PARTITION BY COMPANY_ID) > 10000 THEN ROUND(SALARY - SALARY * 0.49, 0) WHEN MAX(SALARY) OVER (PARTITION BY COMPANY_ID) > 1000 THEN ROUND(SALARY - SALARY * 0.24, 0) ELSE SALARY END AS SALARY FROM SALARIES;

/*
Prediction Result:
(-1, 9999, 'default2', 761.0)
(1, 1, 'default1', None)
(1000, 1000, 'default1', None)
(1001, 9999, 'default2', 1000)
(9999, -1, 'default2', 5101.0)
(9999, 999, 'default2', 1.0)
(10000, 10000, None, 1)
(10001, -1, None, 761.0)
(10001, 0, None, 7600.0)
(10001, 1, 'default2', 760.0)
*/