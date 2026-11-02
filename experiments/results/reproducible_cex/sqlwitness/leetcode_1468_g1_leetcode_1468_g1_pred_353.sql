-- Schema DDL
CREATE TABLE "Salaries" ("company_id" INTEGER, "employee_id" INTEGER, "employee_name" TEXT(255), "salary" INTEGER, PRIMARY KEY ("company_id", "employee_id"), CHECK ("salary" > 0));

-- Loading data
PRAGMA foreign_keys = OFF;
INSERT INTO salaries (company_id, employee_id, employee_name, salary) VALUES (999, 999, NULL, 2), (1000, 10000, 'default2', 999), (0, 1, 'default1', 1000), (-1, 0, NULL, 10001), (2, 10000, 'default2', 1001), (2, 0, 'default2', NULL);
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT S.COMPANY_ID, S.EMPLOYEE_ID, S.EMPLOYEE_NAME, CASE WHEN MAX_SALARY < 1000 THEN SALARY WHEN MAX_SALARY >= 1000 AND MAX_SALARY <= 10000 THEN ROUND(SALARY - SALARY * 0.24, 0) WHEN MAX_SALARY > 10000 THEN ROUND(SALARY - SALARY * 0.49, 0) END AS SALARY FROM SALARIES AS S JOIN (SELECT COMPANY_ID, MAX(SALARY) AS MAX_SALARY FROM SALARIES GROUP BY COMPANY_ID) AS T ON S.COMPANY_ID = T.COMPANY_ID;

/*
Gold Result:
(-1, 0, None, 5101.0)
(0, 1, 'default1', 760.0)
(2, 0, 'default2', None)
(2, 10000, 'default2', 761.0)
(999, 999, None, 2)
(1000, 10000, 'default2', 999)
*/

-- Prediction Query
SELECT S.COMPANY_ID, EMPLOYEE_ID, EMPLOYEE_NAME, ROUND(SALARY * (1 - TAX)) AS SALARY FROM SALARIES AS S JOIN (SELECT COMPANY_ID, (CASE WHEN MAX(SALARY) <= 1000 THEN 0 WHEN MAX(SALARY) >= 10000 THEN 0.49 ELSE 0.24 END) AS TAX FROM SALARIES GROUP BY COMPANY_ID) AS T ON T.COMPANY_ID = S.COMPANY_ID;

/*
Prediction Result:
(-1, 0, None, 5101.0)
(0, 1, 'default1', 1000.0)
(2, 0, 'default2', None)
(2, 10000, 'default2', 761.0)
(999, 999, None, 2.0)
(1000, 10000, 'default2', 999.0)
*/