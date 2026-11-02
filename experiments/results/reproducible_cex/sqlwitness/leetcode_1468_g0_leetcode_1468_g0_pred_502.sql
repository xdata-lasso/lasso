-- Schema DDL
CREATE TABLE "Salaries" ("company_id" INTEGER, "employee_id" INTEGER, "employee_name" TEXT(255), "salary" INTEGER, PRIMARY KEY ("company_id", "employee_id"), CHECK ("salary" > 0));

-- Loading data
PRAGMA foreign_keys = OFF;
INSERT INTO salaries (company_id, employee_id, employee_name, salary) VALUES (-1, -1, NULL, NULL), (1001, 1001, 'default1', 1), (1000, 999, NULL, 1000), (1, 0, 'default2', NULL), (0, 10000, 'default2', 9999), (1, 1000, 'default2', 1);
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT S.COMPANY_ID, S.EMPLOYEE_ID, S.EMPLOYEE_NAME, ROUND(CASE WHEN X.MAX_SAL BETWEEN 1000 AND 10000 THEN SALARY * 0.76 WHEN X.MAX_SAL > 10000 THEN SALARY * 0.51 ELSE SALARY END, 0) AS SALARY FROM SALARIES AS S INNER JOIN (SELECT COMPANY_ID, MAX(SALARY) AS MAX_SAL FROM SALARIES GROUP BY COMPANY_ID) AS X ON S.COMPANY_ID = X.COMPANY_ID;

/*
Gold Result:
(-1, -1, None, None)
(0, 10000, 'default2', 7599.0)
(1, 0, 'default2', None)
(1, 1000, 'default2', 1.0)
(1000, 999, None, 760.0)
(1001, 1001, 'default1', 1.0)
*/

-- Prediction Query
SELECT A.COMPANY_ID, A.EMPLOYEE_ID, A.EMPLOYEE_NAME, ROUND(CASE WHEN B.MAXSAL > 10000 THEN 0.51 * A.SALARY WHEN B.MAXSAL > 1000 THEN 0.76 * A.SALARY ELSE A.SALARY END) AS SALARY FROM SALARIES AS A LEFT JOIN (SELECT COMPANY_ID, MAX(SALARY) AS MAXSAL FROM SALARIES GROUP BY COMPANY_ID) AS B ON A.COMPANY_ID = B.COMPANY_ID;

/*
Prediction Result:
(-1, -1, None, None)
(1001, 1001, 'default1', 1.0)
(1000, 999, None, 1000.0)
(1, 0, 'default2', None)
(0, 10000, 'default2', 7599.0)
(1, 1000, 'default2', 1.0)
*/