-- Schema DDL
CREATE TABLE "Salaries" ("company_id" INTEGER, "employee_id" INTEGER, "employee_name" TEXT(255), "salary" INTEGER, PRIMARY KEY ("company_id", "employee_id"), CHECK ("salary" > 0));

-- Loading data
PRAGMA foreign_keys = OFF;
INSERT INTO salaries (company_id, employee_id, employee_name, salary) VALUES (10000, 10000, 'default2', 1), (0, 1, 'default1', 1000), (-1, 2, 'default1', 999), (999, -1, 'default1', 1001), (10000, 9999, 'default2', 2), (10000, 10001, 'default1', 10000), (10001, 0, 'default1', 999), (0, 0, 'default2', 1);
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT S.COMPANY_ID, S.EMPLOYEE_ID, S.EMPLOYEE_NAME, CASE WHEN MAX_SALARY < 1000 THEN SALARY WHEN MAX_SALARY >= 1000 AND MAX_SALARY <= 10000 THEN ROUND(SALARY - SALARY * 0.24, 0) WHEN MAX_SALARY > 10000 THEN ROUND(SALARY - SALARY * 0.49, 0) END AS SALARY FROM SALARIES AS S JOIN (SELECT COMPANY_ID, MAX(SALARY) AS MAX_SALARY FROM SALARIES GROUP BY COMPANY_ID) AS T ON S.COMPANY_ID = T.COMPANY_ID;

/*
Gold Result:
(-1, 2, 'default1', 999)
(0, 0, 'default2', 1.0)
(0, 1, 'default1', 760.0)
(999, -1, 'default1', 761.0)
(10000, 9999, 'default2', 2.0)
(10000, 10000, 'default2', 1.0)
(10000, 10001, 'default1', 7600.0)
(10001, 0, 'default1', 999)
*/

-- Prediction Query
WITH TAX_RATE AS (SELECT COMPANY_ID, CASE WHEN MAX(SALARY) < 1000 THEN 1 WHEN MAX(SALARY) < 10000 THEN 0.76 ELSE 0.51 END AS TAX_RATE FROM SALARIES GROUP BY COMPANY_ID) SELECT A.COMPANY_ID, A.EMPLOYEE_ID, A.EMPLOYEE_NAME, ROUND(A.SALARY * B.TAX_RATE) AS SALARY FROM SALARIES AS A JOIN TAX_RATE AS B ON A.COMPANY_ID = B.COMPANY_ID;

/*
Prediction Result:
(-1, 2, 'default1', 999.0)
(0, 0, 'default2', 1.0)
(0, 1, 'default1', 760.0)
(999, -1, 'default1', 761.0)
(10000, 9999, 'default2', 1.0)
(10000, 10000, 'default2', 1.0)
(10000, 10001, 'default1', 5100.0)
(10001, 0, 'default1', 999.0)
*/