-- Schema DDL
CREATE TABLE "Salaries" ("company_id" INTEGER, "employee_id" INTEGER, "employee_name" TEXT(255), "salary" INTEGER, PRIMARY KEY ("company_id", "employee_id"), CHECK ("salary" > 0));

-- Loading data
PRAGMA foreign_keys = OFF;
INSERT INTO "Salaries" ("company_id", "employee_id", "employee_name", "salary") VALUES (NULL, 1, 'Alice', 500);
INSERT INTO "Salaries" ("company_id", "employee_id", "employee_name", "salary") VALUES (1, 1, 'Bob', 500);
INSERT INTO "Salaries" ("company_id", "employee_id", "employee_name", "salary") VALUES (2, 1, 'Charlie', 20000);
INSERT INTO "Salaries" ("company_id", "employee_id", "employee_name", "salary") VALUES (2, 2, 'David', 150);
INSERT INTO "Salaries" ("company_id", "employee_id", "employee_name", "salary") VALUES (2, 3, 'Eve', 350);
INSERT INTO "Salaries" ("company_id", "employee_id", "employee_name", "salary") VALUES (2, 4, 'Frank', 550);
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT S.COMPANY_ID, S.EMPLOYEE_ID, S.EMPLOYEE_NAME, ROUND(CASE WHEN X.MAX_SAL BETWEEN 1000 AND 10000 THEN SALARY * 0.76 WHEN X.MAX_SAL > 10000 THEN SALARY * 0.51 ELSE SALARY END, 0) AS SALARY FROM SALARIES AS S INNER JOIN (SELECT COMPANY_ID, MAX(SALARY) AS MAX_SAL FROM SALARIES GROUP BY COMPANY_ID) AS X ON S.COMPANY_ID = X.COMPANY_ID;

/*
Gold Result:
(1, 1, 'Bob', 500.0)
(2, 1, 'Charlie', 10200.0)
(2, 2, 'David', 77.0)
(2, 3, 'Eve', 179.0)
(2, 4, 'Frank', 281.0)
*/

-- Prediction Query
SELECT COMPANY_ID, EMPLOYEE_ID, EMPLOYEE_NAME, CASE WHEN MAX_SALARY < 1000 THEN SALARY WHEN MAX_SALARY >= 1000 AND MAX_SALARY <= 10000 THEN ROUND(SALARY - SALARY * 0.24, 0) WHEN MAX_SALARY > 10000 THEN ROUND(SALARY - 0.49 * SALARY, 0) END AS SALARY FROM (SELECT COMPANY_ID, EMPLOYEE_ID, EMPLOYEE_NAME, SALARY, MAX(SALARY) OVER (PARTITION BY COMPANY_ID) AS MAX_SALARY FROM SALARIES) AS TBL;

/*
Prediction Result:
(None, 1, 'Alice', 500)
(1, 1, 'Bob', 500)
(2, 1, 'Charlie', 10200.0)
(2, 2, 'David', 77.0)
(2, 3, 'Eve', 179.0)
(2, 4, 'Frank', 281.0)
*/