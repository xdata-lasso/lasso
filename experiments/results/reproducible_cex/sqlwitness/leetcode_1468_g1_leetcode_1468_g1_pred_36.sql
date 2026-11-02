-- Schema DDL
CREATE TABLE "Salaries" ("company_id" INTEGER, "employee_id" INTEGER, "employee_name" TEXT(255), "salary" INTEGER, PRIMARY KEY ("company_id", "employee_id"), CHECK ("salary" > 0));

-- Loading data
PRAGMA foreign_keys = OFF;
INSERT INTO salaries (company_id, employee_id, employee_name, salary) VALUES (10001, 1001, NULL, 1), (101, 1000, 'default1', 10000), (1001, -1, 'default1', NULL), (75, 99, NULL, 100), (99, 101, NULL, 50), (1, 10000, 'default2', 1001), (10000, 50, NULL, 10000), (77, 10001, NULL, 51), (0, 77, NULL, 51), (999, 51, NULL, 101), (77, 1000, 'default2', 101), (101, 75, 'default2', 77);
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT S.COMPANY_ID, S.EMPLOYEE_ID, S.EMPLOYEE_NAME, CASE WHEN MAX_SALARY < 1000 THEN SALARY WHEN MAX_SALARY >= 1000 AND MAX_SALARY <= 10000 THEN ROUND(SALARY - SALARY * 0.24, 0) WHEN MAX_SALARY > 10000 THEN ROUND(SALARY - SALARY * 0.49, 0) END AS SALARY FROM SALARIES AS S JOIN (SELECT COMPANY_ID, MAX(SALARY) AS MAX_SALARY FROM SALARIES GROUP BY COMPANY_ID) AS T ON S.COMPANY_ID = T.COMPANY_ID;

/*
Gold Result:
(0, 77, None, 51)
(1, 10000, 'default2', 761.0)
(75, 99, None, 100)
(77, 1000, 'default2', 101)
(77, 10001, None, 51)
(99, 101, None, 50)
(101, 75, 'default2', 59.0)
(101, 1000, 'default1', 7600.0)
(999, 51, None, 101)
(1001, -1, 'default1', None)
(10000, 50, None, 7600.0)
(10001, 1001, None, 1)
*/

-- Prediction Query
SELECT COMPANY_ID, EMPLOYEE_ID, EMPLOYEE_NAME, ROUND(CAST(SALARY * (CASE WHEN MAX(SALARY) OVER (PARTITION BY COMPANY_ID) < 1000 THEN 100 WHEN MAX(SALARY) OVER (PARTITION BY COMPANY_ID) < 10000 THEN 76 ELSE 51 END) AS REAL) / 100) AS SALARY FROM SALARIES;

/*
Prediction Result:
(0, 77, None, 51.0)
(1, 10000, 'default2', 761.0)
(75, 99, None, 100.0)
(77, 1000, 'default2', 101.0)
(77, 10001, None, 51.0)
(99, 101, None, 50.0)
(101, 75, 'default2', 39.0)
(101, 1000, 'default1', 5100.0)
(999, 51, None, 101.0)
(1001, -1, 'default1', None)
(10000, 50, None, 5100.0)
(10001, 1001, None, 1.0)
*/