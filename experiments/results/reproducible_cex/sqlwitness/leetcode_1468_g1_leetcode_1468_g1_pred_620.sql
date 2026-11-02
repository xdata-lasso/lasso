-- Schema DDL
CREATE TABLE "Salaries" ("company_id" INTEGER, "employee_id" INTEGER, "employee_name" TEXT(255), "salary" INTEGER, PRIMARY KEY ("company_id", "employee_id"), CHECK ("salary" > 0));

-- Loading data
PRAGMA foreign_keys = OFF;
INSERT INTO salaries (company_id, employee_id, employee_name, salary) VALUES (1001, 10000, 'default2', 2), (1000, -1, NULL, 10000), (-1, 10000, NULL, 2), (0, 0, 'default1', 2), (-1, 1000, 'default2', 2), (10000, 1000, 'default2', 2), (2, 999, 'default1', 1000);
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT S.COMPANY_ID, S.EMPLOYEE_ID, S.EMPLOYEE_NAME, CASE WHEN MAX_SALARY < 1000 THEN SALARY WHEN MAX_SALARY >= 1000 AND MAX_SALARY <= 10000 THEN ROUND(SALARY - SALARY * 0.24, 0) WHEN MAX_SALARY > 10000 THEN ROUND(SALARY - SALARY * 0.49, 0) END AS SALARY FROM SALARIES AS S JOIN (SELECT COMPANY_ID, MAX(SALARY) AS MAX_SALARY FROM SALARIES GROUP BY COMPANY_ID) AS T ON S.COMPANY_ID = T.COMPANY_ID;

/*
Gold Result:
(-1, 1000, 'default2', 2)
(-1, 10000, None, 2)
(0, 0, 'default1', 2)
(2, 999, 'default1', 760.0)
(1000, -1, None, 7600.0)
(1001, 10000, 'default2', 2)
(10000, 1000, 'default2', 2)
*/

-- Prediction Query
WITH TAX_R AS (SELECT COMPANY_ID, CASE WHEN MAX(SALARY) < 1000 THEN 0 WHEN MAX(SALARY) <= 10000 AND MAX(SALARY) > 1000 THEN 0.24 WHEN MAX(SALARY) > 10000 THEN 0.49 END AS RATIO FROM SALARIES GROUP BY COMPANY_ID) SELECT T1.COMPANY_ID, EMPLOYEE_ID, EMPLOYEE_NAME, ROUND(SALARY * (1 - RATIO)) AS SALARY FROM SALARIES AS T1 JOIN TAX_R AS T2 ON T1.COMPANY_ID = T2.COMPANY_ID;

/*
Prediction Result:
(-1, 1000, 'default2', 2.0)
(-1, 10000, None, 2.0)
(0, 0, 'default1', 2.0)
(2, 999, 'default1', None)
(1000, -1, None, 7600.0)
(1001, 10000, 'default2', 2.0)
(10000, 1000, 'default2', 2.0)
*/