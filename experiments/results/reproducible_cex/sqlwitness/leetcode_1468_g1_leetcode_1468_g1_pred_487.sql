-- Schema DDL
CREATE TABLE "Salaries" ("company_id" INTEGER, "employee_id" INTEGER, "employee_name" TEXT(255), "salary" INTEGER, PRIMARY KEY ("company_id", "employee_id"), CHECK ("salary" > 0));

-- Loading data
PRAGMA foreign_keys = OFF;
INSERT INTO salaries (company_id, employee_id, employee_name, salary) VALUES (1000, 1001, 'default2', NULL), (1000, 0, 'default2', 10001), (9999, 999, NULL, 999), (-1, 10001, 'default2', 1000), (-1, 0, 'default2', 1000);
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT S.COMPANY_ID, S.EMPLOYEE_ID, S.EMPLOYEE_NAME, CASE WHEN MAX_SALARY < 1000 THEN SALARY WHEN MAX_SALARY >= 1000 AND MAX_SALARY <= 10000 THEN ROUND(SALARY - SALARY * 0.24, 0) WHEN MAX_SALARY > 10000 THEN ROUND(SALARY - SALARY * 0.49, 0) END AS SALARY FROM SALARIES AS S JOIN (SELECT COMPANY_ID, MAX(SALARY) AS MAX_SALARY FROM SALARIES GROUP BY COMPANY_ID) AS T ON S.COMPANY_ID = T.COMPANY_ID;

/*
Gold Result:
(-1, 0, 'default2', 760.0)
(-1, 10001, 'default2', 760.0)
(1000, 0, 'default2', 5101.0)
(1000, 1001, 'default2', None)
(9999, 999, None, 999)
*/

-- Prediction Query
SELECT S.COMPANY_ID, S.EMPLOYEE_ID, S.EMPLOYEE_NAME, ROUND(S.SALARY - (S.SALARY * TAX), 0) AS SALARY FROM SALARIES AS S JOIN (SELECT SALARIES.*, CASE WHEN MAX(SALARY) < 1000 THEN 0 WHEN MAX(SALARY) > 1000 AND MAX(SALARY) < 10000 THEN 0.24 ELSE 0.49 END AS TAX FROM SALARIES GROUP BY COMPANY_ID) AS SUB ON S.COMPANY_ID = SUB.COMPANY_ID;

/*
Prediction Result:
(-1, 0, 'default2', 510.0)
(-1, 10001, 'default2', 510.0)
(1000, 0, 'default2', 5101.0)
(1000, 1001, 'default2', None)
(9999, 999, None, 999.0)
*/