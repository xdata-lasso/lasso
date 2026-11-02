-- Schema DDL
CREATE TABLE "Salaries" ("company_id" INTEGER, "employee_id" INTEGER, "employee_name" TEXT(255), "salary" INTEGER, PRIMARY KEY ("company_id", "employee_id"), CHECK ("salary" > 0));

-- Loading data
PRAGMA foreign_keys = OFF;
INSERT INTO salaries (company_id, employee_id, employee_name, salary) VALUES (0, 1000, NULL, 10001), (10001, 9999, NULL, 10000), (999, 9999, 'default2', 1000), (999, 1001, NULL, 10001), (0, 999, 'default2', 1001), (2, -1, NULL, 2), (1000, 1000, 'default1', NULL), (10001, 1000, 'default2', 999), (10001, 0, 'default2', NULL), (9999, -1, 'default2', 1001);
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT S.COMPANY_ID, S.EMPLOYEE_ID, S.EMPLOYEE_NAME, CASE WHEN MAX_SALARY < 1000 THEN SALARY WHEN MAX_SALARY >= 1000 AND MAX_SALARY <= 10000 THEN ROUND(SALARY - SALARY * 0.24, 0) WHEN MAX_SALARY > 10000 THEN ROUND(SALARY - SALARY * 0.49, 0) END AS SALARY FROM SALARIES AS S JOIN (SELECT COMPANY_ID, MAX(SALARY) AS MAX_SALARY FROM SALARIES GROUP BY COMPANY_ID) AS T ON S.COMPANY_ID = T.COMPANY_ID;

/*
Gold Result:
(0, 999, 'default2', 511.0)
(0, 1000, None, 5101.0)
(2, -1, None, 2)
(999, 1001, None, 5101.0)
(999, 9999, 'default2', 510.0)
(1000, 1000, 'default1', None)
(9999, -1, 'default2', 761.0)
(10001, 0, 'default2', None)
(10001, 1000, 'default2', 759.0)
(10001, 9999, None, 7600.0)
*/

-- Prediction Query
WITH T AS (SELECT COMPANY_ID, MAX(SALARY) AS MAX_SALARY, CASE WHEN MAX(SALARY) < 1000 THEN 1 WHEN MAX(SALARY) >= 1000 AND MAX(SALARY) <= 10000 THEN 0.76 ELSE 0.51 END AS TAX_RATE FROM SALARIES GROUP BY COMPANY_ID) SELECT A.COMPANY_ID AS COMPANY_ID, A.EMPLOYEE_ID AS EMPLOYEE_ID, A.EMPLOYEE_NAME AS EMPLOYEE_NAME, FLOOR(ROUND(A.SALARY * T.TAX_RATE, 0)) AS SALARY FROM SALARIES AS A LEFT JOIN T ON A.COMPANY_ID = T.COMPANY_ID;

/*
Prediction Result:
(0, 1000, None, 5101.0)
(10001, 9999, None, 7600.0)
(999, 9999, 'default2', 510.0)
(999, 1001, None, 5101.0)
(0, 999, 'default2', 511.0)
(2, -1, None, 2.0)
(1000, 1000, 'default1', None)
(10001, 1000, 'default2', 759.0)
(10001, 0, 'default2', None)
(9999, -1, 'default2', 761.0)
*/