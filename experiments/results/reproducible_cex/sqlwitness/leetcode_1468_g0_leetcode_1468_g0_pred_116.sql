-- Schema DDL
CREATE TABLE "Salaries" ("company_id" INTEGER, "employee_id" INTEGER, "employee_name" TEXT(255), "salary" INTEGER, PRIMARY KEY ("company_id", "employee_id"), CHECK ("salary" > 0));

-- Loading data
PRAGMA foreign_keys = OFF;
INSERT INTO salaries (company_id, employee_id, employee_name, salary) VALUES (0, 0, 'default1', 24), (49, 25, 'default1', 1001), (101, 1000, 'default2', 1001), (50, 9999, 'default1', 10000), (23, 101, NULL, 49), (101, 101, NULL, 48);
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT S.COMPANY_ID, S.EMPLOYEE_ID, S.EMPLOYEE_NAME, ROUND(CASE WHEN X.MAX_SAL BETWEEN 1000 AND 10000 THEN SALARY * 0.76 WHEN X.MAX_SAL > 10000 THEN SALARY * 0.51 ELSE SALARY END, 0) AS SALARY FROM SALARIES AS S INNER JOIN (SELECT COMPANY_ID, MAX(SALARY) AS MAX_SAL FROM SALARIES GROUP BY COMPANY_ID) AS X ON S.COMPANY_ID = X.COMPANY_ID;

/*
Gold Result:
(0, 0, 'default1', 24.0)
(23, 101, None, 49.0)
(49, 25, 'default1', 761.0)
(50, 9999, 'default1', 7600.0)
(101, 101, None, 36.0)
(101, 1000, 'default2', 761.0)
*/

-- Prediction Query
SELECT A.COMPANY_ID, A.EMPLOYEE_ID, A.EMPLOYEE_NAME, CASE WHEN A.MAX_SAL < 1000 THEN A.SALARY WHEN A.MAX_SAL >= 1000 AND A.MAX_SAL < 10000 THEN ROUND(A.SALARY - CAST(SALARY * 24 AS REAL) / 100) ELSE ROUND(A.SALARY - CAST(SALARY * 49 AS REAL) / 100) END AS SALARY FROM (SELECT COMPANY_ID, EMPLOYEE_ID, EMPLOYEE_NAME, SALARY, MAX(SALARY) OVER (PARTITION BY COMPANY_ID) AS MAX_SAL FROM SALARIES) AS A;

/*
Prediction Result:
(0, 0, 'default1', 24)
(23, 101, None, 49)
(49, 25, 'default1', 761.0)
(50, 9999, 'default1', 5100.0)
(101, 101, None, 36.0)
(101, 1000, 'default2', 761.0)
*/