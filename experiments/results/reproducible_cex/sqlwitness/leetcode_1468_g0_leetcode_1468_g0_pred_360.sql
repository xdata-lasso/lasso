-- Schema DDL
CREATE TABLE "Salaries" ("company_id" INTEGER, "employee_id" INTEGER, "employee_name" TEXT(255), "salary" INTEGER, PRIMARY KEY ("company_id", "employee_id"), CHECK ("salary" > 0));

-- Loading data
PRAGMA foreign_keys = OFF;
INSERT INTO salaries (company_id, employee_id, employee_name, salary) VALUES (10001, 9999, NULL, 999), (999, 1001, 'default2', 1000), (-1, 999, 'default1', 10000), (1, 999, NULL, 10001), (10000, 0, NULL, 1), (10000, 999, 'default1', 1), (999, 9999, NULL, 1001), (9999, 9999, 'default2', 999), (-1, 10000, 'default1', 10001), (1000, 1, NULL, 10000);
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT S.COMPANY_ID, S.EMPLOYEE_ID, S.EMPLOYEE_NAME, ROUND(CASE WHEN X.MAX_SAL BETWEEN 1000 AND 10000 THEN SALARY * 0.76 WHEN X.MAX_SAL > 10000 THEN SALARY * 0.51 ELSE SALARY END, 0) AS SALARY FROM SALARIES AS S INNER JOIN (SELECT COMPANY_ID, MAX(SALARY) AS MAX_SAL FROM SALARIES GROUP BY COMPANY_ID) AS X ON S.COMPANY_ID = X.COMPANY_ID;

/*
Gold Result:
(-1, 999, 'default1', 5100.0)
(-1, 10000, 'default1', 5101.0)
(1, 999, None, 5101.0)
(999, 1001, 'default2', 760.0)
(999, 9999, None, 761.0)
(1000, 1, None, 7600.0)
(9999, 9999, 'default2', 999.0)
(10000, 0, None, 1.0)
(10000, 999, 'default1', 1.0)
(10001, 9999, None, 999.0)
*/

-- Prediction Query
WITH TMP AS (SELECT *, MAX(SALARY) OVER (PARTITION BY COMPANY_ID) AS MAX FROM SALARIES) SELECT COMPANY_ID, EMPLOYEE_ID, EMPLOYEE_NAME, CASE WHEN MAX < 1000 THEN ROUND(SALARY) WHEN MAX >= 1000 AND MAX < 10000 THEN ROUND(SALARY - SALARY * 0.24) ELSE ROUND(SALARY - SALARY * 0.49) END AS SALARY FROM TMP;

/*
Prediction Result:
(-1, 999, 'default1', 5100.0)
(-1, 10000, 'default1', 5101.0)
(1, 999, None, 5101.0)
(999, 1001, 'default2', 760.0)
(999, 9999, None, 761.0)
(1000, 1, None, 5100.0)
(9999, 9999, 'default2', 999.0)
(10000, 0, None, 1.0)
(10000, 999, 'default1', 1.0)
(10001, 9999, None, 999.0)
*/