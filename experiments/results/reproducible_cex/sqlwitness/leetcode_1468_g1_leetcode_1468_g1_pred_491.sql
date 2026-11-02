-- Schema DDL
CREATE TABLE "Salaries" ("company_id" INTEGER, "employee_id" INTEGER, "employee_name" TEXT(255), "salary" INTEGER, PRIMARY KEY ("company_id", "employee_id"), CHECK ("salary" > 0));

-- Loading data
PRAGMA foreign_keys = OFF;
INSERT INTO salaries (company_id, employee_id, employee_name, salary) VALUES (9999, 1000, 'default1', NULL), (1, 9999, 'default2', 1), (1001, 9999, 'default1', 9999), (10000, 0, NULL, 10000), (1000, 1, NULL, 9999), (1, 999, 'default1', 10000), (10000, 999, 'default1', 1000);
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT S.COMPANY_ID, S.EMPLOYEE_ID, S.EMPLOYEE_NAME, CASE WHEN MAX_SALARY < 1000 THEN SALARY WHEN MAX_SALARY >= 1000 AND MAX_SALARY <= 10000 THEN ROUND(SALARY - SALARY * 0.24, 0) WHEN MAX_SALARY > 10000 THEN ROUND(SALARY - SALARY * 0.49, 0) END AS SALARY FROM SALARIES AS S JOIN (SELECT COMPANY_ID, MAX(SALARY) AS MAX_SALARY FROM SALARIES GROUP BY COMPANY_ID) AS T ON S.COMPANY_ID = T.COMPANY_ID;

/*
Gold Result:
(1, 999, 'default1', 7600.0)
(1, 9999, 'default2', 1.0)
(1000, 1, None, 7599.0)
(1001, 9999, 'default1', 7599.0)
(9999, 1000, 'default1', None)
(10000, 0, None, 7600.0)
(10000, 999, 'default1', 760.0)
*/

-- Prediction Query
SELECT COMPANY_ID, EMPLOYEE_ID, EMPLOYEE_NAME, ROUND(CASE WHEN MAX_SALARY < 1000 THEN SALARY WHEN MAX_SALARY >= 1000 AND MAX_SALARY < 10000 THEN (SALARY * 0.76) WHEN MAX_SALARY > 10000 THEN (SALARY * 0.51) END) AS SALARY FROM (SELECT COMPANY_ID, EMPLOYEE_ID, EMPLOYEE_NAME, SALARY, MAX(SALARY) OVER (PARTITION BY COMPANY_ID) AS MAX_SALARY FROM SALARIES) AS A;

/*
Prediction Result:
(1, 999, 'default1', None)
(1, 9999, 'default2', None)
(1000, 1, None, 7599.0)
(1001, 9999, 'default1', 7599.0)
(9999, 1000, 'default1', None)
(10000, 0, None, None)
(10000, 999, 'default1', None)
*/