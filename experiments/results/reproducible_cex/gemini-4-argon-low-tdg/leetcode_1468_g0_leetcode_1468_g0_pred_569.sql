-- Schema DDL
CREATE TABLE "Salaries" ("company_id" INTEGER, "employee_id" INTEGER, "employee_name" TEXT(255), "salary" INTEGER, PRIMARY KEY ("company_id", "employee_id"), CHECK ("salary" > 0));

-- Loading data
PRAGMA foreign_keys = OFF;
-- DATASET 1
INSERT INTO "Salaries" ("company_id", "employee_id", "employee_name", "salary") VALUES (1, 101, 'Alice', 999);
INSERT INTO "Salaries" ("company_id", "employee_id", "employee_name", "salary") VALUES (2, 201, 'Bob', 1000);
INSERT INTO "Salaries" ("company_id", "employee_id", "employee_name", "salary") VALUES (3, 301, 'Charlie', 10000);
INSERT INTO "Salaries" ("company_id", "employee_id", "employee_name", "salary") VALUES (4, 401, 'Diana', 10001);
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT S.COMPANY_ID, S.EMPLOYEE_ID, S.EMPLOYEE_NAME, ROUND(CASE WHEN X.MAX_SAL BETWEEN 1000 AND 10000 THEN SALARY * 0.76 WHEN X.MAX_SAL > 10000 THEN SALARY * 0.51 ELSE SALARY END, 0) AS SALARY FROM SALARIES AS S INNER JOIN (SELECT COMPANY_ID, MAX(SALARY) AS MAX_SAL FROM SALARIES GROUP BY COMPANY_ID) AS X ON S.COMPANY_ID = X.COMPANY_ID;

/*
Gold Result:
(1, 101, 'Alice', 999.0)
(2, 201, 'Bob', 760.0)
(3, 301, 'Charlie', 7600.0)
(4, 401, 'Diana', 5101.0)
*/

-- Prediction Query
SELECT S1.COMPANY_ID, S1.EMPLOYEE_ID, S1.EMPLOYEE_NAME, (CASE WHEN N.COMPANY_MAX < 1000 THEN S1.SALARY WHEN N.COMPANY_MAX >= 10000 THEN ROUND(0.51 * S1.SALARY, 0) ELSE ROUND(0.76 * S1.SALARY, 0) END) AS SALARY FROM SALARIES AS S1 JOIN (SELECT S2.COMPANY_ID, MAX(S2.SALARY) AS COMPANY_MAX FROM SALARIES AS S2 GROUP BY S2.COMPANY_ID) AS N ON S1.COMPANY_ID = N.COMPANY_ID;

/*
Prediction Result:
(1, 101, 'Alice', 999)
(2, 201, 'Bob', 760.0)
(3, 301, 'Charlie', 5100.0)
(4, 401, 'Diana', 5101.0)
*/