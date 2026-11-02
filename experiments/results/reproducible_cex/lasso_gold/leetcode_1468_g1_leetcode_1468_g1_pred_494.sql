-- Schema DDL
CREATE TABLE "Salaries" ("company_id" INTEGER, "employee_id" INTEGER, "employee_name" TEXT(255), "salary" INTEGER, PRIMARY KEY ("company_id", "employee_id"), CHECK ("salary" > 0));

-- Loading data
PRAGMA foreign_keys = OFF;
INSERT INTO "salaries" ("company_id", "employee_id", "employee_name", "salary") VALUES (1325, 1328, 'Joshua Cooke', 1331);
INSERT INTO "salaries" ("company_id", "employee_id", "employee_name", "salary") VALUES (1325, 1329, 'Matthew Harrington', 1340.0);
INSERT INTO "salaries" ("company_id", "employee_id", "employee_name", "salary") VALUES (1325, NULL, 'Nicole Herring', 1349.0);
INSERT INTO "salaries" ("company_id", "employee_id", "employee_name", "salary") VALUES (1325, 1334, 'Alex Hernandez', 1337);
INSERT INTO "salaries" ("company_id", "employee_id", "employee_name", "salary") VALUES (1325, 1335, 'Michael Elliott', 1346.0);
INSERT INTO "salaries" ("company_id", "employee_id", "employee_name", "salary") VALUES (1325, NULL, 'Michael Wang', 1355.0);
INSERT INTO "salaries" ("company_id", "employee_id", "employee_name", "salary") VALUES (1325, NULL, 'Nicole Herring', 1349.0);
INSERT INTO "salaries" ("company_id", "employee_id", "employee_name", "salary") VALUES (1325, NULL, 'Michael Wang', 1355.0);
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT S.COMPANY_ID, S.EMPLOYEE_ID, S.EMPLOYEE_NAME, CASE WHEN MAX_SALARY < 1000 THEN SALARY WHEN MAX_SALARY >= 1000 AND MAX_SALARY <= 10000 THEN ROUND(SALARY - SALARY * 0.24, 0) WHEN MAX_SALARY > 10000 THEN ROUND(SALARY - SALARY * 0.49, 0) END AS SALARY FROM SALARIES AS S JOIN (SELECT COMPANY_ID, MAX(SALARY) AS MAX_SALARY FROM SALARIES GROUP BY COMPANY_ID) AS T ON S.COMPANY_ID = T.COMPANY_ID;

/*
Gold Result:
(1325, None, 'Nicole Herring', 1025.0)
(1325, None, 'Michael Wang', 1030.0)
(1325, None, 'Nicole Herring', 1025.0)
(1325, None, 'Michael Wang', 1030.0)
(1325, 1328, 'Joshua Cooke', 1012.0)
(1325, 1329, 'Matthew Harrington', 1018.0)
(1325, 1334, 'Alex Hernandez', 1016.0)
(1325, 1335, 'Michael Elliott', 1023.0)
*/

-- Prediction Query
SELECT COMPANY_ID, EMPLOYEE_ID, EMPLOYEE_NAME, ROUND(CASE WHEN MAX(SALARY) OVER (PARTITION BY COMPANY_ID) < 1000 THEN SALARY WHEN MAX(SALARY) OVER (PARTITION BY COMPANY_ID) >= 1000 AND MAX(SALARY) OVER (PARTITION BY COMPANY_ID) <= 10000 THEN 0.76 * SALARY WHEN MAX(SALARY) OVER (PARTITION BY COMPANY_ID) > 10000 THEN 0.51 * MAX(SALARY) END) AS SALARY FROM SALARIES GROUP BY 1, 2, 3;

/*
Prediction Result:
(1325, None, 'Michael Wang', 1030.0)
(1325, None, 'Nicole Herring', 1025.0)
(1325, 1328, 'Joshua Cooke', 1012.0)
(1325, 1329, 'Matthew Harrington', 1018.0)
(1325, 1334, 'Alex Hernandez', 1016.0)
(1325, 1335, 'Michael Elliott', 1023.0)
*/