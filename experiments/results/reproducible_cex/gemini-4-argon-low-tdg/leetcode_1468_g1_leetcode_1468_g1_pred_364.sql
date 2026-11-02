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
WITH MAX_SALARY AS (SELECT COMPANY_ID, MAX(SALARY) AS MAX_SALARY FROM SALARIES GROUP BY COMPANY_ID), MAX_SALARY_JOIN AS (SELECT S.COMPANY_ID, S.EMPLOYEE_ID, S.EMPLOYEE_NAME, S.SALARY, M.MAX_SALARY FROM SALARIES AS S LEFT JOIN MAX_SALARY AS M ON S.COMPANY_ID = M.COMPANY_ID) SELECT COMPANY_ID, EMPLOYEE_ID, EMPLOYEE_NAME, ROUND(CASE WHEN MAX_SALARY < 1000 THEN SALARY WHEN MAX_SALARY > 1000 AND MAX_SALARY < 10000 THEN SALARY * 0.76 ELSE SALARY * 0.51 END, 0) AS SALARY FROM MAX_SALARY_JOIN;

/*
Prediction Result:
(1, 1, 'Alice', 999.0)
(1, 2, 'Bob', 501.0)
(2, 1, 'Charlie', 510.0)
(2, 2, 'David', 282.0)
*/