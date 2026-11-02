-- Schema DDL
CREATE TABLE "Salaries" ("company_id" INTEGER, "employee_id" INTEGER, "employee_name" TEXT(255), "salary" INTEGER, PRIMARY KEY ("company_id", "employee_id"), CHECK ("salary" > 0));

-- Loading data
PRAGMA foreign_keys = OFF;
INSERT INTO "Salaries" ("company_id", "employee_id", "employee_name", "salary") VALUES (NULL, 1, 'Alice', 500);
INSERT INTO "Salaries" ("company_id", "employee_id", "employee_name", "salary") VALUES (1, 2, 'Bob', 500);
INSERT INTO "Salaries" ("company_id", "employee_id", "employee_name", "salary") VALUES (1, 1, 'Charlie', NULL);
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT S.COMPANY_ID, S.EMPLOYEE_ID, S.EMPLOYEE_NAME, CASE WHEN MAX_SALARY < 1000 THEN SALARY WHEN MAX_SALARY >= 1000 AND MAX_SALARY <= 10000 THEN ROUND(SALARY - SALARY * 0.24, 0) WHEN MAX_SALARY > 10000 THEN ROUND(SALARY - SALARY * 0.49, 0) END AS SALARY FROM SALARIES AS S JOIN (SELECT COMPANY_ID, MAX(SALARY) AS MAX_SALARY FROM SALARIES GROUP BY COMPANY_ID) AS T ON S.COMPANY_ID = T.COMPANY_ID;

/*
Gold Result:
(1, 1, 'Charlie', None)
(1, 2, 'Bob', 500)
*/

-- Prediction Query
SELECT COMPANY_ID, EMPLOYEE_ID, EMPLOYEE_NAME, ROUND(CASE WHEN MAX(SALARY) OVER (PARTITION BY COMPANY_ID) > 10000 THEN SALARY * (1 - 0.49) WHEN MAX(SALARY) OVER (PARTITION BY COMPANY_ID) BETWEEN 1000 AND 10000 THEN SALARY * (1 - 0.24) ELSE SALARY END, 0) AS SALARY FROM SALARIES ORDER BY 1, 2, SALARIES.company_id NULLS LAST, SALARIES.employee_id NULLS LAST;

/*
Prediction Result:
(None, 1, 'Alice', 500.0)
(1, 1, 'Charlie', None)
(1, 2, 'Bob', 500.0)
*/