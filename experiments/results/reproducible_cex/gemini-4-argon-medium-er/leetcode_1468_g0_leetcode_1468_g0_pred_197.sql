-- Schema DDL
CREATE TABLE "Salaries" ("company_id" INTEGER, "employee_id" INTEGER, "employee_name" TEXT(255), "salary" INTEGER, PRIMARY KEY ("company_id", "employee_id"), CHECK ("salary" > 0));

-- Loading data
PRAGMA foreign_keys = OFF;
INSERT INTO "Salaries" ("company_id", "employee_id", "employee_name", "salary") VALUES (1, 1, 'Alice', 500);
INSERT INTO "Salaries" ("company_id", "employee_id", "employee_name", "salary") VALUES (NULL, 2, 'Bob', 2000);
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT S.COMPANY_ID, S.EMPLOYEE_ID, S.EMPLOYEE_NAME, ROUND(CASE WHEN X.MAX_SAL BETWEEN 1000 AND 10000 THEN SALARY * 0.76 WHEN X.MAX_SAL > 10000 THEN SALARY * 0.51 ELSE SALARY END, 0) AS SALARY FROM SALARIES AS S INNER JOIN (SELECT COMPANY_ID, MAX(SALARY) AS MAX_SAL FROM SALARIES GROUP BY COMPANY_ID) AS X ON S.COMPANY_ID = X.COMPANY_ID;

/*
Gold Result:
(1, 1, 'Alice', 500.0)
*/

-- Prediction Query
SELECT T1.COMPANY_ID, T1.EMPLOYEE_ID, T1.EMPLOYEE_NAME, CASE WHEN T1.MAXIMUM BETWEEN 1000 AND 10000 THEN ROUND(0.76 * T1.SALARY) WHEN T1.MAXIMUM > 10000 THEN ROUND(0.51 * T1.SALARY) ELSE T1.SALARY END AS SALARY FROM (SELECT *, MAX(SALARY) OVER (PARTITION BY COMPANY_ID) AS MAXIMUM FROM SALARIES) AS T1;

/*
Prediction Result:
(None, 2, 'Bob', 1520.0)
(1, 1, 'Alice', 500)
*/