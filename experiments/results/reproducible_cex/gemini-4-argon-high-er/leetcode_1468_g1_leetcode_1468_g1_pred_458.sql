-- Schema DDL
CREATE TABLE "Salaries" ("company_id" INTEGER, "employee_id" INTEGER, "employee_name" TEXT(255), "salary" INTEGER, PRIMARY KEY ("company_id", "employee_id"), CHECK ("salary" > 0));

-- Loading data
PRAGMA foreign_keys = OFF;
INSERT INTO "Salaries" ("company_id", "employee_id", "employee_name", "salary") VALUES (1, 1, 'Alice', 500);
INSERT INTO "Salaries" ("company_id", "employee_id", "employee_name", "salary") VALUES (2, 1, 'Bob', 500.5);
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT S.COMPANY_ID, S.EMPLOYEE_ID, S.EMPLOYEE_NAME, CASE WHEN MAX_SALARY < 1000 THEN SALARY WHEN MAX_SALARY >= 1000 AND MAX_SALARY <= 10000 THEN ROUND(SALARY - SALARY * 0.24, 0) WHEN MAX_SALARY > 10000 THEN ROUND(SALARY - SALARY * 0.49, 0) END AS SALARY FROM SALARIES AS S JOIN (SELECT COMPANY_ID, MAX(SALARY) AS MAX_SALARY FROM SALARIES GROUP BY COMPANY_ID) AS T ON S.COMPANY_ID = T.COMPANY_ID;

/*
Gold Result:
(1, 1, 'Alice', 500)
(2, 1, 'Bob', 500.5)
*/

-- Prediction Query
WITH CTE1 AS (SELECT A.*, B.MS FROM SALARIES AS A LEFT JOIN (SELECT COMPANY_ID, MAX(SALARY) AS MS FROM SALARIES GROUP BY 1) AS B ON A.COMPANY_ID = B.COMPANY_ID) SELECT COMPANY_ID, EMPLOYEE_ID, EMPLOYEE_NAME, ROUND((CASE WHEN MS < 1000 THEN SALARY WHEN (MS >= 1000 AND MS <= 10000) THEN (SALARY - SALARY * 0.24) WHEN MS > 10000 THEN (SALARY - SALARY * 0.49) END)) AS SALARY FROM CTE1;

/*
Prediction Result:
(1, 1, 'Alice', 500.0)
(2, 1, 'Bob', 501.0)
*/