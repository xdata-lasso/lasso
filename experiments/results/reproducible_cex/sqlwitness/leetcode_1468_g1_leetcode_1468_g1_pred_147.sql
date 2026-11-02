-- Schema DDL
CREATE TABLE "Salaries" ("company_id" INTEGER, "employee_id" INTEGER, "employee_name" TEXT(255), "salary" INTEGER, PRIMARY KEY ("company_id", "employee_id"), CHECK ("salary" > 0));

-- Loading data
PRAGMA foreign_keys = OFF;
INSERT INTO salaries (company_id, employee_id, employee_name, salary) VALUES (10001, -1, 'default1', 999), (1000, 1, 'default2', 1000), (0, 1, NULL, 1001), (-1, 1000, 'default1', 1000);
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT S.COMPANY_ID, S.EMPLOYEE_ID, S.EMPLOYEE_NAME, CASE WHEN MAX_SALARY < 1000 THEN SALARY WHEN MAX_SALARY >= 1000 AND MAX_SALARY <= 10000 THEN ROUND(SALARY - SALARY * 0.24, 0) WHEN MAX_SALARY > 10000 THEN ROUND(SALARY - SALARY * 0.49, 0) END AS SALARY FROM SALARIES AS S JOIN (SELECT COMPANY_ID, MAX(SALARY) AS MAX_SALARY FROM SALARIES GROUP BY COMPANY_ID) AS T ON S.COMPANY_ID = T.COMPANY_ID;

/*
Gold Result:
(-1, 1000, 'default1', 760.0)
(0, 1, None, 761.0)
(1000, 1, 'default2', 760.0)
(10001, -1, 'default1', 999)
*/

-- Prediction Query
SELECT COMPANY_ID, EMPLOYEE_ID, EMPLOYEE_NAME, CASE WHEN MAX(SALARY) OVER (PARTITION BY COMPANY_ID) > 10000 THEN ROUND((0.51 * SALARY), 0) WHEN MAX(SALARY) OVER (PARTITION BY COMPANY_ID) > 1000 THEN ROUND((0.76 * SALARY), 0) ELSE ROUND(SALARY, 0) END AS SALARY FROM SALARIES;

/*
Prediction Result:
(-1, 1000, 'default1', 1000.0)
(0, 1, None, 761.0)
(1000, 1, 'default2', 1000.0)
(10001, -1, 'default1', 999.0)
*/