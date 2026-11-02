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
WITH MAX_SALARIES AS (SELECT COMPANY_ID, MAX(SALARY) AS MAX_SALARY FROM SALARIES GROUP BY 1), TAX_BRACKETS AS (SELECT COMPANY_ID AS CID, CASE WHEN MAX_SALARY < 1000 THEN 1 WHEN MAX_SALARY < 10000 THEN 0.76 ELSE 0.51 END AS TAX_BRACKET FROM MAX_SALARIES) SELECT COMPANY_ID, EMPLOYEE_ID, EMPLOYEE_NAME, ROUND(SALARY * TB.TAX_BRACKET, 0) AS SALARY FROM SALARIES AS S JOIN TAX_BRACKETS AS TB ON S.COMPANY_ID = TB.CID;

/*
Prediction Result:
(1, 101, 'Alice', 999.0)
(2, 201, 'Bob', 760.0)
(3, 301, 'Charlie', 5100.0)
(4, 401, 'Diana', 5101.0)
*/