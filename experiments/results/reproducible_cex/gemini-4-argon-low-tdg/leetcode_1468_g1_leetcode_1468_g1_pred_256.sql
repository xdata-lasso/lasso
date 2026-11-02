-- Schema DDL
CREATE TABLE "Salaries" ("company_id" INTEGER, "employee_id" INTEGER, "employee_name" TEXT(255), "salary" INTEGER, PRIMARY KEY ("company_id", "employee_id"), CHECK ("salary" > 0));

-- Loading data
PRAGMA foreign_keys = OFF;
-- DATASET 1
INSERT INTO "Salaries" ("company_id", "employee_id", "employee_name", "salary") VALUES (1, 1, 'Alice', 999);
INSERT INTO "Salaries" ("company_id", "employee_id", "employee_name", "salary") VALUES (1, 2, 'Bob', 501);
INSERT INTO "Salaries" ("company_id", "employee_id", "employee_name", "salary") VALUES (2, 1, 'Charlie', 1000);
INSERT INTO "Salaries" ("company_id", "employee_id", "employee_name", "salary") VALUES (2, 2, 'David', 553);
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT S.COMPANY_ID, S.EMPLOYEE_ID, S.EMPLOYEE_NAME, CASE WHEN MAX_SALARY < 1000 THEN SALARY WHEN MAX_SALARY >= 1000 AND MAX_SALARY <= 10000 THEN ROUND(SALARY - SALARY * 0.24, 0) WHEN MAX_SALARY > 10000 THEN ROUND(SALARY - SALARY * 0.49, 0) END AS SALARY FROM SALARIES AS S JOIN (SELECT COMPANY_ID, MAX(SALARY) AS MAX_SALARY FROM SALARIES GROUP BY COMPANY_ID) AS T ON S.COMPANY_ID = T.COMPANY_ID;

/*
Gold Result:
(1, 1, 'Alice', 999)
(1, 2, 'Bob', 501)
(2, 1, 'Charlie', 760.0)
(2, 2, 'David', 420.0)
*/

-- Prediction Query
WITH MAXSAL(COMPANY_ID, MSALARY) AS (SELECT COMPANY_ID, MAX(SALARY) FROM SALARIES GROUP BY COMPANY_ID) SELECT COMPANY_ID, EMPLOYEE_ID, EMPLOYEE_NAME, CASE WHEN MSALARY > 1000 AND MSALARY < 10000 THEN ROUND(CAST((SALARY * 76) AS REAL) / 100) WHEN MSALARY > 10000 THEN ROUND(CAST((SALARY * 51) AS REAL) / 100) ELSE SALARY END AS SALARY FROM (SELECT SALARIES.COMPANY_ID, SALARIES.EMPLOYEE_ID, SALARIES.EMPLOYEE_NAME, SALARIES.SALARY, MAXSAL.MSALARY FROM SALARIES CROSS JOIN MAXSAL WHERE MAXSAL.COMPANY_ID = SALARIES.COMPANY_ID) AS T;

/*
Prediction Result:
(1, 1, 'Alice', 999)
(1, 2, 'Bob', 501)
(2, 1, 'Charlie', 1000)
(2, 2, 'David', 553)
*/