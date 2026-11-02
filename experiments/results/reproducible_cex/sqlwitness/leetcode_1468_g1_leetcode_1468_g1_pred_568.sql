-- Schema DDL
CREATE TABLE "Salaries" ("company_id" INTEGER, "employee_id" INTEGER, "employee_name" TEXT(255), "salary" INTEGER, PRIMARY KEY ("company_id", "employee_id"), CHECK ("salary" > 0));

-- Loading data
PRAGMA foreign_keys = OFF;
INSERT INTO salaries (company_id, employee_id, employee_name, salary) VALUES (999, 1, 'default2', 10001), (1000, 1000, 'default1', 1000), (1, 9999, 'default2', 10001), (-1, 999, 'default2', 10001), (1001, 1001, NULL, 1), (999, 999, NULL, 999), (1000, 1001, 'default2', 10000), (1001, 9999, 'default2', 1), (10000, 0, 'default2', 999), (999, 0, NULL, 1000), (-1, 10000, 'default2', 10000);
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT S.COMPANY_ID, S.EMPLOYEE_ID, S.EMPLOYEE_NAME, CASE WHEN MAX_SALARY < 1000 THEN SALARY WHEN MAX_SALARY >= 1000 AND MAX_SALARY <= 10000 THEN ROUND(SALARY - SALARY * 0.24, 0) WHEN MAX_SALARY > 10000 THEN ROUND(SALARY - SALARY * 0.49, 0) END AS SALARY FROM SALARIES AS S JOIN (SELECT COMPANY_ID, MAX(SALARY) AS MAX_SALARY FROM SALARIES GROUP BY COMPANY_ID) AS T ON S.COMPANY_ID = T.COMPANY_ID;

/*
Gold Result:
(-1, 999, 'default2', 5101.0)
(-1, 10000, 'default2', 5100.0)
(1, 9999, 'default2', 5101.0)
(999, 0, None, 510.0)
(999, 1, 'default2', 5101.0)
(999, 999, None, 509.0)
(1000, 1000, 'default1', 760.0)
(1000, 1001, 'default2', 7600.0)
(1001, 1001, None, 1)
(1001, 9999, 'default2', 1)
(10000, 0, 'default2', 999)
*/

-- Prediction Query
SELECT S1.COMPANY_ID, S1.EMPLOYEE_ID, S1.EMPLOYEE_NAME, (CASE WHEN N.COMPANY_MAX < 1000 THEN S1.SALARY WHEN N.COMPANY_MAX >= 10000 THEN ROUND(0.51 * S1.SALARY, 0) ELSE ROUND(0.76 * S1.SALARY, 0) END) AS SALARY FROM SALARIES AS S1 JOIN (SELECT S2.COMPANY_ID, MAX(S2.SALARY) AS COMPANY_MAX FROM SALARIES AS S2 GROUP BY S2.COMPANY_ID) AS N ON S1.COMPANY_ID = N.COMPANY_ID;

/*
Prediction Result:
(-1, 999, 'default2', 5101.0)
(-1, 10000, 'default2', 5100.0)
(1, 9999, 'default2', 5101.0)
(999, 0, None, 510.0)
(999, 1, 'default2', 5101.0)
(999, 999, None, 509.0)
(1000, 1000, 'default1', 510.0)
(1000, 1001, 'default2', 5100.0)
(1001, 1001, None, 1)
(1001, 9999, 'default2', 1)
(10000, 0, 'default2', 999)
*/