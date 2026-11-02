-- Schema DDL
CREATE TABLE "Salaries" ("company_id" INTEGER, "employee_id" INTEGER, "employee_name" TEXT(255), "salary" INTEGER, PRIMARY KEY ("company_id", "employee_id"), CHECK ("salary" > 0));

-- Loading data
PRAGMA foreign_keys = OFF;
INSERT INTO salaries (company_id, employee_id, employee_name, salary) VALUES (1, 1001, NULL, 10001), (1, 0, 'default1', NULL), (9999, 999, 'default1', 10000), (10001, 1, NULL, 10000), (10001, 9999, 'default1', 1001);
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT S.COMPANY_ID, S.EMPLOYEE_ID, S.EMPLOYEE_NAME, ROUND(CASE WHEN X.MAX_SAL BETWEEN 1000 AND 10000 THEN SALARY * 0.76 WHEN X.MAX_SAL > 10000 THEN SALARY * 0.51 ELSE SALARY END, 0) AS SALARY FROM SALARIES AS S INNER JOIN (SELECT COMPANY_ID, MAX(SALARY) AS MAX_SAL FROM SALARIES GROUP BY COMPANY_ID) AS X ON S.COMPANY_ID = X.COMPANY_ID;

/*
Gold Result:
(1, 0, 'default1', None)
(1, 1001, None, 5101.0)
(9999, 999, 'default1', 7600.0)
(10001, 1, None, 7600.0)
(10001, 9999, 'default1', 761.0)
*/

-- Prediction Query
SELECT COMPANY_ID, EMPLOYEE_ID, EMPLOYEE_NAME, ROUND(CASE WHEN MAX(SALARY) OVER (PARTITION BY COMPANY_ID) >= 10000 THEN SALARY * 0.51 WHEN MAX(SALARY) OVER (PARTITION BY COMPANY_ID) >= 1000 THEN SALARY * 0.76 ELSE SALARY END, 0) AS SALARY FROM SALARIES;

/*
Prediction Result:
(1, 0, 'default1', None)
(1, 1001, None, 5101.0)
(9999, 999, 'default1', 5100.0)
(10001, 1, None, 5100.0)
(10001, 9999, 'default1', 511.0)
*/