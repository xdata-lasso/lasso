-- Schema DDL
CREATE TABLE "Salaries" ("company_id" INTEGER, "employee_id" INTEGER, "employee_name" TEXT(255), "salary" INTEGER, PRIMARY KEY ("company_id", "employee_id"), CHECK ("salary" > 0));

-- Loading data
PRAGMA foreign_keys = OFF;
INSERT INTO salaries (company_id, employee_id, employee_name, salary) VALUES (10000, 9999, 'default1', 1000), (-1, 1001, 'default1', 1001), (1000, 0, NULL, 9999), (9999, 10000, 'default1', 999), (9999, 9999, NULL, 10000), (10000, -1, 'default2', NULL), (1000, 999, 'default2', 10001);
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT S.COMPANY_ID, S.EMPLOYEE_ID, S.EMPLOYEE_NAME, CASE WHEN MAX_SALARY < 1000 THEN SALARY WHEN MAX_SALARY >= 1000 AND MAX_SALARY <= 10000 THEN ROUND(SALARY - SALARY * 0.24, 0) WHEN MAX_SALARY > 10000 THEN ROUND(SALARY - SALARY * 0.49, 0) END AS SALARY FROM SALARIES AS S JOIN (SELECT COMPANY_ID, MAX(SALARY) AS MAX_SALARY FROM SALARIES GROUP BY COMPANY_ID) AS T ON S.COMPANY_ID = T.COMPANY_ID;

/*
Gold Result:
(-1, 1001, 'default1', 761.0)
(1000, 0, None, 5099.0)
(1000, 999, 'default2', 5101.0)
(9999, 9999, None, 7600.0)
(9999, 10000, 'default1', 759.0)
(10000, -1, 'default2', None)
(10000, 9999, 'default1', 760.0)
*/

-- Prediction Query
SELECT COMPANY_ID, EMPLOYEE_ID, EMPLOYEE_NAME, CASE WHEN A.MAX < 1000 THEN ROUND(SALARY) WHEN A.MAX >= 1000 AND A.MAX < 10000 THEN ROUND(SALARY * 0.76) WHEN A.MAX > 10000 THEN ROUND(SALARY * 0.51) END AS SALARY FROM (SELECT *, MAX(SALARY) OVER (PARTITION BY COMPANY_ID) AS MAX FROM SALARIES) AS A;

/*
Prediction Result:
(-1, 1001, 'default1', 761.0)
(1000, 0, None, 5099.0)
(1000, 999, 'default2', 5101.0)
(9999, 9999, None, None)
(9999, 10000, 'default1', None)
(10000, -1, 'default2', None)
(10000, 9999, 'default1', 760.0)
*/