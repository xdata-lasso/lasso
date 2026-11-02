-- Schema DDL
CREATE TABLE "Salaries" ("company_id" INTEGER, "employee_id" INTEGER, "employee_name" TEXT(255), "salary" INTEGER, PRIMARY KEY ("company_id", "employee_id"), CHECK ("salary" > 0));

-- Loading data
PRAGMA foreign_keys = OFF;
INSERT INTO salaries (company_id, employee_id, employee_name, salary) VALUES (1000, 9999, NULL, 10000), (-1, 9999, 'default2', 1), (1001, 999, 'default2', 10001), (0, 999, 'default1', 999), (10001, 10000, 'default2', 1000), (1001, 9999, 'default1', 1000), (1, 1000, NULL, 10001);
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT S.COMPANY_ID, S.EMPLOYEE_ID, S.EMPLOYEE_NAME, CASE WHEN MAX_SALARY < 1000 THEN SALARY WHEN MAX_SALARY >= 1000 AND MAX_SALARY <= 10000 THEN ROUND(SALARY - SALARY * 0.24, 0) WHEN MAX_SALARY > 10000 THEN ROUND(SALARY - SALARY * 0.49, 0) END AS SALARY FROM SALARIES AS S JOIN (SELECT COMPANY_ID, MAX(SALARY) AS MAX_SALARY FROM SALARIES GROUP BY COMPANY_ID) AS T ON S.COMPANY_ID = T.COMPANY_ID;

/*
Gold Result:
(-1, 9999, 'default2', 1)
(0, 999, 'default1', 999)
(1, 1000, None, 5101.0)
(1000, 9999, None, 7600.0)
(1001, 999, 'default2', 5101.0)
(1001, 9999, 'default1', 510.0)
(10001, 10000, 'default2', 760.0)
*/

-- Prediction Query
SELECT S.COMPANY_ID, EMPLOYEE_ID, EMPLOYEE_NAME, ROUND(SALARY * (1.00 - TAX_RATE), 0) AS SALARY FROM SALARIES AS S LEFT JOIN (SELECT COMPANY_ID, (CASE WHEN MAX(SALARY) < 1000 THEN 0 WHEN MAX(SALARY) >= 1000 AND MAX(SALARY) < 10000 THEN 0.24 ELSE 0.49 END) AS TAX_RATE FROM SALARIES GROUP BY COMPANY_ID) AS T1 ON S.COMPANY_ID = T1.COMPANY_ID;

/*
Prediction Result:
(1000, 9999, None, 5100.0)
(-1, 9999, 'default2', 1.0)
(1001, 999, 'default2', 5101.0)
(0, 999, 'default1', 999.0)
(10001, 10000, 'default2', 760.0)
(1001, 9999, 'default1', 510.0)
(1, 1000, None, 5101.0)
*/