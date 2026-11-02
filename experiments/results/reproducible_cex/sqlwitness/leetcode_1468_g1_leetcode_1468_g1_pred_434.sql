-- Schema DDL
CREATE TABLE "Salaries" ("company_id" INTEGER, "employee_id" INTEGER, "employee_name" TEXT(255), "salary" INTEGER, PRIMARY KEY ("company_id", "employee_id"), CHECK ("salary" > 0));

-- Loading data
PRAGMA foreign_keys = OFF;
INSERT INTO salaries (company_id, employee_id, employee_name, salary) VALUES (101, 99, 'default1', 10000), (23, 1000, NULL, 10001), (10000, 25, NULL, 9999), (1001, 999, 'default2', 1001), (99, 25, NULL, 48), (25, 1001, 'default2', 99), (100, 100, 'default1', 100), (24, 25, 'default1', 50), (999, 1, 'default1', 101);
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT S.COMPANY_ID, S.EMPLOYEE_ID, S.EMPLOYEE_NAME, CASE WHEN MAX_SALARY < 1000 THEN SALARY WHEN MAX_SALARY >= 1000 AND MAX_SALARY <= 10000 THEN ROUND(SALARY - SALARY * 0.24, 0) WHEN MAX_SALARY > 10000 THEN ROUND(SALARY - SALARY * 0.49, 0) END AS SALARY FROM SALARIES AS S JOIN (SELECT COMPANY_ID, MAX(SALARY) AS MAX_SALARY FROM SALARIES GROUP BY COMPANY_ID) AS T ON S.COMPANY_ID = T.COMPANY_ID;

/*
Gold Result:
(23, 1000, None, 5101.0)
(24, 25, 'default1', 50)
(25, 1001, 'default2', 99)
(99, 25, None, 48)
(100, 100, 'default1', 100)
(101, 99, 'default1', 7600.0)
(999, 1, 'default1', 101)
(1001, 999, 'default2', 761.0)
(10000, 25, None, 7599.0)
*/

-- Prediction Query
SELECT S1.COMPANY_ID, EMPLOYEE_ID, EMPLOYEE_NAME, CAST((SALARY - (SALARY * TAX)) AS UBIGINT) AS SALARY FROM SALARIES AS S1 LEFT JOIN (SELECT COMPANY_ID, CASE WHEN MAX(SALARY) < 1000 THEN 0 WHEN MAX(SALARY) >= 1000 AND MAX(SALARY) <= 10000 THEN CAST(24 AS REAL) / 100 WHEN MAX(SALARY) > 10000 THEN CAST(49 AS REAL) / 100 END AS TAX FROM SALARIES GROUP BY COMPANY_ID) AS S2 ON S1.COMPANY_ID = S2.COMPANY_ID;

/*
Prediction Result:
(101, 99, 'default1', 7600)
(23, 1000, None, 5100)
(10000, 25, None, 7599)
(1001, 999, 'default2', 760)
(99, 25, None, 48)
(25, 1001, 'default2', 99)
(100, 100, 'default1', 100)
(24, 25, 'default1', 50)
(999, 1, 'default1', 101)
*/