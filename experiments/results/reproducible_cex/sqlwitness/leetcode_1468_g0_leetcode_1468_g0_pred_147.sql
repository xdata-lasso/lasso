-- Schema DDL
CREATE TABLE "Salaries" ("company_id" INTEGER, "employee_id" INTEGER, "employee_name" TEXT(255), "salary" INTEGER, PRIMARY KEY ("company_id", "employee_id"), CHECK ("salary" > 0));

-- Loading data
PRAGMA foreign_keys = OFF;
INSERT INTO salaries (company_id, employee_id, employee_name, salary) VALUES (0, 10001, 'default2', 1000), (1000, 1001, 'default1', 1001), (-1, -1, NULL, 1001), (9999, -1, 'default2', 10001), (0, 10000, 'default1', 1000), (9999, 9999, NULL, 1000);
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT S.COMPANY_ID, S.EMPLOYEE_ID, S.EMPLOYEE_NAME, ROUND(CASE WHEN X.MAX_SAL BETWEEN 1000 AND 10000 THEN SALARY * 0.76 WHEN X.MAX_SAL > 10000 THEN SALARY * 0.51 ELSE SALARY END, 0) AS SALARY FROM SALARIES AS S INNER JOIN (SELECT COMPANY_ID, MAX(SALARY) AS MAX_SAL FROM SALARIES GROUP BY COMPANY_ID) AS X ON S.COMPANY_ID = X.COMPANY_ID;

/*
Gold Result:
(-1, -1, None, 761.0)
(0, 10000, 'default1', 760.0)
(0, 10001, 'default2', 760.0)
(1000, 1001, 'default1', 761.0)
(9999, -1, 'default2', 5101.0)
(9999, 9999, None, 510.0)
*/

-- Prediction Query
SELECT COMPANY_ID, EMPLOYEE_ID, EMPLOYEE_NAME, CASE WHEN MAX(SALARY) OVER (PARTITION BY COMPANY_ID) > 10000 THEN ROUND((0.51 * SALARY), 0) WHEN MAX(SALARY) OVER (PARTITION BY COMPANY_ID) > 1000 THEN ROUND((0.76 * SALARY), 0) ELSE ROUND(SALARY, 0) END AS SALARY FROM SALARIES;

/*
Prediction Result:
(-1, -1, None, 761.0)
(0, 10000, 'default1', 1000.0)
(0, 10001, 'default2', 1000.0)
(1000, 1001, 'default1', 761.0)
(9999, -1, 'default2', 5101.0)
(9999, 9999, None, 510.0)
*/