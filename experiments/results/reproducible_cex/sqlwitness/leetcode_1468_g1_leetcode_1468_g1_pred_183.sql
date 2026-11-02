-- Schema DDL
CREATE TABLE "Salaries" ("company_id" INTEGER, "employee_id" INTEGER, "employee_name" TEXT(255), "salary" INTEGER, PRIMARY KEY ("company_id", "employee_id"), CHECK ("salary" > 0));

-- Loading data
PRAGMA foreign_keys = OFF;
INSERT INTO salaries (company_id, employee_id, employee_name, salary) VALUES (1, 1000, NULL, 999), (1, -1, 'default1', 9999), (10001, -1, 'default2', 1), (9999, -1, 'default1', 1000), (1000, 1001, 'default1', 999), (1001, 0, NULL, 10001), (9999, 9999, 'default2', 10000), (10001, 10000, 'default1', 1000), (1001, -1, NULL, 1);
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT S.COMPANY_ID, S.EMPLOYEE_ID, S.EMPLOYEE_NAME, CASE WHEN MAX_SALARY < 1000 THEN SALARY WHEN MAX_SALARY >= 1000 AND MAX_SALARY <= 10000 THEN ROUND(SALARY - SALARY * 0.24, 0) WHEN MAX_SALARY > 10000 THEN ROUND(SALARY - SALARY * 0.49, 0) END AS SALARY FROM SALARIES AS S JOIN (SELECT COMPANY_ID, MAX(SALARY) AS MAX_SALARY FROM SALARIES GROUP BY COMPANY_ID) AS T ON S.COMPANY_ID = T.COMPANY_ID;

/*
Gold Result:
(1, -1, 'default1', 7599.0)
(1, 1000, None, 759.0)
(1000, 1001, 'default1', 999)
(1001, -1, None, 1.0)
(1001, 0, None, 5101.0)
(9999, -1, 'default1', 760.0)
(9999, 9999, 'default2', 7600.0)
(10001, -1, 'default2', 1.0)
(10001, 10000, 'default1', 760.0)
*/

-- Prediction Query
SELECT S.COMPANY_ID, S.EMPLOYEE_ID, S.EMPLOYEE_NAME, ROUND(S.SALARY - S.SALARY * (CASE WHEN MX < 1000 THEN 0 WHEN MX > 1000 AND MX < 10000 THEN 0.24 WHEN MX > 10000 THEN 0.49 END), 0) AS SALARY FROM SALARIES AS S LEFT JOIN (SELECT COMPANY_ID, MAX(SALARY) AS MX FROM SALARIES GROUP BY 1) AS T ON S.COMPANY_ID = T.COMPANY_ID;

/*
Prediction Result:
(1, 1000, None, 759.0)
(1, -1, 'default1', 7599.0)
(10001, -1, 'default2', None)
(9999, -1, 'default1', None)
(1000, 1001, 'default1', 999.0)
(1001, 0, None, 5101.0)
(9999, 9999, 'default2', None)
(10001, 10000, 'default1', None)
(1001, -1, None, 1.0)
*/