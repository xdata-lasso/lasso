-- Schema DDL
CREATE TABLE "Salaries" ("company_id" INTEGER, "employee_id" INTEGER, "employee_name" TEXT(255), "salary" INTEGER, PRIMARY KEY ("company_id", "employee_id"), CHECK ("salary" > 0));

-- Loading data
PRAGMA foreign_keys = OFF;
INSERT INTO "Salaries" ("company_id", "employee_id", "employee_name", "salary") VALUES (10, 11, '12', NULL);
INSERT INTO "Salaries" ("company_id", "employee_id", "employee_name", "salary") VALUES (13, 14, '15', 998);
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT S.COMPANY_ID, S.EMPLOYEE_ID, S.EMPLOYEE_NAME, ROUND(CASE WHEN X.MAX_SAL BETWEEN 1000 AND 10000 THEN SALARY * 0.76 WHEN X.MAX_SAL > 10000 THEN SALARY * 0.51 ELSE SALARY END, 0) AS SALARY FROM SALARIES AS S INNER JOIN (SELECT COMPANY_ID, MAX(SALARY) AS MAX_SAL FROM SALARIES GROUP BY COMPANY_ID) AS X ON S.COMPANY_ID = X.COMPANY_ID;

/*
Gold Result:
(10, 11, '12', None)
(13, 14, '15', 998.0)
*/

-- Prediction Query
SELECT COMPANY_ID, EMPLOYEE_ID, EMPLOYEE_NAME, ROUND(SALARY * (1 - (CASE WHEN MAX_SALARY > 10000 THEN 0.49 WHEN MAX_SALARY < 1000 THEN 0 ELSE 0.24 END))) AS SALARY FROM (SELECT COMPANY_ID, EMPLOYEE_ID, EMPLOYEE_NAME, SALARY, MAX(SALARY) OVER (PARTITION BY COMPANY_ID) AS MAX_SALARY FROM SALARIES) AS S;

/*
Prediction Result:
(10, 11, '12', None)
(13, 14, '15', 998.0)
*/