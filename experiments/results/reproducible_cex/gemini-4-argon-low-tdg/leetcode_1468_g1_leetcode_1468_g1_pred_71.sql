-- Schema DDL
CREATE TABLE "Salaries" ("company_id" INTEGER, "employee_id" INTEGER, "employee_name" TEXT(255), "salary" INTEGER, PRIMARY KEY ("company_id", "employee_id"), CHECK ("salary" > 0));

-- Loading data
PRAGMA foreign_keys = OFF;
-- DATASET 2
INSERT INTO "Salaries" ("company_id", "employee_id", "employee_name", "salary") VALUES (1, 1, 'Eve', 10000);
INSERT INTO "Salaries" ("company_id", "employee_id", "employee_name", "salary") VALUES (1, 2, 'Frank', 801);
INSERT INTO "Salaries" ("company_id", "employee_id", "employee_name", "salary") VALUES (2, 1, 'Grace', 10001);
INSERT INTO "Salaries" ("company_id", "employee_id", "employee_name", "salary") VALUES (2, 2, 'Heidi', 950);
INSERT INTO "Salaries" ("company_id", "employee_id", "employee_name", "salary") VALUES (2, 3, 'Ivan', 5000);
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT S.COMPANY_ID, S.EMPLOYEE_ID, S.EMPLOYEE_NAME, CASE WHEN MAX_SALARY < 1000 THEN SALARY WHEN MAX_SALARY >= 1000 AND MAX_SALARY <= 10000 THEN ROUND(SALARY - SALARY * 0.24, 0) WHEN MAX_SALARY > 10000 THEN ROUND(SALARY - SALARY * 0.49, 0) END AS SALARY FROM SALARIES AS S JOIN (SELECT COMPANY_ID, MAX(SALARY) AS MAX_SALARY FROM SALARIES GROUP BY COMPANY_ID) AS T ON S.COMPANY_ID = T.COMPANY_ID;

/*
Gold Result:
(1, 1, 'Eve', 7600.0)
(1, 2, 'Frank', 609.0)
(2, 1, 'Grace', 5101.0)
(2, 2, 'Heidi', 485.0)
(2, 3, 'Ivan', 2550.0)
*/

-- Prediction Query
WITH T1 AS (SELECT *, MAX(SALARY) OVER (PARTITION BY COMPANY_ID) AS HIGHEST_SALARY FROM SALARIES) SELECT COMPANY_ID, EMPLOYEE_ID, EMPLOYEE_NAME, ROUND(SALARY * TAX_RATE, 0) AS SALARY FROM (SELECT *, CASE WHEN HIGHEST_SALARY < 1000 THEN 1 WHEN HIGHEST_SALARY >= 1000 AND HIGHEST_SALARY < 10000 THEN 0.76 WHEN HIGHEST_SALARY >= 10000 THEN 0.51 END AS TAX_RATE FROM T1) AS SUB;

/*
Prediction Result:
(1, 1, 'Eve', 5100.0)
(1, 2, 'Frank', 409.0)
(2, 1, 'Grace', 5101.0)
(2, 2, 'Heidi', 485.0)
(2, 3, 'Ivan', 2550.0)
*/