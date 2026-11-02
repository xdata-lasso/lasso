-- Schema DDL
CREATE TABLE "Salaries" ("company_id" INTEGER, "employee_id" INTEGER, "employee_name" TEXT(255), "salary" INTEGER, PRIMARY KEY ("company_id", "employee_id"), CHECK ("salary" > 0));

-- Loading data
PRAGMA foreign_keys = OFF;
INSERT INTO salaries (company_id, employee_id, employee_name, salary) VALUES (1000, 1001, NULL, NULL), (1000, 9999, 'default2', 1), (-1, 999, 'default1', 9999), (10000, -1, 'default2', NULL), (0, 10001, 'default1', NULL), (9999, 1000, NULL, NULL), (1001, 10000, 'default1', 1000);
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT S.COMPANY_ID, S.EMPLOYEE_ID, S.EMPLOYEE_NAME, CASE WHEN MAX_SALARY < 1000 THEN SALARY WHEN MAX_SALARY >= 1000 AND MAX_SALARY <= 10000 THEN ROUND(SALARY - SALARY * 0.24, 0) WHEN MAX_SALARY > 10000 THEN ROUND(SALARY - SALARY * 0.49, 0) END AS SALARY FROM SALARIES AS S JOIN (SELECT COMPANY_ID, MAX(SALARY) AS MAX_SALARY FROM SALARIES GROUP BY COMPANY_ID) AS T ON S.COMPANY_ID = T.COMPANY_ID;

/*
Gold Result:
(-1, 999, 'default1', 7599.0)
(0, 10001, 'default1', None)
(1000, 1001, None, None)
(1000, 9999, 'default2', 1)
(1001, 10000, 'default1', 760.0)
(9999, 1000, None, None)
(10000, -1, 'default2', None)
*/

-- Prediction Query
SELECT A.COMPANY_ID, A.EMPLOYEE_ID, A.EMPLOYEE_NAME, ROUND(CASE WHEN B.MAXSAL > 10000 THEN 0.51 * A.SALARY WHEN B.MAXSAL > 1000 THEN 0.76 * A.SALARY ELSE A.SALARY END) AS SALARY FROM SALARIES AS A LEFT JOIN (SELECT COMPANY_ID, MAX(SALARY) AS MAXSAL FROM SALARIES GROUP BY COMPANY_ID) AS B ON A.COMPANY_ID = B.COMPANY_ID;

/*
Prediction Result:
(1000, 1001, None, None)
(1000, 9999, 'default2', 1.0)
(-1, 999, 'default1', 7599.0)
(10000, -1, 'default2', None)
(0, 10001, 'default1', None)
(9999, 1000, None, None)
(1001, 10000, 'default1', 1000.0)
*/