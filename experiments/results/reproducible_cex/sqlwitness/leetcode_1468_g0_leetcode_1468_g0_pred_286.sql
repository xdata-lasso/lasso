-- Schema DDL
CREATE TABLE "Salaries" ("company_id" INTEGER, "employee_id" INTEGER, "employee_name" TEXT(255), "salary" INTEGER, PRIMARY KEY ("company_id", "employee_id"), CHECK ("salary" > 0));

-- Loading data
PRAGMA foreign_keys = OFF;
INSERT INTO salaries (company_id, employee_id, employee_name, salary) VALUES (1, 1001, 'default2', 1000), (-1, 0, 'default1', 1001), (-1, 1, 'default2', 999);
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT S.COMPANY_ID, S.EMPLOYEE_ID, S.EMPLOYEE_NAME, ROUND(CASE WHEN X.MAX_SAL BETWEEN 1000 AND 10000 THEN SALARY * 0.76 WHEN X.MAX_SAL > 10000 THEN SALARY * 0.51 ELSE SALARY END, 0) AS SALARY FROM SALARIES AS S INNER JOIN (SELECT COMPANY_ID, MAX(SALARY) AS MAX_SAL FROM SALARIES GROUP BY COMPANY_ID) AS X ON S.COMPANY_ID = X.COMPANY_ID;

/*
Gold Result:
(-1, 0, 'default1', 761.0)
(-1, 1, 'default2', 759.0)
(1, 1001, 'default2', 760.0)
*/

-- Prediction Query
WITH TEMP AS (SELECT COMPANY_ID, MAX(SALARY) AS MAX FROM SALARIES GROUP BY COMPANY_ID) SELECT S.COMPANY_ID, S.EMPLOYEE_ID, S.EMPLOYEE_NAME, CASE WHEN (T.MAX < 1000) THEN ROUND(S.SALARY, 0) WHEN (T.MAX > 1000 AND T.MAX < 10000) THEN ROUND((S.SALARY - (0.24) * S.SALARY), 0) WHEN (T.MAX > 10000) THEN ROUND((S.SALARY - (0.49) * S.SALARY), 0) END AS SALARY FROM SALARIES AS S LEFT OUTER JOIN TEMP AS T ON T.COMPANY_ID = S.COMPANY_ID;

/*
Prediction Result:
(1, 1001, 'default2', None)
(-1, 0, 'default1', 761.0)
(-1, 1, 'default2', 759.0)
*/