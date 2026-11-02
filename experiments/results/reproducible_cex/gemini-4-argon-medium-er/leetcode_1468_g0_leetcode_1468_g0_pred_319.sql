-- Schema DDL
CREATE TABLE "Salaries" ("company_id" INTEGER, "employee_id" INTEGER, "employee_name" TEXT(255), "salary" INTEGER, PRIMARY KEY ("company_id", "employee_id"), CHECK ("salary" > 0));

-- Loading data
PRAGMA foreign_keys = OFF;
INSERT INTO "Salaries" ("company_id", "employee_id", "employee_name", "salary") VALUES (NULL, 1, 'Alice', 500);
INSERT INTO "Salaries" ("company_id", "employee_id", "employee_name", "salary") VALUES (1, 2, 'Bob', NULL);
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT S.COMPANY_ID, S.EMPLOYEE_ID, S.EMPLOYEE_NAME, ROUND(CASE WHEN X.MAX_SAL BETWEEN 1000 AND 10000 THEN SALARY * 0.76 WHEN X.MAX_SAL > 10000 THEN SALARY * 0.51 ELSE SALARY END, 0) AS SALARY FROM SALARIES AS S INNER JOIN (SELECT COMPANY_ID, MAX(SALARY) AS MAX_SAL FROM SALARIES GROUP BY COMPANY_ID) AS X ON S.COMPANY_ID = X.COMPANY_ID;

/*
Gold Result:
(1, 2, 'Bob', None)
*/

-- Prediction Query
SELECT SAL.COMPANY_ID, EMPLOYEE_ID, EMPLOYEE_NAME, ROUND((SALARY * CASE WHEN MAX_SAL < 1000 THEN 1 WHEN MAX_SAL >= 1000 AND MAX_SAL <= 10000 THEN 0.76 ELSE 0.51 END), 0) AS SALARY FROM SALARIES AS SAL LEFT JOIN (SELECT DISTINCT COMPANY_ID, MAX(SALARY) AS MAX_SAL FROM SALARIES GROUP BY 1) AS MX ON MX.COMPANY_ID = SAL.COMPANY_ID GROUP BY SAL.COMPANY_ID, EMPLOYEE_ID;

/*
Prediction Result:
(None, 1, 'Alice', 255.0)
(1, 2, 'Bob', None)
*/