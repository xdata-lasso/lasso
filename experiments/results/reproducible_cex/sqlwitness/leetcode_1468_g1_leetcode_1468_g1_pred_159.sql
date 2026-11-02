-- Schema DDL
CREATE TABLE "Salaries" ("company_id" INTEGER, "employee_id" INTEGER, "employee_name" TEXT(255), "salary" INTEGER, PRIMARY KEY ("company_id", "employee_id"), CHECK ("salary" > 0));

-- Loading data
PRAGMA foreign_keys = OFF;
INSERT INTO salaries (company_id, employee_id, employee_name, salary) VALUES (999, 1000, 'default1', 1), (999, 999, 'default1', 1001), (1000, 10001, NULL, 999), (10000, 10000, NULL, 9999), (1001, -1, 'default2', 10000), (9999, 0, 'default2', 9999), (0, 1001, 'default1', 1000), (10001, 1000, 'default2', NULL);
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT S.COMPANY_ID, S.EMPLOYEE_ID, S.EMPLOYEE_NAME, CASE WHEN MAX_SALARY < 1000 THEN SALARY WHEN MAX_SALARY >= 1000 AND MAX_SALARY <= 10000 THEN ROUND(SALARY - SALARY * 0.24, 0) WHEN MAX_SALARY > 10000 THEN ROUND(SALARY - SALARY * 0.49, 0) END AS SALARY FROM SALARIES AS S JOIN (SELECT COMPANY_ID, MAX(SALARY) AS MAX_SALARY FROM SALARIES GROUP BY COMPANY_ID) AS T ON S.COMPANY_ID = T.COMPANY_ID;

/*
Gold Result:
(0, 1001, 'default1', 760.0)
(999, 999, 'default1', 761.0)
(999, 1000, 'default1', 1.0)
(1000, 10001, None, 999)
(1001, -1, 'default2', 7600.0)
(9999, 0, 'default2', 7599.0)
(10000, 10000, None, 7599.0)
(10001, 1000, 'default2', None)
*/

-- Prediction Query
SELECT COMPANY_ID, EMPLOYEE_ID, EMPLOYEE_NAME, ROUND(CASE WHEN MAX_SALARY < 1000 THEN SALARY WHEN MAX_SALARY < 10000 THEN SALARY * 0.76 ELSE SALARY * 0.51 END) AS SALARY FROM (SELECT *, MAX(SALARY) OVER (PARTITION BY COMPANY_ID) AS MAX_SALARY FROM SALARIES) AS S;

/*
Prediction Result:
(0, 1001, 'default1', 760.0)
(999, 999, 'default1', 761.0)
(999, 1000, 'default1', 1.0)
(1000, 10001, None, 999.0)
(1001, -1, 'default2', 5100.0)
(9999, 0, 'default2', 7599.0)
(10000, 10000, None, 7599.0)
(10001, 1000, 'default2', None)
*/